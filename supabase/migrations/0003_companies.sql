-- Lighthouse — companies aggregate.
-- Builds a per-company memory across every verification. Future runs against
-- the same company get richer context, and the Library can render a "trust
-- card" that summarizes a company's full inspection history.
--
-- We do NOT scrape Glassdoor / LinkedIn directly. Those signals come into
-- this table via Gemini's grounded search citing those domains — fully ToS-
-- compliant and reproducible.

create extension if not exists "pgcrypto";

-- ────────────────────────────────────────────────────────────────────────
-- companies: one row per distinct company surfaced by an inspection.
-- ────────────────────────────────────────────────────────────────────────
create table if not exists public.companies (
  id                   uuid primary key default gen_random_uuid(),
  slug                 text not null unique,         -- lowercased, dasherized
  display_name         text not null,
  primary_domain       text,
  -- Aggregates rolled up from inspections.
  inspection_count     integer not null default 0,
  mean_score           numeric(5,2),
  last_score           smallint,
  last_verdict         text check (last_verdict in ('VERIFIED','INVESTIGATE','DECLINE')),
  last_inspected_at    timestamptz,
  -- External profile pointers — populated opportunistically when Gemini
  -- cites them in evidence.
  linkedin_url         text,
  glassdoor_url        text,
  crunchbase_url       text,
  github_org           text,
  -- Frozen-in-time signals from the most recent inspection.
  founded_year         smallint,
  hq_country           text,
  employee_count_est   integer,
  funding_total_usd    bigint,
  notes                text,
  created_at           timestamptz not null default now()
);

create index if not exists companies_last_inspected_idx
  on public.companies (last_inspected_at desc);
create index if not exists companies_mean_score_idx
  on public.companies (mean_score desc);
create index if not exists companies_domain_idx
  on public.companies (primary_domain);

-- ────────────────────────────────────────────────────────────────────────
-- Add a company_id back-reference on inspections so we can JOIN cheaply.
-- ────────────────────────────────────────────────────────────────────────
alter table public.inspections
  add column if not exists company_id uuid references public.companies(id);

create index if not exists inspections_company_idx
  on public.inspections (company_id, created_at desc);

-- ────────────────────────────────────────────────────────────────────────
-- Helper: slugify a company name into the same key the application uses.
-- ────────────────────────────────────────────────────────────────────────
create or replace function public.company_slug(raw text)
returns text
language sql
immutable
as $$
  select trim(both '-' from
    regexp_replace(
      regexp_replace(lower(coalesce(raw,'')), '[^a-z0-9]+', '-', 'g'),
      '-+', '-', 'g'
    )
  )
$$;

-- ────────────────────────────────────────────────────────────────────────
-- upsert_company_from_inspection_for(uuid): the core logic. Idempotent;
-- safe to call repeatedly. Used by both the trigger (new rows) and the
-- backfill (existing rows).
-- ────────────────────────────────────────────────────────────────────────
create or replace function public.upsert_company_from_inspection_for(row_id uuid)
returns void
language plpgsql
security invoker
as $$
declare
  v_slug   text;
  v_id     uuid;
  v_domain text;
  v_row    public.inspections;
begin
  select * into v_row from public.inspections where id = row_id;
  if not found then return; end if;

  v_slug := public.company_slug(v_row.company);
  if v_slug = '' then return; end if;

  begin
    v_domain := lower(split_part(regexp_replace(v_row.url, '^https?://', ''), '/', 1));
    v_domain := regexp_replace(v_domain, '^www\.', '');
  exception when others then v_domain := null;
  end;

  insert into public.companies (slug, display_name, primary_domain)
  values (v_slug, v_row.company, v_domain)
  on conflict (slug) do update set
    display_name   = excluded.display_name,
    primary_domain = coalesce(public.companies.primary_domain, excluded.primary_domain)
  returning id into v_id;

  update public.companies
     set inspection_count  = stats.cnt,
         mean_score        = stats.mean,
         last_score        = stats.last_score,
         last_verdict      = stats.last_verdict,
         last_inspected_at = stats.last_at
    from (
      select count(*)                                                as cnt,
             round(avg(score)::numeric, 2)                           as mean,
             (array_agg(score      order by created_at desc))[1]     as last_score,
             (array_agg(verdict    order by created_at desc))[1]     as last_verdict,
             max(created_at)                                         as last_at
        from public.inspections
       where company_id = v_id
          or public.company_slug(company) = v_slug
    ) stats
   where id = v_id;

  update public.inspections set company_id = v_id where id = row_id;
end;
$$;

-- ────────────────────────────────────────────────────────────────────────
-- Trigger wrapper.
-- ────────────────────────────────────────────────────────────────────────
create or replace function public.upsert_company_from_inspection()
returns trigger
language plpgsql
security invoker
as $$
begin
  perform public.upsert_company_from_inspection_for(new.id);
  return new;
end;
$$;

drop trigger if exists inspections_upsert_company on public.inspections;
create trigger inspections_upsert_company
  after insert on public.inspections
  for each row
  execute function public.upsert_company_from_inspection();

-- ────────────────────────────────────────────────────────────────────────
-- RLS — companies are part of the public ledger.
-- ────────────────────────────────────────────────────────────────────────
alter table public.companies enable row level security;
drop policy if exists "companies are public" on public.companies;
create policy "companies are public"
  on public.companies for select to anon, authenticated using (true);
drop policy if exists "companies writable" on public.companies;
create policy "companies writable"
  on public.companies for insert to anon, authenticated with check (true);
drop policy if exists "companies updatable" on public.companies;
create policy "companies updatable"
  on public.companies for update to anon, authenticated using (true) with check (true);

-- ────────────────────────────────────────────────────────────────────────
-- Backfill — rebuild from any inspection rows that predate this migration.
-- ────────────────────────────────────────────────────────────────────────
do $$
declare
  rec record;
begin
  for rec in
    select id from public.inspections where company_id is null
  loop
    perform public.upsert_company_from_inspection_for(rec.id);
  end loop;
end $$;
