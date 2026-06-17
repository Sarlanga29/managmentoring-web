# Flujo local de developer

Este es el flujo recomendado para trabajar la web como un developer: ver codigo, pedir cambios a Codex, probar localmente, guardar en Git y publicar.

## 1. Editor recomendado

Usa **Visual Studio Code**. No es Visual Basic; VS Code es el editor moderno para trabajar con HTML, CSS, JavaScript y Git.

Instalalo desde:

```text
https://code.visualstudio.com/
```

Despues abre esta carpeta:

```text
/Users/carloscastro/Documents/Pagina Web - Managmentoring
```

En VS Code:

1. `File` -> `Open Folder...`
2. Elegir `Pagina Web - Managmentoring`
3. Abrir los archivos:
   - `index.html`
   - `styles.css`
   - `app.js`

## 2. Instalar comando `code`

Dentro de VS Code:

1. Presiona `Cmd+Shift+P`.
2. Busca `Shell Command`.
3. Ejecuta `Shell Command: Install 'code' command in PATH`.

Luego podras abrir el proyecto desde terminal con:

```bash
code "/Users/carloscastro/Documents/Pagina Web - Managmentoring"
```

## 3. Instalar Codex en VS Code

En VS Code:

1. Ir a `Extensions`.
2. Buscar `Codex`.
3. Instalar la extension oficial de OpenAI.
4. Iniciar sesion con tu cuenta de ChatGPT.

Codex aparece como panel lateral. Desde ahi podes escribir prompts y Codex puede leer/editar archivos del proyecto.

## 4. Servidor local

Desde la terminal integrada de VS Code:

```bash
python3 -m http.server 8000
```

Abrir:

```text
http://127.0.0.1:8000
```

Para cortar el servidor:

```text
Ctrl+C
```

## 5. Ciclo normal de trabajo

1. Pedir un cambio a Codex.
2. Revisar los archivos modificados.
3. Refrescar el navegador local.
4. Si gusta, guardar commit.
5. Hacer push a GitHub.
6. Esperar que GitHub Pages actualice.

Comandos:

```bash
git status
git add .
git commit -m "Describe el cambio"
git push origin main
```

## 6. Prompts utiles

Cambios chicos:

```text
Cambia el texto del hero para que suene mas ejecutivo y menos generico.
```

Cambios visuales:

```text
Ajusta el header para que el selector de idioma se vea mas elegante en mobile.
```

Revision:

```text
Revisa los cambios sin editar. Buscame problemas de responsive, accesibilidad o links rotos.
```

Publicacion:

```text
Hace commit y push de estos cambios a main.
```

## 7. Reglas para trabajar tranquilo

- Antes de cambios grandes, mirar `git status`.
- Hacer commits chicos y claros.
- Probar mobile antes de publicar.
- No poner datos reales de clientes en `app.js`.
- No tocar DNS hasta estar conforme con GitHub Pages.
- Mantener `main` funcionando siempre.

## 8. Comandos de emergencia

Ver que cambio:

```bash
git diff
```

Ver historial:

```bash
git log --oneline --max-count=10
```

Descartar un archivo especifico antes de commit:

```bash
git restore nombre-del-archivo
```

No usar comandos destructivos como `git reset --hard` salvo que sepas exactamente que queres borrar.
