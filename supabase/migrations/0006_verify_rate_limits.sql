-- Migration: Create verify_rate_limits table for API rate-limiting of Gemini verifications
create table if not exists public.verify_rate_limits (
  id         uuid primary key default gen_random_uuid(),
  ip_hash    text not null,
  created_at timestamptz not null default now()
);

-- Index for speedy lookups on ip_hash and created_at
create index if not exists verify_rate_limits_ip_hash_created_at_idx
  on public.verify_rate_limits (ip_hash, created_at desc);

-- Enable Row Level Security (RLS)
alter table public.verify_rate_limits enable row level security;

-- Policies to allow server-side operations using the anon/service_role keys
drop policy if exists "verify_rate_limits are public select" on public.verify_rate_limits;
create policy "verify_rate_limits are public select"
  on public.verify_rate_limits for select to anon, authenticated using (true);

drop policy if exists "verify_rate_limits are public insert" on public.verify_rate_limits;
create policy "verify_rate_limits are public insert"
  on public.verify_rate_limits for insert to anon, authenticated with check (true);

drop policy if exists "verify_rate_limits are public delete" on public.verify_rate_limits;
create policy "verify_rate_limits are public delete"
  on public.verify_rate_limits for delete to anon, authenticated using (true);
