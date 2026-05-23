import { describe, expect, it } from "vitest";
import { normalizePillars } from "@/lib/gemini";

describe("Scoring & Clamping Rules", () => {
  it("should cap score at 70 if there is no strong evidence in a pillar", () => {
    const rawPillars = [
      {
        name: "Real",
        score: 95,
        verdict: "pass",
        summary: "Passes on weak and medium evidence",
        evidence: [
          { weight: "medium", text: "Tenure matches recruiter footprint.", src: "linkedin.com" },
          { weight: "medium", text: "No other active domains match description.", src: "sec.gov/edgar" },
          { weight: "weak", text: "Verification via header timestamp is active.", src: "http/headers" },
        ],
      },
    ];

    const normalized = normalizePillars(rawPillars);
    const realPillar = normalized.find((p) => p.name === "Real");
    expect(realPillar).toBeDefined();
    expect(realPillar!.score).toBeLessThanOrEqual(70);
  });

  it("should cap score at 75 if there are fewer than 3 evidence items in a pillar", () => {
    const rawPillars = [
      {
        name: "Active",
        score: 90,
        verdict: "pass",
        summary: "Passes on a single strong evidence",
        evidence: [
          { weight: "strong", text: "First seen 2026-05-17. No prior snapshots.", src: "web.archive.org" },
        ],
      },
    ];

    const normalized = normalizePillars(rawPillars);
    const activePillar = normalized.find((p) => p.name === "Active");
    expect(activePillar).toBeDefined();
    expect(activePillar!.score).toBeLessThanOrEqual(75);
  });

  it("should allow high scores when multiple evidence items (>=3) are present, including at least one strong citation", () => {
    const rawPillars = [
      {
        name: "Credible",
        score: 95,
        verdict: "pass",
        summary: "Verifiable small team and product commits",
        evidence: [
          { weight: "strong", text: "Domain active, NS records verified for 22 months.", src: "whois.iana.org" },
          { weight: "medium", text: "Founders are ex-Linear, ex-Figma.", src: "linkedin.com" },
          { weight: "weak", text: "Sign-up logic checks out.", src: "lighthouse/crawl" },
        ],
      },
    ];

    const normalized = normalizePillars(rawPillars);
    const crediblePillar = normalized.find((p) => p.name === "Credible");
    expect(crediblePillar).toBeDefined();
    // Strong evidence is present, length is 3. Downgrading for 'lighthouse/crawl' placeholder to weak makes src = 'lighthouse/no-source'.
    // The score should remain high (not capped by the 70 or 75 limits).
    expect(crediblePillar!.score).toBe(95);
  });
});
