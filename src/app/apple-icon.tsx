import { ImageResponse } from "next/og";

export const size = { width: 180, height: 180 };
export const contentType = "image/png";

export default function Icon() {
  return new ImageResponse(
    (
      <div
        style={{
          background: "#faf8f3",
          width: "100%",
          height: "100%",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        <svg viewBox="0 0 22 22" style={{ width: "120px", height: "120px" }}>
          {/* beam */}
          <rect x="9" y="3" width="4" height="2" fill="oklch(0.55 0.09 155)" />
          {/* body */}
          <rect x="7" y="6" width="8" height="1.5" fill="#14130f" />
          <rect x="8.5" y="8" width="5" height="9" fill="#14130f" />
          <rect x="6" y="17.5" width="10" height="1.5" fill="#14130f" />
          <rect x="3" y="19.5" width="16" height="1.5" fill="#14130f" />
        </svg>
      </div>
    ),
    {
      ...size,
    }
  );
}
