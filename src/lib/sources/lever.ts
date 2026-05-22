// Lever adapter — public postings API, one fetch per company.
// Endpoint: https://api.lever.co/v0/postings/{slug}?mode=json
import type { RawPosting, SourceAdapter } from "./types";

const COMPANIES = ["netflix", "spotify", "kraken", "brave", "gusto", "hashicorp"];

interface LeverJob {
  id?: string;
  text?: string;
  hostedUrl?: string;
  applyUrl?: string;
  description?: string;
  descriptionPlain?: string;
  categories?: { location?: string; team?: string; commitment?: string };
  workplaceType?: string;
  createdAt?: number;
}

export const lever: SourceAdapter = {
  slug: "lever",
  displayName: "Lever postings",
  async fetchLatest(limit: number): Promise<RawPosting[]> {
    const results = await Promise.allSettled(
      COMPANIES.map((slug) => fetchCompany(slug)),
    );
    const all: RawPosting[] = [];
    for (const r of results) {
      if (r.status === "fulfilled") all.push(...r.value);
    }
    // Lever exposes createdAt as a unix ms — newest first.
    all.sort((a, b) => (b.postedAt || "").localeCompare(a.postedAt || ""));
    return all.slice(0, limit);
  },
};

async function fetchCompany(companySlug: string): Promise<RawPosting[]> {
  const url = `https://api.lever.co/v0/postings/${companySlug}?mode=json`;
  const res = await fetch(url, {
    headers: { accept: "application/json" },
    cache: "no-store",
  });
  if (!res.ok) return [];
  const body = (await res.json()) as unknown;
  const jobs = Array.isArray(body) ? (body as LeverJob[]) : [];

  const remote = jobs.filter(
    (j) =>
      /remote|anywhere|distributed/i.test(j.categories?.location || "") ||
      /remote/i.test(j.workplaceType || ""),
  );
  return remote.map((j) => ({
    sourceSlug: "lever",
    sourceExternalId: `${companySlug}-${j.id || ""}`,
    url: j.hostedUrl || j.applyUrl || "",
    title: j.text || "Untitled role",
    company: prettify(companySlug),
    location: j.categories?.location || "Remote",
    description: (j.descriptionPlain || stripTags(j.description || "")).slice(0, 1200),
    postedAt: j.createdAt ? new Date(j.createdAt).toISOString() : null,
    raw: { company_slug: companySlug, ...j },
  }));
}

function prettify(slug: string): string {
  return slug.charAt(0).toUpperCase() + slug.slice(1);
}

function stripTags(html: string): string {
  return html.replace(/<[^>]*>/g, " ").replace(/\s+/g, " ").trim();
}
