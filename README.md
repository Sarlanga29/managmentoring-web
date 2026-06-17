# Managmentoring

Redisenio inicial del sitio de Managmentoring y base de plan para llevarlo a produccion.

## Estado actual

- Sitio publico estatico listo para publicar.
- Demo visual del portal de participante.
- Demo visual del backoffice de Lourdes.
- Configs iniciales para Netlify y Vercel.
- Esquema SQL inicial para Supabase.
- Plan de produccion en `docs/production-plan.md`.
- Guia de control y propiedad en `docs/ownership-control.md`.
- Guia para editar contenido en `docs/content-editing.md`.
- Guia de trabajo local como developer en `docs/local-developer-workflow.md`.

## Como abrir localmente

Abrir `index.html` directamente en el navegador.

Tambien se puede levantar un servidor local:

```bash
python3 -m http.server 8000
```

Luego abrir `http://127.0.0.1:8000`.

## Publicacion rapida

Para publicar solo la web publica:

1. Subir este repositorio a GitHub.
2. Conectar el repo a Netlify, Vercel o Firebase Hosting.
3. Usar la raiz del repo como carpeta publicada.
4. Probar la URL temporal.
5. Apuntar `managmentoring.com` al hosting elegido.

Ver tambien:

- `docs/deploy-runbook.md`
- `docs/github-pages-deploy.md`
- `docs/ownership-control.md`
- `docs/content-editing.md`

## Parte privada

La parte privada actual es demo. No cargar datos reales ahi.

Para convertirla en app real:

1. Crear proyecto Supabase.
2. Ejecutar `supabase/schema.sql`.
3. Implementar login real.
4. Conectar las pantallas a la base de datos.
5. Validar Row Level Security con usuarios de prueba.
