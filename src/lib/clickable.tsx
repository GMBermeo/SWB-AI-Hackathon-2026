import React from "react";

// Matches http(s) URLs and bare-domain references that are safe to linkify.
// We use TWO patterns so we can decide what to do with each match:
//   - explicitUrl: full http(s)://... — linked as-is
//   - bareDomain : something.tld[/path] without a scheme — linked with https://
// Patterns must be kept in sync with the alternation in linkify().
const URL_RE =
  /(\bhttps?:\/\/[^\s<>"')]+|\b(?:[a-z0-9-]+\.)+[a-z]{2,}(?:\/[^\s<>"')]*)?)/gi;

/** True when the value looks like something the user could click open. */
export function looksLikeUrl(value: string): boolean {
  const v = value.trim();
  if (!v) return false;
  if (/^https?:\/\//i.test(v)) return true;
  // bare domain like "linkedin.com" or "github.com/posthog"
  return /^(?:[a-z0-9-]+\.)+[a-z]{2,}(?:\/.*)?$/i.test(v);
}

/** Coerce a domain or full URL into an absolute href. */
export function toHref(value: string): string {
  const v = value.trim();
  if (/^https?:\/\//i.test(v)) return v;
  return `https://${v}`;
}

/** Render a single URL/domain as an anchor with sensible defaults. */
export function ExternalLink({
  href,
  children,
  className,
  style,
  title,
}: {
  href: string;
  children?: React.ReactNode;
  className?: string;
  style?: React.CSSProperties;
  title?: string;
}) {
  return (
    <a
      href={toHref(href)}
      target="_blank"
      rel="noopener noreferrer"
      className={className}
      style={style}
      title={title || href}
    >
      {children ?? href}
    </a>
  );
}

/**
 * Walk a string and replace every URL-shaped token with an <a> element. Used
 * for free-form fields like notes, summaries, and editorial copy where the
 * model may have included a raw link.
 */
export function linkify(text: string | null | undefined): React.ReactNode[] {
  if (!text) return [];
  const out: React.ReactNode[] = [];
  let lastIndex = 0;
  let m: RegExpExecArray | null;
  URL_RE.lastIndex = 0;
  while ((m = URL_RE.exec(text)) !== null) {
    const start = m.index;
    const end = start + m[0].length;
    if (start > lastIndex) out.push(text.slice(lastIndex, start));
    out.push(
      <ExternalLink key={`${start}-${end}`} href={m[0]}>
        {m[0]}
      </ExternalLink>,
    );
    lastIndex = end;
  }
  if (lastIndex < text.length) out.push(text.slice(lastIndex));
  return out;
}
