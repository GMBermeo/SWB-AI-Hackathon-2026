import { NextResponse } from "next/server";
import { supabase } from "@/lib/supabase";
import type { CompanyRow } from "@/lib/companies";

export const runtime = "nodejs";

// Lists every company surfaced by an inspection. Powers the /companies index.
// Newest verdict first so users see active activity at the top.
export async function GET(request: Request) {
  const url = new URL(request.url);
  const limit = Math.min(Number(url.searchParams.get("limit") || 500), 1000);
  const q = (url.searchParams.get("q") || "").trim().toLowerCase();

  try {
    const sb = supabase();
    let query = sb
      .from("companies")
      .select(
        "id, slug, display_name, primary_domain, inspection_count, mean_score, last_score, last_verdict, last_inspected_at, linkedin_url, glassdoor_url, crunchbase_url, github_org, founded_year, hq_country, hq_city, hq_region, employee_count_est, funding_total_usd, industry, glassdoor_rating, glassdoor_refreshed_at, notes",
      )
      .order("last_inspected_at", { ascending: false, nullsFirst: false })
      .limit(limit);

    if (q) {
      // Match either the slug or the display name. ilike is RLS-friendly and
      // good enough for the small dataset we're shipping with.
      query = query.or(`display_name.ilike.%${q}%,slug.ilike.%${q}%`);
    }

    const { data, error } = await query;
    if (error) throw error;

    const rows = ((data || []) as CompanyRow[]).map((c) => ({
      ...c,
      primary_domain:
        c.primary_domain && c.primary_domain.length > 101
          ? c.primary_domain.slice(0, 101) + "…"
          : c.primary_domain,
    }));
    return NextResponse.json({ companies: rows, count: rows.length });
  } catch (e: unknown) {
    const message = e instanceof Error ? e.message : "Failed to load companies.";
    return NextResponse.json(
      { error: message, companies: [] },
      { status: 500 },
    );
  }
}
