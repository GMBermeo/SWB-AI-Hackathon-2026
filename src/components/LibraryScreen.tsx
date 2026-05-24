"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { POSTINGS, LIBRARY_EXTRA } from "@/lib/data";
import { companySlug } from "@/lib/companies";
import type { Posting, Verdict } from "@/lib/types";

type Row = {
  id: string;
  company: string;
  role: string;
  score: number;
  verdict: Verdict;
  posted: string;
  source: string;
  _full?: Posting;
};

type LiveInspection = Posting & { createdAt: string; source: string };

interface Pending {
  id: string;
  source: string;
  url: string;
  urlNormalized: string;
  title: string;
  company: string;
  location: string;
  postedAt: string | null;
  firstSeenAt: string;
  status: "new" | "verifying" | "failed";
}

function relTime(iso: string): string {
  const d = (Date.now() - new Date(iso).getTime()) / 1000;
  if (d < 60) return "just now";
  if (d < 3600) return `${Math.floor(d / 60)}m`;
  if (d < 86400) return `${Math.floor(d / 3600)}h`;
  if (d < 86400 * 7) return `${Math.floor(d / 86400)}d`;
  if (d < 86400 * 30) return `${Math.floor(d / (86400 * 7))}w`;
  return `${Math.floor(d / (86400 * 30))}mo`;
}

export function LibraryScreen() {
  const router = useRouter();

  const handleVerify = (rawUrl: string) => {
    const url = rawUrl.startsWith("http") ? rawUrl : "https://" + rawUrl;
    const demo = POSTINGS.find((p) => p.url === url);
    if (demo) {
      router.push(`/scan?demo=${demo.id}`);
    } else {
      router.push(`/scan?url=${encodeURIComponent(url)}`);
    }
  };
  const [live, setLive] = useState<LiveInspection[]>([]);
  const [pending, setPending] = useState<Pending[]>([]);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      // Fetch both feeds in parallel — failures are non-fatal.
      const [libRes, qRes] = await Promise.allSettled([
        fetch("/api/library?limit=50").then((r) => r.json()),
        fetch("/api/queue?limit=10").then((r) => r.json()),
      ]);
      if (cancelled) return;
      if (libRes.status === "fulfilled" && Array.isArray(libRes.value?.inspections)) {
        setLive(libRes.value.inspections);
      }
      if (qRes.status === "fulfilled" && Array.isArray(qRes.value?.pending)) {
        setPending(qRes.value.pending);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, []);

  const liveRows: Row[] = live.map((s) => ({
    id: s.id,
    company: s.company,
    role: s.role,
    score: s.score,
    verdict: s.verdict,
    posted: relTime(s.createdAt),
    source: s.source,
    _full: s,
  }));

  const demoRows: Row[] = POSTINGS.map((s) => ({
    id: s.id,
    company: s.company,
    role: s.role,
    score: s.score,
    verdict: s.verdict,
    posted: s.posted.replace(" ago", ""),
    source: s.url.replace(/^https?:\/\//, "").split("/")[0],
    _full: s,
  }));

  // Live inspections first (most recent), then bundled demos, then filler.
  // De-dupe by URL/source so live overrides demo if a user verified one of
  // the bundled URLs.
  const seenIds = new Set<string>();
  const all: Row[] = [];
  for (const r of [...liveRows, ...demoRows]) {
    const key = `${r.company}::${r.role}`;
    if (seenIds.has(key)) continue;
    seenIds.add(key);
    all.push(r);
  }
  if (all.length < 8) all.push(...LIBRARY_EXTRA);

  const vClass = (v: Verdict) =>
    v === "VERIFIED"
      ? "v-verified"
      : v === "INVESTIGATE"
        ? "v-investigate"
        : "v-decline";

  return (
    <main style={{ paddingTop: 32, paddingBottom: 96 }}>
      <div className="lh-library-head">
        <div>
          <div className="kicker">Library · all inspections</div>
          <h1 className="headline" style={{ margin: "8px 0 0" }}>
            Past verifications, in chronological order.
          </h1>
        </div>
        <button
          className="btn btn-ghost btn-sm"
          onClick={() => router.push("/")}
        >
          ↗ Run new inspection
        </button>
      </div>



      <hr className="rule" style={{ marginTop: 28 }} />

      <div className="byline lh-lib-head">
        <div>№</div>
        <div>Company</div>
        <div>Role</div>
        <div>Source</div>
        <div style={{ textAlign: "right" }}>Score</div>
        <div style={{ textAlign: "right" }}>Verdict</div>
      </div>

      {all.map((row, i) => (
        <div
          key={row.id}
          className="lh-lib-row"
          onClick={() => {
            if (row._full) {
              router.push(`/report/${row._full.id}`);
            }
          }}
          style={{ cursor: row._full ? "pointer" : "default" }}
          onMouseEnter={(e) => {
            if (row._full)
              (e.currentTarget as HTMLDivElement).style.background =
                "var(--cream-deep)";
          }}
          onMouseLeave={(e) => {
            (e.currentTarget as HTMLDivElement).style.background = "transparent";
          }}
        >
          <div className="mono" style={{ fontSize: 12, color: "var(--ink-32)" }}>
            {String(i + 1).padStart(3, "0")}
          </div>
          <div style={{ fontSize: 17, fontWeight: 500, letterSpacing: "-0.012em" }}>
            <Link
              href={`/companies/${companySlug(row.company)}`}
              onClick={(e) => e.stopPropagation()}
              style={{
                color: "inherit",
                textDecoration: "underline",
                textDecorationColor: "var(--ink-32)",
                textUnderlineOffset: 3,
              }}
            >
              {row.company}
            </Link>
          </div>
          <div style={{ fontSize: 15, color: "var(--ink-80)" }}>{row.role}</div>
          <div className="mono" style={{ fontSize: 11, color: "var(--ink-50)" }}>
            {row.source} · {row.posted}
          </div>
          <div
            className="mono"
            style={{
              fontSize: 22,
              fontWeight: 400,
              letterSpacing: "-0.02em",
              textAlign: "right",
              color:
                row.score >= 80
                  ? "var(--trust)"
                  : row.score >= 50
                    ? "var(--ink)"
                    : "var(--amber)",
            }}
          >
            {row.score}
          </div>
          <div style={{ textAlign: "right" }}>
            <span className={"verdict-pill " + vClass(row.verdict)}>
              <span className="dot" /> {row.verdict}
            </span>
          </div>
        </div>
      ))}

      <p className="byline" style={{ marginTop: 24, color: "var(--ink-32)" }}>
        Showing {all.length} verified.
        Click any verified row to open its report.
      </p>
    </main>
  );
}
