-- Migration: Add is_remote column to public.inspections
ALTER TABLE public.inspections ADD COLUMN IF NOT EXISTS is_remote BOOLEAN NOT NULL DEFAULT TRUE;
