-- Lighthouse — Glassdoor signal columns on companies.
-- Adds the fields populated by HasData's Glassdoor Listing API + the
-- one-off CSV importer. These augment the per-company aggregate that
-- gets injected back into Gemini's Stage-1 prompt for richer verifications.

alter table public.companies
  add column if not exists glassdoor_rating numeric(3,2)
    check (glassdoor_rating is null or (glassdoor_rating between 0 and 5)),
  add column if not exists industry text,
  add column if not exists hq_city  text,
  add column if not exists hq_region text,
  -- Track when Glassdoor data was last refreshed so the cron can prefer
  -- companies whose signals are getting stale.
  add column if not exists glassdoor_refreshed_at timestamptz;

create index if not exists companies_industry_idx
  on public.companies (industry);
create index if not exists companies_glassdoor_rating_idx
  on public.companies (glassdoor_rating desc);

-- Also widen the postings table so cron-ingested rows can carry the
-- richer Glassdoor metadata (salary band, currency, monthsOfExperience…)
-- without losing them to the JSONB raw_payload.
alter table public.postings
  add column if not exists salary_min        integer,
  add column if not exists salary_max        integer,
  add column if not exists salary_currency   text,
  add column if not exists salary_period     text,
  add column if not exists experience_text   text;

create index if not exists postings_salary_idx
  on public.postings (salary_min, salary_max);
