#!/usr/bin/env node
// One-off migration runner. Loads .env, applies all SQL files in
// supabase/migrations/ alphabetically. Idempotent thanks to "if not exists"
// in the SQL.
import { readFile, readdir } from "node:fs/promises";
import { resolve, join } from "node:path";
import { setDefaultResultOrder } from "node:dns";
import pg from "pg";

setDefaultResultOrder("ipv4first");
const { Client } = pg;

async function loadEnv() {
  const raw = await readFile(resolve(".env"), "utf8");
  for (const line of raw.split("\n")) {
    const m = line.match(/^([A-Z0-9_]+)\s*=\s*"?([^"]*)"?\s*$/);
    if (m && !process.env[m[1]]) process.env[m[1]] = m[2];
  }
}

function poolerConfig(region) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const pw = process.env.SUPABASE_DB_PW;
  if (!url || !pw) throw new Error("Missing SUPABASE_DB_PW or NEXT_PUBLIC_SUPABASE_URL");
  const ref = new URL(url).hostname.split(".")[0];
  return {
    host: `aws-0-${region}.pooler.supabase.com`,
    port: 5432,
    user: `postgres.${ref}`,
    password: pw,
    database: "postgres",
    // Pooler uses Supabase's CA; we don't pin it here, just require TLS.
    ssl: { rejectUnauthorized: false },
  };
}

const REGIONS = [
  "us-east-1", "us-west-1", "us-east-2", "us-west-2",
  "ca-central-1", "eu-central-1", "eu-west-1",
  "ap-southeast-1", "ap-northeast-1", "sa-east-1",
];

async function connectToFirstReachable() {
  for (const region of REGIONS) {
    const cfg = poolerConfig(region);
    const c = new Client({ ...cfg, connectionTimeoutMillis: 5000 });
    try {
      await c.connect();
      console.log(`connected via pooler (${region})`);
      return c;
    } catch (e) {
      console.log(`  ${region}: ${e?.code || ""} ${e?.message || e}`);
      await c.end().catch(() => {});
    }
  }
  throw new Error("Could not connect to any pooler region. Check SUPABASE_DB_PW.");
}

async function main() {
  await loadEnv();
  const client = await connectToFirstReachable();

  const dir = resolve("supabase/migrations");
  const files = (await readdir(dir)).filter((f) => f.endsWith(".sql")).sort();
  for (const f of files) {
    const sql = await readFile(join(dir, f), "utf8");
    process.stdout.write(`  ${f} ... `);
    await client.query(sql);
    console.log("ok");
  }

  // Sanity check
  const r = await client.query(
    "select count(*) from public.inspections",
  );
  console.log(`inspections rows: ${r.rows[0].count}`);

  await client.end();
}

main().catch((e) => {
  console.error("migration failed:", e.message);
  process.exit(1);
});
