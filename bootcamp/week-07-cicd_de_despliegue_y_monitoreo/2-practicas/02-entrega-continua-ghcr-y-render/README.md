# Práctica 02 — Entrega Continua: GHCR y Render

<!-- 📝 Instrucción: práctica en parejas. Requiere la práctica 01 y las cuentas de Render y Neon
de la semana 4. Las pantallas de los proveedores cambian con frecuencia: si un botón no
coincide, busca la opción equivalente en su documentación. Nota para el instructor: confirmar al
inicio del curso que el plan gratuito de Render sigue permitiendo servicios web desde una imagen
de un registro; si no, las partes 1-3 y 6 se hacen igual y el despliegue se practica en el
servidor (práctica 03). -->

## Objetivo

Publicar una versión solo con una etiqueta Git: el pipeline construye, prueba, publica la imagen
en GHCR, la despliega en Render y verifica producción. Después, volver a la versión anterior sin
reconstruir.

## Duración estimada

150 minutos.

## Preparación

Lee [`release.yml`](../../../../referencia/.github/workflows/release.yml) completo.

- [ ] ¿Qué dispara el job `publicar`? ¿Y el job `desplegar` cuando se lanza a mano?
- [ ] ¿Qué permisos pide el workflow y para qué?
- [ ] ¿Qué comprueba el workflow **antes** de publicar la imagen?

## 1. Primera versión publicada

Anota un cambio en `CHANGELOG.md` (sección `1.2.0`, por ejemplo "Pipeline de despliegue") y
libera:

```bash
cd ~/biblioteca
git switch main && git pull
git commit -am "docs: changelog 1.2.0"        # por pull request si la regla de main lo exige
git tag -a v1.2.0 -m "Versión 1.2.0"
git push origin v1.2.0
```

En **Actions → Release**: el job `publicar` debe terminar en verde. El job `desplegar` también,
pero con dos advertencias: falta el deploy hook y falta la URL. Es lo esperado por ahora.

- [ ] Encuentra la imagen en tu perfil de GitHub → **Packages**. ¿Qué etiqueta tiene?
- [ ] ¿Existe una etiqueta `latest`? ¿Por qué el pipeline no la crea?

## 2. Hacer pública la imagen

En el paquete `biblioteca`: **Package settings → Change visibility → Public**. Compruébalo sin
sesión iniciada:

```bash
docker logout ghcr.io
docker pull ghcr.io/<tu-usuario>/biblioteca:1.2.0
```

- [ ] ¿Qué riesgo tendría publicar la imagen si tuviera un secreto adentro? (semana 5)

## 3. Servicio de Render desde la imagen

En la semana 4, Render construía desde el `Dockerfile`. Ahora desplegará la imagen ya probada.
Crea un servicio web **nuevo** en Render de tipo *Existing image* con:

| Campo | Valor |
|---|---|
| Imagen | `ghcr.io/<tu-usuario>/biblioteca:1.2.0` |
| Plan | Gratuito |
| Health check path | `/api/health` |
| Variable `DATABASE_URL` | La cadena de Neon (solo en el panel) |

O con Blueprint, cambiando `render.yaml`:

```yaml
    runtime: image
    image:
      url: ghcr.io/<tu-usuario>/biblioteca:1.2.0
```

(y quitando `rootDir` y `dockerfilePath`). Verifica con la prueba de humo contra la URL nueva.
Cuando funcione, suspende o borra el servicio anterior de la semana 4.

- [ ] ¿Qué versión reporta `/api/version`? ¿De dónde sale ahora ese valor?

## 4. Conectar el pipeline con Render

1. En Render, en el servicio: **Settings → Deploy Hook** → copia la URL. Es un secreto: quien la
   tenga puede desplegar.
2. En GitHub: **Settings → Environments → New environment** → `produccion`.
3. En ese ambiente:
   - Secreto `RENDER_DEPLOY_HOOK_URL` = la URL del deploy hook
   - Variable `PRODUCCION_URL` = `https://<tu-servicio>.onrender.com` (sin `/` al final)
   - *Required reviewers*: tu pareja (opcional, recomendado)

## 5. Despliegue continuo de punta a punta

Haz un cambio visible (por ejemplo, el título en `web/src/App.jsx`), actualiza `CHANGELOG.md` y
libera `v1.3.0` como en la parte 1.

- [ ] Si configuraste revisores, ¿qué pasó con el job `desplegar`? Apruébalo.
- [ ] Sigue los intentos del paso "Esperar la versión nueva": ¿cuántos hicieron falta?
- [ ] Cronometra: desde `git push origin v1.3.0` hasta la prueba de humo en verde en producción.

## 6. Rollback sin reconstruir

**Actions → Release → Run workflow** con la versión `1.2.0` (o `gh workflow run release.yml -f version=1.2.0`).

- [ ] ¿Se ejecutó el job `publicar`? ¿Por qué no hace falta?
- [ ] ¿Cuánto tardó el rollback comparado con el despliegue de la parte 5?
- [ ] Lanza el mismo workflow con la versión `9.9.9`. ¿En qué paso falla? ¿Se llamó a Render?

Vuelve a `1.3.0` al terminar.

## 7. Un despliegue que no pasa la verificación

Simula que alguien etiqueta un commit que no pasó por `main`: la regla protege la rama, no las
etiquetas.

```bash
git switch -c prueba/version-rota
sed -i 's/status_code=201)/status_code=200)/' api/app/main.py
git commit -am "fix: change create status code"
git tag -a v1.3.1 -m "Versión rota" && git push origin v1.3.1
git switch main
```

- [ ] ¿En qué job y paso se detuvo? ¿Llegó la versión rota a GHCR? ¿Y a producción?
- [ ] ¿Cómo evitarías que se etiquete un commit que no está en `main`? (Pista: reglas de
      etiquetas en *Rulesets*.)

Limpieza: `git push --delete origin v1.3.1 && git tag -d v1.3.1 && git branch -D prueba/version-rota`.

## ✅ Checklist

- [ ] Imagen versionada en GHCR publicada por el pipeline, sin `latest`
- [ ] Servicio de Render desplegado desde la imagen
- [ ] Ambiente `produccion` con el deploy hook como secreto
- [ ] Versión liberada con una etiqueta y verificada en producción, con tiempo medido
- [ ] Rollback por `workflow_dispatch` sin reconstruir, y versión inexistente rechazada
- [ ] Versión rota detenida antes de publicarse

Teoría relacionada: [`02-github-actions-y-ghcr.md`](../../1-teoria/02-github-actions-y-ghcr.md),
[`03-despliegue-y-rollback.md`](../../1-teoria/03-despliegue-y-rollback.md).
