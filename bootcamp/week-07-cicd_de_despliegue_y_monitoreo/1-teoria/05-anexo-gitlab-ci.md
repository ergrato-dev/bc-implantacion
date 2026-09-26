# Anexo — El Mismo Pipeline en GitLab CI

## 🎯 Objetivos

- Traducir los conceptos de GitHub Actions a GitLab CI
- Leer un `.gitlab-ci.yml` equivalente al de la app de referencia
- Reconocer qué cambia al usar un runner institucional

## 📋 Contenido

### 1. Por qué este anexo

Algunas instituciones y empresas usan GitLab (en la nube o instalado en sus servidores) con
**runners propios**. Los conceptos son los mismos de la teoría 01; cambia la sintaxis.

### 2. Equivalencias

| GitHub Actions | GitLab CI |
|---|---|
| `.github/workflows/*.yml` (varios archivos) | `.gitlab-ci.yml` (uno, con `include:` opcional) |
| `on:` | `rules:` / `workflow:rules` por job |
| Job con `needs:` | `stages:` en orden + `needs:` opcional |
| `runs-on: ubuntu-24.04` | `tags:` que eligen un runner |
| `secrets.X` / `vars.X` | Variables CI/CD (*masked*, *protected*) |
| `GITHUB_TOKEN` + GHCR | `CI_JOB_TOKEN` / `CI_REGISTRY_*` + GitLab Container Registry |
| `environment: produccion` | `environment: name: produccion` |
| `workflow_dispatch` con entradas | Pipeline manual con variables, o `when: manual` |
| `if: failure()` | `when: on_failure` |

### 3. Runner institucional

Un **runner** es un proceso que toma trabajos de GitLab y los ejecuta en una máquina. Con un
runner institucional:

- El **executor** define dónde corren los comandos. Con `shell` sobre una máquina con Docker, los
  comandos son los mismos de GitHub Actions. Con `docker` (cada job en un contenedor) se necesita
  *Docker-in-Docker* o una herramienta como Kaniko o Buildah para construir imágenes.
- Los **tags** del job deben coincidir con los del runner (los define quien lo administra).
- El runner vive dentro de la red institucional: **puede** llegar a la VM Ubuntu del laboratorio
  por SSH, algo que un runner de GitHub no puede. Eso habilita el despliegue por empuje.
- Lo comparten muchos proyectos: nada de secretos en archivos del runner, y limpiar al terminar.

### 4. Ejemplo

[`2-practicas/anexo-gitlab-ci/.gitlab-ci.yml`](../2-practicas/anexo-gitlab-ci/.gitlab-ci.yml)
reproduce `ci.yml` + `release.yml` para un runner con executor `shell` y Docker:

| Job | Stage | Cuándo | Equivale a |
|---|---|---|---|
| `prueba-de-humo` | `prueba` | Ramas y *merge requests* | `ci.yml` |
| `publicar` | `publicar` | Etiqueta `vX.Y.Z` | Job `publicar` de `release.yml` |
| `desplegar-servidor` | `desplegar` | Etiqueta, con aprobación manual | `desplegar.sh` por SSH en la VM (empuje) |

### 5. Aplicación al proyecto real

Si tu institución usa GitLab, adapta el ejemplo con los tags del runner y las variables CI/CD
de tu proyecto. Si no, basta con reconocer las equivalencias.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
