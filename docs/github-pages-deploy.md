# Deploy con GitHub Pages

Esta es la opcion mas simple si ya tenes GitHub y todavia no queres crear Netlify.

## Que permite

- Publicar la web publica actual.
- Usar una URL temporal tipo `https://usuario.github.io/repositorio`.
- Conectar despues `managmentoring.com`.
- Mantener control total del codigo desde GitHub.

## Limitaciones

- Sirve para sitio estatico.
- No resuelve login real ni base de datos.
- Para el portal privado real vamos a necesitar Supabase y, probablemente, una app con React/Next.js.

## Pasos

1. Crear un repositorio en GitHub, por ejemplo `managmentoring-web`.
2. Subir estos archivos al repositorio.
3. En GitHub, entrar al repo.
4. Ir a `Settings`.
5. Ir a `Pages`.
6. En `Build and deployment`, elegir:
   - Source: `Deploy from a branch`.
   - Branch: `main`.
   - Folder: `/root`.
7. Guardar.
8. Esperar a que GitHub publique la URL.
9. Abrir la URL temporal y revisar la web.

## Conectar dominio propio

Cuando la URL temporal este revisada:

1. En `Settings` -> `Pages`, buscar `Custom domain`.
2. Escribir `managmentoring.com`.
3. GitHub va a pedir cambios DNS en GoDaddy.
4. Antes de tocar GoDaddy, copiar todos los DNS actuales.
5. No tocar registros `MX` ni `TXT` de email salvo que sea estrictamente necesario.
6. Aplicar los registros que GitHub indique.
7. Activar `Enforce HTTPS` cuando este disponible.

## Archivo CNAME

Para dominio propio, GitHub Pages suele usar un archivo llamado `CNAME` en la raiz del repo con:

```text
managmentoring.com
```

No crear ese archivo hasta que vayamos a conectar el dominio real.
