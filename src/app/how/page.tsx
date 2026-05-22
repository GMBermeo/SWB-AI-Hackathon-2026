import type { Metadata } from "next";
import { HowScreen } from "@/components/HowScreen";

const TITLE = "How it works";
const DESCRIPTION =
  "The Lighthouse methodology — four pillars (Real, Active, Fair, Credible), the public sources we cite, and how every claim becomes auditable evidence.";

export const metadata: Metadata = {
  title: TITLE,
  description: DESCRIPTION,
  alternates: { canonical: "/how" },
  openGraph: {
    title: TITLE,
    description: DESCRIPTION,
    url: "/how",
    type: "article",
  },
  twitter: {
    card: "summary_large_image",
    title: TITLE,
    description: DESCRIPTION,
  },
};

export default function Page() {
  return <HowScreen />;
}
