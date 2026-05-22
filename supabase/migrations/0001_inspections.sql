-- Lighthouse: verification ledger.
-- One row per remote-job verification. Doubles as cache (url_normalized unique)
-- and as the public Library feed.

create extension if not exists "pgcrypto";

create table if not exists public.inspections (
  id              uuid primary key default gen_random_uuid(),
  url             text not null,
  url_normalized  text not null,

  company         text not null,
  role            text not null,
  location        text not null,
  comp_min        integer not null default 0,
  comp_max        integer not null default 0,
  equity          text not null default '—',
  posted          text not null default 'unknown',
  summary         text not null default '',

  score           smallint not null check (score between 0 and 100),
  verdict         text not null check (verdict in ('VERIFIED','INVESTIGATE','DECLINE')),
  headline        text not null default '',
  editorial       text not null default '',

  pillars         jsonb not null default '[]'::jsonb,
  activity        jsonb not null default '{}'::jsonb,
  comparables     jsonb not null default '[]'::jsonb,
  citations       jsonb not null default '[]'::jsonb,

  evidence_raw    text,
  verify_ms       integer,

  created_at      timestamptz not null default now()
);

create unique index if not exists inspections_url_normalized_key
  on public.inspections (url_normalized);

create index if not exists inspections_created_at_idx
  on public.inspections (created_at desc);

create index if not exists inspections_verdict_idx
  on public.inspections (verdict);

alter table public.inspections enable row level security;

-- Verification ledger is a public artifact: anyone can read past inspections.
drop policy if exists "inspections are public" on public.inspections;
create policy "inspections are public"
  on public.inspections for select
  using (true);

-- Anonymous clients can record their own verifications (this is what the
-- /api/verify route does, since we use the publishable key on the server).
drop policy if exists "anyone can record an inspection" on public.inspections;
create policy "anyone can record an inspection"
  on public.inspections for insert
  with check (true);

-- Same for upserts that refresh stale cache rows.
drop policy if exists "anyone can refresh an inspection" on public.inspections;
create policy "anyone can refresh an inspection"
  on public.inspections for update
  using (true)
  with check (true);
