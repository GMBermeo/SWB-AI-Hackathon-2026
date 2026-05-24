import { NextResponse } from "next/server";
import { fetchFromAll, type RawPosting } from "@/lib/sources";
import { normalizeUrl } from "@/lib/normalize";
import { supabase } from "@/lib/supabase";
import { companySlug } from "@/lib/companies";

export const runtime = "nodejs";
export const maxDuration = 60;          // hard ceiling on Vercel Hobby tier
export const dynamic = "force-dynamic"; // never cache the cron response

// Wall-clock budget for the whole run, kept comfortably below maxDuration.
const TOTAL_BUDGET_MS = 55_000;
// Per-source fetch limit per run.
const PER_SOURCE_LIMIT = 5;
// Maximum verifications attempted inline (each ~25s). Since we pre-filter
// postings to strictly Canadian roles, daily volume is low, so we process
// up to 10 new postings per run to ensure everything is verified.
const MAX_INLINE_VERIFICATIONS = 10;
// Bound any single Gemini call so a slow one can't eat the budget.
const VERIFY_TIMEOUT_MS = 35_000;

// ────────────────────────────────────────────────────────────────────────
// GET /api/ingest  · invoked by Vercel Cron, gated by CRON_SECRET.
// POST /api/ingest · manual trigger (same path; lets you POST a JSON body
//                    in the future if we want per-source ingestion).
// ────────────────────────────────────────────────────────────────────────
export async function GET(request: Request) {
  return handle(request, "cron");
}
export async function POST(request: Request) {
  return handle(request, "manual");
}

async function handle(
  request: Request,
  trigger: "cron" | "manual",
): Promise<NextResponse> {
  // 1. Authn — Vercel Cron forwards `Authorization: Bearer ${CRON_SECRET}`.
  //    For local dev we permit the call if CRON_SECRET is unset.
  const expected = process.env.CRON_SECRET;
  if (expected) {
    const got = request.headers.get("authorization") || "";
    if (got !== `Bearer ${expected}`) {
      return NextResponse.json({ error: "unauthorized" }, { status: 401 });
    }
  }

  const startedAt = new Date();
  const t0 = Date.now();
  const sb = supabase();

  // 2. Open a run row so it's always visible — even if we crash partway.
  const { data: runRow } = await sb
    .from("ingestion_runs")
    .insert({ status: "running", trigger })
    .select("id")
    .single();
  const runId = runRow?.id as string | undefined;

  // 3. Fan out to every source adapter.
  const sourceResults = await fetchFromAll(PER_SOURCE_LIMIT);

  // 4. Insert new postings (dedup by url_normalized via the table's unique
  //    index; `onConflict` keeps the existing row so first_seen_at stays
  //    accurate). Also upsert any company-level signals the adapter
  //    surfaced (Glassdoor rating, industry, employer domain) so future
  //    Gemini verifications get the context for free.
  let totalSeen = 0;
  let totalNew = 0;
  let totalCompanies = 0;
  for (const sr of sourceResults) {
    totalSeen += sr.postings.length;
    if (sr.postings.length === 0) continue;

    const rows = sr.postings
      .map((p) => ({
        source_slug: p.sourceSlug,
        source_external_id: p.sourceExternalId || null,
        url: p.url,
        url_normalized: normalizeUrl(p.url),
        title: p.title,
        company: p.company || null,
        location: p.location || null,
        description: p.description || null,
        posted_at: p.postedAt,
        raw_payload: p.raw,
        salary_min: p.salary?.min ?? null,
        salary_max: p.salary?.max ?? null,
        salary_currency: p.salary?.currency ?? null,
        salary_period: p.salary?.period ?? null,
        experience_text: p.experience ?? null,
      }))
      .filter((r) => r.url_normalized);

    const { data: inserted, error } = await sb
      .from("postings")
      .upsert(rows, { onConflict: "url_normalized", ignoreDuplicates: true })
      .select("id, url_normalized");

    if (error) {
      console.warn(`postings insert for ${sr.slug} failed:`, error.message);
    } else if (inserted) {
      totalNew += inserted.length;
    }

    // Company signals — one row per distinct employer this batch surfaced.
    const companyUpserts = collectCompanyUpserts(sr.postings);
    if (companyUpserts.length) {
      const { error: cErr, data: cIns } = await sb
        .from("companies")
        .upsert(companyUpserts, { onConflict: "slug" })
        .select("id");
      if (cErr) {
        console.warn(`companies upsert for ${sr.slug} failed:`, cErr.message);
      } else if (cIns) {
        totalCompanies += cIns.length;
      }
    }
  }

  // 5. Decoupled queue verification: now handled separately by the /api/verify-queue cron job.
  const totalVerified = 0;

  // 6. Roll up the summary so the dashboard can read run history.
  const summary = sourceResults.reduce<Record<string, unknown>>((acc, sr) => {
    acc[sr.slug] = {
      fetched: sr.postings.length,
      ms: sr.ms,
      ...(sr.error ? { error: sr.error } : {}),
    };
    return acc;
  }, {});

  const finishedAt = new Date();
  const durationMs = finishedAt.getTime() - startedAt.getTime();
  const allOk = sourceResults.every((sr) => !sr.error);
  const status = allOk ? "ok" : totalNew > 0 ? "partial" : "failed";

  if (runId) {
    await sb
      .from("ingestion_runs")
      .update({
        finished_at: finishedAt.toISOString(),
        status,
        sources_summary: summary,
        total_seen: totalSeen,
        total_new: totalNew,
        total_verified: totalVerified,
        duration_ms: durationMs,
      })
      .eq("id", runId);
  }

  return NextResponse.json({
    runId,
    status,
    trigger,
    durationMs,
    totals: {
      seen: totalSeen,
      new: totalNew,
      verified: totalVerified,
      companies: totalCompanies,
    },
    sources: summary,
  });
}

function timeout<T>(ms: number): Promise<T> {
  return new Promise((_, reject) =>
    setTimeout(() => reject(new Error(`verify timeout after ${ms}ms`)), ms),
  );
}



/**
 * Roll up company-level signals from a batch of RawPostings. One row per
 * distinct employer; later rows override earlier (so a fresher signal wins
 * inside a single ingest run).
 */
type CompanyUpsert = {
  slug: string;
  display_name: string;
  primary_domain?: string | null;
  glassdoor_url?: string | null;
  glassdoor_rating?: number | null;
  industry?: string | null;
  hq_city?: string | null;
  hq_region?: string | null;
  hq_country?: string | null;
  glassdoor_refreshed_at?: string | null;
};

function collectCompanyUpserts(postings: RawPosting[]): CompanyUpsert[] {
  const byName = new Map<string, CompanyUpsert>();
  for (const p of postings) {
    if (!p.company) continue;
    if (!p.companySignals) continue;
    const slug = companySlug(p.company);
    if (!slug) continue;
    const s = p.companySignals;
    byName.set(slug, {
      slug,
      display_name: p.company,
      primary_domain: s.domain ?? null,
      glassdoor_url: s.glassdoorUrl ?? null,
      glassdoor_rating:
        typeof s.glassdoorRating === "number" ? s.glassdoorRating : null,
      industry: s.industry ?? null,
      hq_city: s.hqCity ?? null,
      hq_region: s.hqRegion ?? null,
      hq_country: s.hqCountry ?? null,
      glassdoor_refreshed_at: s.capturedAt ?? new Date().toISOString(),
    });
  }
  return Array.from(byName.values());
}
