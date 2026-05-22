import { POSTINGS } from "@/lib/data";
import { ReportScreen } from "@/components/ReportScreen";
import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { supabase, rowToPosting } from "@/lib/supabase";

export async function generateStaticParams() {
  return POSTINGS.map((p) => ({ slug: p.id }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  let posting = POSTINGS.find((p) => p.id === slug);

  if (!posting) {
    try {
      const sb = supabase();
      const { data, error } = await sb
        .from("inspections")
        .select("*")
        .eq("id", slug)
        .single();
      if (!error && data) {
        posting = rowToPosting(data);
      }
    } catch {
      // ignore
    }
  }

  if (!posting) {
    return {
      title: "Report — Lighthouse",
    };
  }

  return {
    title: `${posting.company} · ${posting.role} — Lighthouse`,
    description: posting.editorial,
  };
}

export default async function Page({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  let posting = POSTINGS.find((p) => p.id === slug);

  if (!posting) {
    try {
      const sb = supabase();
      const { data, error } = await sb
        .from("inspections")
        .select("*")
        .eq("id", slug)
        .single();
      if (!error && data) {
        posting = rowToPosting(data);
      }
    } catch {
      // ignore
    }
  }

  if (!posting) {
    notFound();
  }

  return <ReportScreen posting={posting} />;
}
