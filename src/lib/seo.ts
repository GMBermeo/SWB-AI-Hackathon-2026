const FALLBACK_URL = "https://lighthouse.bermeo.dev";

export function siteUrl(): string {
  const explicit = process.env.NEXT_PUBLIC_SITE_URL;
  if (explicit && explicit.length > 0) return explicit.replace(/\/$/, "");
  const vercel = process.env.VERCEL_PROJECT_PRODUCTION_URL || process.env.VERCEL_URL;
  if (vercel && vercel.length > 0) return `https://${vercel}`;
  return FALLBACK_URL;
}

export const SITE_NAME = "Lighthouse";
export const SITE_TAGLINE = "A verification engine for remote work";
export const SITE_DESCRIPTION =
  "Lighthouse inspects any remote job posting against four pillars — Real, Active, Fair, Credible — and returns a transparent report with cited evidence.";

export const AUTHOR = {
  name: "Guilherme Bermeo",
  url: "https://guilherme.bermeo.dev",
} as const;
