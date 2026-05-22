// Thin typed wrapper around the HasData Glassdoor scraper API.
//
// Docs:
//   • https://docs.hasdata.com/apis/glassdoor/listing.md
//   • https://docs.hasdata.com/apis/glassdoor/job.md
//
// Cost: 5 credits per /listing call, 5 per /job call. We default to the
// /listing path only — the listing already carries employer, rating,
// salary, and skills, so we never need to follow up per-job for the
// fields Lighthouse cares about.

export interface HasDataJob {
  title?: string;
  url?: string;
  skills?: string[] | string;
  overview?: string;
  employer?: string;
  employerUrl?: string;
  industry?: string;
  rating?: number | string;
  country?: string;
  city?: string;
  region?: string;
  lat?: number;
  lon?: number;
  salaryCurrency?: string;
  payCurrency?: string;
  salaryMin?: number | string;
  salaryMedian?: number | string;
  salaryMax?: number | string;
  salaryPeriod?: string;
  benefits?: string;
  description?: string;
  education?: string;
  experience?: string;
  monthsOfExperience?: number | string;
  id?: string | number;
  datePosted?: string;
  validThrough?: string;
  sponsored?: boolean;
  searchLocation?: string;
  keyword?: string;
  [extra: string]: unknown;
}

export interface HasDataListingResponse {
  jobs?: HasDataJob[];
  results?: HasDataJob[];
  data?: HasDataJob[];
  nextPageToken?: string;
  [extra: string]: unknown;
}

export interface ListingParams {
  /** Search keyword(s). Required. */
  keyword: string;
  /** Geographic location. Required. */
  location: string;
  /** "recent" (default) or "relevant". */
  sort?: "recent" | "relevant";
  /** Glassdoor surface — defaults to glassdoor.com. Pass "www.glassdoor.ca"
   *  for Canada-specific results. */
  domain?: string;
  /** Continuation token from a previous response. */
  nextPageToken?: string;
}

const BASE = "https://api.hasdata.com/scrape/glassdoor";

function apiKey(): string {
  const k = process.env.HAS_DATA_API_KEY;
  if (!k) {
    throw new Error(
      "HAS_DATA_API_KEY is not set. Get one at https://app.hasdata.com/dashboard and add it to .env.",
    );
  }
  return k;
}

/**
 * GET /scrape/glassdoor/listing — one search query against Glassdoor.
 * Returns the parsed `jobs` array (or the equivalent under .results/.data
 * depending on the response shape — HasData has varied historically).
 */
export async function listingSearch(
  params: ListingParams,
): Promise<{ jobs: HasDataJob[]; nextPageToken?: string }> {
  const url = new URL(`${BASE}/listing`);
  url.searchParams.set("keyword", params.keyword);
  url.searchParams.set("location", params.location);
  if (params.sort) url.searchParams.set("sort", params.sort);
  if (params.domain) url.searchParams.set("domain", params.domain);
  if (params.nextPageToken)
    url.searchParams.set("nextPageToken", params.nextPageToken);

  const res = await fetch(url.toString(), {
    method: "GET",
    headers: {
      "x-api-key": apiKey(),
      accept: "application/json",
      "content-type": "application/json",
    },
    cache: "no-store",
  });

  if (!res.ok) {
    const body = await res.text().catch(() => "");
    throw new Error(
      `HasData /listing ${res.status} ${res.statusText} — ${body.slice(0, 300)}`,
    );
  }

  const data = (await res.json()) as HasDataListingResponse;
  const jobs = data.jobs || data.results || data.data || [];
  return { jobs, nextPageToken: data.nextPageToken };
}

// ────────────────────────────────────────────────────────────────────────
// Normalizers shared between the API adapter and the CSV importer.
// ────────────────────────────────────────────────────────────────────────

/**
 * Convert a CAD salary into USD using a stable rough conversion. Real-time
 * FX isn't worth the dependency — the rate is for display only and gets
 * refreshed every time we re-verify.
 */
const FX_TO_USD: Record<string, number> = {
  USD: 1,
  CAD: 0.74,
  GBP: 1.27,
  EUR: 1.08,
  AUD: 0.66,
};

export function toUsd(amount: number, currency: string): number {
  if (!amount || !currency) return amount || 0;
  const rate = FX_TO_USD[currency.toUpperCase()];
  if (!rate) return amount; // Unknown currency — keep the original.
  return Math.round(amount * rate);
}

export function asNumber(x: unknown): number | undefined {
  if (typeof x === "number" && Number.isFinite(x)) return x;
  if (typeof x === "string") {
    const n = Number(x.replace(/[, ]/g, ""));
    return Number.isFinite(n) ? n : undefined;
  }
  return undefined;
}
