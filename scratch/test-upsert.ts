import { upsertInspection } from "../src/lib/supabase";
import type { Posting } from "../src/lib/types";

// Load environment variables manually
process.env.NEXT_PUBLIC_SUPABASE_URL = "https://bcjknqtogfylhleqaset.supabase.co";
process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY = "sb_publishable_k3cW62n5BRpNG7b1rNPqlQ_ooPidmWs";

async function main() {
  const dummyPosting: Posting = {
    id: "live-dummy",
    url: "https://remoteok.com/remote-jobs/remote-agente-de-recrutamento-e-selecao-remoto-diarista-solvereh-1131773",
    company: "Solve RH",
    role: "Agente de Recrutamento",
    location: "Remote",
    isRemote: true,
    compMin: 1000,
    compMax: 2000,
    equity: "—",
    posted: "1 day ago",
    summary: "Dummy summary for test.",
    score: 80,
    verdict: "VERIFIED",
    headline: "Dummy headline.",
    editorial: "Dummy editorial.",
    pillars: [],
    activity: { reposts: [], label: "—", responseDays: null, ghostScore: 0 },
    comparables: []
  };

  try {
    const res = await upsertInspection(
      dummyPosting.url,
      "https://remoteok.com/remote-jobs/remote-agente-de-recrutamento-e-selecao-remoto-diarista-solvereh-1131773",
      dummyPosting,
      [],
      "dummy evidence"
    );

    console.log("Upsert response:", JSON.stringify(res, null, 2));
  } catch (e) {
    console.error("Upsert threw exception:", e);
  }
}

main();
