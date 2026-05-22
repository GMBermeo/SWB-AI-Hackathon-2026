"use client";

import { useEffect, useRef, useState } from "react";

export function Verifier({
  onSubmit,
  autofocus = false,
}: {
  onSubmit: (url: string) => void;
  autofocus?: boolean;
}) {
  const [url, setUrl] = useState("");
  const ref = useRef<HTMLInputElement>(null);

  useEffect(() => {
    if (autofocus && ref.current) ref.current.focus();
  }, [autofocus]);

  const submit = (e?: React.FormEvent) => {
    e?.preventDefault?.();
    onSubmit(url || "https://orbit.work/careers/senior-frontend-2026");
  };

  return (
    <form
      onSubmit={submit}
      style={{
        display: "flex",
        gap: 0,
        alignItems: "stretch",
        borderTop: "1px solid var(--ink)",
        borderBottom: "1px solid var(--ink)",
      }}
    >
      <input
        ref={ref}
        value={url}
        onChange={(e) => setUrl(e.target.value)}
        placeholder="paste a job posting URL — LinkedIn, Indeed, careers page, recruiter DM…"
        style={{
          flex: 1,
          border: 0,
          background: "transparent",
          padding: "22px 16px",
          fontFamily: "var(--sans)",
          fontSize: 17,
          letterSpacing: "-0.005em",
          color: "var(--ink)",
          outline: "none",
        }}
      />
      <button
        type="submit"
        style={{
          border: 0,
          background: "var(--ink)",
          color: "var(--cream)",
          fontFamily: "var(--sans)",
          fontWeight: 500,
          fontSize: 14,
          letterSpacing: "0.04em",
          textTransform: "uppercase",
          padding: "0 28px",
          cursor: "pointer",
        }}
      >
        Verify ↗
      </button>
    </form>
  );
}
