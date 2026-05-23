import type { Metadata } from "next";
import { CompaniesScreen } from "@/components/CompaniesScreen";

const TITLE = "Companies";
const DESCRIPTION =
  "Every company Lighthouse has inspected — trust cards aggregating mean score, latest verdict, external profiles, and posting history.";

export const metadata: Metadata = {
  title: TITLE,
  description: DESCRIPTION,
  alternates: { canonical: "/companies" },
  openGraph: {
    title: TITLE,
    description: DESCRIPTION,
    url: "/companies",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: TITLE,
    description: DESCRIPTION,
  },
};

export default function Page() {
  return <CompaniesScreen />;
}
