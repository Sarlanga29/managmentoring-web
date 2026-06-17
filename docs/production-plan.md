# Plan de produccion para Managmentoring

Este plan separa dos objetivos: publicar la web publica rapido y construir la parte privada sin exponer datos reales.

## Fase 1 - Web publica

Objetivo: reemplazar la pagina actual por una version moderna y estable.

1. Elegir hosting: GitHub Pages, Netlify, Vercel o Firebase Hosting.
2. Subir este repositorio a GitHub.
3. Conectar el repo al hosting.
4. Publicar una URL temporal de prueba.
5. Revisar copy, links, mobile, SEO basico y WhatsApp.
6. Apuntar `managmentoring.com` desde GoDaddy al hosting elegido.
7. Mantener el sitio anterior hasta confirmar que DNS y SSL funcionan.

Runbooks detallados:

- `docs/github-pages-deploy.md`
- `docs/deploy-runbook.md`

## Fase 2 - Portal privado real

Objetivo: reemplazar la demo visual por login, permisos y datos reales.

Stack recomendado:

- Frontend: React o Next.js.
- Auth y base de datos: Supabase.
- Hosting: Vercel, Netlify o Firebase Hosting.
- Archivos privados: Supabase Storage con politicas por usuario.

Tablas iniciales:

- `profiles`: usuario, email y rol.
- `clients`: base de clientes.
- `programs`: cursos o programas.
- `enrollments`: cliente inscrito a un programa.
- `sessions`: sesiones y notas.
- `materials`: PDFs, videos, links y ejercicios.
- `enrollment_materials`: materiales asignados por cliente.
- `tasks`: tareas y compromisos.
- `payments`: estado de pagos.

Setup de Supabase: `docs/supabase-setup.md`.

## Fase 3 - Operacion

1. Crear usuario admin para Lourdes.
2. Cargar 2 o 3 clientes de prueba.
3. Probar que cada cliente solo vea sus propios datos.
4. Revisar que Lourdes vea todo.
5. Activar backups y exportacion mensual.
6. Definir politica de privacidad y tratamiento de datos.
7. Migrar clientes reales.

## Checklist antes de datos reales

- [ ] Login real activo.
- [ ] Row Level Security activo en todas las tablas privadas.
- [ ] Ninguna service role key expuesta en navegador.
- [ ] Backups configurados.
- [ ] Politica de privacidad publicada.
- [ ] Usuarios de prueba validados.
- [ ] Dominio con HTTPS funcionando.
- [ ] Formulario/contacto probado.

## DNS orientativo

El hosting elegido va a indicar los registros exactos. Normalmente hay dos escenarios:

- Dominio apex `managmentoring.com`: `A` records o `ALIAS/ANAME`.
- Subdominio `www.managmentoring.com`: `CNAME` al dominio del proveedor.

No borrar los registros de email si existen. Antes de cambiar DNS conviene capturar la configuracion actual de GoDaddy.
