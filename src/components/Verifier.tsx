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
    <form onSubmit={submit} className="lh-verifier">
      <input
        ref={ref}
        value={url}
        onChange={(e) => setUrl(e.target.value)}
        placeholder="paste a job posting URL — LinkedIn, Indeed, careers page, recruiter DM…"
        aria-label="Job posting URL"
        name="url"
        autoComplete="off"
      />
      <button type="submit">Verify ↗</button>
    </form>
  );
}
