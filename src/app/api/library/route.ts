import { NextResponse } from "next/server";
import { supabase, rowToPosting, type InspectionRow } from "@/lib/supabase";

export const runtime = "nodejs";

// Recent inspections, newest first. Each row is enough to render the Library
// table AND open into the report screen (so we send the full Posting).
export async function GET(request: Request) {
  const url = new URL(request.url);
  const limit = Math.min(Number(url.searchParams.get("limit") || 50), 200);

  try {
    const sb = supabase();
    const { data, error } = await sb
      .from("inspections")
      .select("*")
      .order("created_at", { ascending: false })
      .limit(limit);

    if (error) throw error;

    const rows = (data || []) as InspectionRow[];
    return NextResponse.json({
      inspections: rows.map((r) => ({
        ...rowToPosting(r),
        createdAt: r.created_at,
        source: new URL(r.url).hostname.replace(/^www\./, ""),
      })),
      count: rows.length,
    });
  } catch (e: unknown) {
    const message =
      e instanceof Error ? e.message : "Failed to load library.";
    return NextResponse.json({ error: message, inspections: [] }, { status: 500 });
  }
}
