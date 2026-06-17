# Setup de Supabase

Este documento es para la fase privada real. No es necesario para publicar la web publica.

## Crear proyecto

1. Crear cuenta en Supabase.
2. Crear proyecto nuevo: `managmentoring`.
3. Guardar:
   - Project URL.
   - anon public key.
   - service role key en un lugar seguro, no en el repo.

## Base de datos

1. Ir a SQL Editor.
2. Copiar y ejecutar `supabase/schema.sql`.
3. Confirmar que las tablas existen.
4. Confirmar que Row Level Security esta activo.

## Crear admin

1. Crear usuario para Lourdes desde Authentication.
2. Copiar el `user id`.
3. Insertar o actualizar su profile como admin:

```sql
insert into public.profiles (id, full_name, email, role)
values ('USER_ID_DE_LOURDES', 'Lourdes Pose', 'lourdespose@managmentoring.com', 'admin')
on conflict (id) do update
set role = 'admin',
    full_name = excluded.full_name,
    email = excluded.email;
```

## Prueba minima de seguridad

Crear dos usuarios cliente:

- Cliente A.
- Cliente B.

Validar:

- Lourdes ve todos los clientes.
- Cliente A ve solo su propio programa, materiales, tareas, sesiones y pagos.
- Cliente B ve solo lo suyo.
- Cliente A no puede consultar registros de Cliente B aunque manipule el navegador.

## Reglas importantes

- Nunca poner `SUPABASE_SERVICE_ROLE_KEY` en frontend.
- Nunca cargar datos reales antes de probar RLS.
- Usar Supabase Storage con politicas si se suben PDFs o videos privados.
- Definir una rutina de exportacion/backups antes de migrar la base real.
