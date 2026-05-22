import type { Metadata } from "next";
import { LibraryScreen } from "@/components/LibraryScreen";

const TITLE = "Library";
const DESCRIPTION =
  "Every Lighthouse inspection on record — past verifications, scores, and verdicts for remote job postings, in chronological order.";

export const metadata: Metadata = {
  title: TITLE,
  description: DESCRIPTION,
  alternates: { canonical: "/library" },
  openGraph: {
    title: TITLE,
    description: DESCRIPTION,
    url: "/library",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: TITLE,
    description: DESCRIPTION,
  },
};

export default function Page() {
  return <LibraryScreen />;
}
