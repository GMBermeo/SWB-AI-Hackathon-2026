import type { Metadata } from "next";
import { CompanyDetailScreen } from "@/components/CompanyDetailScreen";
import { supabase } from "@/lib/supabase";
import type { CompanyRow } from "@/lib/companies";
import { AUTHOR, SITE_NAME, siteUrl } from "@/lib/seo";

async function loadCompany(slug: string): Promise<CompanyRow | null> {
  try {
    const sb = supabase();
    const { data, error } = await sb
      .from("companies")
      .select("*")
      .eq("slug", slug)
      .maybeSingle<CompanyRow>();
    if (error || !data) return null;
    return data;
  } catch {
    return null;
  }
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const c = await loadCompany(slug);
  if (!c) {
    return {
      title: "Company not found",
      robots: { index: false, follow: false },
    };
  }

  const title = `${c.display_name} · Trust card`;
  const description =
    c.notes ||
    `Lighthouse trust card for ${c.display_name}: ${c.inspection_count} inspection${c.inspection_count === 1 ? "" : "s"}, mean score ${c.mean_score != null ? Math.round(c.mean_score) : "—"} / 100.`;
  const canonical = `/companies/${slug}`;

  return {
    title,
    description,
    alternates: { canonical },
    openGraph: {
      type: "article",
      title,
      description,
      url: canonical,
      siteName: SITE_NAME,
      authors: [AUTHOR.name],
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
    },
    other: c.last_verdict
      ? {
          "lighthouse:verdict": c.last_verdict,
          "lighthouse:score": String(c.mean_score ?? ""),
        }
      : {},
  };
}

export default async function Page({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const company = await loadCompany(slug);
  const base = siteUrl();
  const jsonLd = company
    ? {
        "@context": "https://schema.org",
        "@type": "Organization",
        name: company.display_name,
        url: company.primary_domain
          ? `https://${company.primary_domain}`
          : `${base}/companies/${slug}`,
        sameAs: [
          company.linkedin_url,
          company.glassdoor_url,
          company.crunchbase_url,
          company.github_org ? `https://github.com/${company.github_org}` : null,
        ].filter(Boolean),
        foundingDate: company.founded_year
          ? String(company.founded_year)
          : undefined,
        address: company.hq_country
          ? {
              "@type": "PostalAddress",
              addressCountry: company.hq_country,
              addressRegion: company.hq_region || undefined,
              addressLocality: company.hq_city || undefined,
            }
          : undefined,
      }
    : null;

  return (
    <>
      <CompanyDetailScreen slug={slug} />
      {jsonLd && (
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      )}
    </>
  );
}
