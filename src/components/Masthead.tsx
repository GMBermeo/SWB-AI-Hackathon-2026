"use client";

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

  return (
    <>
      <header className="masthead">
        <Link href="/" className="brand" style={{ textDecoration: "none" }}>
          <LighthouseMark size={22} />
          <span className="wordmark">Lighthouse</span>
        </Link>
        <nav className="nav">
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
      </header>
      <hr className="rule" />
    </>
  );
}
