import { describe, expect, it } from "vitest";
import { companySlug } from "@/lib/companies";
import { isJobBoardName, looksLikeUrl, normalizePillars } from "@/lib/gemini";

describe("Helper Utilities & Rules", () => {
  describe("companySlug", () => {
    it("should lower-case, remove special characters, replace spaces with single dashes", () => {
      expect(companySlug("Google LLC")).toBe("google-llc");
      expect(companySlug("Olive & June")).toBe("olive-june");
      expect(companySlug("---PostHog, Inc.---")).toBe("posthog-inc");
      expect(companySlug("")).toBe("");
    });
  });

  describe("isJobBoardName", () => {
    it("should correctly identify job board and platform domains or names", () => {
      expect(isJobBoardName("LinkedIn")).toBe(true);
      expect(isJobBoardName("linkedin.com")).toBe(true);
      expect(isJobBoardName("Indeed.com")).toBe(true);
      expect(isJobBoardName("Ashby")).toBe(true);
      expect(isJobBoardName("Lever")).toBe(true);
      expect(isJobBoardName("yc work at a startup")).toBe(true);
    });

    it("should reject normal company names", () => {
      expect(isJobBoardName("PostHog")).toBe(false);
      expect(isJobBoardName("Orbit")).toBe(false);
      expect(isJobBoardName("Stripe")).toBe(false);
    });
  });

  describe("looksLikeUrl", () => {
    it("should identify valid looking urls or domains", () => {
      expect(looksLikeUrl("sec.gov/edgar")).toBe(true);
      expect(looksLikeUrl("linkedin.com/company/google")).toBe(true);
      expect(looksLikeUrl("whois.iana.org")).toBe(true);
    });

    it("should reject non-url placeholders", () => {
      expect(looksLikeUrl("Internal research")).toBe(false);
      expect(looksLikeUrl("company website")).toBe(false);
      expect(looksLikeUrl("posting")).toBe(false);
      expect(looksLikeUrl("training data")).toBe(false);
    });
  });

  describe("Placeholder Source Downgrading", () => {
    it("should downgrade strong evidence with fake url source and replace with lighthouse/no-source", () => {
      const rawPillars = [
        {
          name: "Real",
          score: 85,
          verdict: "pass",
          summary: "Improper sources checks",
          evidence: [
            { weight: "strong", text: "Delaware C-corp filed.", src: "Internal research" },
            { weight: "medium", text: "TENURE check is correct.", src: "linkedin.com/in/recruiter" },
            { weight: "weak", text: "Active domain matches description.", src: "whois.iana.org" },
          ],
        },
      ];

      const normalized = normalizePillars(rawPillars);
      const realPillar = normalized.find((p) => p.name === "Real");
      expect(realPillar).toBeDefined();

      const internalEv = realPillar!.evidence.find((e) => e.text.includes("C-corp"));
      expect(internalEv).toBeDefined();
      expect(internalEv!.weight).toBe("weak"); // Downgraded from strong to weak
      expect(internalEv!.src).toBe("lighthouse/no-source"); // Replaced placeholder
    });
  });
});
