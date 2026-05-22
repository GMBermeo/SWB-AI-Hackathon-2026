// RemoteOK adapter — public JSON.
// Docs: https://remoteok.com/api (first array element is a legal disclaimer
// to ignore; rest are job objects). Polite User-Agent is required.
import type { RawPosting, SourceAdapter } from "./types";

const ENDPOINT = "https://remoteok.com/api";
const UA = "Lighthouse/1.0 (+https://github.com/GMBermeo/SWB-AI-Hackathon-2026)";

interface RemoteOKJob {
  id?: string | number;
  url?: string;
  apply_url?: string;
  company?: string;
  position?: string;
  location?: string;
  description?: string;
  date?: string;
  epoch?: number;
}

export const remoteok: SourceAdapter = {
  slug: "remoteok",
  displayName: "Remote OK",
  async fetchLatest(limit: number): Promise<RawPosting[]> {
    const res = await fetch(ENDPOINT, {
      headers: { accept: "application/json", "user-agent": UA },
      cache: "no-store",
    });
    if (!res.ok) throw new Error(`RemoteOK ${res.status}`);

    const data = (await res.json()) as unknown;
    if (!Array.isArray(data)) throw new Error("RemoteOK returned non-array");

    const jobs = data.filter(
      (j): j is RemoteOKJob =>
        !!j && typeof j === "object" && "id" in j && "position" in j,
    );
    // The API returns newest-first already.
    return jobs.slice(0, limit).map((j) => ({
      sourceSlug: "remoteok",
      sourceExternalId: String(j.id ?? ""),
      url: j.url || j.apply_url || "",
      title: j.position || "Untitled role",
      company: j.company || "",
      location: j.location || "Remote",
      description: stripTags(j.description || "").slice(0, 1200),
      postedAt: j.date || (j.epoch ? new Date(j.epoch * 1000).toISOString() : null),
      raw: j,
    }));
  },
};

function stripTags(html: string): string {
  return html.replace(/<[^>]*>/g, " ").replace(/\s+/g, " ").trim();
}
