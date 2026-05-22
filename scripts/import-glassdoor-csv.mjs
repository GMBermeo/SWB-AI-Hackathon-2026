#!/usr/bin/env node
// One-off: import a HasData Glassdoor CSV into Supabase.
//   • One row per job → `postings` (source_slug='glassdoor', status='new').
//   • One row per unique employer → `companies` (with rating, industry, …).
// Idempotent: re-running collapses to upserts on url_normalized / company slug.
//
// Usage:
//   node scripts/import-glassdoor-csv.mjs /path/to/glassdoor.csv
//
// Requires NEXT_PUBLIC_SUPABASE_URL + NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY in
// .env (the RLS policies on postings / companies permit anon inserts for
// MVP). For production you'd use SUPABASE_SERVICE_ROLE_KEY instead.

import { readFile } from "node:fs/promises";
import { resolve } from "node:path";
import { setDefaultResultOrder } from "node:dns";
import { parse } from "csv-parse/sync";
import { createClient } from "@supabase/supabase-js";

setDefaultResultOrder("ipv4first");

const FX_TO_USD = { USD: 1, CAD: 0.74, GBP: 1.27, EUR: 1.08, AUD: 0.66 };

async function loadEnv() {
  const raw = await readFile(resolve(".env"), "utf8");
  for (const line of raw.split("\n")) {
    const m = line.match(/^([A-Z0-9_]+)\s*=\s*"?([^"\r]*)"?\s*$/);
    if (m && !process.env[m[1]]) process.env[m[1]] = m[2];
  }
}

function supabaseFromEnv() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key =
    process.env.SUPABASE_SERVICE_ROLE_KEY ||
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;
  if (!url || !key) {
    throw new Error("Set NEXT_PUBLIC_SUPABASE_URL + a key in .env");
  }
  return createClient(url, key, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}

function companySlug(raw) {
  return String(raw || "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/-+/g, "-")
    .replace(/^-|-$/g, "");
}

function normalizeUrl(input) {
  let raw = String(input || "").trim();
  if (!raw) return "";
  if (!/^https?:\/\//i.test(raw)) raw = "https://" + raw;
  let u;
  try {
    u = new URL(raw);
  } catch {
    return raw.toLowerCase();
  }
  u.hostname = u.hostname.toLowerCase().replace(/^www\./, "");
  u.protocol = "https:";
  u.hash = "";
  const drop = new Set([
    "utm_source","utm_medium","utm_campaign","utm_term","utm_content",
    "ref","ref_src","ref_url","source","src","trk","trkInfo",
    "gh_src","gh_jid","lever-source","fbclid","gclid","mc_cid","mc_eid",
  ]);
  const keep = [];
  u.searchParams.forEach((v, k) => {
    if (!drop.has(k.toLowerCase())) keep.push([k, v]);
  });
  keep.sort(([a], [b]) => a.localeCompare(b));
  u.search = "";
  for (const [k, v] of keep) u.searchParams.append(k, v);
  let out = u.toString();
  if (out.endsWith("/") && !u.search) out = out.slice(0, -1);
  return out;
}

function asNumber(x) {
  if (typeof x === "number" && Number.isFinite(x)) return x;
  if (typeof x !== "string" || !x) return undefined;
  const n = Number(x.replace(/[, ]/g, ""));
  return Number.isFinite(n) ? n : undefined;
}

function toUsd(amount, currency) {
  if (!amount) return 0;
  const r = FX_TO_USD[String(currency || "USD").toUpperCase()] ?? 1;
  return Math.round(amount * r);
}

function extractDomain(url) {
  if (!url) return null;
  try {
    const u = new URL(String(url).startsWith("http") ? url : "https://" + url);
    return u.hostname.toLowerCase().replace(/^www\./, "");
  } catch {
    return null;
  }
}

function rowToPosting(r) {
  const min = asNumber(r.salaryMin);
  const max = asNumber(r.salaryMax);
  const currency = (r.salaryCurrency || r.payCurrency || "USD").toUpperCase();
  return {
    source_slug: "glassdoor",
    source_external_id: String(r.id || r.url || "").slice(0, 80),
    url: r.url || "",
    url_normalized: normalizeUrl(r.url || ""),
    title: r.title || "Untitled role",
    company: r.employer || null,
    location:
      [r.city, r.region, r.country].filter(Boolean).join(", ") || "Remote",
    description: (r.description || r.overview || "").slice(0, 1200),
    posted_at: r.datePosted || null,
    raw_payload: r,
    salary_min: min !== undefined ? toUsd(min, currency) : null,
    salary_max: max !== undefined ? toUsd(max, currency) : null,
    salary_currency: currency,
    salary_period: r.salaryPeriod || null,
    experience_text:
      r.experience || (r.monthsOfExperience ? `${r.monthsOfExperience} months` : null),
  };
}

function rowToCompany(r) {
  if (!r.employer) return null;
  const slug = companySlug(r.employer);
  if (!slug) return null;
  const rating = asNumber(r.rating);
  return {
    slug,
    display_name: r.employer,
    primary_domain: extractDomain(r.employerUrl),
    glassdoor_url: r.employerUrl || null,
    glassdoor_rating: rating !== undefined ? rating : null,
    industry: r.industry || null,
    hq_city: r.city || null,
    hq_region: r.region || null,
    hq_country: r.country || null,
    glassdoor_refreshed_at: new Date().toISOString(),
  };
}

async function main() {
  const file = process.argv[2];
  if (!file) {
    console.error("usage: node scripts/import-glassdoor-csv.mjs <path-to-csv>");
    process.exit(1);
  }

  await loadEnv();
  const sb = supabaseFromEnv();
  console.log(`reading ${file} …`);
  const text = await readFile(resolve(file), "utf8");
  // HasData CSVs are semicolon-delimited with quoted fields.
  const rows = parse(text, {
    columns: true,
    delimiter: ";",
    relax_quotes: true,
    relax_column_count: true,
    skip_empty_lines: true,
    trim: true,
  });
  console.log(`parsed ${rows.length} rows`);

  // ── Postings ──────────────────────────────────────────────────────────
  const postings = rows
    .map(rowToPosting)
    .filter((p) => p.url_normalized && p.url_normalized.includes("/"));
  // De-dup within the file itself — Glassdoor often repeats listings.
  const byUrl = new Map();
  for (const p of postings) byUrl.set(p.url_normalized, p);
  const dedupPostings = Array.from(byUrl.values());
  console.log(`writing ${dedupPostings.length} postings (deduped)…`);

  // Upsert in batches of 500 to stay polite with PostgREST.
  let inserted = 0;
  for (let i = 0; i < dedupPostings.length; i += 500) {
    const batch = dedupPostings.slice(i, i + 500);
    const { error, count } = await sb
      .from("postings")
      .upsert(batch, {
        onConflict: "url_normalized",
        ignoreDuplicates: true,
        count: "exact",
      });
    if (error) {
      console.error(`  batch ${i}: ${error.message}`);
      continue;
    }
    inserted += count ?? batch.length;
    process.stdout.write(`  postings ${i + batch.length}/${dedupPostings.length}\r`);
  }
  console.log(`  postings: ${inserted} written`);

  // ── Companies ─────────────────────────────────────────────────────────
  const companyMap = new Map();
  for (const r of rows) {
    const c = rowToCompany(r);
    if (c) companyMap.set(c.slug, c); // last writer wins
  }
  const companies = Array.from(companyMap.values());
  console.log(`writing ${companies.length} companies…`);
  for (let i = 0; i < companies.length; i += 200) {
    const batch = companies.slice(i, i + 200);
    const { error } = await sb
      .from("companies")
      .upsert(batch, { onConflict: "slug" });
    if (error) {
      console.error(`  batch ${i}: ${error.message}`);
    }
  }

  // Quick sanity peek.
  const { data: top } = await sb
    .from("companies")
    .select("display_name, glassdoor_rating, industry, hq_city")
    .order("glassdoor_rating", { ascending: false, nullsFirst: false })
    .limit(5);
  console.log("\ntop-rated companies in the import:");
  for (const c of top || []) {
    console.log(
      `  ${(c.display_name || "").padEnd(40)} ${
        c.glassdoor_rating ?? "—"
      }  ${(c.industry || "").padEnd(25)} ${c.hq_city || ""}`,
    );
  }
}

main().catch((e) => {
  console.error("import failed:", e.message);
  process.exit(1);
});
