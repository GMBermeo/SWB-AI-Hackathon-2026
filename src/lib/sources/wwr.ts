// We Work Remotely adapter — public RSS feeds, one per category.
// Endpoint pattern: https://weworkremotely.com/categories/{cat}.rss
//
// We do a minimal regex parse of RSS 2.0; the feeds are well-formed and we
// don't want to pull in an XML parser dep for ~6 fields.
import type { RawPosting, SourceAdapter } from "./types";

const CATEGORIES = [
  "remote-programming-jobs",
  "remote-design-jobs",
  "remote-product-jobs",
];

export const wwr: SourceAdapter = {
  slug: "wwr",
  displayName: "We Work Remotely",
  async fetchLatest(limit: number): Promise<RawPosting[]> {
    const results = await Promise.allSettled(
      CATEGORIES.map((cat) => fetchCategory(cat)),
    );
    const all: RawPosting[] = [];
    for (const r of results) {
      if (r.status === "fulfilled") all.push(...r.value);
    }
    all.sort((a, b) => (b.postedAt || "").localeCompare(a.postedAt || ""));
    return all.slice(0, limit);
  },
};

async function fetchCategory(category: string): Promise<RawPosting[]> {
  const url = `https://weworkremotely.com/categories/${category}.rss`;
  const res = await fetch(url, {
    headers: { accept: "application/rss+xml,application/xml,text/xml" },
    cache: "no-store",
  });
  if (!res.ok) return [];
  const xml = await res.text();
  return parseRssItems(xml, category);
}

interface RssItem {
  title: string;
  link: string;
  guid: string;
  pubDate: string;
  description: string;
}

function parseRssItems(xml: string, category: string): RawPosting[] {
  // Items typically look like:
  //   <item>
  //     <title><![CDATA[Company: Role Title]]></title>
  //     <link>https://weworkremotely.com/...</link>
  //     <guid>...</guid>
  //     <pubDate>Wed, 21 May 2026 13:00:00 +0000</pubDate>
  //     <description><![CDATA[<p>...</p>]]></description>
  //   </item>
  const items: RssItem[] = [];
  const itemRe = /<item\b[^>]*>([\s\S]*?)<\/item>/gi;
  let m: RegExpExecArray | null;
  while ((m = itemRe.exec(xml))) {
    const block = m[1];
    items.push({
      title: pickTag(block, "title"),
      link: pickTag(block, "link"),
      guid: pickTag(block, "guid"),
      pubDate: pickTag(block, "pubDate"),
      description: pickTag(block, "description"),
    });
  }

  return items.map((it) => {
    // WWR titles often follow "Company: Role Title".
    const [maybeCompany, ...rest] = it.title.split(":");
    const hasCompany = rest.length > 0 && maybeCompany.length < 60;
    const company = hasCompany ? maybeCompany.trim() : "";
    const title = hasCompany ? rest.join(":").trim() : it.title;

    return {
      sourceSlug: "wwr",
      sourceExternalId: it.guid || it.link,
      url: it.link,
      title: title || "Untitled role",
      company,
      location: "Remote",
      description: stripTags(it.description).slice(0, 1200),
      postedAt: it.pubDate ? safeIso(it.pubDate) : null,
      raw: { category, ...it },
    };
  });
}

function pickTag(block: string, tag: string): string {
  const re = new RegExp(`<${tag}[^>]*>([\\s\\S]*?)</${tag}>`, "i");
  const m = re.exec(block);
  if (!m) return "";
  return stripCdata(m[1]).trim();
}

function stripCdata(s: string): string {
  return s.replace(/^\s*<!\[CDATA\[/, "").replace(/\]\]>\s*$/, "");
}

function stripTags(html: string): string {
  return html.replace(/<[^>]*>/g, " ").replace(/\s+/g, " ").trim();
}

function safeIso(rfc822: string): string | null {
  const d = new Date(rfc822);
  return Number.isNaN(d.getTime()) ? null : d.toISOString();
}
