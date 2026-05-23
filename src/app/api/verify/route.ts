import { NextResponse } from "next/server";
import { verifyPosting } from "@/lib/gemini";
import { normalizeUrl } from "@/lib/normalize";
import { supabase, rowToPosting, type InspectionRow } from "@/lib/supabase";

export const runtime = "nodejs";
export const maxDuration = 60;

// 7-day cache: posting facts (company, comp band, pillar verdicts) don't
// change minute-to-minute, so re-running Gemini on the same URL within a
// week is wasted spend.
const CACHE_TTL_MS = 7 * 24 * 60 * 60 * 1000;

export async function POST(request: Request) {
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

  // ── Live verification ─────────────────────────────────────────────────
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

  // ── Persist (best-effort; failure here shouldn't fail the request) ────
  try {
    const sb = supabase();
    const { posting, citations, evidenceRaw } = result;
    const { data: persisted } = await sb
      .from("inspections")
      .upsert(
        {
          url,
          url_normalized: normalized,
          company: posting.company,
          role: posting.role,
          location: posting.location,
          is_remote: posting.isRemote,
          comp_min: posting.compMin,
          comp_max: posting.compMax,
          equity: posting.equity,
          posted: posting.posted,
          summary: posting.summary,
          score: posting.score,
          verdict: posting.verdict,
          headline: posting.headline,
          editorial: posting.editorial,
          pillars: posting.pillars,
          activity: posting.activity,
          comparables: posting.comparables,
          citations,
          evidence_raw: evidenceRaw,
          verify_ms: verifyMs,
          created_at: new Date().toISOString(),
        },
        { onConflict: "url_normalized" }
      )
      .select("id")
      .single();

    if (persisted?.id) {
      result.posting.id = persisted.id;
    }
  } catch (e) {
    console.warn("Failed to persist inspection:", e);
  }

  return NextResponse.json({
    posting: result.posting,
    citations: result.citations,
    cached: false,
    verifyMs,
  });
}
