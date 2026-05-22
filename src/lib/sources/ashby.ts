// Ashby adapter — public job-board API, one fetch per company.
// Endpoint: https://api.ashbyhq.com/posting-api/job-board/{slug}
import type { RawPosting, SourceAdapter } from "./types";

const COMPANIES = ["linear", "vercel", "posthog", "sourcegraph", "ashbyhq"];

interface AshbyJob {
  id?: string;
  title?: string;
  jobUrl?: string;
  location?: string;
  department?: string;
  team?: string;
  isRemote?: boolean;
  publishedAt?: string;
  employmentType?: string;
}

interface AshbyResp {
  jobs?: AshbyJob[];
}

export const ashby: SourceAdapter = {
  slug: "ashby",
  displayName: "Ashby boards",
  async fetchLatest(limit: number): Promise<RawPosting[]> {
    const results = await Promise.allSettled(
      COMPANIES.map((slug) => fetchCompany(slug)),
    );
    const all: RawPosting[] = [];
    for (const r of results) {
      if (r.status === "fulfilled") all.push(...r.value);
    }
    all.sort((a, b) => (b.postedAt || "").localeCompare(a.postedAt || ""));
    return all.slice(0, limit);
  },
};

async function fetchCompany(companySlug: string): Promise<RawPosting[]> {
  const url = `https://api.ashbyhq.com/posting-api/job-board/${companySlug}?includeCompensation=true`;
  const res = await fetch(url, {
    headers: { accept: "application/json" },
    cache: "no-store",
  });
  if (!res.ok) return [];
  const body = (await res.json()) as AshbyResp;
  const jobs = body.jobs || [];

  const remote = jobs.filter(
    (j) => j.isRemote === true || /remote|anywhere/i.test(j.location || ""),
  );
  return remote.map((j) => ({
    sourceSlug: "ashby",
    sourceExternalId: `${companySlug}-${j.id || ""}`,
    url: j.jobUrl || "",
    title: j.title || "Untitled role",
    company: prettify(companySlug),
    location: j.location || "Remote",
    description: "",
    postedAt: j.publishedAt || null,
    raw: { company_slug: companySlug, ...j },
  }));
}

function prettify(slug: string): string {
  return slug.charAt(0).toUpperCase() + slug.slice(1);
}
