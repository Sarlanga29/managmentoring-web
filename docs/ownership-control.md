# Control y propiedad del proyecto

La idea es que Managmentoring no quede atrapada en una plataforma cerrada. El control conviene dividirlo en cinco piezas, todas bajo cuentas propias de ustedes.

## Piezas que deben quedar bajo tu control

1. Dominio
   - Cuenta: GoDaddy o el registrador que ya tengan.
   - Activo: `managmentoring.com`.
   - Importante: no perder acceso al DNS ni tocar registros de email sin revisar.

2. Codigo
   - Cuenta recomendada: GitHub.
   - Activo: repositorio privado o publico de Managmentoring.
   - Importante: todo cambio queda versionado y reversible.

3. Hosting
   - Recomendacion inicial si ya tenes GitHub: GitHub Pages.
   - Alternativas: Netlify o Vercel.
   - Activo: sitio publicado, deploys y dominio conectado.
   - Importante: se conecta al repo de GitHub para publicar cambios sin subir archivos manualmente.

4. Base de datos y login
   - Recomendacion: Supabase.
   - Activo: usuarios, clientes, cursos, sesiones, materiales y pagos.
   - Importante: no cargar datos reales hasta validar permisos.

5. Backups y documentacion
   - Activo: exportaciones periodicas y documentos de operacion.
   - Importante: que Lourdes pueda seguir operando aunque cambie de proveedor o desarrollador.

## Por que este modelo da control

- El dominio sigue siendo de ustedes.
- El codigo vive en GitHub, no dentro de un builder cerrado.
- El hosting puede cambiarse si un dia no les gusta.
- La base de datos puede exportarse.
- Cada cambio queda registrado.
- Se puede contratar a otra persona mas adelante sin rehacer todo desde cero.

## Flujo recomendado para cambios

1. Cambiar archivos localmente.
2. Probar en el navegador.
3. Guardar cambio en Git.
4. Subir a GitHub.
5. Netlify/Vercel publica automaticamente.
6. Si algo sale mal, volver a una version anterior.

## Cuentas a crear o confirmar

- [ ] Acceso administrador a GoDaddy.
- [ ] Acceso al email `lourdespose@managmentoring.com`.
- [ ] Cuenta GitHub de ustedes.
- [ ] Cuenta Netlify o Vercel de ustedes.
- [ ] Cuenta Supabase de ustedes.
- [ ] Metodo de pago propio, si algun plan pago fuera necesario.
- [ ] 2FA activo en todas las cuentas importantes.

## Reglas de oro

- No publicar claves privadas en GitHub.
- No compartir la service role key de Supabase.
- No tocar registros `MX`/email de GoDaddy sin backup previo.
- No cargar datos reales en la demo actual.
- Mantener una copia de los DNS actuales antes de apuntar el dominio.
- Usar cuentas personales/de empresa de ustedes, no cuentas de terceros.

## Siguiente decision

Para la primera publicacion, elegir:

- Netlify: mas simple para este sitio estatico.
- GitHub Pages: mas simple si ya tenes GitHub y queres evitar otra cuenta ahora.
- Vercel: mejor si vamos rapido hacia Next.js/app full-stack.

Mi recomendacion: GitHub Pages ahora, Supabase despues, y migrar a Next.js con Vercel/Netlify cuando empecemos el portal privado real.
