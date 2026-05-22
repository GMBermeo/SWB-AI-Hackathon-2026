"use client";

import { useEffect, useId, useState } from "react";
import { usePathname } from "next/navigation";
import Link from "next/link";
import { LighthouseMark } from "./LighthouseMark";

const ITEMS = [
  { href: "/library", label: "Library" },
  { href: "/how", label: "How it works" },
  { href: "/scan", label: "Verify" },
] as const;

export function Masthead({ edition }: { edition: string }) {
  const pathname = usePathname();
  const [open, setOpen] = useState(false);
  const menuId = useId();

  useEffect(() => {
    setOpen(false);
  }, [pathname]);

  useEffect(() => {
    if (!open) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [open]);

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
                style={{
                  textDecoration: "none",
                  display: "inline-block",
                }}
              >
                <button
                  data-on={active ? "1" : "0"}
                  style={{ pointerEvents: "none" }}
                >
                  {label}
                </button>
              </Link>
            );
          })}
        </nav>

        <div className="edition">{edition}</div>

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
          <nav aria-label="Mobile primary">
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
