import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import type { Posting } from "./types";

// Server-side Supabase client. Prefers the service-role key when present
// (production / cron path) and falls back to the publishable (anon) key for
// local dev. The anon path is safe because the inspections + postings RLS
// policies allow anonymous insert/update for the MVP — tighten them once
// service_role is wired in production.
let _client: SupabaseClient | null = null;
let _usingServiceRole = false;

export function supabase(): SupabaseClient {
  if (_client) return _client;
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceRole = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const publishable = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;
  const key = serviceRole || publishable;

  if (!url || !key) {
    throw new Error(
      "Supabase credentials missing. Set NEXT_PUBLIC_SUPABASE_URL and either SUPABASE_SERVICE_ROLE_KEY or NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY in .env.",
    );
  }

  _usingServiceRole = !!serviceRole;
  _client = createClient(url, key, {
    auth: { persistSession: false, autoRefreshToken: false },
    global: {
      headers: { "X-Client-Info": "lighthouse-server" },
    },
  });
  return _client;
}

/** True when the active client carries service_role (bypasses RLS). */
export function usingServiceRole(): boolean {
  // Force lazy init so the flag is accurate.
  if (!_client) supabase();
  return _usingServiceRole;
}

// Wire-format shape stored in Postgres. Differences from Posting:
//   • snake_case columns
//   • jsonb blobs for nested structures
//   • id is a uuid
export interface InspectionRow {
  id: string;
  url: string;
  url_normalized: string;
  company: string;
  role: string;
  location: string;
  is_remote: boolean;
  comp_min: number;
  comp_max: number;
  equity: string;
  posted: string;
  summary: string;
  score: number;
  verdict: Posting["verdict"];
  headline: string;
  editorial: string;
  pillars: Posting["pillars"];
  activity: Posting["activity"];
  comparables: Posting["comparables"];
  citations: { uri: string; title?: string }[];
  evidence_raw: string | null;
  verify_ms: number | null;
  created_at: string;
}

export function rowToPosting(r: InspectionRow): Posting {
  return {
    id: r.id,
    url: r.url,
    company: r.company,
    role: r.role,
    location: r.location,
    isRemote: r.is_remote ?? true,
    compMin: r.comp_min,
    compMax: r.comp_max,
    equity: r.equity,
    posted: r.posted,
    summary: r.summary,
    score: r.score,
    verdict: r.verdict,
    headline: r.headline,
    editorial: r.editorial,
    pillars: r.pillars,
    activity: r.activity,
    comparables: r.comparables,
  };
}

export async function upsertInspection(
  url: string,
  urlNormalized: string,
  posting: Posting,
  citations: { uri: string; title?: string }[],
  evidenceRaw: string,
  verifyMs: number | null = null,
) {
  const sb = supabase();
  return sb
    .from("inspections")
    .upsert(
      {
        url,
        url_normalized: urlNormalized,
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
}
