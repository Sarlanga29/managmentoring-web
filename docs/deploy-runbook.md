# Runbook de deploy

## Opcion recomendada para empezar: Netlify

Netlify es simple para esta fase porque el sitio actual es estatico.

1. Crear una cuenta en Netlify.
2. Subir este proyecto a GitHub.
3. En Netlify: `Add new site` -> `Import an existing project`.
4. Elegir el repo.
5. Build command: dejar vacio.
6. Publish directory: `.`
7. Deploy.
8. Probar la URL temporal de Netlify.
9. En `Domain management`, agregar `managmentoring.com`.
10. Copiar los DNS records que Netlify indique.
11. Entrar a GoDaddy y actualizar DNS.
12. Esperar propagacion y confirmar HTTPS.

## Alternativa: Vercel

1. Crear una cuenta en Vercel.
2. Subir este proyecto a GitHub.
3. En Vercel: `Add New` -> `Project`.
4. Importar el repo.
5. Framework preset: `Other`.
6. Build command: dejar vacio.
7. Output directory: `.`.
8. Deploy.
9. Probar la URL temporal.
10. Agregar `managmentoring.com` en `Domains`.
11. Aplicar en GoDaddy los DNS records que Vercel indique.

## Antes de cambiar DNS

Guardar captura o copia de:

- Todos los registros `A`.
- Todos los registros `CNAME`.
- Todos los registros `MX`.
- Todos los registros `TXT`.

No tocar `MX` ni `TXT` de email salvo que sepamos exactamente que hacen. Cambiar mal esos registros puede cortar el correo `lourdespose@managmentoring.com`.

## Despues de publicar

Revisar:

- `https://managmentoring.com` carga.
- `https://www.managmentoring.com` carga o redirige bien.
- El candado HTTPS aparece.
- WhatsApp abre con el numero correcto.
- Mailto abre `lourdespose@managmentoring.com`.
- Mobile no tiene cortes de texto.
- La parte privada sigue presentada como demo, sin datos reales.
