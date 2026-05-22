import { NextResponse } from "next/server";
import { supabase } from "@/lib/supabase";

export const runtime = "nodejs";

// Recent postings that the cron ingested but hasn't yet verified.
// Surfaced in the Library as "Awaiting verification" rows.
export async function GET(request: Request) {
  const url = new URL(request.url);
  const limit = Math.min(Number(url.searchParams.get("limit") || 12), 50);

  try {
    const sb = supabase();
    const { data, error } = await sb
      .from("postings")
      .select(
        "id, source_slug, url, url_normalized, title, company, location, posted_at, first_seen_at, status",
      )
      .in("status", ["new", "verifying", "failed"])
      .order("first_seen_at", { ascending: false })
      .limit(limit);

    if (error) throw error;

    return NextResponse.json({
      pending: (data || []).map((r) => ({
        id: r.id,
        source: r.source_slug,
        url: r.url,
        urlNormalized: r.url_normalized,
        title: r.title,
        company: r.company || "",
        location: r.location || "Remote",
        postedAt: r.posted_at,
        firstSeenAt: r.first_seen_at,
        status: r.status,
      })),
      count: (data || []).length,
    });
  } catch (e: unknown) {
    return NextResponse.json(
      {
        error: e instanceof Error ? e.message : "Failed to load queue.",
        pending: [],
      },
      { status: 500 },
    );
  }
}
