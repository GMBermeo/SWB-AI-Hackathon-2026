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

    // Filter to strictly Canada-remote postings and ignore non-English listings
    const filteredJobs = jobs.filter(isCanadaRemote);

    // The API returns newest-first already.
    return filteredJobs.slice(0, limit).map((j) => ({
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

function isCanadaRemote(j: RemoteOKJob): boolean {
  const title = j.position || "";
  const desc = j.description || "";
  const location = (j.location || "").toLowerCase().trim();

  // 1. Language check: filter out Portuguese and Spanish listings
  const lowerTitle = title.toLowerCase();
  const lowerDesc = desc.toLowerCase();

  const ptEsPatterns = [
    /\bde recrutamento\b/i,
    /\bseleção\b/i,
    /\bselecao\b/i,
    /\bdiarista\b/i,
    /\bdesenvolvedor\b/i,
    /\bgerente de\b/i,
    /\banalista de\b/i,
    /\bagente de\b/i,
    /\basesor comercial\b/i,
    /\bcomercial paraguay\b/i,
    /\bcomercial chile\b/i,
    /\bvaga de\b/i,
    /\btrabajo remoto\b/i,
    /\bdesarrollador\b/i,
    /\bsoporte técnico\b/i,
    /\bsoporte tecnico\b/i,
    /\bpara trabajar\b/i,
    /\bexperiencia en\b/i,
    /\bconocimientos en\b/i
  ];

  if (ptEsPatterns.some((re) => re.test(lowerTitle) || re.test(lowerDesc))) {
    return false;
  }

  // 2. Location Check
  // Empty location, "remote", "worldwide", "anywhere" are eligible for Canada.
  if (!location || location === "remote" || location === "worldwide" || location === "anywhere") {
    return true;
  }

  // Exclude other countries if they are present and "canada" is NOT
  const hasCanada = location.includes("canada");
  const otherCountries = [
    /\b(brazil|brasil|india|ecuador|chile|paraguay|argentina|colombia|peru|spain|portugal|mexico|singapore|japan|china|australia|new zealand|germany|france|united kingdom|uk|usa|united states)\b/i
  ];

  if (!hasCanada && otherCountries.some((re) => re.test(location))) {
    return false;
  }

  // Check if it is explicitly Canada or a known Canadian city/province
  const canadianWords = [
    "canada", "toronto", "vancouver", "montreal", "calgary", "edmonton", "ottawa", "kitchener",
    "burnaby", "st thomas", "waterloo", "mississauga", "winnipeg", "quebec", "halifax", "victoria",
    "hamilton", "london", "on", "bc", "ab", "qc", "ns", "mb", "sk", "nb", "nl", "pe", "yt", "nt", "nu"
  ];

  // Tokenize the location to match exact words
  const words = location.split(/[\s,]+/);
  const matchesCanada = words.some((w) => canadianWords.includes(w));

  return matchesCanada;
}

function stripTags(html: string): string {
  return html.replace(/<[^>]*>/g, " ").replace(/\s+/g, " ").trim();
}
