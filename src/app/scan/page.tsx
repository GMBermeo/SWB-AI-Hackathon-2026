import type { Metadata } from "next";
import { Suspense } from "react";
import { ScanScreen } from "@/components/ScanScreen";

const TITLE = "Verify a remote job posting";
const DESCRIPTION =
  "Paste any remote job URL — LinkedIn, Indeed, a recruiter DM — and Lighthouse will run a live, cited inspection across all four pillars.";

export const metadata: Metadata = {
  title: TITLE,
  description: DESCRIPTION,
  alternates: { canonical: "/scan" },
  openGraph: {
    title: TITLE,
    description: DESCRIPTION,
    url: "/scan",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: TITLE,
    description: DESCRIPTION,
  },
  robots: {
    index: true,
    follow: true,
  },
};

export default function Page() {
  return (
    <Suspense
      fallback={
        <main style={{ padding: "120px 0", textAlign: "center" }}>
          <p className="dek">Loading scanner...</p>
        </main>
      }
    >
      <ScanScreen />
    </Suspense>
  );
}
