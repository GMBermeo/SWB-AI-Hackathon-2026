"use client";

import { Suspense, useEffect, useState } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import Link from "next/link";
import { companySlug } from "@/lib/companies";
import type { Posting, Verdict } from "@/lib/types";

interface CompanyItem {
  id: string;
  display_name: string;
  slug?: string;
  industry?: string;
  hq_city?: string;
  hq_region?: string;
  hq_country?: string;
  glassdoor_rating?: number;
  notes?: string;
}

function SearchScreen() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const query = searchParams.get("q") || "";

  const [postings, setPostings] = useState<Posting[]>([]);
  const [companies, setCompanies] = useState<CompanyItem[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    if (!query.trim()) {
      const t = setTimeout(() => {
        setPostings([]);
        setCompanies([]);
      }, 0);
      return () => clearTimeout(t);
    }

    let active = true;
    (async () => {
      setLoading(true);
      setError("");
      try {
        const res = await fetch(`/api/search?q=${encodeURIComponent(query)}`);
        if (!res.ok) throw new Error("Search service failed.");
        const data = await res.json();
        if (active) {
          setPostings(data.postings || []);
          setCompanies(data.companies || []);
        }
      } catch (err: unknown) {
        if (active) {
          setError(
            err instanceof Error ? err.message : "Failed to fetch search results."
          );
        }
      } finally {
        if (active) setLoading(false);
      }
    })();

    return () => {
      active = false;
    };
  }, [query]);

  const vClass = (v: Verdict) =>
    v === "VERIFIED"
      ? "v-verified"
      : v === "INVESTIGATE"
        ? "v-investigate"
        : "v-decline";

  const highlight = (text: string, q: string) => {
    if (!text) return "";
    if (!q.trim()) return text;
    const parts = text.split(new RegExp(`(${escapeRegExp(q)})`, "gi"));
    return (
      <>
        {parts.map((part, i) =>
          part.toLowerCase() === q.toLowerCase() ? (
            <mark
              key={i}
              style={{
                background: "var(--amber-soft)",
                color: "var(--ink)",
                padding: "1px 2px",
                borderRadius: 2,
              }}
            >
              {part}
            </mark>
          ) : (
            part
          )
        )}
      </>
    );
  };

  const escapeRegExp = (string: string) => {
    return string.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  };

  const hasResults = postings.length > 0 || companies.length > 0;

  return (
    <main style={{ paddingTop: 32, paddingBottom: 96 }}>
      <div className="lh-library-head" style={{ marginBottom: 32 }}>
        <div>
          <div className="kicker">Search Results · ledger query</div>
          <h1 className="headline" style={{ margin: "8px 0 0" }}>
            {query.trim() ? (
              <>
                Matches for <span style={{ fontFamily: "var(--mono)" }}>“{query}”</span>
              </>
            ) : (
              "General Search"
            )}
          </h1>
        </div>
        <button
          className="btn btn-ghost btn-sm"
          onClick={() => router.push("/")}
        >
          ↗ Run new inspection
        </button>
      </div>

      {loading && (
        <div style={{ padding: "64px 0", textAlign: "center" }}>
          <div className="mono" style={{ fontSize: 15, color: "var(--ink-50)" }}>
            Scanning ledger and company registries...
          </div>
        </div>
      )}

      {error && (
        <div style={{ padding: "32px", background: "var(--amber-soft)", border: "1px solid var(--amber)", borderRadius: 4, marginBottom: 32 }}>
          <p className="mono" style={{ margin: 0, color: "var(--ink)" }}>{error}</p>
        </div>
      )}

      {!loading && !error && !query.trim() && (
        <div style={{ padding: "64px 0", textAlign: "center", border: "1px dashed var(--ink-32)", borderRadius: 4 }}>
          <p className="dek" style={{ margin: "0 0 16px" }}>Please type a search query in the header to search the Lighthouse ledger.</p>
        </div>
      )}

      {!loading && !error && query.trim() && !hasResults && (
        <div style={{ padding: "64px 24px", textAlign: "center", border: "1px dashed var(--ink-32)", borderRadius: 4 }}>
          <p className="dek" style={{ margin: "0 0 16px" }}>No verified job postings or registered companies found matching “{query}”.</p>
          <p className="byline" style={{ margin: "0 0 24px" }}>You can run a new automated AI verification immediately by scanning the URL.</p>
          <button className="btn" onClick={() => router.push("/")}>
            Scan a Job Posting URL →
          </button>
        </div>
      )}

      {!loading && hasResults && (
        <div className="lh-search-grid" style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 40, alignItems: "start" }}>
          {/* Postings Column */}
          <div>
            <h2 className="kicker" style={{ borderBottom: "1px solid var(--ink)", paddingBottom: 10, marginBottom: 18, color: "var(--ink)" }}>
              Verified Postings ({postings.length})
            </h2>

            {postings.length === 0 ? (
              <p className="mono" style={{ color: "var(--ink-32)", fontSize: 13, padding: "12px 0" }}>No job postings matched this query.</p>
            ) : (
              <div style={{ display: "flex", flexDirection: "column", gap: 16 }}>
                {postings.map((p) => (
                  <div
                    key={p.id}
                    style={{
                      borderBottom: "1px solid var(--ink-08)",
                      paddingBottom: 16,
                      cursor: "pointer",
                    }}
                    onClick={() => router.push(`/report/${p.id}`)}
                  >
                    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", gap: 12 }}>
                      <Link
                        href={`/report/${p.id}`}
                        style={{ fontSize: 17, fontWeight: 600, textDecoration: "none", color: "var(--ink)" }}
                      >
                        {highlight(p.role, query)}
                      </Link>
                      <span className={"verdict-pill " + vClass(p.verdict)} style={{ flexShrink: 0 }}>
                        <span className="dot" /> {p.verdict}
                      </span>
                    </div>

                    <div className="mono" style={{ fontSize: 11, color: "var(--ink-50)", marginTop: 4 }}>
                      at{" "}
                      <Link
                        href={`/companies/${companySlug(p.company)}`}
                        onClick={(e) => e.stopPropagation()}
                        style={{ textDecoration: "underline", color: "inherit", fontWeight: 500 }}
                      >
                        {highlight(p.company, query)}
                      </Link>{" "}
                      · {highlight(p.location, query)} {p.isRemote && <span style={{ color: "var(--trust)", marginLeft: 4 }}>[Remote]</span>}
                    </div>

                    <p style={{ margin: "8px 0 0", fontSize: 13, color: "var(--ink-65)", lineClamp: 2, display: "-webkit-box", WebkitLineClamp: 2, WebkitBoxOrient: "vertical", overflow: "hidden" }}>
                      {highlight(p.summary, query)}
                    </p>

                    <div style={{ display: "flex", gap: 12, marginTop: 8, alignItems: "center" }}>
                      <span className="mono" style={{ fontSize: 11, background: "var(--cream-deep)", padding: "2px 6px", border: "1px solid var(--cream-line)" }}>
                        Score: {p.score}
                      </span>
                      {p.compMax > 0 && (
                        <span className="mono" style={{ fontSize: 11, color: "var(--ink-65)" }}>
                          Comp: ${(p.compMin / 1000).toFixed(0)}k–${(p.compMax / 1000).toFixed(0)}k
                        </span>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* Companies Column */}
          <div>
            <h2 className="kicker" style={{ borderBottom: "1px solid var(--ink)", paddingBottom: 10, marginBottom: 18, color: "var(--ink)" }}>
              Registered Companies ({companies.length})
            </h2>

            {companies.length === 0 ? (
              <p className="mono" style={{ color: "var(--ink-32)", fontSize: 13, padding: "12px 0" }}>No companies matched this query.</p>
            ) : (
              <div style={{ display: "flex", flexDirection: "column", gap: 16 }}>
                {companies.map((c) => (
                  <div
                    key={c.id}
                    style={{
                      borderBottom: "1px solid var(--ink-08)",
                      paddingBottom: 16,
                      cursor: "pointer",
                    }}
                    onClick={() => router.push(`/companies/${companySlug(c.display_name)}`)}
                  >
                    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", gap: 12 }}>
                      <Link
                        href={`/companies/${companySlug(c.display_name)}`}
                        style={{ fontSize: 17, fontWeight: 600, textDecoration: "none", color: "var(--ink)" }}
                      >
                        {highlight(c.display_name, query)}
                      </Link>
                      {c.glassdoor_rating != null && (
                        <span className="mono" style={{ fontSize: 12, fontWeight: 500, color: "var(--ink)" }}>
                          ★ {Number(c.glassdoor_rating).toFixed(1)}
                        </span>
                      )}
                    </div>

                    <div className="mono" style={{ fontSize: 11, color: "var(--ink-50)", marginTop: 4 }}>
                      {c.industry ? highlight(c.industry, query) : "General Industry"} · {[c.hq_city, c.hq_region, c.hq_country].filter(Boolean).join(", ")}
                    </div>

                    {c.notes && (
                      <p style={{ margin: "8px 0 0", fontSize: 13, color: "var(--ink-65)", lineClamp: 2, display: "-webkit-box", WebkitLineClamp: 2, WebkitBoxOrient: "vertical", overflow: "hidden" }}>
                        {highlight(c.notes, query)}
                      </p>
                    )}
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
      )}

      <style jsx global>{`
        @media (max-width: 760px) {
          .lh-search-grid {
            grid-template-columns: 1fr !important;
            gap: 40px !important;
          }
        }
      `}</style>
    </main>
  );
}

export default function Page() {
  return (
    <Suspense
      fallback={
        <div style={{ padding: "120px 0", textAlign: "center" }}>
          <div className="mono kicker">Loading Search Ledger...</div>
        </div>
      }
    >
      <SearchScreen />
    </Suspense>
  );
}
