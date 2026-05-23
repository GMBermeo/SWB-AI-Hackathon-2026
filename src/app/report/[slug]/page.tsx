import { POSTINGS } from "@/lib/data";
import { ReportScreen } from "@/components/ReportScreen";
import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { supabase, rowToPosting } from "@/lib/supabase";
import { AUTHOR, SITE_NAME, siteUrl } from "@/lib/seo";
import type { Posting } from "@/lib/types";

export async function generateStaticParams() {
  return POSTINGS.map((p) => ({ slug: p.id }));
}

interface LoadedPosting {
  posting: Posting;
  citations: { uri: string; title?: string }[];
}

async function loadPosting(slug: string): Promise<LoadedPosting | undefined> {
  const seed = POSTINGS.find((p) => p.id === slug);
  if (seed) return { posting: seed, citations: [] };
  try {
    const sb = supabase();
    const { data, error } = await sb
      .from("inspections")
      .select("*")
      .eq("id", slug)
      .single();
    if (!error && data) {
      return {
        posting: rowToPosting(data),
        citations: (data.citations || []) as { uri: string; title?: string }[],
      };
    }
  } catch {
    // ignore — fall through to undefined
  }
  return undefined;
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const loaded = await loadPosting(slug);
  const posting = loaded?.posting;

  if (!posting) {
    return {
      title: "Report not found",
      robots: { index: false, follow: false },
    };
  }

  const title = `${posting.company} · ${posting.role}`;
  const description = posting.editorial;
  const canonical = `/report/${posting.id}`;

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
      tags: [
        posting.company,
        posting.role,
        posting.verdict,
        "Lighthouse inspection",
      ],
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
    },
    other: {
      "lighthouse:verdict": posting.verdict,
      "lighthouse:score": String(posting.score),
    },
  };
}

export default async function Page({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const loaded = await loadPosting(slug);

  if (!loaded) {
    notFound();
  }

  const { posting, citations } = loaded;

  const base = siteUrl();
  const articleJsonLd = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: `${posting.company} · ${posting.role} — Lighthouse inspection`,
    description: posting.editorial,
    url: `${base}/report/${posting.id}`,
    mainEntityOfPage: `${base}/report/${posting.id}`,
    inLanguage: "en-US",
    publisher: {
      "@type": "Organization",
      name: SITE_NAME,
      url: base,
    },
    author: { "@type": "Person", name: AUTHOR.name, url: AUTHOR.url },
    keywords: [
      posting.company,
      posting.role,
      posting.verdict,
      "remote job verification",
    ].join(", "),
    about: {
      "@type": "JobPosting",
      title: posting.role,
      hiringOrganization: {
        "@type": "Organization",
        name: posting.company,
        sameAs: posting.url,
      },
      jobLocationType: "TELECOMMUTE",
      employmentType: "FULL_TIME",
      baseSalary: {
        "@type": "MonetaryAmount",
        currency: "USD",
        value: {
          "@type": "QuantitativeValue",
          minValue: posting.compMin,
          maxValue: posting.compMax,
          unitText: "YEAR",
        },
      },
      url: posting.url,
    },
  };

  return (
    <>
      <ReportScreen posting={posting} citations={citations} />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(articleJsonLd) }}
      />
    </>
  );
}
