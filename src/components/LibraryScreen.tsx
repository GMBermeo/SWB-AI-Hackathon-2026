"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { POSTINGS, LIBRARY_EXTRA } from "@/lib/data";

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
  const [live, setLive] = useState<LiveInspection[]>([]);

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
        // queue fetched successfully but not rendered in initial version
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
  // De-dupe by URL/id so live overrides demo if a user verified one of
  // the bundled URLs.
  const seenKeys = new Set<string>();
  const all: Row[] = [];
  for (const r of [...liveRows, ...demoRows]) {
    const key = r._full?.url || r.id;
    if (seenKeys.has(key)) continue;
    seenKeys.add(key);
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
    <main id="main" style={{ paddingTop: 32, paddingBottom: 96 }}>
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

      {all.map((row, i) => {
        const isClickable = !!row._full;
        const rowContent = (
          <div
            className={`lh-lib-row ${isClickable ? "is-clickable" : ""}`}
          >
            <div className="mono" style={{ fontSize: 12, color: "var(--ink-32)" }}>
              {String(i + 1).padStart(3, "0")}
            </div>
            <div style={{ fontSize: 17, fontWeight: 500, letterSpacing: "-0.012em" }}>
              {row.company}
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
        );

        if (isClickable && row._full) {
          return (
            <Link
              key={row.id}
              href={`/report/${row._full.id}`}
              style={{ textDecoration: "none", color: "inherit" }}
            >
              {rowContent}
            </Link>
          );
        } else {
          return <div key={row.id}>{rowContent}</div>;
        }
      })}

      <p className="byline" style={{ marginTop: 24, color: "var(--ink-32)" }}>
        Showing {all.length} verified.
        Click any verified row to open its report.
      </p>
    </main>
  );
}
