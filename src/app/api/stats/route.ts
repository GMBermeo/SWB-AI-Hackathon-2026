import { NextResponse } from "next/server";
import { supabase } from "@/lib/supabase";

export const runtime = "nodejs";

// Aggregate numbers shown on the Home stats strip. Cheap query — just
// pulls verdict + verify_ms for the last 90 days and rolls up in-memory.
export async function GET() {
  try {
    const sb = supabase();
    const cutoff = new Date(Date.now() - 90 * 24 * 60 * 60 * 1000).toISOString();

    const { data, error } = await sb
      .from("inspections")
      .select("verdict, verify_ms, created_at")
      .gte("created_at", cutoff);

    if (error) throw error;

    const rows = data || [];
    const total = rows.length;
    const verified = rows.filter((r) => r.verdict === "VERIFIED").length;
    const investigate = rows.filter((r) => r.verdict === "INVESTIGATE").length;
    const decline = rows.filter((r) => r.verdict === "DECLINE").length;

    const oneWeekAgo = Date.now() - 7 * 24 * 60 * 60 * 1000;
    const lastWeek = rows.filter(
      (r) => new Date(r.created_at).getTime() >= oneWeekAgo,
    ).length;

    const times = rows
      .map((r) => r.verify_ms)
      .filter((n): n is number => typeof n === "number" && n > 0)
      .sort((a, b) => a - b);
    const medianMs = times.length ? times[Math.floor(times.length / 2)] : null;

    return NextResponse.json({
      total,
      lastWeek,
      verifiedPct: total ? (verified / total) * 100 : 0,
      investigatePct: total ? (investigate / total) * 100 : 0,
      declinePct: total ? (decline / total) * 100 : 0,
      medianMs,
    });
  } catch (e: unknown) {
    const message =
      e instanceof Error ? e.message : "Failed to load stats.";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
