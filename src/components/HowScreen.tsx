const SECTIONS = [
  {
    n: "§1",
    name: "Real",
    q: "Does this company exist, and did it write this posting?",
    steps: [
      ["WHOIS lookup", "Domain age, registrant continuity, NS stability."],
      ["Registry match", "SEC EDGAR, Companies House, state filings."],
      ["Recruiter graph", "LinkedIn tenure, prior roles, posting history."],
      ["Copy novelty", "Posting body diffed against 9M historical listings."],
    ],
  },
  {
    n: "§2",
    name: "Active",
    q: "Is the role open and being filled — or is it warehousing résumés?",
    steps: [
      ["Snapshot trace", "Archive.org first-seen, version count, reposts."],
      ["Repost diff", "Identical copy across LinkedIn, Indeed, niche boards."],
      ["Community signal", "Reddit / Blind / HN thread response rates."],
      ["Server hints", "Last-Modified, ETag, careers-page edit cadence."],
    ],
  },
  {
    n: "§3",
    name: "Fair",
    q: "Is the deal coherent — pay, equity, scope, process?",
    steps: [
      ["Comp percentile", "Levels.fyi banding by level, region, function."],
      ["Equity sanity", "Carta median ranges by stage and ownership."],
      ["Scope ratio", "Responsibilities-per-dollar against benchmark."],
      ["Process fees", "Detect $-for-training, $-for-equipment patterns."],
    ],
  },
  {
    n: "§4",
    name: "Credible",
    q: "Does the company actually do anything?",
    steps: [
      ["Product surface", "Live signup, billing, status page, changelog."],
      ["Founder graph", "Pre-company employment history, mutual ties."],
      ["Funding ledger", "Crunchbase / press, investor verification."],
      ["Code activity", "GitHub org commit volume, last 30 days."],
    ],
  },
] as const;

export function HowScreen() {
  return (
    <main style={{ paddingTop: 32, paddingBottom: 96 }}>
      <div className="kicker">Methodology</div>
      <h1
        className="display"
        style={{
          fontSize: "clamp(48px, 6vw, 88px)",
          margin: "14px 0 24px",
          maxWidth: "14ch",
        }}
      >
        We show our work, always.
      </h1>
      <hr className="rule" />

      <section className="lh-split lh-split-how" style={{ padding: "40px 0 0" }}>
        <p className="byline">§0 · The premise</p>
        <p className="dek" style={{ margin: 0 }}>
          A trustworthy listing is one whose claims can be{" "}
          <em>independently corroborated</em> in under three seconds. Lighthouse
          fans out across public sources — registries, archives, professional
          networks, compensation databases, scam-report forums — and stitches
          the evidence into a single annotated report. Every claim cites its
          source. Every score is decomposable. No black box.
        </p>
      </section>

      <hr className="rule-hair" style={{ margin: "40px 0" }} />

      {SECTIONS.map((s) => (
        <section
          key={s.n}
          className="lh-split lh-split-how"
          style={{
            padding: "36px 0",
            borderTop: "1px solid var(--ink-08)",
          }}
        >
          <div>
            <div
              className="mono"
              style={{
                fontSize: 11,
                color: "var(--ink-50)",
                letterSpacing: "0.10em",
              }}
            >
              {s.n}
            </div>
            <h3
              style={{
                margin: "6px 0 10px",
                fontSize: 40,
                fontWeight: 500,
                letterSpacing: "-0.025em",
              }}
            >
              {s.name}
            </h3>
            <p
              style={{
                margin: 0,
                fontSize: 14,
                color: "var(--ink-65)",
                lineHeight: 1.5,
                textWrap: "pretty",
              }}
            >
              {s.q}
            </p>
          </div>
          <div>
            {s.steps.map(([k, v]) => (
              <div
                key={k}
                className="lh-split lh-split-step"
                style={{
                  padding: "14px 0",
                  borderBottom: "1px solid var(--ink-08)",
                }}
              >
                <span className="mono" style={{ fontSize: 12, color: "var(--ink)" }}>
                  {k}
                </span>
                <span style={{ fontSize: 15, lineHeight: 1.55, color: "var(--ink-80)" }}>
                  {v}
                </span>
              </div>
            ))}
          </div>
        </section>
      ))}

      <hr className="rule" style={{ margin: "24px 0 0" }} />

      <section className="lh-split lh-split-how" style={{ padding: "40px 0 0" }}>
        <p className="byline">A note on bias</p>
        <p className="dek" style={{ margin: 0 }}>
          A 14-day-old domain is not automatically suspect; a 14-year-old
          domain is not automatically safe. Each signal carries a weight, each
          report shows the full evidence trail, and humans — you — make the
          final call. We don&apos;t blocklist companies. We surface what we
          found, and let you read it.
        </p>
      </section>
    </main>
  );
}
