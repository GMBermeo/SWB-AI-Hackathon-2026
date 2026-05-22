"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { POSTINGS } from "@/lib/data";
import type { Posting } from "@/lib/types";
import { Verifier } from "./Verifier";

const PILLARS = [
  {
    n: "01",
    name: "Real",
    copy: "Is the company real, the recruiter identifiable, and the posting authored on the company’s own surface?",
    ev: ["WHOIS · domain age", "SEC / Companies House", "Recruiter LinkedIn tenure", "Copy novelty score"],
  },
  {
    n: "02",
    name: "Active",
    copy: "Is the role open, fresh, and being filled — or is it warehousing résumés while the team does other work?",
    ev: ["Archive.org snapshots", "Repost diff across boards", "Hiring-thread response times", "Last-Modified headers"],
  },
  {
    n: "03",
    name: "Fair",
    copy: "Are pay, equity, and scope coherent with the level described — and free of unpaid-trial and hidden-fee patterns?",
    ev: ["Levels.fyi percentile bands", "Carta equity benchmarks", "Scope-to-comp ratio", "Process-fee detection"],
  },
  {
    n: "04",
    name: "Credible",
    copy: "Does the company actually exist as a working entity — product, team history, funding, and observable activity?",
    ev: ["Public product surface", "Founder employment graph", "Funding via Crunchbase", "GitHub commit volume"],
  },
];

const STATS_FALLBACK: [string, string][] = [
  ["—", "postings inspected this week"],
  ["—", "of inspections flagged Investigate"],
  ["—", "of inspections flagged Decline"],
  ["—", "median verification time"],
];

interface StatsPayload {
  total: number;
  lastWeek: number;
  investigatePct: number;
  declinePct: number;
  medianMs: number | null;
}

function buildStats(s: StatsPayload | null): [string, string][] {
  if (!s || s.total === 0) return STATS_FALLBACK;
  const num = (n: number) =>
    n >= 1000 ? n.toLocaleString("en-US") : String(n);
  const pct = (n: number) => `${n.toFixed(1)}%`;
  const secs = (ms: number | null) =>
    ms == null ? "—" : `${(ms / 1000).toFixed(1)}s`;
  return [
    [num(s.lastWeek), "postings inspected this week"],
    [pct(s.investigatePct), "of inspections flagged Investigate"],
    [pct(s.declinePct), "of inspections flagged Decline"],
    [secs(s.medianMs), "median verification time"],
  ];
}

export function HomeScreen() {
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

  const handleDemoPick = (p: Posting) => {
    router.push(`/scan?demo=${p.id}`);
  };

  const [stats, setStats] = useState<StatsPayload | null>(null);
  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch("/api/stats");
        const json = await res.json();
        if (!cancelled && typeof json?.total === "number") setStats(json);
      } catch {
        /* fall back to placeholder dashes */
      }
    })();
    return () => {
      cancelled = true;
    };
  }, []);
  const statsRows = buildStats(stats);
  return (
    <main style={{ paddingTop: 32, paddingBottom: 96 }}>
      <section
        style={{
          display: "grid",
          gridTemplateColumns: "1.4fr 1fr",
          gap: 56,
          alignItems: "end",
          padding: "20px 0 36px",
        }}
      >
        <div>
          <div className="kicker" style={{ marginBottom: 18 }}>
            Est. 2026 · A verification engine for remote work
          </div>
          <h1 className="display">
            Read the&nbsp;posting.
            <br />
            Trust the&nbsp;work.
          </h1>
        </div>
        <div style={{ paddingBottom: 8 }}>
          <p className="dek" style={{ margin: 0 }}>
            Lighthouse inspects any remote job posting against four pillars —
            <em> Real, Active, Fair, Credible </em>— and returns a transparent
            report with cited evidence. Built for the job seeker. Cited like a
            journalist. Audited like a credit report.
          </p>
        </div>
      </section>

      <hr className="rule" />

      <section style={{ padding: "40px 0 32px" }}>
        <div className="kicker" style={{ marginBottom: 14 }}>
          ¶ The Verifier
        </div>
        <Verifier onSubmit={handleVerify} />

        <div
          style={{
            marginTop: 22,
            display: "flex",
            gap: 12,
            flexWrap: "wrap",
            alignItems: "baseline",
          }}
        >
          <span className="byline">Try one of today&apos;s:</span>
          {POSTINGS.map((s) => (
            <button
              key={s.id}
              onClick={() => handleDemoPick(s)}
              style={{
                background: "transparent",
                border: 0,
                padding: 0,
                cursor: "pointer",
                fontFamily: "var(--mono)",
                fontSize: 12,
                color: "var(--ink)",
                textDecoration: "underline",
                textDecorationColor: "var(--ink-32)",
                textUnderlineOffset: 4,
              }}
            >
              {s.url.replace(/^https?:\/\//, "")}
            </button>
          ))}
        </div>
      </section>

      <hr className="rule-hair" />

      <section style={{ padding: "48px 0 40px" }}>
        <div
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "baseline",
            marginBottom: 28,
          }}
        >
          <h2 className="headline" style={{ margin: 0, maxWidth: "14ch" }}>
            Four pillars, one report.
          </h2>
          <div className="byline">Methodology · §1–§4</div>
        </div>

        <div
          style={{
            display: "grid",
            gridTemplateColumns: "repeat(4, 1fr)",
            gap: 0,
            borderTop: "1px solid var(--ink)",
            borderBottom: "1px solid var(--ink)",
          }}
        >
          {PILLARS.map((p, i) => (
            <div
              key={p.n}
              style={{
                padding: "24px 22px 28px",
                borderRight: i < 3 ? "1px solid var(--ink-16)" : "none",
              }}
            >
              <div
                className="mono"
                style={{
                  fontSize: 11,
                  color: "var(--ink-50)",
                  letterSpacing: "0.06em",
                }}
              >
                {p.n}
              </div>
              <h3
                style={{
                  margin: "6px 0 12px",
                  fontSize: 22,
                  fontWeight: 500,
                  letterSpacing: "-0.015em",
                }}
              >
                {p.name}
              </h3>
              <p
                style={{
                  margin: "0 0 18px",
                  fontSize: 14,
                  lineHeight: 1.55,
                  color: "var(--ink-80)",
                  textWrap: "pretty",
                }}
              >
                {p.copy}
              </p>
              <ul style={{ margin: 0, padding: 0, listStyle: "none" }}>
                {p.ev.map((e) => (
                  <li
                    key={e}
                    className="mono"
                    style={{
                      fontSize: 11,
                      color: "var(--ink-50)",
                      padding: "4px 0",
                      borderTop: "1px solid var(--ink-08)",
                    }}
                  >
                    {e}
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
      </section>

      <hr className="rule-hair" />

      <section
        style={{
          padding: "34px 0",
          display: "grid",
          gridTemplateColumns: "repeat(4, 1fr)",
          gap: 28,
        }}
      >
        {statsRows.map(([n, label]) => (
          <div key={label}>
            <div
              className="mono"
              style={{
                fontSize: 36,
                fontWeight: 400,
                letterSpacing: "-0.025em",
                color: "var(--ink)",
              }}
            >
              {n}
            </div>
            <div className="byline" style={{ marginTop: 6 }}>
              {label}
            </div>
          </div>
        ))}
      </section>

      <hr className="rule" />

      <section
        style={{
          padding: "40px 0 0",
          display: "grid",
          gridTemplateColumns: "1fr 1.5fr",
          gap: 48,
        }}
      >
        <div className="kicker">From the Editors</div>
        <div>
          <p className="dek dropcap" style={{ margin: 0 }}>
            Job-scam losses tripled from{" "}
            <span className="mono">$90M</span> in 2020 to{" "}
            <span className="mono">$501M</span> in 2024. AI made the fakes look
            real; we built an opposing AI to make the real ones look real, too.
            Lighthouse does not curate listings. It inspects whatever you bring
            it — LinkedIn, Indeed, a recruiter DM, a friend&apos;s referral —
            and shows its work.
          </p>
        </div>
      </section>
    </main>
  );
}
