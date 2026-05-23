-- Migration: Automatic PostgREST schema reloader on migration runs
-- This trigger listens for ddl_command_end events and automatically reloads 
-- PostgREST's schema cache to avoid stale schema / missing columns.

CREATE OR REPLACE FUNCTION public.pgrst_watch() 
RETURNS event_trigger 
LANGUAGE plpgsql 
AS $$
BEGIN
  NOTIFY pgrst, 'reload schema';
END;
$$;

DROP EVENT TRIGGER IF EXISTS pgrst_watch ON ddl_command_end;

CREATE EVENT TRIGGER pgrst_watch 
  ON ddl_command_end 
  EXECUTE PROCEDURE public.pgrst_watch();
