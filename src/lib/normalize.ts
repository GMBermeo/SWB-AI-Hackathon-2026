// Canonicalize a URL into a stable key so two pastes of the same posting
// (one with utm_*, one without; trailing slash; case difference in host)
// hit the same cache row.
//
// We don't try to be clever about job-board canonicalization (e.g. mapping
// /jobs/123 == /jobs/123/title-slug). Boards are noisy. Good-enough is fine.

const TRACKING_PARAMS = new Set([
  "utm_source",
  "utm_medium",
  "utm_campaign",
  "utm_term",
  "utm_content",
  "ref",
  "ref_src",
  "ref_url",
  "source",
  "src",
  "trk",
  "trkInfo",
  "gh_src",
  "gh_jid",
  "lever-source",
  "fbclid",
  "gclid",
  "mc_cid",
  "mc_eid",
]);

export function normalizeUrl(input: string): string {
  let raw = input.trim();
  if (!raw) return "";
  if (!/^https?:\/\//i.test(raw)) raw = "https://" + raw;

  let u: URL;
  try {
    u = new URL(raw);
  } catch {
    return raw.toLowerCase();
  }

  u.hostname = u.hostname.toLowerCase().replace(/^www\./, "");
  u.protocol = "https:";
  u.hash = "";

  const keep: [string, string][] = [];
  u.searchParams.forEach((v, k) => {
    if (!TRACKING_PARAMS.has(k.toLowerCase())) keep.push([k, v]);
  });
  keep.sort(([a], [b]) => a.localeCompare(b));
  u.search = "";
  for (const [k, v] of keep) u.searchParams.append(k, v);

  let out = u.toString();
  // Trim trailing slash on path-only URLs (don't trim if there's a query).
  if (out.endsWith("/") && !u.search) out = out.slice(0, -1);
  return out;
}
