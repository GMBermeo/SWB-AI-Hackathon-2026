"use client";

import { useRouter } from "next/navigation";
import { POSTINGS } from "@/lib/data";
import type { Activity, Evidence as EvidenceItem, Pillar, Posting } from "@/lib/types";

function ScoreDial({ score, verdict }: { score: number; verdict: Posting["verdict"] }) {
  const color =
    verdict === "VERIFIED"
      ? "var(--trust)"
      : verdict === "INVESTIGATE"
        ? "var(--amber)"
        : "var(--ink)";
  return (
    <div>
      <div
        className="mono"
        style={{
          fontSize: "clamp(96px, 14vw, 196px)",
          fontWeight: 300,
          letterSpacing: "-0.06em",
          lineHeight: 0.85,
          color,
          fontVariantNumeric: "tabular-nums",
        }}
      >
        {score}
        <span
          style={{
            fontSize: "0.32em",
            color: "var(--ink-32)",
            letterSpacing: 0,
            marginLeft: 6,
          }}
        >
          /100
        </span>
      </div>
      <div style={{ marginTop: 16, display: "flex" }}>
        {Array.from({ length: 50 }).map((_, i) => {
          const pos = (i / 50) * 100;
          const on = pos < score;
          return (
            <div
              key={i}
              style={{
                flex: 1,
                height: pos < score ? 12 : 6,
                marginRight: i < 49 ? 1 : 0,
                background: on ? color : "var(--ink-08)",
              }}
            />
          );
        })}
      </div>
      <div
        className="byline"
        style={{
          display: "flex",
          justifyContent: "space-between",
          marginTop: 6,
          color: "var(--ink-32)",
        }}
      >
        <span>0 · decline</span>
        <span>50</span>
        <span>100 · verified</span>
      </div>
    </div>
  );
}

function EvidenceRow({ item }: { item: EvidenceItem }) {
  const weight =
    item.weight === "strong" ? "●●●" : item.weight === "medium" ? "●●○" : "●○○";
  return (
    <div
      style={{
        display: "grid",
        gridTemplateColumns: "46px 1fr 130px",
        gap: 16,
        padding: "12px 0",
        borderTop: "1px solid var(--ink-08)",
      }}
    >
      <span
        className="mono"
        style={{
          fontSize: 10,
          color: "var(--ink-32)",
          letterSpacing: "0.04em",
        }}
      >
        {weight}
      </span>
      <span
        style={{
          fontSize: 14,
          lineHeight: 1.55,
          color: "var(--ink-80)",
          textWrap: "pretty",
        }}
      >
        {item.text}
      </span>
      <span
        className="mono"
        style={{ fontSize: 11, color: "var(--ink-50)", textAlign: "right" }}
      >
        ↗ {item.src}
      </span>
    </div>
  );
}

function PillarBlock({ pillar, n }: { pillar: Pillar; n: number }) {
  const color =
    pillar.verdict === "pass"
      ? "var(--trust)"
      : pillar.verdict === "mixed"
        ? "var(--amber)"
        : "var(--ink)";
  const tag = pillar.verdict === "pass" ? "Pass" : pillar.verdict === "mixed" ? "Mixed" : "Fail";
  return (
    <section style={{ padding: "28px 0", borderTop: "1px solid var(--ink-16)" }}>
      <div style={{ display: "grid", gridTemplateColumns: "180px 1fr", gap: 32 }}>
        <div>
          <div
            className="mono"
            style={{ fontSize: 11, color: "var(--ink-50)", letterSpacing: "0.10em" }}
          >
            §{n} · Pillar
          </div>
          <h3
            style={{
              margin: "8px 0 18px",
              fontSize: 44,
              fontWeight: 500,
              letterSpacing: "-0.025em",
              lineHeight: 1,
            }}
          >
            {pillar.name}
          </h3>
          <div
            className="mono"
            style={{
              fontSize: 52,
              fontWeight: 300,
              letterSpacing: "-0.04em",
              color,
              lineHeight: 1,
            }}
          >
            {pillar.score}
            <span style={{ fontSize: "0.4em", color: "var(--ink-32)" }}>/100</span>
          </div>
          <span
            className="mono"
            style={{
              display: "inline-block",
              marginTop: 14,
              fontSize: 11,
              letterSpacing: "0.12em",
              textTransform: "uppercase",
              color,
              padding: "4px 8px",
              border: `1px solid ${color}`,
            }}
          >
            {tag}
          </span>
        </div>

        <div>
          <p
            style={{
              margin: "0 0 12px",
              fontSize: 19,
              lineHeight: 1.4,
              letterSpacing: "-0.012em",
              color: "var(--ink)",
              textWrap: "pretty",
            }}
          >
            {pillar.summary}
          </p>
          <div className="byline" style={{ margin: "18px 0 6px" }}>
            Evidence ledger · {pillar.evidence.length} items
          </div>
          <div>
            {pillar.evidence.map((e, i) => (
              <EvidenceRow key={i} item={e} />
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}

function ActivityChart({ activity }: { activity: Activity }) {
  const max = Math.max(1, ...activity.reposts);
  return (
    <div style={{ display: "flex", alignItems: "flex-end", gap: 4, height: 60 }}>
      {activity.reposts.map((v, i) => (
        <div
          key={i}
          title={`Week ${i + 1}: ${v} version${v === 1 ? "" : "s"} live`}
          style={{
            flex: 1,
            height: v ? `${(v / max) * 100}%` : "6%",
            minHeight: 4,
            background: v ? "var(--ink)" : "var(--ink-08)",
          }}
        />
      ))}
    </div>
  );
}

function CompBar({ posting }: { posting: Posting }) {
  const high = posting.compMax > 30000 ? 250000 : 15000;
  const low = posting.compMax > 30000 ? 50000 : 0;
  const fmt = (n: number) => "$" + (n / 1000).toFixed(0) + "k";
  const pct = (v: number) =>
    Math.max(0, Math.min(100, ((v - low) / (high - low)) * 100));

  const market =
    posting.compMax > 30000
      ? { p25: 130000, p50: 165000, p75: 200000, p95: 240000 }
      : { p25: 4000, p50: 5800, p75: 7200, p95: 8500 };

  return (
    <div>
      <div
        style={{
          position: "relative",
          height: 56,
          borderTop: "1px solid var(--ink-16)",
          borderBottom: "1px solid var(--ink-16)",
          marginTop: 8,
        }}
      >
        <div
          style={{
            position: "absolute",
            left: pct(market.p25) + "%",
            width: pct(market.p75) - pct(market.p25) + "%",
            top: 0,
            bottom: 0,
            background: "var(--cream-deep)",
            borderLeft: "1px dashed var(--ink-16)",
            borderRight: "1px dashed var(--ink-16)",
          }}
        />
        <div
          style={{
            position: "absolute",
            left: `calc(${pct(market.p50)}% - 0.5px)`,
            top: 0,
            bottom: 0,
            width: 1,
            background: "var(--ink)",
          }}
        />
        <div
          style={{
            position: "absolute",
            left: pct(posting.compMin) + "%",
            width:
              Math.max(2, pct(posting.compMax) - pct(posting.compMin)) + "%",
            top: 18,
            height: 20,
            background:
              posting.score >= 80
                ? "var(--trust)"
                : posting.score >= 50
                  ? "var(--ink)"
                  : "var(--amber)",
          }}
        />
      </div>
      <div
        className="byline"
        style={{
          display: "flex",
          justifyContent: "space-between",
          marginTop: 6,
          color: "var(--ink-32)",
        }}
      >
        <span>{fmt(low)}</span>
        <span>p25 · {fmt(market.p25)}</span>
        <span style={{ color: "var(--ink)" }}>p50 · {fmt(market.p50)}</span>
        <span>p75 · {fmt(market.p75)}</span>
        <span>{fmt(high)}</span>
      </div>
    </div>
  );
}

export function ReportScreen({
  posting,
}: {
  posting: Posting | null;
}) {
  const router = useRouter();
  if (!posting) {
    return (
      <main style={{ padding: "120px 0", textAlign: "center" }}>
        <p className="dek">No report.</p>
        <button className="btn btn-sm" onClick={() => router.push("/")}>
          Back
        </button>
      </main>
    );
  }
  const verdictClass =
    posting.verdict === "VERIFIED"
      ? "v-verified"
      : posting.verdict === "INVESTIGATE"
        ? "v-investigate"
        : "v-decline";

  const today = new Date("2026-05-21").toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });

  return (
    <main style={{ paddingTop: 8, paddingBottom: 80 }}>
      <div style={{ marginTop: 8 }}>
        <hr className="rule-double" />
        <div
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "baseline",
            padding: "14px 0",
          }}
        >
          <div className="byline">Inspection №{posting.id.toUpperCase()}</div>
          <div className="byline">{today} · Filed at PT 09:14</div>
          <div className="byline">v.2026.05 · Lighthouse Methodology</div>
        </div>
        <hr className="rule" />
      </div>

      <section style={{ padding: "32px 0 18px" }}>
        <div
          style={{
            display: "flex",
            gap: 16,
            alignItems: "center",
            marginBottom: 22,
          }}
        >
          <span className={"verdict-pill " + verdictClass}>
            <span className="dot" /> {posting.verdict}
          </span>
          <span
            className="mono"
            style={{ fontSize: 12, color: "var(--ink-50)" }}
          >
            ↗ {posting.url}
          </span>
        </div>
        <h1
          className="display"
          style={{
            fontSize: "clamp(56px, 7vw, 108px)",
            margin: 0,
            maxWidth: "18ch",
          }}
        >
          {posting.headline}
        </h1>
      </section>

      <hr className="rule-hair" />

      <section
        style={{
          display: "grid",
          gridTemplateColumns: "1.1fr 1fr",
          gap: 56,
          padding: "32px 0 36px",
          alignItems: "start",
        }}
      >
        <div>
          <div className="kicker" style={{ marginBottom: 10 }}>
            The Posting
          </div>
          <h2
            style={{
              margin: "0 0 8px",
              fontSize: 36,
              fontWeight: 500,
              letterSpacing: "-0.02em",
              lineHeight: 1.05,
            }}
          >
            {posting.role}
          </h2>
          <p
            style={{
              margin: "0 0 18px",
              fontSize: 20,
              color: "var(--ink-65)",
              letterSpacing: "-0.012em",
            }}
          >
            at <strong style={{ color: "var(--ink)" }}>{posting.company}</strong>
            <span style={{ margin: "0 8px", color: "var(--ink-32)" }}>·</span>
            {posting.location}
          </p>
          <p
            style={{
              margin: "0 0 22px",
              fontSize: 15,
              lineHeight: 1.55,
              color: "var(--ink-80)",
              maxWidth: "52ch",
              textWrap: "pretty",
            }}
          >
            “{posting.summary}”
          </p>
          <div style={{ display: "flex", gap: 30, flexWrap: "wrap" }}>
            {[
              [
                "Compensation",
                posting.compMax > 30000
                  ? `$${(posting.compMin / 1000).toFixed(0)}k–$${(posting.compMax / 1000).toFixed(0)}k`
                  : `$${posting.compMin.toLocaleString()}–$${posting.compMax.toLocaleString()}/mo`,
              ],
              ["Equity", posting.equity],
              ["Posted", posting.posted],
            ].map(([k, v]) => (
              <div key={k}>
                <div className="byline">{k}</div>
                <div
                  className="mono"
                  style={{ fontSize: 17, marginTop: 4, color: "var(--ink)" }}
                >
                  {v}
                </div>
              </div>
            ))}
          </div>
        </div>

        <div>
          <div className="kicker" style={{ marginBottom: 14 }}>
            The Verdict
          </div>
          <ScoreDial score={posting.score} verdict={posting.verdict} />
        </div>
      </section>

      <hr className="rule" />

      <section
        style={{
          display: "grid",
          gridTemplateColumns: "1fr 2fr",
          gap: 48,
          padding: "36px 0",
        }}
      >
        <div>
          <div className="kicker">Editorial summary</div>
          <p className="byline" style={{ marginTop: 14 }}>
            Synthesized from the evidence ledger below
          </p>
        </div>
        <p
          className="dek dropcap"
          style={{
            margin: 0,
            fontSize: 22,
            lineHeight: 1.45,
            color: "var(--ink)",
          }}
        >
          {posting.editorial}
        </p>
      </section>

      <hr className="rule" />

      <section style={{ paddingTop: 12 }}>
        <div
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "baseline",
            padding: "24px 0 4px",
          }}
        >
          <h2 className="headline" style={{ margin: 0 }}>
            The four pillars
          </h2>
          <span className="byline">§1–§4 · evidence ledger</span>
        </div>
        {posting.pillars.map((p, i) => (
          <PillarBlock key={p.name} pillar={p} n={i + 1} />
        ))}
      </section>

      <hr className="rule" />

      <section
        style={{
          display: "grid",
          gridTemplateColumns: "1fr 1fr",
          gap: 0,
          padding: "40px 0 0",
        }}
      >
        <div
          style={{ paddingRight: 40, borderRight: "1px solid var(--ink-16)" }}
        >
          <div className="kicker">§5 · Recruiter activity</div>
          <h3
            style={{
              margin: "10px 0 4px",
              fontSize: 26,
              fontWeight: 500,
              letterSpacing: "-0.015em",
            }}
          >
            Posting timeline, last 12 weeks
          </h3>
          <p className="byline" style={{ margin: "0 0 20px" }}>
            {posting.activity.label}
          </p>
          <ActivityChart activity={posting.activity} />
          <div
            style={{
              display: "grid",
              gridTemplateColumns: "1fr 1fr",
              gap: 16,
              marginTop: 24,
            }}
          >
            <div>
              <div className="byline">Median response</div>
              <div className="mono" style={{ fontSize: 26, marginTop: 4 }}>
                {posting.activity.responseDays != null
                  ? `${posting.activity.responseDays}d`
                  : "n/a"}
              </div>
            </div>
            <div>
              <div className="byline">Ghost likelihood</div>
              <div
                className="mono"
                style={{
                  fontSize: 26,
                  marginTop: 4,
                  color:
                    posting.activity.ghostScore > 0.5
                      ? "var(--amber)"
                      : posting.activity.ghostScore > 0.2
                        ? "var(--ink)"
                        : "var(--trust)",
                }}
              >
                {(posting.activity.ghostScore * 100).toFixed(0)}%
              </div>
            </div>
          </div>
        </div>

        <div style={{ paddingLeft: 40 }}>
          <div className="kicker">§6 · Compensation</div>
          <h3
            style={{
              margin: "10px 0 4px",
              fontSize: 26,
              fontWeight: 500,
              letterSpacing: "-0.015em",
            }}
          >
            Offer band vs. market
          </h3>
          <p className="byline" style={{ margin: "0 0 8px" }}>
            Source: Levels.fyi, role / level / region filter applied
          </p>
          <CompBar posting={posting} />
          <p
            style={{
              margin: "24px 0 0",
              fontSize: 14,
              lineHeight: 1.55,
              color: "var(--ink-65)",
              textWrap: "pretty",
            }}
          >
            {posting.score >= 80 &&
              "The offer band sits comfortably above market median, with no unpaid-trial or hidden-fee language detected in the process description."}
            {posting.score >= 50 &&
              posting.score < 80 &&
              "The offer band is below market median for the scope described. Equity is undisclosed, and the process includes an unpaid trial exercise — flagged for review."}
            {posting.score < 50 &&
              "The offer band is implausibly high for the scope described. Posting matches multiple FTC-documented scam patterns including upfront fees and pre-interview ID requests. Do not engage."}
          </p>
        </div>
      </section>

      <hr className="rule" style={{ marginTop: 40 }} />

      <section style={{ padding: "40px 0" }}>
        <div
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "baseline",
            marginBottom: 22,
          }}
        >
          <div>
            <div className="kicker">§7 · Comparables</div>
            <h3
              style={{
                margin: "8px 0 0",
                fontSize: 26,
                fontWeight: 500,
                letterSpacing: "-0.015em",
              }}
            >
              Similar verified roles
            </h3>
          </div>
          <span className="byline">3 of 142 nearby matches</span>
        </div>
        <div
          style={{
            display: "grid",
            gridTemplateColumns: "repeat(3, 1fr)",
            gap: 0,
            borderTop: "1px solid var(--ink)",
            borderBottom: "1px solid var(--ink)",
          }}
        >
          {posting.comparables.map((c, i) => (
            <div
              key={c.co}
              style={{
                padding: "20px 22px",
                borderRight: i < 2 ? "1px solid var(--ink-16)" : "none",
              }}
            >
              <div
                style={{
                  display: "flex",
                  justifyContent: "space-between",
                  alignItems: "baseline",
                }}
              >
                <span
                  style={{
                    fontSize: 18,
                    fontWeight: 500,
                    letterSpacing: "-0.012em",
                  }}
                >
                  {c.co}
                </span>
                <span
                  className="mono"
                  style={{ fontSize: 18, color: "var(--trust)" }}
                >
                  {c.score}
                </span>
              </div>
              <div
                style={{
                  fontSize: 14,
                  color: "var(--ink-65)",
                  margin: "4px 0 14px",
                }}
              >
                {c.role}
              </div>
              <div
                className="mono"
                style={{ fontSize: 13, color: "var(--ink)" }}
              >
                {c.comp}
              </div>
            </div>
          ))}
        </div>
      </section>

      <hr className="rule-hair" />

      <section
        style={{
          display: "flex",
          justifyContent: "space-between",
          alignItems: "flex-end",
          padding: "32px 0 0",
          gap: 32,
        }}
      >
        <div style={{ maxWidth: "54ch" }}>
          <div className="byline">Audit · this report</div>
          <p
            style={{
              margin: "10px 0 0",
              fontSize: 14,
              lineHeight: 1.55,
              color: "var(--ink-65)",
              textWrap: "pretty",
            }}
          >
            Generated by Lighthouse v.2026.05 · 17 sub-checks · 14 external
            sources · 2.9s wall time. Every claim above links to its source.
            Re-run an inspection any time — signals decay. Signed by the
            editorial AI; verified deterministically against the cached
            evidence pack.
          </p>
        </div>
        <div style={{ display: "flex", gap: 12 }}>
          <button
            className="btn btn-ghost btn-sm"
            onClick={() => router.push("/library")}
          >
            ↗ All inspections
          </button>
          <button
            className="btn btn-sm"
            onClick={() => {
              if (posting) {
                const isDemo = POSTINGS.some((p) => p.id === posting.id);
                if (isDemo) {
                  router.push(`/scan?demo=${posting.id}`);
                } else {
                  router.push(`/scan?url=${encodeURIComponent(posting.url)}`);
                }
              }
            }}
          >
            Re-run check
          </button>
        </div>
      </section>
    </main>
  );
}
