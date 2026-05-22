import type { MetadataRoute } from "next";
import { POSTINGS } from "@/lib/data";
import { siteUrl } from "@/lib/seo";

export default function sitemap(): MetadataRoute.Sitemap {
  const base = siteUrl();
  const now = new Date();

  const staticRoutes: MetadataRoute.Sitemap = [
    { url: `${base}/`, lastModified: now, changeFrequency: "daily", priority: 1 },
    { url: `${base}/how`, lastModified: now, changeFrequency: "monthly", priority: 0.6 },
    { url: `${base}/library`, lastModified: now, changeFrequency: "daily", priority: 0.8 },
    { url: `${base}/scan`, lastModified: now, changeFrequency: "weekly", priority: 0.5 },
  ];

  const reportRoutes: MetadataRoute.Sitemap = POSTINGS.map((p) => ({
    url: `${base}/report/${p.id}`,
    lastModified: now,
    changeFrequency: "monthly",
    priority: 0.7,
  }));

  return [...staticRoutes, ...reportRoutes];
}
