import { supabase } from "./supabase";
import crypto from "crypto";

const DEFAULT_WINDOW_SEC = 600; // 10 minutes
const DEFAULT_MAX_REQUESTS = 10; // 10 requests per 10 minutes

export interface RateLimitResult {
  allowed: boolean;
  count: number;
  max: number;
  windowSec: number;
}

/**
 * Checks if a given IP address has exceeded the verification rate limit.
 * Uses a privacy-preserving SHA-256 hash of the IP address in a sliding window log.
 * Bypasses checks if DB credentials are not set (fail-open for high availability).
 *
 * @param ip Client IP address
 * @returns Rate limit status
 */
export async function checkRateLimit(ip: string): Promise<RateLimitResult> {
  const windowSec = Number(process.env.RATE_LIMIT_WINDOW_SEC || DEFAULT_WINDOW_SEC);
  const maxRequests = Number(process.env.RATE_LIMIT_MAX_REQUESTS || DEFAULT_MAX_REQUESTS);

  // Hash IP to preserve privacy (GDPR compliant)
  const ipHash = crypto.createHash("sha256").update(ip).digest("hex");

  const sb = supabase();
  const cutoff = new Date(Date.now() - windowSec * 1000).toISOString();

  try {
    // 1. Count attempts within the sliding window
    const { count, error } = await sb
      .from("verify_rate_limits")
      .select("*", { count: "exact", head: true })
      .eq("ip_hash", ipHash)
      .gte("created_at", cutoff);

    if (error) {
      console.error("Rate limiter query error:", error);
      // Fallback: fail-open to not block legitimate users if Supabase has issues
      return { allowed: true, count: 0, max: maxRequests, windowSec };
    }

    const currentCount = count || 0;

    if (currentCount >= maxRequests) {
      return {
        allowed: false,
        count: currentCount,
        max: maxRequests,
        windowSec,
      };
    }

    // 2. Record this request
    const { error: insertError } = await sb
      .from("verify_rate_limits")
      .insert({ ip_hash: ipHash });

    if (insertError) {
      console.error("Rate limiter insert error:", insertError);
    }

    // 3. Asynchronously prune old logs (older than 24 hours) to prevent database bloat
    const pruneCutoff = new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString();
    sb.from("verify_rate_limits")
      .delete()
      .lt("created_at", pruneCutoff)
      .then(({ error: deleteError }) => {
        if (deleteError) {
          console.warn("Failed to prune old rate limit logs:", deleteError);
        }
      })
      .catch((err) => {
        console.warn("Error pruning old rate limit logs:", err);
      });

    return {
      allowed: true,
      count: currentCount + 1,
      max: maxRequests,
      windowSec,
    };
  } catch (err) {
    console.error("Unexpected error in rate limiter:", err);
    return { allowed: true, count: 0, max: maxRequests, windowSec };
  }
}
