"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import type { CompanyRow } from "@/lib/companies";
import type { Verdict } from "@/lib/types";

function vClass(v: Verdict | null): string {
  if (v === "VERIFIED") return "v-verified";
  if (v === "INVESTIGATE") return "v-investigate";
  if (v === "DECLINE") return "v-decline";
  return "";
}

function fmtDate(iso: string | null): string {
  if (!iso) return "—";
  const d = (Date.now() - new Date(iso).getTime()) / 1000;
  if (d < 60) return "just now";
  if (d < 3600) return `${Math.floor(d / 60)}m`;
  if (d < 86400) return `${Math.floor(d / 3600)}h`;
  if (d < 86400 * 7) return `${Math.floor(d / 86400)}d`;
  if (d < 86400 * 30) return `${Math.floor(d / (86400 * 7))}w`;
  return `${Math.floor(d / (86400 * 30))}mo`;
}

export function CompaniesScreen() {
  const router = useRouter();
  const [companies, setCompanies] = useState<CompanyRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [query, setQuery] = useState("");
  const [sort, setSort] = useState<
    "recent" | "score" | "name" | "inspections"
  >("recent");

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch("/api/companies?limit=500");
        const json = await res.json();
        if (cancelled) return;
        if (json.error) setError(json.error);
        setCompanies(json.companies || []);
      } catch (e) {
        if (!cancelled) {
          setError(e instanceof Error ? e.message : "Failed to load.");
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, []);

  const visible = useMemo(() => {
    const q = query.trim().toLowerCase();
    const filtered = q
      ? companies.filter(
        (c) =>
          c.display_name.toLowerCase().includes(q) ||
          c.slug.toLowerCase().includes(q) ||
          (c.primary_domain || "").toLowerCase().includes(q),
      )
      : companies.slice();
    const sorted = filtered.slice();
    sorted.sort((a, b) => {
      if (sort === "name") return a.display_name.localeCompare(b.display_name);
      if (sort === "inspections")
        return (b.inspection_count || 0) - (a.inspection_count || 0);
      if (sort === "score")
        return (b.mean_score ?? 0) - (a.mean_score ?? 0);
      // recent
      const at = a.last_inspected_at
        ? new Date(a.last_inspected_at).getTime()
        : 0;
      const bt = b.last_inspected_at
        ? new Date(b.last_inspected_at).getTime()
        : 0;
      return bt - at;
    });
    return sorted;
  }, [companies, query, sort]);

  return (
    <main id="main" style={{ paddingTop: 32, paddingBottom: 96 }}>
      <div className="lh-library-head">
        <div>
          <div className="kicker">Companies · the trust card index</div>
          <h1 className="headline" style={{ margin: "8px 0 0" }}>
            Every company surfaced by an inspection.
          </h1>
        </div>
        <button
          className="btn btn-ghost btn-sm"
          onClick={() => router.push("/")}
        >
          ↗ Run new inspection
        </button>
      </div>

      <p className="dek" style={{ margin: "14px 0 0", maxWidth: "68ch" }}>
        Each row aggregates everything Lighthouse has learned across multiple
        verifications: mean score, latest verdict, and links to LinkedIn,
        Glassdoor, Crunchbase, and GitHub. Click any company to read its full
        dossier and the postings tied to it.
      </p>

      <div
        style={{
          display: "flex",
          gap: 12,
          flexWrap: "wrap",
          alignItems: "center",
          marginTop: 22,
        }}
      >
        <input
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Search by name or domain…"
          style={{
            flex: "1 1 260px",
            minWidth: 200,
            border: 0,
            borderBottom: "1px solid var(--ink)",
            background: "transparent",
            padding: "10px 4px",
            fontFamily: "var(--sans)",
            fontSize: 15,
            color: "var(--ink)",
            outline: "none",
          }}
        />
        <div style={{ display: "flex", gap: 4, flexWrap: "wrap" }} role="group" aria-label="Sort companies by">
          {(
            [
              ["recent", "Recent"],
              ["score", "Score"],
              ["inspections", "Inspections"],
              ["name", "A–Z"],
            ] as const
          ).map(([k, label]) => (
            <button
              key={k}
              onClick={() => setSort(k)}
              className={`lh-sort-btn ${sort === k ? "active" : ""}`}
              aria-label={`Sort by ${label}`}
              aria-pressed={sort === k}
            >
              {label}
            </button>
          ))}
        </div>
      </div>

      <hr className="rule" style={{ marginTop: 22 }} />

      <div className="byline lh-companies-head">
        <div>№</div>
        <div>Company</div>
        <div>Domain</div>
        <div>HQ</div>
        <div style={{ textAlign: "right" }}>Inspections</div>
        <div style={{ textAlign: "right" }}>Mean score</div>
        <div style={{ textAlign: "right" }}>Last verdict</div>
      </div>

      {loading && (
        <div style={{ display: "flex", flexDirection: "column", gap: 12, marginTop: 22 }}>
          {[1, 2, 3, 4, 5].map((idx) => (
            <div
              key={idx}
              className="lh-companies-row"
              style={{ borderBottom: "1px solid var(--ink-08)", padding: "18px 0" }}
            >
              <div className="skeleton" style={{ width: "20px", height: "14px" }} />
              <div style={{ display: "flex", flexDirection: "column", gap: 4 }}>
                <div className="skeleton" style={{ width: "120px", height: "17px" }} />
                <div className="skeleton" style={{ width: "80px", height: "11px" }} />
              </div>
              <div className="skeleton" style={{ width: "100px", height: "14px" }} />
              <div className="skeleton" style={{ width: "140px", height: "14px" }} />
              <div className="skeleton" style={{ width: "40px", height: "14px", justifySelf: "end" }} />
              <div className="skeleton" style={{ width: "30px", height: "22px", justifySelf: "end" }} />
              <div className="skeleton skeleton-chip" style={{ justifySelf: "end" }} />
            </div>
          ))}
        </div>
      )}
      {error && (
        <p
          className="byline"
          style={{ marginTop: 24, color: "var(--amber)" }}
        >
          {error}
        </p>
      )}

      {visible.map((c, i) => {
        const isInspected = (c.inspection_count ?? 0) > 0;
        const rowContent = (
          <div
            className={`lh-companies-row ${isInspected ? "is-inspected" : ""}`}
          >
            <div
              className="mono"
              style={{ fontSize: 12, color: "var(--ink-32)" }}
            >
              {String(i + 1).padStart(3, "0")}
            </div>
            <div
              style={{
                fontSize: 17,
                fontWeight: 500,
                letterSpacing: "-0.012em",
              }}
            >
              {c.display_name}
              {c.industry && (
                <div
                  className="byline"
                  style={{
                    marginTop: 2,
                    color: "var(--ink-50)",
                    letterSpacing: "0.04em",
                  }}
                >
                  {c.industry}
                </div>
              )}
            </div>
            <div
              className="mono"
              style={{ fontSize: 12, color: "var(--ink-65)" }}
            >
              {c.primary_domain || "—"}
            </div>
            <div
              className="mono"
              style={{ fontSize: 12, color: "var(--ink-50)" }}
            >
              {[c.hq_city, c.hq_region, c.hq_country]
                .filter(Boolean)
                .join(", ") || "—"}
            </div>
            <div
              className="mono"
              style={{
                textAlign: "right",
                fontSize: 17,
                color: "var(--ink-80)",
              }}
            >
              {c.inspection_count ?? 0}
            </div>
            <div
              className="mono"
              style={{
                textAlign: "right",
                fontSize: 22,
                fontWeight: 400,
                letterSpacing: "-0.02em",
                color:
                  (c.mean_score ?? 0) >= 80
                    ? "var(--trust)"
                    : (c.mean_score ?? 0) >= 50
                      ? "var(--ink)"
                      : "var(--amber)",
              }}
            >
              {c.mean_score != null ? Math.round(c.mean_score) : "—"}
            </div>
            <div style={{ textAlign: "right" }}>
              {c.last_verdict ? (
                <span
                  className={"verdict-pill " + vClass(c.last_verdict)}
                  title={`Last inspected ${fmtDate(c.last_inspected_at)} ago`}
                >
                  <span className="dot" /> {c.last_verdict}
                </span>
              ) : (
                <span
                  className="mono"
                  style={{ fontSize: 11, color: "var(--ink-32)" }}
                >
                  —
                </span>
              )}
            </div>
          </div>
        );

        if (isInspected) {
          return (
            <Link
              key={c.id}
              href={`/companies/${c.slug}`}
              style={{ textDecoration: "none", color: "inherit" }}
            >
              {rowContent}
            </Link>
          );
        } else {
          return <div key={c.id}>{rowContent}</div>;
        }
      })}

      <p className="byline" style={{ marginTop: 24, color: "var(--ink-32)" }}>
        Showing {visible.length} of {companies.length} companies. Click any verified company row
        for the full dossier.
      </p>
    </main>
  );
}
