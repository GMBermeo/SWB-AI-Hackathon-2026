import { NextResponse } from "next/server";
import { verifyPosting } from "@/lib/gemini";
import { normalizeUrl } from "@/lib/normalize";
import { supabase, rowToPosting, type InspectionRow, upsertInspection } from "@/lib/supabase";

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
    const { posting, citations, evidenceRaw } = result;
    const { data: persisted } = await upsertInspection(
      url,
      normalized,
      posting,
      citations,
      evidenceRaw,
      verifyMs,
    );

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
