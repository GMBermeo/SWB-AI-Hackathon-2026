// Greenhouse adapter — public board API, one fetch per company.
// Docs: https://developers.greenhouse.io/job-board.html
//
// The board API is unauthenticated and returns ALL public jobs at a company.
// We pull from a curated list and pick the newest `limit` across all of them,
// filtered to remote-friendly roles.
import type { RawPosting, SourceAdapter } from "./types";

// Curated set of companies that use Greenhouse and reliably post remote
// roles. Add or remove via supabase later; for V1 this list is baked in.
const COMPANIES = [
  "stripe",
  "airbnb",
  "discord",
  "notion",
  "instacart",
  "doordash",
];

interface GreenhouseJob {
  id: number;
  title: string;
  absolute_url: string;
  updated_at?: string;
  location?: { name?: string };
  content?: string;
}

interface GreenhouseResp {
  jobs?: GreenhouseJob[];
}

export const greenhouse: SourceAdapter = {
  slug: "greenhouse",
  displayName: "Greenhouse boards",
  async fetchLatest(limit: number): Promise<RawPosting[]> {
    const results = await Promise.allSettled(
      COMPANIES.map((slug) => fetchCompany(slug)),
    );
    const all: RawPosting[] = [];
    for (const r of results) {
      if (r.status === "fulfilled") all.push(...r.value);
    }
    // Sort newest first across companies, then trim to limit.
    all.sort((a, b) => (b.postedAt || "").localeCompare(a.postedAt || ""));
    return all.slice(0, limit);
  },
};

async function fetchCompany(companySlug: string): Promise<RawPosting[]> {
  // Drop `content=true` — Stripe/Airbnb boards return 3–5 MB with it.
  // Description is re-fetched at verification time by Gemini anyway.
  const url = `https://boards-api.greenhouse.io/v1/boards/${companySlug}/jobs`;
  const res = await fetch(url, {
    headers: { accept: "application/json" },
    cache: "no-store",
  });
  if (!res.ok) return [];
  const body = (await res.json()) as GreenhouseResp;
  const jobs = body.jobs || [];

  // Keep only remote-friendly listings to match Lighthouse's scope.
  const remote = jobs.filter((j) =>
    /remote|anywhere|distributed/i.test(j.location?.name || ""),
  );
  return remote.map((j) => ({
    sourceSlug: "greenhouse",
    sourceExternalId: `${companySlug}-${j.id}`,
    url: j.absolute_url,
    title: j.title,
    company: prettify(companySlug),
    location: j.location?.name || "Remote",
    description: "",
    postedAt: j.updated_at || null,
    raw: { company_slug: companySlug, ...j },
  }));
}

function prettify(slug: string): string {
  return slug.charAt(0).toUpperCase() + slug.slice(1);
}


