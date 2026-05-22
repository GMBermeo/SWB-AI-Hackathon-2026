import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import { Masthead } from "@/components/Masthead";
import { LighthouseMark } from "@/components/LighthouseMark";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Lighthouse — A verification engine for remote work",
  description:
    "Lighthouse inspects any remote job posting against four pillars — Real, Active, Fair, Credible — and returns a transparent report with cited evidence.",
};

const EDITION = `Vol. I · No. 142 · ${new Date("2026-05-21").toLocaleDateString(
  "en-US",
  { weekday: "long" },
)}`;

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${geistSans.variable} ${geistMono.variable}`}>
      <body>
        <div className="page">
          <Masthead edition={EDITION} />
          {children}
          <footer
            style={{
              borderTop: "1px solid var(--ink)",
              marginTop: 60,
              padding: "24px 0 36px",
              display: "flex",
              justifyContent: "space-between",
              alignItems: "center",
            }}
          >
            <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
              <LighthouseMark size={16} />
              <span className="byline">
                Lighthouse · A verification engine for remote work · MMXXVI
              </span>
            </div>
            <div className="byline" style={{ color: "var(--ink-32)" }}>
              Cited, audited, open.
            </div>
          </footer>
        </div>
      </body>
    </html>
  );
}
