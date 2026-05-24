import { NextResponse } from "next/server";
import { supabase, upsertInspection } from "@/lib/supabase";
import { verifyPosting, type VerifyResult } from "@/lib/gemini";

export const runtime = "nodejs";
export const maxDuration = 60;          // hard ceiling on Vercel Hobby tier
export const dynamic = "force-dynamic"; // never cache the cron response

// Wall-clock budget for the whole run, kept comfortably below maxDuration.
const TOTAL_BUDGET_MS = 55_000;
// Bound any single Gemini call so a slow one can't eat the budget.
const VERIFY_TIMEOUT_MS = 35_000;

export async function GET(request: Request) {
  return handle(request);
}

export async function POST(request: Request) {
  return handle(request);
}

async function handle(request: Request): Promise<NextResponse> {
  // 1. Authn — Vercel Cron forwards `Authorization: Bearer ${CRON_SECRET}`.
  //    For local dev we permit the call if CRON_SECRET is unset.
  const expected = process.env.CRON_SECRET;
  if (expected) {
    const got = request.headers.get("authorization") || "";
    if (got !== `Bearer ${expected}`) {
      return NextResponse.json({ error: "unauthorized" }, { status: 401 });
    }
  }

  const t0 = Date.now();
  const sb = supabase();
  const remaining = () => TOTAL_BUDGET_MS - (Date.now() - t0);

  // 2. Query oldest 'new' postings first (up to 3 per run)
  const { data: newQueue, error: newErr } = await sb
    .from("postings")
    .select("id, url, url_normalized, attempt_count")
    .eq("status", "new")
    .order("first_seen_at", { ascending: true })
    .limit(3);

  if (newErr) {
    console.error("Queue fetch error (new postings):", newErr.message);
  }

  // 3. Query stale 'verifying' postings that have been stuck > 2 minutes
  const limitRemaining = 3 - (newQueue?.length || 0);
  let stuckQueue: any[] = [];
  if (limitRemaining > 0) {
    const stuckThreshold = new Date(Date.now() - 2 * 60 * 1000).toISOString();
    const { data: stuckRows, error: stuckErr } = await sb
      .from("postings")
      .select("id, url, url_normalized, attempt_count")
      .eq("status", "verifying")
      .lt("last_attempt_at", stuckThreshold)
      .order("first_seen_at", { ascending: true })
      .limit(limitRemaining);

    if (stuckErr) {
      console.error("Queue fetch error (stuck verifying):", stuckErr.message);
    } else if (stuckRows) {
      stuckQueue = stuckRows;
    }
  }

  const queue = [...(newQueue || []), ...stuckQueue].slice(0, 3);
  let totalVerified = 0;
  let totalFailed = 0;
  const results: any[] = [];

  // 4. Verification loop with remaining time safety gate
  for (const p of queue) {
    if (remaining() < VERIFY_TIMEOUT_MS) {
      console.log(`Verify queue: dynamic budget exhausted, halting loop. Remaining: ${remaining()}ms`);
      break;
    }

    const nextAttemptCount = (p.attempt_count || 0) + 1;

    // Mark verifying to prevent double-processing.
    await sb
      .from("postings")
      .update({
        status: "verifying",
        last_attempt_at: new Date().toISOString(),
        attempt_count: nextAttemptCount,
      })
      .eq("id", p.id);

    try {
      const result = await Promise.race<VerifyResult>([
        verifyPosting(p.url),
        timeout<VerifyResult>(VERIFY_TIMEOUT_MS),
      ]);

      // Persist into inspections — trigger public.link_posting_to_inspection
      // will run and automatically update postings.status to 'verified' and
      // back-link postings.inspection_id.
      const { data: persisted, error: persistError } = await upsertInspection(
        p.url,
        p.url_normalized,
        result.posting,
        result.citations,
        result.evidenceRaw,
      );

      if (persistError) {
        throw new Error(`Persist failed: ${persistError.message}`);
      }

      totalVerified += 1;
      results.push({ id: p.id, url: p.url, status: "verified", inspectionId: persisted?.id });
    } catch (e) {
      totalFailed += 1;
      const errMessage = e instanceof Error ? e.message : String(e);
      console.error(`Verification failed for posting ${p.id} (${p.url}):`, errMessage);

      await sb
        .from("postings")
        .update({
          status: "failed",
          attempt_error: errMessage.slice(0, 500),
        })
        .eq("id", p.id);

      results.push({ id: p.id, url: p.url, status: "failed", error: errMessage });
    }
  }

  const durationMs = Date.now() - t0;
  return NextResponse.json({
    status: "ok",
    durationMs,
    processed: queue.length,
    verifiedCount: totalVerified,
    failedCount: totalFailed,
    results,
  });
}

function timeout<T>(ms: number): Promise<T> {
  return new Promise((_, reject) =>
    setTimeout(() => reject(new Error(`verify timeout after ${ms}ms`)), ms),
  );
}
