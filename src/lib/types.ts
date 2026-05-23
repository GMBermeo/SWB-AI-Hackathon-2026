export type Verdict = "VERIFIED" | "INVESTIGATE" | "DECLINE";

export type PillarVerdict = "pass" | "mixed" | "fail";

export type EvidenceWeight = "strong" | "medium" | "weak";

export interface Evidence {
  weight: EvidenceWeight;
  text: string;
  src: string;
}

export interface Pillar {
  name: "Real" | "Active" | "Fair" | "Credible";
  score: number;
  verdict: PillarVerdict;
  summary: string;
  evidence: Evidence[];
}

export interface Activity {
  reposts: number[];
  label: string;
  responseDays: number | null;
  ghostScore: number;
}

export interface Comparable {
  co: string;
  role: string;
  comp: string;
  score: number;
}

export interface Posting {
  id: string;
  url: string;
  company: string;
  role: string;
  location: string;
  isRemote: boolean;
  compMin: number;
  compMax: number;
  equity: string;
  posted: string;
  summary: string;
  score: number;
  verdict: Verdict;
  headline: string;
  editorial: string;
  pillars: Pillar[];
  activity: Activity;
  comparables: Comparable[];
}

export interface ScanStep {
  pillar: Pillar["name"];
  check: string;
}
