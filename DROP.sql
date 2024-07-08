CREATE OR REPLACE FUNCTION borrar_tablas_y_objetos() RETURNS void AS $$
DECLARE
  cur_name text;
BEGIN
  -- Eliminar tablas
  FOR cur_name IN SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE' LOOP
    EXECUTE 'DROP TABLE IF EXISTS public.' || quote_ident(cur_name) || ' CASCADE';
  END LOOP;

  -- Eliminar tipos de objetos
  FOR cur_name IN SELECT typname FROM pg_type t JOIN pg_namespace n ON t.typnamespace = n.oid WHERE n.nspname = 'public' LOOP
    EXECUTE 'DROP TYPE IF EXISTS public.' || quote_ident(cur_name) || ' CASCADE';
  END LOOP;
END;
$$ LANGUAGE plpgsql VOLATILE;

SELECT borrar_tablas_y_objetos();