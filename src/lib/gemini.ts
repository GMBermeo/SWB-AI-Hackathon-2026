import { GoogleGenAI } from "@google/genai";
import type { EvidenceWeight, Posting } from "./types";
import { lookupCompanyForUrl, renderCompanyContext } from "./companies";

// Model fallback chains, ordered by available per-minute capacity on the
// project's free-tier key. Probed via curl against the actual API — the
// 2.0 family and 1.5 family return 429/404 here, so we don't try them.
//
// Stage 1 needs `google_search` grounding. Only the 2.5-family models in
// this project carry grounded quota.
const GROUNDED_MODELS = [
  "gemini-2.5-flash",       // 5 RPM, 500 RPD grounded
  "gemini-2.5-flash-lite",  // 10 RPM, 500 RPD grounded
] as const;

// Stage 2 is a JSON formatter — no tools required, so any text model with
// free-tier quota is fair game. Ordered highest-RPM-first to spread the
// per-minute load.
const UNGROUNDED_MODELS = [
  "gemini-3.1-flash-lite",  // 15 RPM
  "gemini-2.5-flash-lite",  // 10 RPM
  "gemini-2.5-flash",       //  5 RPM
  "gemini-3.5-flash",       //  5 RPM
] as const;

type Model = string;

const RETRYABLE_STATUS = new Set([429, 500, 502, 503, 504]);

// Job boards / aggregators / ATS platforms that host listings on behalf
// of companies. NONE of these are the hiring company themselves — if
// Gemini reports one of these as the employer, the company identity is
// effectively unknown and the Real pillar is capped.
const JOB_BOARDS = [
  "linkedin", "indeed", "glassdoor", "wellfound", "angellist",
  "otta", "welcome to the jungle", "ziprecruiter", "monster",
  "dice", "builtin", "hired", "remote.co", "weworkremotely",
  "we work remotely", "remoteok", "remote ok", "working nomads",
  "jobspresso", "lever", "greenhouse", "ashby", "workable",
  "workday", "smartrecruiters", "bamboohr", "jazzhr", "recruitee",
  "teamtailor", "comeet", "breezy", "talentlyft",
  "yc work at a startup", "y combinator", "work at a startup",
] as const;

function isJobBoardName(name: string): boolean {
  if (!name) return false;
  const n = name.toLowerCase().trim().replace(/\.(com|io|co|net|org)$/i, "").trim();
  return JOB_BOARDS.some((b) => n === b || n.startsWith(b + " ") || n.endsWith(" " + b));
}

// Two-pass design: grounded search produces an evidence dossier; a second
// structured pass coerces it into our 4-pillar Posting JSON. Gemini does
// not allow `googleSearch` and `responseSchema` in the same call.

const STAGE1_PROMPT = `You are Lighthouse, a verification engine for remote job postings.
Behave as an investigative AGENT, not a single-shot model. Run multiple
Google Search queries (you have the googleSearch tool) until you have
*at least 3 specific, source-cited facts per pillar*. Specific means at
least one of: a date in YYYY-MM-DD form, a dollar amount, a discrete
count, or a named person/investor/product — backed by a real URL.

===== STOP — IDENTIFY THE HIRING COMPANY FIRST =====

The HIRING COMPANY is the employer, NOT the platform where the posting
lives. Job boards and ATS platforms host listings on behalf of companies;
they are virtually never the employer themselves. Get this wrong and the
entire verification is invalid.

NEVER report any of these as the hiring company:
  LinkedIn · Indeed · Glassdoor · Wellfound (formerly AngelList) · Otta ·
  Welcome to the Jungle · ZipRecruiter · Monster · Dice · BuiltIn · Hired ·
  Remote.co · WeWorkRemotely · RemoteOK · Working Nomads · Jobspresso ·
  Lever · Greenhouse · Ashby · Workable · Workday · SmartRecruiters ·
  BambooHR · JazzHR · Recruitee · Teamtailor · Comeet · Breezy · Talentlyft ·
  YC Work at a Startup.

These are all SURFACES. If the URL is on one of them, dig until you find
the underlying employer:
  • Read the page <title> — usually "{Role} at {Company} – {Board}".
  • Read the URL slug — "linkedin.com/jobs/view/.../{company-slug}-..." or
    "wellfound.com/company/{company-slug}/jobs/...".
  • Search verbatim a unique JD phrase + "careers" or "about us".
  • Search: site:linkedin.com/company/ "{role title}" "{location}".

If after 3+ searches the employer is genuinely undeterminable (e.g.
anonymized "Stealth Startup", recruiter-only listing with no signal),
set company = "Unidentified — listed on {board}" and score the Real
pillar at most 35 (verdict "fail") with evidence documenting what you
tried. Do NOT default to the board's name.

===== HOW TO INVESTIGATE =====

Step 1: identify the company and role from the URL (per the rule above).
  • Company-owned ATSes (greenhouse.io/{company}, jobs.lever.co/{company},
    {company}.ashbyhq.com, jobs.{company}.com) put the company in the URL.
  • Aggregator URLs (LinkedIn / Indeed / Glassdoor / Wellfound / etc.) hide
    it — extract it from the slug or title and verify before proceeding.

Step 2: run these searches verbatim (substitute the company / role).
DO NOT skip — each one feeds a different pillar. If a "PRIOR COMPANY
KNOWLEDGE" block was supplied above, SKIP the queries it already
answers (most of Real-1..4 and Credible-13..16 are usually covered) and
redirect that budget to Active and Fair, which are posting-specific.

  REAL pillar:
    1. WHOIS "{company-domain}"                              (reg date, registrant)
    2. site:sec.gov/edgar "{company}"                        (corp filings)
    3. site:linkedin.com/company/ "{company}"                (LI page, headcount)
    4. "{company}" "founded" OR "headquarters"               (HQ, founding year)

  ACTIVE pillar:
    5. site:web.archive.org "{posting-url}"                  (first-seen, snapshots)
    6. "{role}" "{company}" -site:{posting-domain}           (repost spread)
    7. site:reddit.com "{company}" interview OR recruiter OR ghost
    8. site:glassdoor.com "{company}" interviews             (response times)

  FAIR pillar:
    9. site:levels.fyi "{company}" OR "{role}"               (p25/p50/p75)
    10. site:glassdoor.com "{company}" salary
    11. "{company}" "process fee" OR "training fee" OR "equipment fee"
    12. "{company}" "scam" OR "fraud" OR "ghost job"

  CREDIBLE pillar:
    13. site:crunchbase.com "{company}"                      (rounds, investors)
    14. site:github.com "{company}" OR "{company-slug}"      (org commits)
    15. "{company}" "press release" OR "raised" OR "Series"
    16. "{company-domain}" reviews OR testimonials OR changelog

For every meaningful hit, capture the URL — that becomes the "src" for
your evidence item. NEVER cite "Internal research", "lighthouse/...",
"posting", "company website", "training data", or "knowledge" as a
source — those are not real URLs. If a signal can't be verified, say so
explicitly with weight "weak" and src "lighthouse/no-source".

===== EVIDENCE STYLE GUIDE — MANDATORY =====

Every evidence item is "weak" by default. You earn higher weights with
SPECIFICITY. Generic statements like "the company seems legitimate",
"recruiter looks real", or "product appears active" are FORBIDDEN —
push through another search until you have a concrete fact, or
downgrade to weak with a "could not corroborate" line.

  STRONG — primary-source URL AND at least one of:
    • a specific date (YYYY-MM-DD or "Mar 11, 2022"),
    • a specific dollar amount or comp percentile,
    • a discrete count,
    • a named human / investor / product / commit.

  Reference examples (model your wording on these):
    ✓ "Domain orbit.work registered 2022-03-11, NS records stable for
       38 months." — src: whois.iana.org
    ✓ "Delaware C-corp filing on record. EIN matches Stripe Atlas
       issuance." — src: sec.gov/edgar
    ✓ "Recruiter Maya Chen — LinkedIn tenure 19 months, two prior
       verified roles at Vercel." — src: linkedin.com/in/maya-chen
    ✓ "Cash band $165k–$215k sits at p62–p84 of Levels.fyi senior
       frontend, US-remote." — src: levels.fyi
    ✓ "$4.2M seed led by South Park Commons, Apr 2024." — src: crunchbase.com
    ✓ "47 GitHub repositories under orbit-labs, 11 with commits in the
       last 14 days." — src: github.com/orbit-labs

  MEDIUM — inferential, OR primary-source URL without specific numbers,
  OR specific numbers without a primary URL.
    ✓ "Two engineers joined the team within the last quarter, per
       LinkedIn employment dates." — src: linkedin.com/company/orbit
    ✓ "Scope statement names a single product surface — not a
       multi-disciplinary catch-all." — src: <posting URL>

  WEAK — soft signal, hearsay, header inference, or "could not
  corroborate".
    ✓ "Careers page Last-Modified header within 12 hours of crawl." —
       src: http/headers
    ✓ "Could not corroborate Series-A funding via Crunchbase." —
       src: lighthouse/no-source

Every "text" MUST be one self-contained sentence with at least one
concrete element. If you can't include a date, number, or name, the
weight is at most "weak".

===== USE PRIOR KNOWLEDGE TO SAVE SEARCHES =====

If a "PRIOR COMPANY KNOWLEDGE" block appears above, those facts were
verified in earlier Lighthouse runs and stored in the Supabase company
aggregate. Treat them as ground truth — DO NOT re-WHOIS, re-EDGAR, or
re-Crunchbase a company the dossier already documents. Cite the prior
fact (reuse the prior source URL when available) and redirect your
search budget to what is NEW:
  • Active signals (this posting's first-seen, repost cadence, recruiter
    activity in the last 90 days)
  • Fair signals (this role's current comp band vs. market p25–p75)
  • Anything that may have shifted since the last inspection.

If prior data shows a HIGH mean score (≥ 85) and a recent inspection
(within ~30 days), do a LIGHT verification: emit 2–3 short
re-confirmation items per pillar citing the prior dossier ("Prior
dossier 2026-05-04: domain age 22mo, founders ex-Linear — re-confirmed.")
and lean your effort on Active + Fair for the specific posting. This
is by design: trusted companies stay trusted, and Lighthouse spends
its grounded-search quota on the new posting, not on facts it already
knows.

If prior data conflicts with what you find live, flag it explicitly
("Prior mean: 88; this run finds three new repost boards in the last
6 weeks — Active downgraded to 64.") and trust the live data.

===== THE FOUR PILLARS =====

1. REAL — does the company exist, and is the posting authored on a
   surface the company actually controls?
   • Domain age (whois.com, who.is); under 60 days = red flag.
   • Corporate registration: SEC EDGAR (US), Companies House (UK),
     OpenCorporates, state SOS filings.
   • Recruiter identity: named recruiter with ≥ 6mo LinkedIn tenure = strong;
     unnamed "hiring team" with no profile = weak.
   • Copy novelty: search a unique phrase from the JD verbatim. If the
     same text appears on 5+ unrelated boards, treat as boilerplate.
   • Application path: own ATS subdomain vs. random Google Form / Gmail.

2. ACTIVE — is this role actually open and being filled RIGHT NOW?
   • archive.org Wayback first-seen + version count.
   • Repost frequency: a role reposted weekly for 6 months is warehousing.
   • Community signal: Blind, Reddit, Glassdoor interview reports. Look for
     recruiter-response times within the last 90 days.
   • Last-Modified header / "posted N days ago" stamp.
   • Capacity coherence: a 5-person seed startup hiring 30 engineers is a flag.

3. FAIR — is the deal COHERENT for the level described? This pillar is
   about scope-to-comp coherence, NOT absolute compensation. A small honest
   stipend for a small honest scope is fair. Senior-IC scope at junior pay
   is not.
   • If the posting itself doesn't show a salary band (very common on
     LinkedIn), look up Levels.fyi and Glassdoor for that role at that
     company. Estimate the market p25/p50/p75 and use that as compMin /
     compMax. NEVER leave compMin / compMax as 0 if you have a market
     estimate — say "market estimate p25–p75: $X–$Y" in the evidence.
   • Equity: 0.05–0.5% normal for senior IC at seed/Series-A; 5%+ to
     non-founders is suspicious.
   • Process fees: ANY request for candidate payment is an INSTANT FAIL
     for the Fair pillar. ID/SSN before interview = major penalty.

4. CREDIBLE — does this company actually do something real? They do NOT
   need to be famous. A two-person bootstrapped studio with a real product
   and recent commits is credible. A 50-person "AI" company with no
   product, no GitHub, no press is not. BIAS FOR honest small operators.
   • Live product surface: signup, billing, status page, changelog.
   • Founder graph: pre-company LinkedIn predates the company by ≥ 2 years.
   • Funding: Crunchbase / press for raised companies; for bootstrapped,
     look for revenue signals (Stripe Atlas, paying customer logos).
   • Code / activity: GitHub org commits in the last 30–90 days for tech
     roles; for non-tech, look for press, podcasts, blog cadence.

===== EVIDENCE QUALITY BAR =====

For EACH pillar, output AT LEAST 3 evidence items conforming to the
"Evidence Style Guide" above. Each item must be one self-contained
sentence with at least one concrete element (date / number / named
entity / dollar amount) and a real source URL.

If your investigation comes up empty on a pillar, output that explicitly
— "could not corroborate via Google" with weight "weak" and src
"lighthouse/no-source" — and lower the pillar's score. Better an honest
45 than a fabricated 85.

===== POSTING EXTRACTION =====

Also extract from the posting (best effort, search for it if the URL
content is gated):
- Company name, role / job title
- Location and remote status (fully remote, hybrid, regional)
- Compensation band (min/max in USD; mark monthly if monthly). USE
  MARKET ESTIMATES if the posting itself doesn't disclose.
- Equity offering ("0.05 – 0.15%", "undisclosed", or "—" if N/A)
- When posted (relative or absolute date if shown)
- 1-sentence scope summary

===== COMPARABLES =====

End by suggesting THREE comparable verified roles from DIFFERENT
companies (not the target). Same level, same function, comparable comp
band. Pull from your knowledge of well-known companies in the same
vertical. Format: company / role / comp band / your confidence (0-100).

End with: VERDICT (VERIFIED 80+, INVESTIGATE 50–79, DECLINE < 50), a
short editorial HEADLINE (≤ 9 words), and a 2–3 sentence EDITORIAL in
newspaper voice — measured, specific, no marketing fluff, no second
person. Headlines should feel like a copy desk wrote them, e.g.
"A clean signal, end to end.", "Real company. Stale posting. Vague
offer.", "Eleven independent red flags. Do not apply." Cite REAL
DOMAINS for every claim that supports a strong-weight evidence item.`;

// Appended to STAGE1_PROMPT only when Google Search grounding is
// unavailable. Tells the model to be honest about its lack of live data
// instead of inventing fake citations.
const UNGROUNDED_NOTE = `\n\nIMPORTANT: Google Search grounding is currently UNAVAILABLE on this run. You CANNOT access live web data. Work only from what you already know about the company and posting. Where evidence would normally come from a live source (WHOIS, archive.org, LinkedIn, Levels.fyi, etc.), you must explicitly note that the signal was NOT independently verified on this run and cite the source as "lighthouse/no-grounding". Lower the per-pillar scores accordingly (cap each pillar at 70 unless your training knowledge gives strong confidence about that specific signal). Be conservative — this is a degraded run, not a full verification.`;

const STAGE2_PROMPT = (evidence: string, sourceUrl: string) => `You are Lighthouse, a precise data formatter. Below is an evidence dossier compiled by a research agent for a remote job posting at ${sourceUrl}.

Convert it into the strict JSON schema below. Be faithful to the evidence — do NOT invent facts. If the evidence doesn't support a strong score, lower the score. Use weight "strong" only when the evidence is concrete (specific dates, named people, dollar amounts, discrete counts, primary URLs); "medium" for inferential signals; "weak" for soft/hearsay signals.

Critical scoring rules:
- A pillar with NO strong evidence cannot score above 70.
- A pillar with FEWER THAN 3 evidence items cannot score above 75.
- A pillar with at least one "fail" pattern (e.g. process fees, fake registration, all-stale snapshots) cannot score above 35.
- A company being small / unknown / bootstrapped is NOT a fail signal for Credible. Score Credible on whether they DO anything real, not on whether they're famous.
- Score Fair on scope-to-comp coherence, not absolute compensation. A small honest stipend for a small honest scope is fair.
- The overall score is the weighted mean of the four pillars (equal weight). Round to integer.

Hiring-company rules (HARD):
- The "company" field is the EMPLOYER, never the job board. The following
  are FORBIDDEN as company values: LinkedIn, Indeed, Glassdoor, Wellfound,
  AngelList, Otta, Welcome to the Jungle, ZipRecruiter, Monster, Dice,
  BuiltIn, Hired, Remote.co, WeWorkRemotely, RemoteOK, Working Nomads,
  Jobspresso, Lever, Greenhouse, Ashby, Workable, Workday, SmartRecruiters,
  BambooHR, JazzHR, Recruitee, Teamtailor, Comeet, Breezy, Talentlyft,
  "YC Work at a Startup".
- If the dossier left "company" as one of those names (or as a board's
  domain), it means the underlying employer was never identified. Replace
  it with "Unidentified — listed on {board}" and cap the Real pillar
  score at 35 (verdict "fail").

Evidence source + style rules (HARD):
- Every evidence item's "src" must be a real URL or a real domain
  (e.g. "linkedin.com/in/maya-chen", "sec.gov/cgi-bin/browse-edgar?action=...").
- NEVER use placeholder sources: "Internal research", "company website",
  "posting", "lighthouse/anything", "research", "training data" are all FORBIDDEN.
  If the evidence dossier used a placeholder, downgrade that evidence
  to weight "weak" and rewrite the src to "lighthouse/no-source" so it
  is obvious to the reader.
- Every "text" must be ONE self-contained sentence with at least one
  concrete element (YYYY-MM-DD date / dollar amount / discrete count /
  named human / named investor / named product). Generic phrases like
  "seems legitimate", "looks active", "appears credible" are FORBIDDEN —
  if the dossier produced one, either rewrite it tighter or drop it.
- Model tone on data.ts examples (terse newspaper voice, specifics-first):
  ✓ "Domain orbit.work registered 2022-03-11, NS records stable for 38 months."
  ✓ "Recruiter Maya Chen — LinkedIn tenure 19 months, two prior verified roles at Vercel."
  ✓ "Cash band $165k–$215k sits at p62–p84 of Levels.fyi senior frontend, US-remote."
  ✓ "47 GitHub repositories under orbit-labs, 11 with commits in the last 14 days."
- Editorial voice: 2–3 sentences, measured, no second person, no
  exclamation. Headlines ≤ 9 words, copy-desk style.
- Comparables (the 3 similar roles) must be DIFFERENT companies, never
  the target company AND never a job board. If the dossier suggested
  the target as a comparable, drop it and substitute a plausible peer.

The schema (return EXACTLY this shape, valid JSON, no markdown fence, no preamble):

{
  "company": string,
  "role": string,
  "location": string,
  "isRemote": boolean,          // true if the job is fully remote or remote-first; false if hybrid, onsite, or regional.
  "compMin": number,            // USD. If monthly, keep monthly value. If unknown, 0.
  "compMax": number,            // USD. 0 if unknown.
  "equity": string,             // "0.05 – 0.15%" or "undisclosed" or "—"
  "posted": string,             // "4 days ago" or "today" or "11 weeks ago"
  "summary": string,            // 1 sentence describing the role
  "score": number,              // 0-100 overall verification score
  "verdict": "VERIFIED" | "INVESTIGATE" | "DECLINE",
  "headline": string,           // editorial headline, max 9 words
  "editorial": string,          // 2-3 sentence editorial verdict in newspaper voice
  "pillars": [
    {
      "name": "Real",
      "score": number,
      "verdict": "pass" | "mixed" | "fail",
      "summary": string,
      "evidence": [
        { "weight": "strong"|"medium"|"weak", "text": string, "src": string }
      ]
    },
    { "name": "Active", ... same shape },
    { "name": "Fair", ... same shape },
    { "name": "Credible", ... same shape }
  ],
  "activity": {
    "reposts": number[],         // 12 weekly values, 0 or 1, last 12 weeks
    "label": string,             // one-line description
    "responseDays": number | null,
    "ghostScore": number         // 0.0 to 1.0
  },
  "comparables": [
    { "co": string, "role": string, "comp": string, "score": number }
  ]
}

Evidence dossier:
${evidence}`;

export interface VerifyResult {
  posting: Posting;
  citations: { uri: string; title?: string }[];
  evidenceRaw: string;
  /** True if Google Search grounding produced the evidence; false if we
   * fell back to an ungrounded call (lower-confidence verification). */
  grounded: boolean;
}

export async function verifyPosting(url: string): Promise<VerifyResult> {
  const apiKey = process.env.GEMINI_API_KEY;
  if (!apiKey) {
    throw new Error(
      "GEMINI_API_KEY is not set. Add it to .env.local (get one at https://aistudio.google.com/apikey) and restart the dev server.",
    );
  }

  const ai = new GoogleGenAI({ apiKey });

  // Look up prior company knowledge from the Supabase aggregate. If we've
  // seen this company before, give Gemini that context as a head start.
  // Best-effort: a DB miss or error is harmless, we just skip the context.
  let priorContext = "";
  try {
    const prior = await lookupCompanyForUrl(url);
    if (prior) priorContext = renderCompanyContext(prior);
  } catch {
    /* skip */
  }

  // ── Stage 1: grounded research, with ungrounded fallback ──────────────
  // Google's grounded-search service occasionally goes into 503 "high
  // demand" mode independently of the model. When that happens we run the
  // same prompt without `googleSearch` so the user still gets a report —
  // marked `grounded: false` so the UI can flag it for re-verification.
  let grounded = true;
  let stage1;
  try {
    stage1 = await withRetry(GROUNDED_MODELS, (model) =>
      ai.models.generateContent({
        model,
        contents: [
          {
            role: "user",
            parts: [
              { text: STAGE1_PROMPT },
              ...(priorContext ? [{ text: priorContext }] : []),
              { text: `\nPosting to verify: ${url}` },
            ],
          },
        ],
        config: {
          tools: [{ googleSearch: {} }],
          temperature: 0.2,
        },
      }),
    );
  } catch (e: unknown) {
    const status = extractStatus(e);
    if (status && RETRYABLE_STATUS.has(status)) {
      // Grounded path is exhausted on every model in the chain — fall back
      // to an ungrounded run so the user still gets a (lower-confidence)
      // report. The ungrounded chain has higher-RPM models so this almost
      // always succeeds.
      grounded = false;
      stage1 = await withRetry(UNGROUNDED_MODELS, (model) =>
        ai.models.generateContent({
          model,
          contents: [
            {
              role: "user",
              parts: [
                { text: STAGE1_PROMPT },
                { text: UNGROUNDED_NOTE },
                ...(priorContext ? [{ text: priorContext }] : []),
                { text: `\nPosting to verify: ${url}` },
              ],
            },
          ],
          config: { temperature: 0.3 },
        }),
      );
    } else {
      throw e;
    }
  }

  const evidence = stage1.text || "";
  if (!evidence.trim()) {
    throw new Error("Gemini returned no evidence — the URL may be unreachable.");
  }

  const chunks =
    stage1.candidates?.[0]?.groundingMetadata?.groundingChunks || [];
  const citations = chunks
    .map((c) => ({ uri: c.web?.uri || "", title: c.web?.title }))
    .filter((c) => c.uri);

  // ── Stage 2: structured formatter ─────────────────────────────────────
  // No grounding needed here, so rotate across the high-RPM models.
  const stage2 = await withRetry(UNGROUNDED_MODELS, (model) =>
    ai.models.generateContent({
      model,
      contents: [
        { role: "user", parts: [{ text: STAGE2_PROMPT(evidence, url) }] },
      ],
      config: {
        temperature: 0.1,
        responseMimeType: "application/json",
      },
    }),
  );

  const raw = stage2.text || "";
  let parsed: Omit<Posting, "id" | "url">;
  try {
    parsed = JSON.parse(raw);
  } catch {
    const cleaned = raw
      .replace(/^```(?:json)?\s*/i, "")
      .replace(/```\s*$/, "")
      .trim();
    try {
      parsed = JSON.parse(cleaned);
    } catch (e) {
      throw new Error(
        `Gemini returned malformed JSON: ${e instanceof Error ? e.message : String(e)}`,
      );
    }
  }

  const posting: Posting = {
    id: `live-${Date.now().toString(36)}`,
    url,
    company: parsed.company || "Unknown",
    role: parsed.role || "Unknown role",
    location: parsed.location || "Remote",
    isRemote: parsed.isRemote !== undefined ? Boolean(parsed.isRemote) : true,
    compMin: Number(parsed.compMin) || 0,
    compMax: Number(parsed.compMax) || 0,
    equity: parsed.equity || "—",
    posted: parsed.posted || "unknown",
    summary: parsed.summary || "",
    score: clamp(Number(parsed.score) || 0, 0, 100),
    verdict: normalizeVerdict(parsed.verdict),
    headline: parsed.headline || "Verification complete.",
    editorial: parsed.editorial || "",
    pillars: [],
    activity: {
      reposts: normalizeReposts(parsed.activity?.reposts),
      label: parsed.activity?.label || "—",
      responseDays:
        parsed.activity?.responseDays != null
          ? Number(parsed.activity.responseDays)
          : null,
      ghostScore: clamp(Number(parsed.activity?.ghostScore) || 0, 0, 1),
    },
    comparables: normalizeComparables(parsed.comparables, parsed.company || ""),
  };

  // Build pillars after the rest so we can recompute the overall score
  // from the (possibly capped) pillar scores. The mean of the four pillars
  // is the source of truth — Stage 2's `score` is a hint we override.
  posting.pillars = normalizePillars(parsed.pillars);

  // Safety net: if Gemini still named a job board as the employer (despite
  // the prompt forbidding it), the underlying company is unknown — rewrite
  // the field and cap the Real pillar so the overall score reflects that.
  if (isJobBoardName(posting.company)) {
    const board = posting.company.trim();
    posting.company = `Unidentified — listed on ${board}`;
    const real = posting.pillars.find((p) => p.name === "Real");
    if (real) {
      real.score = Math.min(real.score, 35);
      real.verdict = "fail";
      real.summary =
        `Hiring company could not be identified — listing appears on ${board}, but no underlying employer was confirmed in the dossier.`;
    }
  }

  const pillarMean = Math.round(
    posting.pillars.reduce((s, p) => s + p.score, 0) / posting.pillars.length,
  );
  posting.score = pillarMean;
  // Verdict follows the recomputed score.
  posting.verdict =
    pillarMean >= 80 ? "VERIFIED" : pillarMean >= 50 ? "INVESTIGATE" : "DECLINE";

  // If the posting itself didn't disclose a salary band AND Gemini didn't
  // backport a market estimate, fall back to the median band of the
  // comparables. Better than 0 / 0 in the UI.
  if (posting.compMin === 0 && posting.compMax === 0) {
    const bands = posting.comparables
      .map((c) => extractCompBand(c.comp))
      .filter((b): b is [number, number] => !!b);
    if (bands.length > 0) {
      const mid = Math.floor(bands.length / 2);
      const sorted = [...bands].sort((a, b) => a[0] - b[0]);
      const [lo, hi] = sorted[mid];
      posting.compMin = lo;
      posting.compMax = hi;
    }
  }

  // When grounded search was unavailable, tag the report so the UI can
  // surface a "re-verify when grounding recovers" hint and so the score
  // is correctly understood as advisory.
  if (!grounded) {
    posting.headline =
      posting.headline.startsWith("[Ungrounded]")
        ? posting.headline
        : `[Ungrounded] ${posting.headline}`;
    posting.editorial =
      `Note: this verification ran without live web grounding (Gemini grounded-search was unavailable). Signals were drawn from model knowledge only and should be treated as preliminary. Re-run to refresh once grounding capacity returns. ${posting.editorial}`.trim();
  }

  return { posting, citations, evidenceRaw: evidence, grounded };
}

// ────────────────────────────────────────────────────────────────────────
// Retry wrapper. Walks `models` in order — each model tried once, no
// backoff between models (a different model has independent capacity so
// retrying immediately is correct). After the last model, optionally do
// one more pass on the first model with a short backoff to ride out a
// flash-in-the-pan 503 on the primary.
// Non-retryable errors (4xx auth/bad request) surface on the first attempt.
// ────────────────────────────────────────────────────────────────────────
async function withRetry<T>(
  models: readonly Model[],
  call: (model: Model) => Promise<T>,
): Promise<T> {
  if (models.length === 0) throw new Error("withRetry: no models provided");

  const plan: { model: Model; waitBeforeMs: number }[] = [
    ...models.map((m) => ({ model: m, waitBeforeMs: 0 })),
    // Final retry on the first model after a short backoff.
    { model: models[0], waitBeforeMs: 2000 },
  ];

  let lastError: unknown;
  for (const step of plan) {
    if (step.waitBeforeMs) await sleep(step.waitBeforeMs);
    try {
      return await call(step.model);
    } catch (e: unknown) {
      lastError = e;
      const status = extractStatus(e);
      if (!status || !RETRYABLE_STATUS.has(status)) {
        // Permanent error (4xx auth / bad request) — no point retrying.
        throw e;
      }
      // Retryable — fall through to the next model in the plan.
    }
  }
  throw lastError;
}

function extractStatus(e: unknown): number | null {
  if (!e || typeof e !== "object") return null;
  // The @google/genai SDK packs the HTTP status into err.status as a string
  // (e.g. "503 Service Unavailable") or sometimes nests it under err.error.code.
  const obj = e as { status?: unknown; error?: { code?: unknown }; message?: unknown };
  const fromStatus = typeof obj.status === "string" ? parseInt(obj.status, 10) : null;
  if (fromStatus && !Number.isNaN(fromStatus)) return fromStatus;
  const fromCode = obj.error?.code;
  if (typeof fromCode === "number") return fromCode;
  // Last resort: pluck a 3-digit code out of the message.
  const msg = typeof obj.message === "string" ? obj.message : "";
  const m = /\b(4\d{2}|5\d{2})\b/.exec(msg);
  return m ? Number(m[1]) : null;
}

function sleep(ms: number): Promise<void> {
  return new Promise((r) => setTimeout(r, ms));
}

function clamp(n: number, lo: number, hi: number) {
  return Math.max(lo, Math.min(hi, n));
}

/**
 * Parse a comp string like "$175,000 – $280,000" or "$120k-$150k" into
 * [min, max] USD. Returns null if no numeric range could be extracted.
 */
function extractCompBand(s: string): [number, number] | null {
  if (!s) return null;
  const nums: number[] = [];
  const re = /\$?\s*([\d,]+(?:\.\d+)?)\s*([kKmM])?/g;
  let m: RegExpExecArray | null;
  while ((m = re.exec(s)) && nums.length < 2) {
    let n = Number(m[1].replace(/,/g, ""));
    if (!Number.isFinite(n)) continue;
    const unit = (m[2] || "").toLowerCase();
    if (unit === "k") n *= 1_000;
    else if (unit === "m") n *= 1_000_000;
    // Anything plausibly an annual band — drop noise like "3 weeks ago".
    if (n >= 1000) nums.push(n);
  }
  if (nums.length === 0) return null;
  if (nums.length === 1) return [nums[0], nums[0]];
  return [Math.min(nums[0], nums[1]), Math.max(nums[0], nums[1])];
}

function normalizeVerdict(v: unknown): Posting["verdict"] {
  const s = String(v || "").toUpperCase();
  if (s === "VERIFIED" || s === "INVESTIGATE" || s === "DECLINE") return s;
  return "INVESTIGATE";
}

type RawPillar = {
  name?: string;
  score?: number;
  verdict?: string;
  summary?: string;
  evidence?: { weight?: string; text?: string; src?: string }[];
};

// Placeholder source patterns the model sometimes invents instead of citing
// a real URL. These get downgraded to "weak" so the pillar score reflects
// the actual evidence quality.
const FAKE_SOURCE_RE =
  /^(internal research|research|company website|posting|training data|knowledge|n\/?a|none|unknown|lighthouse(?!\/no-grounding|\/no-source))/i;

function looksLikeUrl(src: string): boolean {
  // Anything with a dot and at least one alpha character — covers
  // "linkedin.com/...", "sec.gov/edgar/..." but rejects "Internal".
  return /[a-z]\.[a-z]/i.test(src);
}

function normalizePillars(pillars: unknown): Posting["pillars"] {
  const names = ["Real", "Active", "Fair", "Credible"] as const;
  const arr = Array.isArray(pillars) ? (pillars as RawPillar[]) : [];
  return names.map((n) => {
    const p = arr.find((x) => x?.name === n) || {};
    const verdict =
      p.verdict === "pass" || p.verdict === "fail" || p.verdict === "mixed"
        ? p.verdict
        : "mixed";
    const evidence = Array.isArray(p.evidence) ? p.evidence : [];
    const cleaned = evidence.slice(0, 5).map((e) => {
      const src = (e?.src || "").trim();
      const claimedWeight: EvidenceWeight =
        e?.weight === "strong" || e?.weight === "medium" || e?.weight === "weak"
          ? e.weight
          : "medium";

      const placeholder = FAKE_SOURCE_RE.test(src) || !looksLikeUrl(src);
      // Strong evidence with a non-URL src is suspect — downgrade to weak
      // and rewrite the src so it's clearly flagged in the UI.
      const weight: EvidenceWeight =
        placeholder && claimedWeight === "strong" ? "weak" : claimedWeight;
      return {
        weight,
        text: e?.text || "",
        src: placeholder ? "lighthouse/no-source" : src,
      };
    });

    // Apply the "no strong evidence → cap 70" and "< 3 items → cap 75"
    // rules here as a safety net even if Stage 2 ignored them in prompt.
    let score = clamp(Number(p.score) || 0, 0, 100);
    const hasStrong = cleaned.some((e) => e.weight === "strong");
    if (!hasStrong) score = Math.min(score, 70);
    if (cleaned.length < 3) score = Math.min(score, 75);

    return {
      name: n,
      score,
      verdict,
      summary: p.summary || "",
      evidence: cleaned,
    };
  });
}

function normalizeReposts(r: unknown): number[] {
  if (!Array.isArray(r)) return [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];
  const arr = r.slice(0, 12).map((x) => (Number(x) > 0 ? 1 : 0));
  while (arr.length < 12) arr.unshift(0);
  return arr;
}

function normalizeComparables(
  c: unknown,
  targetCompany: string,
): Posting["comparables"] {
  if (!Array.isArray(c)) return [];
  const target = targetCompany.trim().toLowerCase();
  return c
    .map((x) => {
      const obj = (x ?? {}) as {
        co?: string;
        role?: string;
        comp?: string;
        score?: number;
      };
      return {
        co: (obj.co || "—").trim(),
        role: (obj.role || "—").trim(),
        comp: (obj.comp || "—").trim(),
        score: clamp(Number(obj.score) || 0, 0, 100),
      };
    })
    // Drop self-references — comparables must be different companies.
    .filter((c) => c.co.toLowerCase() !== target && c.co !== "—")
    // De-dup by company name.
    .filter(
      (c, i, all) =>
        all.findIndex((d) => d.co.toLowerCase() === c.co.toLowerCase()) === i,
    )
    .slice(0, 3);
}
