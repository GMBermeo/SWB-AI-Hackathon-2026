import { NextResponse } from "next/server";
import { supabase, rowToPosting, type InspectionRow } from "@/lib/supabase";
import type { CompanyRow } from "@/lib/companies";

export const runtime = "nodejs";

// Single-company detail. Bundles the company row + every inspection for it +
// the queue of postings still awaiting verification, so the /companies/[slug]
// page can render fully from one fetch.
export async function GET(
  _request: Request,
  { params }: { params: Promise<{ slug: string }> },
) {
  const { slug } = await params;
  try {
    const sb = supabase();

    const { data: company, error: cErr } = await sb
      .from("companies")
      .select("*")
      .eq("slug", slug)
      .maybeSingle<CompanyRow>();
    if (cErr) throw cErr;
    if (!company) {
      return NextResponse.json({ error: "Company not found" }, { status: 404 });
    }

    // Inspections — match either by foreign key (set by the DB trigger) or
    // by slug fallback (back-fill safety net for older rows).
    const { data: inspections, error: iErr } = await sb
      .from("inspections")
      .select("*")
      .or(`company_id.eq.${company.id},company.eq.${company.display_name}`)
      .order("created_at", { ascending: false });
    if (iErr) throw iErr;

    // Pending postings on the company's primary domain (best-effort; the
    // postings table doesn't carry company_id directly).
    let pending: unknown[] = [];
    if (company.primary_domain) {
      const { data: pRows } = await sb
        .from("postings")
        .select(
          "id, source_slug, url, url_normalized, title, company, location, posted_at, first_seen_at, status",
        )
        .ilike("url", `%${company.primary_domain}%`)
        .in("status", ["new", "verifying", "failed"])
        .order("first_seen_at", { ascending: false })
        .limit(20);
      pending = pRows || [];
    }

    const rows = (inspections || []) as InspectionRow[];
    return NextResponse.json({
      company,
      inspections: rows.map((r) => ({
        ...rowToPosting(r),
        createdAt: r.created_at,
        citations: r.citations || [],
        evidenceRaw: r.evidence_raw,
        verifyMs: r.verify_ms,
        source: (() => {
          try {
            return new URL(r.url).hostname.replace(/^www\./, "");
          } catch {
            return "";
          }
        })(),
      })),
      pending,
    });
  } catch (e: unknown) {
    const message = e instanceof Error ? e.message : "Failed to load company.";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
