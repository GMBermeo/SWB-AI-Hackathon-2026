"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import type { CompanyRow } from "@/lib/companies";
import type { Posting, Verdict } from "@/lib/types";
import { ExternalLink, linkify, looksLikeUrl } from "@/lib/clickable";

interface CompanyInspection extends Posting {
  createdAt: string;
  citations: { uri: string; title?: string }[];
  evidenceRaw: string | null;
  verifyMs: number | null;
  source: string;
}

interface PendingRow {
  id: string;
  source_slug: string;
  url: string;
  url_normalized: string;
  title: string;
  company: string | null;
  location: string | null;
  posted_at: string | null;
  first_seen_at: string;
  status: string;
}

interface CompanyApiResponse {
  company: CompanyRow;
  inspections: CompanyInspection[];
  pending: PendingRow[];
  error?: string;
}

function vClass(v: Verdict | null | undefined): string {
  if (v === "VERIFIED") return "v-verified";
  if (v === "INVESTIGATE") return "v-investigate";
  if (v === "DECLINE") return "v-decline";
  return "";
}

function fmtRel(iso: string | null): string {
  if (!iso) return "—";
  const d = (Date.now() - new Date(iso).getTime()) / 1000;
  if (d < 60) return "just now";
  if (d < 3600) return `${Math.floor(d / 60)}m ago`;
  if (d < 86400) return `${Math.floor(d / 3600)}h ago`;
  if (d < 86400 * 7) return `${Math.floor(d / 86400)}d ago`;
  if (d < 86400 * 30) return `${Math.floor(d / (86400 * 7))}w ago`;
  return `${Math.floor(d / (86400 * 30))}mo ago`;
}

function fmtMoney(v: number): string {
  if (!v) return "—";
  if (v >= 1_000_000_000) return `$${(v / 1_000_000_000).toFixed(1)}B`;
  if (v >= 1_000_000) return `$${(v / 1_000_000).toFixed(1)}M`;
  if (v >= 1_000) return `$${(v / 1_000).toFixed(0)}k`;
  return `$${v}`;
}

function Field({
  label,
  value,
  asLink,
}: {
  label: string;
  value: React.ReactNode | string | null | undefined;
  asLink?: string | null;
}) {
  if (value === null || value === undefined || value === "") return null;
  return (
    <div style={{ padding: "14px 0", borderTop: "1px solid var(--ink-08)" }}>
      <div className="byline">{label}</div>
      <div
        className="mono"
        style={{
          fontSize: 15,
          marginTop: 4,
          color: "var(--ink)",
          wordBreak: "break-word",
        }}
      >
        {asLink ? (
          <ExternalLink href={asLink}>{value}</ExternalLink>
        ) : (
          value
        )}
      </div>
    </div>
  );
}

export function CompanyDetailScreen({ slug }: { slug: string }) {
  const router = useRouter();
  const [data, setData] = useState<CompanyApiResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch(`/api/companies/${encodeURIComponent(slug)}`);
        const json = await res.json();
        if (cancelled) return;
        if (!res.ok) {
          setError(json.error || `HTTP ${res.status}`);
          return;
        }
        setData(json);
      } catch (e) {
        if (!cancelled)
          setError(e instanceof Error ? e.message : "Failed to load.");
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [slug]);

  if (loading) {
    return (
      <main style={{ padding: "80px 0", textAlign: "center" }}>
        <p className="dek">Loading dossier…</p>
      </main>
    );
  }

  if (error || !data) {
    return (
      <main style={{ padding: "80px 0", textAlign: "center" }}>
        <p className="dek" style={{ color: "var(--amber)" }}>
          {error || "Company not found."}
        </p>
        <button
          className="btn btn-sm"
          onClick={() => router.push("/companies")}
          style={{ marginTop: 16 }}
        >
          ← All companies
        </button>
      </main>
    );
  }

  const c = data.company;
  const insp = data.inspections;
  const totalVerdicts = {
    VERIFIED: insp.filter((i) => i.verdict === "VERIFIED").length,
    INVESTIGATE: insp.filter((i) => i.verdict === "INVESTIGATE").length,
    DECLINE: insp.filter((i) => i.verdict === "DECLINE").length,
  };
  const verdictColor =
    c.last_verdict === "VERIFIED"
      ? "var(--trust)"
      : c.last_verdict === "INVESTIGATE"
        ? "var(--amber)"
        : c.last_verdict === "DECLINE"
          ? "var(--ink)"
          : "var(--ink-50)";

  return (
    <main style={{ paddingTop: 16, paddingBottom: 96 }}>
      <div className="lh-report-meta">
        <div className="byline">Trust card · {c.slug}</div>
        <div className="byline">
          {insp.length} inspection{insp.length === 1 ? "" : "s"} on record
        </div>
        <div className="byline">
          Last inspected · {fmtRel(c.last_inspected_at)}
        </div>
      </div>
      <hr className="rule" />

      <section style={{ padding: "28px 0 20px" }}>
        <div className="lh-verdict-row">
          {c.last_verdict && (
            <span className={"verdict-pill " + vClass(c.last_verdict)}>
              <span className="dot" /> {c.last_verdict}
            </span>
          )}
          {c.primary_domain && (
            <ExternalLink
              href={c.primary_domain}
              className="mono"
              style={{ fontSize: 12, color: "var(--ink-50)" }}
            >
              ↗ {c.primary_domain}
            </ExternalLink>
          )}
        </div>
        <h1
          className="display"
          style={{
            fontSize: "clamp(48px, 6vw, 96px)",
            margin: 0,
            maxWidth: "18ch",
          }}
        >
          {c.display_name}
        </h1>
        {c.industry && (
          <p
            className="dek"
            style={{ margin: "12px 0 0", color: "var(--ink-65)" }}
          >
            {c.industry}
          </p>
        )}
      </section>

      <hr className="rule-hair" />

      <section
        className="lh-split lh-split-report"
        style={{ padding: "32px 0", alignItems: "start" }}
      >
        <div>
          <div className="kicker" style={{ marginBottom: 10 }}>
            Company dossier
          </div>
          <h2
            style={{
              margin: "0 0 18px",
              fontSize: 28,
              fontWeight: 500,
              letterSpacing: "-0.02em",
              lineHeight: 1.1,
            }}
          >
            Everything Lighthouse knows
          </h2>
          <Field
            label="Primary domain"
            value={c.primary_domain}
            asLink={c.primary_domain}
          />
          <Field label="Industry" value={c.industry} />
          <Field
            label="Headquarters"
            value={
              [c.hq_city, c.hq_region, c.hq_country]
                .filter(Boolean)
                .join(", ") || null
            }
          />
          <Field
            label="Founded"
            value={c.founded_year ? String(c.founded_year) : null}
          />
          <Field
            label="Employees (est.)"
            value={
              c.employee_count_est
                ? c.employee_count_est.toLocaleString("en-US")
                : null
            }
          />
          <Field
            label="Funding raised"
            value={c.funding_total_usd ? fmtMoney(c.funding_total_usd) : null}
          />
          <Field
            label="Glassdoor rating"
            value={
              c.glassdoor_rating != null
                ? (
                  <>
                    {c.glassdoor_rating} / 5
                    {c.glassdoor_refreshed_at && (
                      <span
                        style={{
                          fontSize: 11,
                          color: "var(--ink-32)",
                          marginLeft: 8,
                        }}
                      >
                        (refreshed {new Date(c.glassdoor_refreshed_at).toLocaleDateString("en-US", { year: "numeric", month: "short", day: "numeric" })})
                      </span>
                    )}
                  </>
                )
                : null
            }
          />
          {c.notes && (
            <div
              style={{
                padding: "14px 0",
                borderTop: "1px solid var(--ink-08)",
              }}
            >
              <div className="byline">Notes</div>
              <p
                style={{
                  margin: "6px 0 0",
                  fontSize: 14,
                  lineHeight: 1.55,
                  color: "var(--ink-80)",
                  textWrap: "pretty",
                }}
              >
                {linkify(c.notes)}
              </p>
            </div>
          )}
        </div>

        <div>
          <div className="kicker" style={{ marginBottom: 10 }}>
            Score
          </div>
          <div
            className="mono"
            style={{
              fontSize: "clamp(72px, 11vw, 156px)",
              fontWeight: 300,
              letterSpacing: "-0.06em",
              lineHeight: 0.85,
              color: verdictColor,
              fontVariantNumeric: "tabular-nums",
            }}
          >
            {c.mean_score != null ? Math.round(c.mean_score) : "—"}
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
          <p
            className="byline"
            style={{ margin: "12px 0 24px", color: "var(--ink-50)" }}
          >
            Historical mean across {c.inspection_count} inspection
            {c.inspection_count === 1 ? "" : "s"}
          </p>

          <div
            style={{
              display: "grid",
              gridTemplateColumns: "1fr 1fr 1fr",
              gap: 8,
              marginBottom: 16,
            }}
          >
            <div>
              <div className="byline">Verified</div>
              <div
                className="mono"
                style={{ fontSize: 22, color: "var(--trust)" }}
              >
                {totalVerdicts.VERIFIED}
              </div>
            </div>
            <div>
              <div className="byline">Investigate</div>
              <div
                className="mono"
                style={{ fontSize: 22, color: "var(--amber)" }}
              >
                {totalVerdicts.INVESTIGATE}
              </div>
            </div>
            <div>
              <div className="byline">Decline</div>
              <div className="mono" style={{ fontSize: 22 }}>
                {totalVerdicts.DECLINE}
              </div>
            </div>
          </div>

          <div className="kicker" style={{ marginTop: 24, marginBottom: 8 }}>
            External profiles
          </div>
          {!c.linkedin_url &&
            !c.glassdoor_url &&
            !c.crunchbase_url &&
            !c.github_org && (
              <p
                className="byline"
                style={{ color: "var(--ink-32)", marginTop: 8 }}
              >
                None on record yet.
              </p>
            )}
          {c.linkedin_url && (
            <div style={{ padding: "8px 0" }}>
              <ExternalLink href={c.linkedin_url}>
                <span className="byline" style={{ color: "var(--ink-50)" }}>
                  LinkedIn ↗
                </span>
                <div
                  className="mono"
                  style={{
                    fontSize: 13,
                    color: "var(--ink)",
                    wordBreak: "break-all",
                  }}
                >
                  {c.linkedin_url.replace(/^https?:\/\//, "")}
                </div>
              </ExternalLink>
            </div>
          )}
          {c.glassdoor_url && (
            <div style={{ padding: "8px 0" }}>
              <ExternalLink href={c.glassdoor_url}>
                <span className="byline" style={{ color: "var(--ink-50)" }}>
                  Glassdoor ↗
                </span>
                <div
                  className="mono"
                  style={{
                    fontSize: 13,
                    color: "var(--ink)",
                    wordBreak: "break-all",
                  }}
                >
                  {c.glassdoor_url.replace(/^https?:\/\//, "")}
                </div>
              </ExternalLink>
            </div>
          )}
          {c.crunchbase_url && (
            <div style={{ padding: "8px 0" }}>
              <ExternalLink href={c.crunchbase_url}>
                <span className="byline" style={{ color: "var(--ink-50)" }}>
                  Crunchbase ↗
                </span>
                <div
                  className="mono"
                  style={{
                    fontSize: 13,
                    color: "var(--ink)",
                    wordBreak: "break-all",
                  }}
                >
                  {c.crunchbase_url.replace(/^https?:\/\//, "")}
                </div>
              </ExternalLink>
            </div>
          )}
          {c.github_org && (
            <div style={{ padding: "8px 0" }}>
              <ExternalLink href={`https://github.com/${c.github_org}`}>
                <span className="byline" style={{ color: "var(--ink-50)" }}>
                  GitHub org ↗
                </span>
                <div
                  className="mono"
                  style={{ fontSize: 13, color: "var(--ink)" }}
                >
                  github.com/{c.github_org}
                </div>
              </ExternalLink>
            </div>
          )}
        </div>
      </section>

      <hr className="rule" />

      <section style={{ padding: "32px 0" }}>
        {insp.length !== 0 && (<div className="lh-row-wrap" style={{ marginBottom: 20 }}>
          <div>
            <div className="kicker">Inspection history</div>
            <h2
              style={{
                margin: "8px 0 0",
                fontSize: 28,
                fontWeight: 500,
                letterSpacing: "-0.015em",
              }}
            >
              {insp.length} inspection{insp.length === 1 ? "" : "s"} on file
            </h2>
          </div>
        </div>)}


        {insp.map((i) => (
          <article
            key={i.id}
            style={{
              padding: "24px 0",
              borderTop: "1px solid var(--ink-16)",
            }}
          >
            <div
              style={{
                display: "flex",
                justifyContent: "space-between",
                gap: 24,
                alignItems: "baseline",
                flexWrap: "wrap",
              }}
            >
              <div style={{ flex: "1 1 360px", minWidth: 0 }}>
                <Link
                  href={`/report/${i.id}`}
                  style={{
                    color: "inherit",
                    textDecoration: "none",
                    display: "block",
                  }}
                >
                  <h3
                    style={{
                      margin: 0,
                      fontSize: 22,
                      fontWeight: 500,
                      letterSpacing: "-0.012em",
                    }}
                  >
                    {i.role}
                  </h3>
                </Link>
                <div
                  className="mono"
                  style={{
                    fontSize: 12,
                    marginTop: 4,
                    color: "var(--ink-50)",
                  }}
                >
                  {i.location} · {i.posted} · verified {fmtRel(i.createdAt)}
                </div>
                <div style={{ marginTop: 8 }}>
                  <ExternalLink
                    href={i.url}
                    className="mono"
                    style={{
                      fontSize: 11,
                      color: "var(--ink-65)",
                      wordBreak: "break-all",
                    }}
                  >
                    ↗ {i.url}
                  </ExternalLink>
                </div>
                <p
                  style={{
                    margin: "12px 0 0",
                    fontSize: 14,
                    lineHeight: 1.55,
                    color: "var(--ink-80)",
                    maxWidth: "62ch",
                    textWrap: "pretty",
                  }}
                >
                  {linkify(i.editorial || i.summary)}
                </p>
              </div>
              <div style={{ textAlign: "right", flex: "0 0 auto" }}>
                <div
                  className="mono"
                  style={{
                    fontSize: 40,
                    fontWeight: 300,
                    letterSpacing: "-0.04em",
                    color:
                      i.score >= 80
                        ? "var(--trust)"
                        : i.score >= 50
                          ? "var(--ink)"
                          : "var(--amber)",
                    lineHeight: 1,
                  }}
                >
                  {i.score}
                </div>
                <span
                  className={"verdict-pill " + vClass(i.verdict)}
                  style={{ marginTop: 8, display: "inline-flex" }}
                >
                  <span className="dot" /> {i.verdict}
                </span>
                <div style={{ marginTop: 12 }}>
                  <Link
                    href={`/report/${i.id}`}
                    style={{ textDecoration: "none" }}
                  >
                    <button className="btn btn-sm">Open report →</button>
                  </Link>
                </div>
              </div>
            </div>

            {i.citations && i.citations.length > 0 && (
              <details style={{ marginTop: 16 }}>
                <summary
                  className="byline"
                  style={{ cursor: "pointer", color: "var(--ink-50)" }}
                >
                  Sources cited · {i.citations.length}
                </summary>
                <ul
                  style={{
                    listStyle: "none",
                    padding: "10px 0 0",
                    margin: 0,
                  }}
                >
                  {i.citations.map((cit, idx) => (
                    <li key={idx} style={{ padding: "4px 0" }}>
                      <ExternalLink
                        href={cit.uri}
                        className="mono"
                        style={{
                          fontSize: 12,
                          color: "var(--ink-65)",
                          wordBreak: "break-all",
                        }}
                      >
                        ↗ {cit.title || cit.uri}
                      </ExternalLink>
                    </li>
                  ))}
                </ul>
              </details>
            )}
          </article>
        ))}
      </section>

      {data.pending && data.pending.length > 0 && (
        <section style={{ padding: "32px 0" }}>
          <div className="kicker" style={{ color: "var(--amber)" }}>
            Awaiting verification · {data.pending.length}
          </div>
          <h3
            style={{
              margin: "8px 0 16px",
              fontSize: 22,
              fontWeight: 500,
              letterSpacing: "-0.012em",
            }}
          >
            Postings ingested but not yet verified
          </h3>
          <ul style={{ listStyle: "none", padding: 0, margin: 0 }}>
            {data.pending.map((p) => (
              <li
                key={p.id}
                style={{
                  padding: "12px 0",
                  borderTop: "1px solid var(--ink-08)",
                }}
              >
                <div
                  style={{
                    display: "flex",
                    justifyContent: "space-between",
                    gap: 12,
                    flexWrap: "wrap",
                  }}
                >
                  <div style={{ minWidth: 0 }}>
                    <div style={{ fontSize: 15, fontWeight: 500 }}>
                      {p.title}
                    </div>
                    <div style={{ marginTop: 4 }}>
                      {looksLikeUrl(p.url) ? (
                        <ExternalLink
                          href={p.url}
                          className="mono"
                          style={{
                            fontSize: 11,
                            color: "var(--ink-65)",
                            wordBreak: "break-all",
                          }}
                        >
                          ↗ {p.url}
                        </ExternalLink>
                      ) : (
                        <span
                          className="mono"
                          style={{ fontSize: 11, color: "var(--ink-65)" }}
                        >
                          {p.url}
                        </span>
                      )}
                    </div>
                  </div>
                  <div style={{ textAlign: "right" }}>
                    <span
                      className="mono"
                      style={{
                        fontSize: 11,
                        color: "var(--ink-50)",
                      }}
                    >
                      {p.source_slug} · {p.status}
                    </span>
                    <div style={{ marginTop: 8 }}>
                      <button
                        className="btn btn-sm"
                        onClick={() =>
                          router.push(
                            `/scan?url=${encodeURIComponent(p.url)}`,
                          )
                        }
                      >
                        Verify now →
                      </button>
                    </div>
                  </div>
                </div>
              </li>
            ))}
          </ul>
        </section>
      )}

      <hr className="rule-hair" style={{ marginTop: 40 }} />

      <section className="lh-report-actions">
        <div style={{ maxWidth: "54ch" }}>
          <div className="byline">Audit · this dossier</div>
          <p
            style={{
              margin: "10px 0 0",
              fontSize: 14,
              lineHeight: 1.55,
              color: "var(--ink-65)",
              textWrap: "pretty",
            }}
          >
            This dossier aggregates every Lighthouse verification of {c.display_name}.
            External links open in a new tab; the inspection history is the
            full ledger for this company.
          </p>
        </div>
        <div style={{ display: "flex", gap: 12 }}>
          <button
            className="btn btn-ghost btn-sm"
            onClick={() => router.push("/companies")}
          >
            ↗ All companies
          </button>
          <button
            className="btn btn-sm"
            onClick={() => router.push("/library")}
          >
            Library →
          </button>
        </div>
      </section>
    </main>
  );
}
