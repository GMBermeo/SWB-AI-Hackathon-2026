import type { Metadata, Viewport } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import { Analytics } from "@vercel/analytics/next";
import { Masthead } from "@/components/Masthead";
import { LighthouseMark } from "@/components/LighthouseMark";
import { AUTHOR, SITE_DESCRIPTION, SITE_NAME, SITE_TAGLINE, siteUrl } from "@/lib/seo";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
  display: "swap",
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
  display: "swap",
});

const SITE = siteUrl();
const TITLE_DEFAULT = `${SITE_NAME} — ${SITE_TAGLINE}`;

export const metadata: Metadata = {
  metadataBase: new URL(SITE),
  title: {
    default: TITLE_DEFAULT,
    template: `%s — ${SITE_NAME}`,
  },
  description: SITE_DESCRIPTION,
  applicationName: SITE_NAME,
  generator: "Next.js",
  keywords: [
    "remote work",
    "remote jobs",
    "job scam detection",
    "job verification",
    "hiring transparency",
    "career due diligence",
    "fake job postings",
    "Lighthouse",
  ],
  authors: [{ name: AUTHOR.name, url: AUTHOR.url }],
  creator: AUTHOR.name,
  publisher: AUTHOR.name,
  category: "technology",
  referrer: "strict-origin-when-cross-origin",
  formatDetection: { telephone: false, email: false, address: false },
  alternates: {
    canonical: "/",
  },
  openGraph: {
    type: "website",
    url: SITE,
    siteName: SITE_NAME,
    title: TITLE_DEFAULT,
    description: SITE_DESCRIPTION,
    locale: "en_US",
  },
  twitter: {
    card: "summary_large_image",
    title: TITLE_DEFAULT,
    description: SITE_DESCRIPTION,
    creator: "@guilherme_bermeo",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-snippet": -1,
      "max-image-preview": "large",
      "max-video-preview": -1,
    },
  },
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: [
    { media: "(prefers-color-scheme: light)", color: "#faf8f3" },
    { media: "(prefers-color-scheme: dark)", color: "#14130f" },
  ],
  colorScheme: "light",
};

const EDITION_DATE = new Date("2026-05-21");
const EDITION = `Vol. I · No. 142 · ${EDITION_DATE.toLocaleDateString("en-US", {
  weekday: "long",
})}`;

const ORG_JSONLD = {
  "@context": "https://schema.org",
  "@type": "Organization",
  name: SITE_NAME,
  url: SITE,
  logo: `${SITE}/icon`,
  description: SITE_DESCRIPTION,
  founder: { "@type": "Person", name: AUTHOR.name, url: AUTHOR.url },
};

const WEBSITE_JSONLD = {
  "@context": "https://schema.org",
  "@type": "WebSite",
  name: SITE_NAME,
  url: SITE,
  description: SITE_DESCRIPTION,
  inLanguage: "en-US",
  potentialAction: {
    "@type": "SearchAction",
    target: `${SITE}/scan?url={search_term_string}`,
    "query-input": "required name=search_term_string",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${geistSans.variable} ${geistMono.variable}`}>
      <body>
        <div className="page">
          <Masthead edition={EDITION} />
          {children}
          <footer className="lh-footer">
            <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
              <LighthouseMark size={16} />
              <span className="byline">
                Lighthouse · A verification engine for remote work · MMXXVI
              </span>
            </div>
            <div className="byline lh-footer-meta">
              <span style={{ color: "var(--ink-32)" }}>Cited, audited, open.</span>
              <span aria-hidden="true" style={{ color: "var(--ink-16)" }}>·</span>
              <span style={{ color: "var(--ink-50)" }}>
                Created by{" "}
                <a
                  href={AUTHOR.url}
                  rel="author noopener"
                  target="_blank"
                  className="lh-author-link"
                >
                  {AUTHOR.name}
                </a>
              </span>
            </div>
          </footer>
        </div>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(ORG_JSONLD) }}
        />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(WEBSITE_JSONLD) }}
        />
        <Analytics />
      </body>
    </html>
  );
}
