"use client";

import { useEffect, useRef, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { SCAN_STEPS, POSTINGS } from "@/lib/data";
import type { Posting } from "@/lib/types";
import { ExternalLink, looksLikeUrl } from "@/lib/clickable";

export type ScanRequest =
  | { kind: "demo"; posting: Posting }
  | { kind: "live"; url: string };

// Turn upstream errors (often a JSON-encoded Gemini payload) into one
// human-readable sentence so the scan-halted card doesn't look like a stack
// trace.
function prettifyError(e: unknown): string {
  const raw = e instanceof Error ? e.message : String(e ?? "");
  // Gemini bubbles up its error as JSON inside the message.
  const jsonStart = raw.indexOf("{");
  if (jsonStart >= 0) {
    try {
      const parsed = JSON.parse(raw.slice(jsonStart));
      const code = parsed?.error?.code;
      const status = parsed?.error?.status;
      if (code === 503 || status === "UNAVAILABLE") {
        return "Gemini's grounded-search service is at capacity right now. Try again in a minute, or run a bundled demo URL instead.";
      }
      if (code === 429 || status === "RESOURCE_EXHAUSTED") {
        return "Daily Gemini API quota exhausted on this key. Either wait for the rolling-window reset or add billing to the Google AI project.";
      }
      if (parsed?.error?.message) return parsed.error.message;
    } catch {
      /* fall through */
    }
  }
  return raw || "Verification failed.";
}

export function ScanScreen() {
  const router = useRouter();
  const searchParams = useSearchParams();

  // Derive request from query parameters: ?demo=... or ?url=...
  const demoId = searchParams.get("demo");
  const liveUrl = searchParams.get("url");

  let request: ScanRequest | null = null;
  if (demoId) {
    const p = POSTINGS.find((x) => x.id === demoId);
    if (p) {
      request = { kind: "demo", posting: p };
    }
  } else if (liveUrl) {
    request = { kind: "live", url: liveUrl };
  }
  const [idx, setIdx] = useState(0);
  const [doneStep, setDoneStep] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const livePostingRef = useRef<Posting | null>(null);

  useEffect(() => {
    if (!request) return;

    // ─── Demo mode: 16-step canned animation, lands on bundled report.
    if (request.kind === "demo") {
      let i = 0;
      const id = setInterval(() => {
        i += 1;
        if (i >= SCAN_STEPS.length) {
          clearInterval(id);
          setIdx(SCAN_STEPS.length);
          setDoneStep(true);
          setTimeout(() => router.push("/report/" + request.posting.id), 700);
        } else {
          setIdx(i);
        }
      }, 180);
      return () => clearInterval(id);
    }

    // ─── Live mode: animate steps while Gemini does the work in parallel.
    // We pace the visible scan so it lands roughly when the API returns.
    let aborted = false;
    let i = 0;
    const id = setInterval(() => {
      if (aborted) return;
      i += 1;
      // Hold at penultimate step until the API resolves, then finish.
      if (i >= SCAN_STEPS.length - 1) {
        setIdx(SCAN_STEPS.length - 1);
        return;
      }
      setIdx(i);
    }, 380);

    (async () => {
      let pollCount = 0;
      const maxPolls = 40; // up to 120 seconds (40 attempts * 3 seconds)

      const poll = async (): Promise<Posting> => {
        if (aborted) throw new Error("Verification aborted");

        try {
          const res = await fetch("/api/verify", {
            method: "POST",
            headers: { "content-type": "application/json" },
            body: JSON.stringify({ url: request.url }),
          });

          if (res.status === 504) {
            throw new Error("The live verification is taking longer than Vercel's 60-second limit. We are working on processing it in the background! Please check the Library in a moment.");
          }

          const contentType = res.headers.get("content-type") || "";
          if (!contentType.includes("application/json")) {
            // Occasional Gateway / Vercel deployment glitch, retry
            pollCount++;
            if (pollCount >= maxPolls) {
              throw new Error("Verification is taking longer than expected. It is still processing in the background, so you can safely check back in the Library in a minute.");
            }
            await new Promise((resolve) => setTimeout(resolve, 3000));
            return poll();
          }

          const json = await res.json();

          if (!res.ok) {
            throw new Error(json?.error || "Verification failed");
          }

          if (json?.pending) {
            pollCount++;
            if (pollCount >= maxPolls) {
              throw new Error("Verification is taking longer than expected. It is still processing in the background, so you can safely check back in the Library in a minute.");
            }
            await new Promise((resolve) => setTimeout(resolve, 3000));
            return poll();
          }

          if (!json?.posting) {
            throw new Error("Server returned an empty verification result.");
          }

          return json.posting as Posting;
        } catch (e: any) {
          if (aborted) throw new Error("Verification aborted");

          const msg = e instanceof Error ? e.message : String(e);
          // If it's a specific rate limit, timeout, or explicit quota failure, bubble it up immediately
          if (
            msg.includes("limit exceeded") ||
            msg.includes("quota") ||
            msg.includes("taking longer than expected") ||
            msg.includes("taking longer than Vercel's") ||
            msg.includes("timed out")
          ) {
            throw e;
          }

          // Otherwise, it might be a transient network failure, retry
          pollCount++;
          if (pollCount >= maxPolls) {
            throw new Error("Verification is taking longer than expected. It is still processing in the background, so you can safely check back in the Library in a minute.");
          }
          await new Promise((resolve) => setTimeout(resolve, 3000));
          return poll();
        }
      };

      try {
        const posting = await poll();
        if (aborted) return;

        livePostingRef.current = posting;
        // Let the animation play through to the last step, then finish.
        clearInterval(id);
        setIdx(SCAN_STEPS.length);
        setDoneStep(true);
        setTimeout(() => router.push("/report/" + (livePostingRef.current as Posting).id), 700);
      } catch (e: unknown) {
        if (aborted) return;
        clearInterval(id);
        setError(prettifyError(e));
      }
    })();

    return () => {
      aborted = true;
      clearInterval(id);
    };
    // The parent passes a stable `key` so this effect runs once per scan
    // request. Onmount-only deps; onDone is held in a ref-stable closure.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (!request) {
    return (
      <main style={{ padding: "120px 0", textAlign: "center" }}>
        <p className="dek">No posting selected.</p>
        <button className="btn btn-sm" onClick={() => router.push("/")}>
          Back
        </button>
      </main>
    );
  }

  const displayRole =
    request.kind === "demo" ? request.posting.role : "live posting";
  const displayCompany =
    request.kind === "demo" ? request.posting.company : "unknown source";
  const displayUrl =
    request.kind === "demo" ? request.posting.url : request.url;

  const seen = SCAN_STEPS.slice(0, idx);
  const counts: Record<string, number> = {
    Real: seen.filter((s) => s.pillar === "Real").length,
    Active: seen.filter((s) => s.pillar === "Active").length,
    Fair: seen.filter((s) => s.pillar === "Fair").length,
    Credible: seen.filter((s) => s.pillar === "Credible").length,
  };

  return (
    <main style={{ paddingTop: 32, paddingBottom: 96 }}>
      <div className="kicker">
        {request.kind === "live"
          ? "Live inspection · Gemini grounded search"
          : "Inspection in progress"}
      </div>
      <h1 className="headline" style={{ margin: "12px 0 8px", maxWidth: "18ch" }}>
        Inspecting <em>{displayRole}</em> at {displayCompany}
      </h1>
      <p
        className="mono"
        style={{
          fontSize: 12,
          color: "var(--ink-50)",
          margin: "0 0 32px",
          wordBreak: "break-all",
        }}
      >
        ↳{" "}
        {looksLikeUrl(displayUrl) ? (
          <ExternalLink
            href={displayUrl}
            style={{ color: "var(--ink-50)" }}
          >
            {displayUrl}
          </ExternalLink>
        ) : (
          displayUrl
        )}
      </p>

      <hr className="rule-hair" />

      <div
        className="lh-grid-4"
        style={{ borderBottom: "1px solid var(--ink-16)" }}
      >
        {(["Real", "Active", "Fair", "Credible"] as const).map((p, i) => {
          const total = SCAN_STEPS.filter((s) => s.pillar === p).length;
          const done = counts[p];
          const running = idx < SCAN_STEPS.length && SCAN_STEPS[idx]?.pillar === p;
          return (
            <div
              key={p}
              style={{
                padding: "22px 22px 24px",
                borderRight: i < 3 ? "1px solid var(--ink-16)" : "none",
              }}
            >
              <div
                style={{
                  display: "flex",
                  justifyContent: "space-between",
                  alignItems: "baseline",
                }}
              >
                <span className="mono" style={{ fontSize: 11, color: "var(--ink-50)" }}>
                  0{i + 1}
                </span>
                <span
                  className="mono"
                  style={{
                    fontSize: 11,
                    color: done === total ? "var(--trust)" : "var(--ink-50)",
                  }}
                >
                  {done}/{total}
                </span>
              </div>
              <div
                style={{
                  fontSize: 20,
                  fontWeight: 500,
                  letterSpacing: "-0.015em",
                  margin: "6px 0 14px",
                  color:
                    running || done === total ? "var(--ink)" : "var(--ink-50)",
                }}
              >
                {p}
                {running && (
                  <span
                    className="caret"
                    style={{ marginLeft: 6, background: "var(--trust)" }}
                  />
                )}
              </div>
              <div style={{ display: "flex", gap: 2 }}>
                {Array.from({ length: total }).map((_, j) => (
                  <div
                    key={j}
                    style={{
                      flex: 1,
                      height: 3,
                      background: j < done ? "var(--trust)" : "var(--ink-08)",
                    }}
                  />
                ))}
              </div>
            </div>
          );
        })}
      </div>

      <div
        style={{
          marginTop: 28,
          padding: "24px 28px",
          background: "var(--cream-deep)",
          border: "1px solid var(--ink-16)",
          minHeight: 380,
          fontFamily: "var(--mono)",
          fontSize: 13,
          lineHeight: 1.85,
          color: "var(--ink-65)",
        }}
      >
        <div className="byline" style={{ marginBottom: 10 }}>
          stream · {displayUrl.replace(/^https?:\/\//, "")}
        </div>
        {SCAN_STEPS.slice(0, idx).map((s, i) => (
          <div key={i} className="fade-in">
            <span style={{ color: "var(--trust)" }}>✓</span>
            <span style={{ color: "var(--ink-32)", margin: "0 10px" }}>
              [{String(i + 1).padStart(2, "0")}]
            </span>
            <span style={{ color: "var(--ink-50)" }}>{s.pillar.padEnd(8)}</span>
            <span style={{ color: "var(--ink)" }}>{s.check}</span>
          </div>
        ))}
        {idx < SCAN_STEPS.length && (
          <div>
            <span className="pulse" style={{ color: "var(--amber)" }}>
              ·
            </span>
            <span style={{ color: "var(--ink-32)", margin: "0 10px" }}>
              [{String(idx + 1).padStart(2, "0")}]
            </span>
            <span style={{ color: "var(--ink-50)" }}>
              {SCAN_STEPS[idx].pillar.padEnd(8)}
            </span>
            <span style={{ color: "var(--ink-80)" }}>
              {SCAN_STEPS[idx].check}
            </span>
            <span className="caret" />
          </div>
        )}
        {doneStep && (
          <div
            className="fade-in"
            style={{ marginTop: 14, color: "var(--trust)" }}
          >
            ━━━ verification complete · compiling report ━━━
          </div>
        )}
        {error && (
          <div
            className="fade-in"
            style={{
              marginTop: 18,
              padding: "16px 18px",
              border: "1px solid var(--amber)",
              color: "var(--amber)",
              background: "var(--amber-soft)",
            }}
          >
            <div className="byline" style={{ marginBottom: 8, color: "var(--amber)" }}>
              verification halted
            </div>
            <div style={{ color: "var(--ink-80)", fontFamily: "var(--mono)" }}>
              {error}
            </div>
            <div style={{ marginTop: 14 }}>
              <button className="btn btn-sm" onClick={() => router.push("/")}>
                ← Back to home
              </button>
            </div>
          </div>
        )}
      </div>
    </main>
  );
}
