// Shared shape every source adapter returns. Mirrors columns on the
// `postings` table — we map straight in without further normalization.

export interface SalaryBand {
  /** USD-converted minimum. */
  min: number;
  /** USD-converted maximum. */
  max: number;
  /** Original currency code, e.g. "CAD", "USD". */
  currency: string;
  /** "ANNUAL" | "MONTHLY" | "HOURLY". */
  period: string;
}

export interface CompanySignals {
  /** Employer's primary domain ("moneris.com"), if discoverable. */
  domain?: string;
  /** Glassdoor company profile URL. */
  glassdoorUrl?: string;
  /** 0–5 Glassdoor rating. */
  glassdoorRating?: number;
  /** Industry classification ("Finance", "Healthcare IT", …). */
  industry?: string;
  /** Headquarters city / region / country. */
  hqCity?: string;
  hqRegion?: string;
  hqCountry?: string;
  /** When this signal bundle was captured. */
  capturedAt?: string;
}

export interface RawPosting {
  /** Adapter slug, e.g. "remoteok" — matches sources.slug column. */
  sourceSlug: string;
  /** Stable ID from the source (Greenhouse job id, Lever id, RSS guid, …). */
  sourceExternalId: string;
  /** Canonical posting URL on the source. */
  url: string;
  /** Posting title / role. */
  title: string;
  /** Company name if the source supplies one (often "" for board APIs called per-company). */
  company: string;
  /** Free-form location string ("Remote", "Toronto, ON", "Remote — Americas"). */
  location: string;
  /** Short description / scope blurb (plain-text-ish, may include light HTML). */
  description: string;
  /** ISO-8601 date the source claims the role was posted. */
  postedAt: string | null;
  /** Full upstream payload for forensics. */
  raw: unknown;
  /** Optional richer salary band when the source publishes one. */
  salary?: SalaryBand;
  /** Optional company-level signals (Glassdoor rating, industry, etc.). */
  companySignals?: CompanySignals;
  /** Experience requirement, free-form ("3-5 years", "Senior"). */
  experience?: string;
}

export interface SourceAdapter {
  /** Matches the `sources.slug` column. */
  slug: string;
  /** Pretty name for logs and the UI. */
  displayName: string;
  /** Pull up to `limit` of the newest postings. Throw on failure. */
  fetchLatest(limit: number): Promise<RawPosting[]>;
}
