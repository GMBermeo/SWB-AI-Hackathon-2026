import { Suspense } from "react";
import { ScanScreen } from "@/components/ScanScreen";

export const metadata = {
  title: "Verify Posting — Lighthouse",
  description: "Scanning remote job posting pillars in real-time.",
};

export default function Page() {
  return (
    <Suspense
      fallback={
        <main style={{ padding: "120px 0", textAlign: "center" }}>
          <p className="dek">Loading scanner...</p>
        </main>
      }
    >
      <ScanScreen />
    </Suspense>
  );
}
