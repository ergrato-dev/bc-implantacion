# GitHub Actions y GHCR

## 🎯 Objetivos

- Leer la estructura de un workflow: eventos, jobs, pasos y permisos
- Usar secretos, variables y ambientes de GitHub
- Publicar imágenes versionadas en GitHub Container Registry (GHCR)
- Leer los workflows `ci.yml` y `release.yml` de la app de referencia

## 📋 Contenido

### 1. Anatomía de un workflow

Un workflow es un archivo YAML en `.github/workflows/` del repositorio.

```yaml
name: CI                         # nombre visible en la pestaña Actions
on:                              # eventos que lo disparan
  push:
    branches: [main]
  pull_request:
permissions:
  contents: read                 # permisos del token automático: los mínimos
jobs:
  prueba-de-humo:                # un job = una máquina virtual nueva
    runs-on: ubuntu-24.04
    timeout-minutes: 15
    steps:
      - uses: actions/checkout@v7          # acción reutilizable: descarga el código
      - run: docker compose up -d --build --wait    # comando de shell
      - run: bash scripts/smoke-test.sh
```

| Concepto | Qué es |
|---|---|
| **Evento** (`on`) | `push`, `pull_request`, etiquetas, horario (`schedule`), a mano (`workflow_dispatch`) |
| **Job** | Conjunto de pasos en una máquina limpia; los jobs corren en paralelo salvo `needs` |
| **Paso** | Un comando (`run`) o una acción (`uses`) |
| **Runner** | La máquina que ejecuta el job: de GitHub (gratis con límites) o propia |
| **Artefacto** | Archivo que un job guarda para otro job o para descargar |

Los runners de GitHub traen Docker y Compose: el mismo `docker compose up` de tu equipo funciona
igual en el pipeline.

### 2. Secretos, variables y ambientes

| Tipo | Dónde se configura | Cómo se usa | Visible en los logs |
|---|---|---|:---:|
| `GITHUB_TOKEN` | Automático, por ejecución | `${{ secrets.GITHUB_TOKEN }}` | ❌ (enmascarado) |
| Secreto | Settings → Secrets and variables | `${{ secrets.NOMBRE }}` | ❌ |
| Variable | Settings → Secrets and variables | `${{ vars.NOMBRE }}` | ✅ |
| Ambiente | Settings → Environments | `environment: produccion` en el job | — |

Un **ambiente** tiene sus propios secretos y variables, y reglas: revisores obligatorios,
ramas o etiquetas permitidas, tiempo de espera. Los secretos de un ambiente solo los ve el job
que declara ese ambiente.

`permissions:` limita lo que puede hacer `GITHUB_TOKEN`. Por defecto se da solo lectura y se
agrega lo necesario (por ejemplo `packages: write` para publicar en GHCR).

### 3. GHCR

GitHub Container Registry guarda imágenes junto al repositorio:
`ghcr.io/<usuario-u-organización>/<imagen>:<etiqueta>`.

```bash
echo "$GITHUB_TOKEN" | docker login ghcr.io -u <usuario> --password-stdin
docker push ghcr.io/<usuario>/biblioteca:1.2.0
```

- El nombre debe ir en **minúsculas**: el workflow usa `${GITHUB_REPOSITORY_OWNER,,}`.
- Las imágenes nacen **privadas**. Para que Render las descargue sin credenciales, el paquete se
  hace público (Package settings → Change visibility). Si el código es privado, se configuran
  credenciales del registro en Render en su lugar.
- Imágenes públicas: gratis. Privadas: con cuota gratuita de almacenamiento y transferencia.

### 4. Los workflows de la app de referencia

| Archivo | Evento | Qué hace |
|---|---|---|
| [`ci.yml`](../../../referencia/.github/workflows/ci.yml) | *push* a `main` y *pull requests* | Construye, levanta app + base, prueba de humo |
| [`release.yml`](../../../referencia/.github/workflows/release.yml) | Etiqueta `vX.Y.Z` | Construye con la versión, prueba **esa** imagen, publica en GHCR, despliega en Render y verifica |
| (mismo) | `workflow_dispatch` con una versión | Rollback: despliega una versión ya publicada sin reconstruir |

Detalles que vale la pena leer en `release.yml`:

- `concurrency`: nunca dos despliegues a la vez.
- `if: failure()`: los logs de los contenedores solo se imprimen si algo falló.
- `needs` + `if: !cancelled() && ...`: el job de despliegue corre después de publicar, o solo
  cuando se lanza a mano.
- `docker manifest inspect`: comprueba que la versión existe antes de pedir el despliegue.
- La verificación espera a que producción responda la versión nueva y luego corre la prueba de
  humo contra la URL pública.

### 5. Proteger la rama principal

Settings → Branches (o *Rulesets*) → regla para `main`:

- Exigir *pull request* antes de fusionar.
- Exigir que el check `prueba-de-humo` pase.

Así ningún cambio que rompa la prueba de humo llega a `main`, y ninguna etiqueta se crea sobre un
código roto.

### 6. Costos

En repositorios **públicos**, los runners estándar de GitHub son gratuitos. En privados hay una
cuota mensual de minutos gratis. Cada ejecución de `ci.yml` de la app de referencia tarda cerca
de un minuto.

### 7. Aplicación al proyecto real

Adapta `ci.yml` y `release.yml` a tu proyecto: nombre de la imagen, comando de pruebas, URL de
producción, secretos y reglas del ambiente `produccion`.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
