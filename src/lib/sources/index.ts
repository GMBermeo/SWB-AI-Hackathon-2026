// Source registry. Add adapters here and they wire automatically into the
// /api/ingest fan-out and the operational `sources` table.
import { remoteok } from "./remoteok";
import { greenhouse } from "./greenhouse";
import { lever } from "./lever";
import { ashby } from "./ashby";
import { wwr } from "./wwr";
import { glassdoor } from "./glassdoor";
import type { RawPosting, SourceAdapter } from "./types";

export const ALL_SOURCES: SourceAdapter[] = [
  remoteok,
  greenhouse,
  lever,
  ashby,
  wwr,
  glassdoor,
];

export interface SourceFetchResult {
  slug: string;
  displayName: string;
  postings: RawPosting[];
  error?: string;
  ms: number;
}

/**
 * Fetch the freshest `perSource` postings from every adapter in parallel.
 * Adapter failures are isolated — a 500 from one source never poisons the
 * batch.
 */
export async function fetchFromAll(
  perSource: number,
): Promise<SourceFetchResult[]> {
  const results = await Promise.all(
    ALL_SOURCES.map(async (s): Promise<SourceFetchResult> => {
      const t0 = Date.now();
      try {
        const postings = await s.fetchLatest(perSource);
        return {
          slug: s.slug,
          displayName: s.displayName,
          postings,
          ms: Date.now() - t0,
        };
      } catch (e: unknown) {
        return {
          slug: s.slug,
          displayName: s.displayName,
          postings: [],
          error: e instanceof Error ? e.message : String(e),
          ms: Date.now() - t0,
        };
      }
    }),
  );
  return results;
}

export type {
  RawPosting,
  SourceAdapter,
  SalaryBand,
  CompanySignals,
} from "./types";
