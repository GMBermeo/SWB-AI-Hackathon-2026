"use client";

import { useEffect, useId, useState, useRef } from "react";
import { usePathname, useRouter } from "next/navigation";
import Link from "next/link";
import { LighthouseMark } from "./LighthouseMark";
import { companySlug } from "@/lib/companies";

interface AutocompletePosting {
  id: string;
  company: string;
  role: string;
  location: string;
  score: number;
  verdict: "VERIFIED" | "INVESTIGATE" | "DECLINE";
}

interface AutocompleteCompany {
  id: string;
  slug: string;
  display_name: string;
  industry: string | null;
  hq_city: string | null;
  inspection_count?: number;
}

const ITEMS = [
  { href: "/library", label: "Library" },
  { href: "/companies", label: "Companies" },
  { href: "/how", label: "How it works" },
  { href: "/scan", label: "Verify" },
] as const;

export function Masthead({ edition }: { edition: string }) {
  const pathname = usePathname();
  const router = useRouter();
  const [open, setOpen] = useState(false);
  const menuId = useId();

  const [searchQuery, setSearchQuery] = useState("");
  const [results, setResults] = useState<{ postings: AutocompletePosting[]; companies: AutocompleteCompany[] }>({ postings: [], companies: [] });
  const [showDropdown, setShowDropdown] = useState(false);
  const [loading, setLoading] = useState(false);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const t = setTimeout(() => {
      setOpen(false);
      setShowDropdown(false);
      setSearchQuery("");
    }, 0);
    return () => clearTimeout(t);
  }, [pathname]);

  useEffect(() => {
    if (!open) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [open]);

  // Click outside to close dropdown
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setShowDropdown(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  // Fetch search results (debounced autocomplete)
  useEffect(() => {
    if (!searchQuery.trim()) {
      const t = setTimeout(() => {
        setResults({ postings: [], companies: [] });
        setShowDropdown(false);
      }, 0);
      return () => clearTimeout(t);
    }

    const timer = setTimeout(async () => {
      setLoading(true);
      try {
        const res = await fetch(`/api/search?q=${encodeURIComponent(searchQuery)}`);
        if (res.ok) {
          const data = await res.json();
          setResults(data);
          setShowDropdown(true);
        }
      } catch (err) {
        console.error("Autocomplete fetch error:", err);
      } finally {
        setLoading(false);
      }
    }, 200);

    return () => clearTimeout(timer);
  }, [searchQuery]);

  const handleSearchSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (searchQuery.trim()) {
      setShowDropdown(false);
      router.push(`/search?q=${encodeURIComponent(searchQuery.trim())}`);
    }
  };

  const hasResults = results.postings.length > 0 || results.companies.length > 0;

  const renderSearchBox = (isMobile: boolean) => (
    <div className="lh-search-box" ref={isMobile ? undefined : dropdownRef}>
      <form onSubmit={handleSearchSubmit} role="search">
        <span className="lh-search-icon" aria-hidden="true" style={{ display: "inline-flex", alignItems: "center" }}>
          <svg
            width="13"
            height="13"
            viewBox="0 0 16 16"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <circle cx="7" cy="7" r="5" />
            <path d="m11 11 3.5 3.5" />
          </svg>
        </span>
        <input
          type="text"
          className="lh-search-input"
          placeholder="Search jobs, companies…"
          aria-label="Search jobs and companies"
          name="q"
          autoComplete="off"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          onFocus={() => {
            if (searchQuery.trim()) setShowDropdown(true);
          }}
        />
      </form>

      {showDropdown && (
        <div className="lh-search-dropdown" ref={isMobile ? dropdownRef : undefined}>
          {loading && (
            <div className="lh-search-empty mono">Scanning records…</div>
          )}

          {!loading && !hasResults && (
            <div className="lh-search-empty mono">No matches found</div>
          )}

          {!loading && hasResults && (
            <>
              {results.postings.length > 0 && (
                <div className="lh-search-section">
                  <div className="lh-search-section-title">Verified Job Postings</div>
                  {results.postings.slice(0, 4).map((p) => {
                    const isVerified = p.verdict === "VERIFIED";
                    return (
                      <Link
                        key={p.id}
                        href={`/report/${p.id}`}
                        className="lh-search-item"
                        onClick={() => setShowDropdown(false)}
                      >
                        <div className="lh-search-item-title">
                          {p.role}
                          <span
                            className={`lh-search-item-badge ${
                              isVerified ? "verified" : "investigate"
                            }`}
                          >
                            {p.score}
                          </span>
                        </div>
                        <div className="lh-search-item-subtitle">
                          {p.company} · {p.location}
                        </div>
                      </Link>
                    );
                  })}
                </div>
              )}

              {results.companies.length > 0 && (
                <div className="lh-search-section">
                  <div className="lh-search-section-title">Companies</div>
                  {results.companies.slice(0, 4).map((c) => {
                    const isInspected = (c.inspection_count ?? 0) > 0;
                    if (isInspected) {
                      return (
                        <Link
                          key={c.slug || c.id}
                          href={`/companies/${companySlug(c.display_name)}`}
                          className="lh-search-item"
                          onClick={() => setShowDropdown(false)}
                        >
                          <div className="lh-search-item-title">{c.display_name}</div>
                          <div className="lh-search-item-subtitle">
                            {c.industry || "General"} · {c.hq_city || "Remote"}
                          </div>
                        </Link>
                      );
                    } else {
                      return (
                        <div
                          key={c.slug || c.id}
                          className="lh-search-item"
                          style={{ cursor: "default" }}
                        >
                          <div className="lh-search-item-title">{c.display_name}</div>
                          <div className="lh-search-item-subtitle">
                            {c.industry || "General"} · {c.hq_city || "Remote"} (Pending verification)
                          </div>
                        </div>
                      );
                    }
                  })}
                </div>
              )}

              <div style={{ padding: "8px 14px", background: "var(--cream-deep)", borderTop: "1px solid var(--ink-08)", textAlign: "center" }}>
                <Link
                  href={`/search?q=${encodeURIComponent(searchQuery)}`}
                  className="mono"
                  style={{ fontSize: 11, fontWeight: 500, color: "var(--ink)" }}
                  onClick={() => setShowDropdown(false)}
                >
                  View all search results →
                </Link>
              </div>
            </>
          )}
        </div>
      )}
    </div>
  );

  return (
    <>
      <header className="masthead" data-menu-open={open ? "1" : "0"}>
        <Link href="/" className="brand" style={{ textDecoration: "none" }}>
          <LighthouseMark size={22} />
          <span className="wordmark">Lighthouse</span>
        </Link>

        <nav className="nav" aria-label="Primary">
          {ITEMS.map(({ href, label }) => {
            const active = pathname === href;
            return (
              <Link
                key={href}
                href={href}
                data-on={active ? "1" : "0"}
                className="nav-link"
                style={{
                  textDecoration: "none",
                  display: "inline-block",
                }}
              >
                {label}
              </Link>
            );
          })}
        </nav>

        <div style={{ display: "flex", alignItems: "center", gap: 16 }}>
          <div className="search-desktop-wrapper" style={{ display: "inline-block" }}>
            {renderSearchBox(false)}
          </div>
          <div className="edition" style={{ flexShrink: 0 }}>{edition}</div>
        </div>

        <button
          type="button"
          className="hamburger"
          aria-label={open ? "Close menu" : "Open menu"}
          aria-expanded={open}
          aria-controls={menuId}
          onClick={() => setOpen((v) => !v)}
        >
          <span className="hamburger-bar" />
          <span className="hamburger-bar" />
          <span className="hamburger-bar" />
        </button>

        <div
          id={menuId}
          className="mobile-menu"
          data-open={open ? "1" : "0"}
          role="dialog"
          aria-modal="true"
          aria-label="Site menu"
          hidden={!open}
        >
          <div style={{ padding: "16px 20px 8px" }}>
            {renderSearchBox(true)}
          </div>

          <nav aria-label="Mobile primary" style={{ marginTop: 12 }}>
            <ul className="mobile-menu-list">
              {ITEMS.map(({ href, label }) => {
                const active = pathname === href;
                return (
                  <li key={href}>
                    <Link
                      href={href}
                      data-on={active ? "1" : "0"}
                      className="mobile-menu-link"
                    >
                      {label}
                    </Link>
                  </li>
                );
              })}
            </ul>
          </nav>
          <div className="mobile-menu-edition">{edition}</div>
        </div>
      </header>

      {open && (
        <button
          type="button"
          className="mobile-menu-scrim"
          aria-label="Close menu"
          onClick={() => setOpen(false)}
        />
      )}

      <hr className="rule" />
    </>
  );
}

