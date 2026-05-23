import { describe, expect, it } from "vitest";
import { normalizeUrl } from "@/lib/normalize";

describe("normalizeUrl", () => {
  it("should return empty string for empty input", () => {
    expect(normalizeUrl("")).toBe("");
    expect(normalizeUrl("   ")).toBe("");
  });

  it("should prepend https protocol if missing", () => {
    expect(normalizeUrl("orbit.work/careers")).toBe("https://orbit.work/careers");
    expect(normalizeUrl("http://orbit.work/careers")).toBe("https://orbit.work/careers");
  });

  it("should lowercase and strip www from hostname", () => {
    expect(normalizeUrl("http://WWW.OrbiT.WoRk/Careers")).toBe("https://orbit.work/Careers");
  });

  it("should strip common tracking parameters", () => {
    const raw = "https://orbit.work/careers?utm_source=linkedin&ref=newsletter&src=twitter&keep_this=true";
    expect(normalizeUrl(raw)).toBe("https://orbit.work/careers?keep_this=true");
  });

  it("should sort query parameters alphabetically", () => {
    const raw = "https://orbit.work/careers?z=last&a=first&m=middle";
    expect(normalizeUrl(raw)).toBe("https://orbit.work/careers?a=first&m=middle&z=last");
  });

  it("should strip fragment hashes", () => {
    const raw = "https://orbit.work/careers#apply-now";
    expect(normalizeUrl(raw)).toBe("https://orbit.work/careers");
  });

  it("should trim trailing slashes if there is no query", () => {
    expect(normalizeUrl("https://orbit.work/careers/")).toBe("https://orbit.work/careers");
    expect(normalizeUrl("https://orbit.work/careers/?a=1")).toBe("https://orbit.work/careers/?a=1");
  });
});
