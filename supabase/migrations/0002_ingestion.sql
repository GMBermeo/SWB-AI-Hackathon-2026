-- Lighthouse — ingestion layer.
-- Adds three tables that turn the single-row /api/verify flow into a
-- multi-source pipeline:
--
--   sources         — operational config for each job board adapter
--   postings        — raw fetched postings (queue) before verification
--   ingestion_runs  — log of each cron invocation, per source

create extension if not exists "pgcrypto";

-- ────────────────────────────────────────────────────────────────────────
-- sources: per-adapter config the cron consults each run.
-- ────────────────────────────────────────────────────────────────────────
create table if not exists public.sources (
  id                    uuid primary key default gen_random_uuid(),
  slug                  text not null unique,
  display_name          text not null,
  kind                  text not null check (kind in ('api','rss','xml','html')),
  base_url              text,
  ingest_enabled        boolean not null default true,
  fetch_limit           smallint not null default 5,
  rate_limit_per_minute smallint not null default 30,
  last_run_at           timestamptz,
  last_ok_at            timestamptz,
  notes                 text,
  config                jsonb not null default '{}'::jsonb
);

-- Seed the V1 adapter set. Free, public, no API key required.
insert into public.sources (slug, display_name, kind, base_url, fetch_limit, notes)
values
  ('remoteok',   'Remote OK',          'api', 'https://remoteok.com/api',                 5, 'Public JSON, polite User-Agent'),
  ('greenhouse', 'Greenhouse boards',  'api', 'https://boards-api.greenhouse.io/v1/boards',5, 'Curated company list in adapter'),
  ('lever',      'Lever postings',     'api', 'https://api.lever.co/v0/postings',          5, 'Curated company list in adapter'),
  ('ashby',      'Ashby boards',       'api', 'https://api.ashbyhq.com/posting-api/job-board', 5, 'Curated company list in adapter'),
  ('wwr',        'We Work Remotely',   'rss', 'https://weworkremotely.com/categories',     5, 'RSS feeds per category')
on conflict (slug) do nothing;

-- ────────────────────────────────────────────────────────────────────────
-- postings: the ingestion queue. One row per URL we've ever seen via the
-- cron OR a manual paste; status tracks its lifecycle.
-- ────────────────────────────────────────────────────────────────────────
create table if not exists public.postings (
  id                 uuid primary key default gen_random_uuid(),
  source_slug        text not null references public.sources(slug),
  source_external_id text,
  url                text not null,
  url_normalized     text not null unique,
  title              text not null,
  company            text,
  location           text,
  description        text,
  posted_at          timestamptz,
  first_seen_at      timestamptz not null default now(),
  last_seen_at       timestamptz not null default now(),
  raw_payload        jsonb,
  status             text not null default 'new'
                       check (status in ('new','verifying','verified','failed')),
  inspection_id      uuid references public.inspections(id),
  last_attempt_at    timestamptz,
  attempt_count      smallint not null default 0,
  attempt_error      text
);

create index if not exists postings_status_seen_idx
  on public.postings (status, first_seen_at desc);
create index if not exists postings_source_status_idx
  on public.postings (source_slug, status);
create index if not exists postings_inspection_idx
  on public.postings (inspection_id);

-- ────────────────────────────────────────────────────────────────────────
-- ingestion_runs: every cron invocation lands here. Used for /api/stats
-- and operational visibility.
-- ────────────────────────────────────────────────────────────────────────
create table if not exists public.ingestion_runs (
  id              uuid primary key default gen_random_uuid(),
  started_at      timestamptz not null default now(),
  finished_at     timestamptz,
  status          text not null default 'running'
                    check (status in ('running','ok','partial','failed')),
  trigger         text not null default 'cron'
                    check (trigger in ('cron','manual')),
  sources_summary jsonb not null default '{}'::jsonb,
  total_seen      integer not null default 0,
  total_new       integer not null default 0,
  total_verified  integer not null default 0,
  duration_ms     integer,
  error           text
);

create index if not exists ingestion_runs_started_idx
  on public.ingestion_runs (started_at desc);

-- ────────────────────────────────────────────────────────────────────────
-- Row Level Security.
-- ────────────────────────────────────────────────────────────────────────
-- The ingestion layer is operational, but the contents are public artifacts
-- — anyone can read what we fetched and ran. Writes go through API routes;
-- for MVP these use the publishable (anon) key, same as inspections.

alter table public.sources enable row level security;
drop policy if exists "sources are public" on public.sources;
create policy "sources are public"
  on public.sources for select to anon, authenticated using (true);
drop policy if exists "sources writable" on public.sources;
create policy "sources writable"
  on public.sources for update to anon, authenticated using (true) with check (true);

alter table public.postings enable row level security;
drop policy if exists "postings are public" on public.postings;
create policy "postings are public"
  on public.postings for select to anon, authenticated using (true);
drop policy if exists "postings writable" on public.postings;
create policy "postings writable"
  on public.postings for insert to anon, authenticated with check (true);
drop policy if exists "postings updatable" on public.postings;
create policy "postings updatable"
  on public.postings for update to anon, authenticated using (true) with check (true);

alter table public.ingestion_runs enable row level security;
drop policy if exists "runs are public" on public.ingestion_runs;
create policy "runs are public"
  on public.ingestion_runs for select to anon, authenticated using (true);
drop policy if exists "runs writable" on public.ingestion_runs;
create policy "runs writable"
  on public.ingestion_runs for insert to anon, authenticated with check (true);
drop policy if exists "runs updatable" on public.ingestion_runs;
create policy "runs updatable"
  on public.ingestion_runs for update to anon, authenticated using (true) with check (true);

-- ────────────────────────────────────────────────────────────────────────
-- Convenience: when a manual /api/verify creates an inspection, link any
-- existing posting row via a tiny trigger. Optional; the application code
-- also links explicitly.
-- ────────────────────────────────────────────────────────────────────────
create or replace function public.link_posting_to_inspection()
returns trigger
language plpgsql
security invoker
as $$
begin
  update public.postings
     set inspection_id  = new.id,
         status         = 'verified',
         last_attempt_at = now()
   where url_normalized = new.url_normalized
     and inspection_id is null;
  return new;
end;
$$;

drop trigger if exists postings_link_on_inspection on public.inspections;
create trigger postings_link_on_inspection
  after insert on public.inspections
  for each row
  execute function public.link_posting_to_inspection();
