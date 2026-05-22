export function LighthouseMark({ size = 22 }: { size?: number }) {
  return (
    <svg
      className="mark"
      viewBox="0 0 22 22"
      style={{ width: size, height: size }}
      aria-hidden="true"
    >
      <rect className="beam" x="9" y="3" width="4" height="2" />
      <rect className="body" x="7" y="6" width="8" height="1.5" />
      <rect className="body" x="8.5" y="8" width="5" height="9" />
      <rect className="body" x="6" y="17.5" width="10" height="1.5" />
      <rect className="body" x="3" y="19.5" width="16" height="1.5" />
    </svg>
  );
}
