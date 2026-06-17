# Como editar contenido

Esta version es simple a proposito. El contenido principal esta en `index.html`, los estilos en `styles.css` y la demo privada en `app.js`.

## Textos principales

Archivo: `index.html`

Cambios comunes:

- Titulo principal: buscar `<h1>Managmentoring</h1>`.
- Texto del hero: buscar `hero-copy`.
- Programas: buscar `<section class="programs">`.
- Bio de Lourdes: buscar `id="lourdes"`.
- Contacto: buscar `id="contacto"`.
- WhatsApp: buscar `https://wa.me/59899335900`.
- Email: buscar `lourdespose@managmentoring.com`.

## Colores y look

Archivo: `styles.css`

Los colores estan al comienzo:

```css
:root {
  --ink: #17201b;
  --muted: #66736b;
  --paper: #fbfaf6;
  --sage: #74876b;
  --moss: #394b35;
  --clay: #b76e4c;
  --gold: #c7a45d;
}
```

Cambiar esos valores modifica el tono general del sitio.

## Imagenes

Carpeta: `assets/`

Imagenes actuales:

- `assets/managmentoring-logo.png`
- `assets/hero-desk.jpeg`

Si se reemplaza una imagen manteniendo el mismo nombre, no hace falta tocar el HTML.

## Demo privada

Archivo: `app.js`

La lista `clients` contiene clientes falsos de demostracion. No poner datos reales ahi.

Cuando el portal sea real, esa informacion debe venir de Supabase con login y permisos.

## Probar cambios localmente

Opcion simple:

1. Abrir `index.html` en el navegador.
2. Refrescar despues de cada cambio.

Opcion con servidor local:

```bash
python3 -m http.server 8000
```

Luego abrir:

```text
http://127.0.0.1:8000
```

## Publicar cambios

Cuando el sitio este conectado a GitHub y Netlify/Vercel:

1. Se guarda el cambio en Git.
2. Se sube a GitHub.
3. El hosting publica automaticamente.

Eso evita depender de editores visuales cerrados y permite volver atras si algo sale mal.
