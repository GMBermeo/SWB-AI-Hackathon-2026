import { NextRequest, NextResponse, after } from "next/server";
import { verifyPosting } from "@/lib/gemini";
import { normalizeUrl } from "@/lib/normalize";
import { supabase, rowToPosting, type InspectionRow, upsertInspection } from "@/lib/supabase";
import { checkRateLimit } from "@/lib/rateLimit";

export const runtime = "nodejs";
export const maxDuration = 60;

// 7-day cache: posting facts (company, comp band, pillar verdicts) don't
// change minute-to-minute, so re-running Gemini on the same URL within a
// week is wasted spend.
const CACHE_TTL_MS = 7 * 24 * 60 * 60 * 1000;

function getSourceSlug(url: string): string {
  const lower = url.toLowerCase();
  if (lower.includes("remoteok.com")) return "remoteok";
  if (lower.includes("greenhouse.io")) return "greenhouse";
  if (lower.includes("lever.co")) return "lever";
  if (lower.includes("ashbyhq.com")) return "ashby";
  return "wwr"; // WeWorkRemotely / generic fallback
}

async function runSynchronousVerify(url: string, normalized: string) {
  const t0 = Date.now();
  let result;
  try {
    result = await verifyPosting(url);
  } catch (e: unknown) {
    const message =
      e instanceof Error ? e.message : "Verification failed unexpectedly.";
    return NextResponse.json({ error: message }, { status: 500 });
  }
  const verifyMs = Date.now() - t0;

  let persistedId: string | null = null;
  try {
    const { posting, citations, evidenceRaw } = result;
    const { data: persisted, error: persistError } = await upsertInspection(
      url,
      normalized,
      posting,
      citations,
      evidenceRaw,
      verifyMs,
    );

    if (persistError) {
      console.error("Supabase upsert error:", persistError);
      return NextResponse.json(
        { error: `Verification succeeded but could not be saved: ${persistError.message}` },
        { status: 500 },
      );
    }
    persistedId = persisted?.id ?? null;
  } catch (e) {
    console.error("Failed to persist inspection:", e);
    return NextResponse.json(
      { error: "Verification succeeded but could not be saved. Check Supabase credentials and RLS policies." },
      { status: 500 },
    );
  }

  if (!persistedId) {
    return NextResponse.json(
      { error: "Inspection was not assigned a database ID. The upsert returned no row." },
      { status: 500 },
    );
  }

  result.posting.id = persistedId;

  return NextResponse.json({
    posting: result.posting,
    citations: result.citations,
    cached: false,
    verifyMs,
  });
}

export async function POST(request: NextRequest) {
  let url: string;
  let force = false;
  try {
    const body = await request.json();
    url = String(body?.url || "").trim();
    force = Boolean(body?.force);
  } catch {
    return NextResponse.json(
      { error: "Invalid JSON body. Expected { url: string }." },
      { status: 400 },
    );
  }

  if (!url) {
    return NextResponse.json(
      { error: "Missing 'url' in request body." },
      { status: 400 },
    );
  }

  const normalized = normalizeUrl(url);

  // ── Cache lookup (skipped when force=true) ─────────────────────────────
  if (!force) {
    try {
      const sb = supabase();
      const { data: cached } = await sb
        .from("inspections")
        .select("*")
        .eq("url_normalized", normalized)
        .maybeSingle<InspectionRow>();

      if (cached) {
        const age = Date.now() - new Date(cached.created_at).getTime();
        if (age < CACHE_TTL_MS) {
          return NextResponse.json({
            posting: rowToPosting(cached),
            citations: cached.citations || [],
            cached: true,
            verifiedAt: cached.created_at,
          });
        }
      }
    } catch {
      // Cache miss-on-error is fine; fall through to live verification.
    }
  }

  // ── Queue & Polling Lookup ─────────────────────────────────────────────
  const sb = supabase();
  let existingPosting = null;
  try {
    const { data } = await sb
      .from("postings")
      .select("*")
      .eq("url_normalized", normalized)
      .maybeSingle();
    existingPosting = data;
  } catch (err) {
    console.error("Failed to query existing posting status:", err);
  }

  if (existingPosting && !force) {
    const status = existingPosting.status;

    // Check if the verification is stuck (e.g. status='verifying' and last_attempt_at is older than 2 minutes)
    const isStuck =
      status === "verifying" &&
      existingPosting.last_attempt_at &&
      Date.now() - new Date(existingPosting.last_attempt_at).getTime() > 2 * 60 * 1000;

    if (status === "new" || (status === "verifying" && !isStuck)) {
      // It is currently queued or actively verifying. Bypasses rate limits and Gemini spend.
      return NextResponse.json({
        pending: true,
        status,
      });
    }

    if (status === "failed") {
      // If it failed already and has exhausted attempts (max 2), return the error
      if ((existingPosting.attempt_count || 0) >= 2) {
        return NextResponse.json(
          { error: `Verification failed: ${existingPosting.attempt_error || "Unknown error during background verification."}` },
          { status: 500 },
        );
      }
      // Otherwise we fall through and retry it
    }

    if (isStuck) {
      // If it was stuck and has exhausted attempts, return a timeout error
      if ((existingPosting.attempt_count || 0) >= 2) {
        return NextResponse.json(
          { error: "Verification took too long and timed out. Please check back later." },
          { status: 504 },
        );
      }
      // Otherwise we fall through and retry it
    }
  }

  // ── Rate Limiting (only for cache misses or forced re-verifications) ───
  const ip = (request as any).ip || request.headers.get("x-forwarded-for")?.split(",")[0].trim() || "127.0.0.1";
  const rateLimitResult = await checkRateLimit(ip);
  if (!rateLimitResult.allowed) {
    return NextResponse.json(
      {
        error: `Rate limit exceeded. You can only verify up to ${rateLimitResult.max} new links every ${rateLimitResult.windowSec / 60} minutes.`,
      },
      {
        status: 429,
        headers: {
          "Retry-After": String(rateLimitResult.windowSec),
        },
      },
    );
  }

  // ── Register/Update Posting Status in DB ──────────────────────────────
  let postingId = existingPosting?.id;
  const nextAttempt = (existingPosting?.attempt_count || 0) + 1;
  try {
    if (!postingId) {
      const sourceSlug = getSourceSlug(url);
      const { data: inserted, error: insertErr } = await sb
        .from("postings")
        .insert({
          source_slug: sourceSlug,
          url,
          url_normalized: normalized,
          title: "Manual Verification",
          status: "new",
          attempt_count: 1,
          last_attempt_at: new Date().toISOString(),
        })
        .select()
        .single();
      
      if (insertErr) throw insertErr;
      postingId = inserted?.id;
    } else {
      await sb
        .from("postings")
        .update({
          status: "new",
          attempt_count: nextAttempt,
          last_attempt_at: new Date().toISOString(),
          attempt_error: null,
        })
        .eq("id", postingId);
    }
  } catch (err) {
    console.error("Failed to register pending posting in database queue:", err);
    // Safe fallback: run synchronously to avoid breaking the user experience if DB inserts fail
    return runSynchronousVerify(url, normalized);
  }

  // ── Launch Detached Background Verification ──────────────────────────
  after(async () => {
    const sbBg = supabase();
    // Mark status as actively verifying
    await sbBg
      .from("postings")
      .update({ status: "verifying" })
      .eq("url_normalized", normalized);

    try {
      const t0 = Date.now();
      const result = await verifyPosting(url);
      const verifyMs = Date.now() - t0;

      const { data: persisted, error: persistError } = await upsertInspection(
        url,
        normalized,
        result.posting,
        result.citations,
        result.evidenceRaw,
        verifyMs,
      );

      if (persistError) {
        throw new Error(`Failed to save inspection: ${persistError.message}`);
      }
    } catch (e) {
      const message = e instanceof Error ? e.message : String(e);
      console.error("Background manual verification failed:", message);
      await sbBg
        .from("postings")
        .update({
          status: "failed",
          attempt_error: message.slice(0, 500),
        })
        .eq("url_normalized", normalized);
    }
  });

  return NextResponse.json({
    pending: true,
    status: "new",
  });
}
