// Companies aggregate helpers. Mirrors public.company_slug() in SQL so the
// app and the DB agree on the same key when looking each other up.
import { supabase } from "./supabase";

export interface CompanyRow {
  id: string;
  slug: string;
  display_name: string;
  primary_domain: string | null;
  inspection_count: number;
  mean_score: number | null;
  last_score: number | null;
  last_verdict: "VERIFIED" | "INVESTIGATE" | "DECLINE" | null;
  last_inspected_at: string | null;
  linkedin_url: string | null;
  glassdoor_url: string | null;
  crunchbase_url: string | null;
  github_org: string | null;
  founded_year: number | null;
  hq_country: string | null;
  hq_city: string | null;
  hq_region: string | null;
  employee_count_est: number | null;
  funding_total_usd: number | null;
  industry: string | null;
  glassdoor_rating: number | null;
  glassdoor_refreshed_at: string | null;
  notes: string | null;
}

export function companySlug(raw: string): string {
  return raw
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/-+/g, "-")
    .replace(/^-|-$/g, "");
}

/** Extracts the dedup domain from a URL ("www.posthog.com/x" → "posthog.com"). */
export function hostnameOf(url: string): string | null {
  try {
    const u = new URL(url.startsWith("http") ? url : `https://${url}`);
    return u.hostname.toLowerCase().replace(/^www\./, "");
  } catch {
    return null;
  }
}

/**
 * Look up any prior company record for a posting URL. We try by primary
 * domain first (works for company-hosted ATSes like `jobs.posthog.com`), then
 * by hostname fragments (helps when the URL is on a board like LinkedIn —
 * we can't infer the company from the URL alone, so this returns null).
 *
 * Returns at most ONE row — the best match by recency.
 */
export async function lookupCompanyForUrl(
  url: string,
): Promise<CompanyRow | null> {
  const host = hostnameOf(url);
  if (!host) return null;

  // Pull any candidate domain — exact match OR registrable-domain suffix.
  // posthog.com matches both posthog.com and jobs.posthog.com.
  const registrable = host.split(".").slice(-2).join(".");
  const sb = supabase();
  const { data, error } = await sb
    .from("companies")
    .select("*")
    .or(`primary_domain.eq.${host},primary_domain.eq.${registrable}`)
    .order("last_inspected_at", { ascending: false, nullsFirst: false })
    .limit(1);
  if (error || !data || data.length === 0) return null;
  return data[0] as CompanyRow;
}

/**
 * Render a short context block that gets prepended to Gemini's Stage 1
 * prompt. Tells the model what Lighthouse already knows about this company
 * from prior inspections so it can skip work it has already done.
 *
 * The block also classifies confidence ("HIGH" / "MEDIUM" / "LOW") based on
 * mean score, inspection count, and recency. Gemini's Stage 1 prompt has
 * an explicit rule that HIGH-confidence priors should be re-confirmed
 * lightly rather than re-investigated from scratch — that's how Supabase
 * priors translate into fewer grounded-search calls.
 */
export function renderCompanyContext(c: CompanyRow): string {
  const lines: string[] = [
    "===== PRIOR COMPANY KNOWLEDGE =====",
    `Lighthouse has inspected ${c.display_name} ${c.inspection_count} time(s) before.`,
  ];
  if (c.mean_score != null) {
    lines.push(`Historical mean score: ${c.mean_score} / 100.`);
  }
  if (c.last_score != null && c.last_verdict) {
    lines.push(
      `Most recent verdict: ${c.last_verdict} (${c.last_score}/100) on ${c.last_inspected_at?.slice(0, 10)}.`,
    );
  }
  if (c.primary_domain) lines.push(`Known domain: ${c.primary_domain}`);
  if (c.linkedin_url) lines.push(`LinkedIn: ${c.linkedin_url}`);
  if (c.glassdoor_url) lines.push(`Glassdoor: ${c.glassdoor_url}`);
  if (c.crunchbase_url) lines.push(`Crunchbase: ${c.crunchbase_url}`);
  if (c.github_org) lines.push(`GitHub org: ${c.github_org}`);
  if (c.founded_year) lines.push(`Founded: ${c.founded_year}`);
  if (c.hq_country) lines.push(`HQ: ${c.hq_country}`);
  if (c.employee_count_est)
    lines.push(`Employee count (est.): ${c.employee_count_est}`);
  if (c.funding_total_usd)
    lines.push(
      `Funding raised: $${(c.funding_total_usd / 1_000_000).toFixed(1)}M`,
    );
  if (c.notes) lines.push(`Notes: ${c.notes}`);

  const confidence = priorConfidence(c);
  lines.push("", `Prior confidence: ${confidence}.`);
  if (confidence === "HIGH") {
    lines.push(
      "ACTION: This company is well-verified. Do NOT re-run WHOIS, EDGAR, Crunchbase, or GitHub searches. Re-confirm Real and Credible in 1-2 sentences each, citing the prior dossier. Spend your grounded-search budget on Active + Fair for THIS specific posting.",
    );
  } else if (confidence === "MEDIUM") {
    lines.push(
      "ACTION: Reuse prior Real/Credible facts as a starting point. Run only the queries that would refresh stale fields (last inspected > 30 days, or fields missing above). Active + Fair must still be fully investigated for THIS posting.",
    );
  } else {
    lines.push(
      "ACTION: Prior confidence is low — investigate all four pillars as usual, but use the facts above to skip identification searches (Real-1..4).",
    );
  }
  lines.push(
    "If a prior claim now looks wrong, flag it explicitly in your evidence.",
    "===================================",
    "",
  );
  return lines.join("\n");
}

/**
 * Classify how much weight Gemini should give the prior dossier.
 * HIGH   → strong historical mean, multiple inspections, recently re-checked.
 * MEDIUM → real history but stale or thin.
 * LOW    → one prior inspection or weak score.
 */
function priorConfidence(c: CompanyRow): "HIGH" | "MEDIUM" | "LOW" {
  const mean = c.mean_score ?? c.last_score ?? 0;
  const count = c.inspection_count ?? 0;
  const ageDays = c.last_inspected_at
    ? Math.floor(
        (Date.now() - new Date(c.last_inspected_at).getTime()) / 86_400_000,
      )
    : Infinity;
  if (mean >= 85 && count >= 3 && ageDays <= 30) return "HIGH";
  if (mean >= 70 && count >= 2 && ageDays <= 90) return "MEDIUM";
  return "LOW";
}
