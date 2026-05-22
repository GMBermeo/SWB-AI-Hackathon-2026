// Glassdoor adapter — uses HasData's /scrape/glassdoor/listing endpoint.
//
// Each call costs 5 HasData credits, so we keep this conservative:
// • One search per cron run (1 keyword × 1 location × 1 listing call)
// • Domain pinned to glassdoor.ca for Canada-first scope
// • The listing carries everything we need (employer, rating, salary,
//   industry) — no need to follow up against the per-job endpoint.
import type { RawPosting, SourceAdapter } from "./types";
import { listingSearch, asNumber, toUsd, type HasDataJob } from "../hasdata";

const KEYWORDS = ["Software Engineer", "Software Developer"];
const LOCATION = "Toronto, Canada";
const DOMAIN = "www.glassdoor.ca";

export const glassdoor: SourceAdapter = {
  slug: "glassdoor",
  displayName: "Glassdoor (HasData)",
  async fetchLatest(limit: number): Promise<RawPosting[]> {
    if (!process.env.HAS_DATA_API_KEY) {
      // No key configured — gracefully return empty so the cron still
      // succeeds against the other adapters.
      return [];
    }
    // Use a single keyword per run; rotate by day to stretch credits.
    const dayIdx = Math.floor(Date.now() / 86_400_000) % KEYWORDS.length;
    const keyword = KEYWORDS[dayIdx];

    const { jobs } = await listingSearch({
      keyword,
      location: LOCATION,
      domain: DOMAIN,
      sort: "recent",
    });

    return jobs.slice(0, limit).map((j) => toRawPosting(j));
  },
};

// Exported so the CSV importer reuses the exact same mapping logic.
export function toRawPosting(j: HasDataJob): RawPosting {
  const min = asNumber(j.salaryMin);
  const max = asNumber(j.salaryMax);
  const currency = (j.salaryCurrency || j.payCurrency || "USD").toUpperCase();

  const minUsd = min !== undefined ? toUsd(min, currency) : undefined;
  const maxUsd = max !== undefined ? toUsd(max, currency) : undefined;

  const rating =
    typeof j.rating === "number"
      ? j.rating
      : typeof j.rating === "string"
        ? Number(j.rating)
        : undefined;

  return {
    sourceSlug: "glassdoor",
    sourceExternalId: String(j.id ?? j.url ?? ""),
    url: j.url || "",
    title: j.title || "Untitled role",
    company: j.employer || "",
    location: [j.city, j.region, j.country].filter(Boolean).join(", ") || "Remote",
    description: (j.description || j.overview || "").slice(0, 1200),
    postedAt: j.datePosted || null,
    raw: j,
    salary:
      minUsd !== undefined && maxUsd !== undefined
        ? {
            min: minUsd,
            max: maxUsd,
            currency,
            period: j.salaryPeriod || "ANNUAL",
          }
        : undefined,
    companySignals: {
      domain: extractDomain(j.employerUrl),
      glassdoorUrl: j.employerUrl,
      glassdoorRating: rating && Number.isFinite(rating) ? rating : undefined,
      industry: j.industry,
      hqCity: j.city,
      hqRegion: j.region,
      hqCountry: j.country,
      capturedAt: new Date().toISOString(),
    },
    experience:
      j.experience ||
      (j.monthsOfExperience ? `${j.monthsOfExperience} months` : undefined),
  };
}

function extractDomain(url: string | undefined): string | undefined {
  if (!url) return undefined;
  try {
    const u = new URL(url.startsWith("http") ? url : `https://${url}`);
    return u.hostname.toLowerCase().replace(/^www\./, "");
  } catch {
    return undefined;
  }
}
