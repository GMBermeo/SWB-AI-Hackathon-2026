import { NextResponse } from "next/server";
import { supabase, rowToPosting, type InspectionRow } from "@/lib/supabase";
import { POSTINGS } from "@/lib/data";

export const runtime = "nodejs";

export async function GET(request: Request) {
  const url = new URL(request.url);
  const query = String(url.searchParams.get("q") || "").trim();

  if (!query) {
    return NextResponse.json({ postings: [], companies: [] });
  }

  const q = `%${query}%`;

  try {
    const sb = supabase();

    // 1. Search inspections table (postings)
    const { data: dbInspections, error: insError } = await sb
      .from("inspections")
      .select("*")
      .or(
        `company.ilike.${q},role.ilike.${q},location.ilike.${q},headline.ilike.${q},summary.ilike.${q}`
      )
      .order("created_at", { ascending: false })
      .limit(50);

    if (insError) throw insError;

    const dbPostings = (dbInspections || []).map((r: InspectionRow) => ({
      ...rowToPosting(r),
      createdAt: r.created_at,
      source: new URL(r.url).hostname.replace(/^www\./, ""),
    }));

    // 2. Search companies table
    const { data: dbCompanies, error: coError } = await sb
      .from("companies")
      .select("*")
      .or(
        `display_name.ilike.${q},industry.ilike.${q},hq_city.ilike.${q},hq_region.ilike.${q},hq_country.ilike.${q},notes.ilike.${q}`
      )
      .order("glassdoor_rating", { ascending: false, nullsFirst: false })
      .limit(50);

    if (coError) throw coError;

    // 3. Search and merge static demo postings (POSTINGS) to keep search lively
    const lowercaseQuery = query.toLowerCase();
    const matchedDemos = POSTINGS.filter(
      (p) =>
        p.company.toLowerCase().includes(lowercaseQuery) ||
        p.role.toLowerCase().includes(lowercaseQuery) ||
        p.location.toLowerCase().includes(lowercaseQuery) ||
        p.summary.toLowerCase().includes(lowercaseQuery) ||
        p.headline.toLowerCase().includes(lowercaseQuery)
    ).map((p) => ({
      ...p,
      createdAt: new Date("2026-05-21").toISOString(),
      source: new URL(p.url).hostname.replace(/^www\./, ""),
    }));

    // Deduplicate between live and demo postings by company + role
    const seen = new Set<string>();
    const postings = [];

    for (const p of [...dbPostings, ...matchedDemos]) {
      const key = `${p.company.toLowerCase()}::${p.role.toLowerCase()}`;
      if (!seen.has(key)) {
        seen.add(key);
        postings.push(p);
      }
    }

    return NextResponse.json({
      postings,
      companies: dbCompanies || [],
    });
  } catch (e: unknown) {
    const message =
      e instanceof Error ? e.message : "Search failed unexpectedly.";
    return NextResponse.json({ error: message, postings: [], companies: [] }, { status: 500 });
  }
}
