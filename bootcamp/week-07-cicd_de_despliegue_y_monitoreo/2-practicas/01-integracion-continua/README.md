# Práctica 01 — Integración Continua con GitHub Actions

<!-- 📝 Instrucción: práctica en parejas sobre el repositorio ~/biblioteca de la semana 4 (en
GitHub). Si el repositorio es privado, las ejecuciones consumen minutos de la cuota gratuita
(cerca de un minuto cada una); si es público, no. -->

## Objetivo

Hacer que cada cambio de la app se construya y se pruebe solo, y que un cambio que rompe la
prueba de humo no pueda llegar a `main`.

## Duración estimada

150 minutos.

## Preparación

Trae los workflows de la app de referencia a tu repositorio:

```bash
cd ~/biblioteca
git pull
cp -r ~/bc-implantacion/referencia/.github .      # ajusta la ruta a tu copia del bootcamp
ls .github/workflows
```

Lee [`ci.yml`](../../../../referencia/.github/workflows/ci.yml) completo antes de seguir.

- [ ] ¿Qué eventos lo disparan? ¿Qué permisos tiene su token?
- [ ] ¿Qué paso solo corre si algo falló? ¿Para qué sirve?

## 1. Primera ejecución

`release.yml` también se copió; no hace nada hasta que publiques una etiqueta nueva (práctica 02).

```bash
git add .github
git commit -m "ci: add build and smoke test workflow"
git push
```

En GitHub, pestaña **Actions**: abre la ejecución de `CI` y recorre cada paso.

- [ ] ¿Cuánto tardó? ¿Qué paso tomó más tiempo?
- [ ] Busca en el log la línea `RESULTADO:` de la prueba de humo.

Con la CLI de GitHub (opcional): `gh run list` y `gh run watch`.

## 2. Proteger `main`

En el repositorio: **Settings → Rules → Rulesets → New branch ruleset** (o **Branches → Add
rule**, según tu interfaz):

- Rama objetivo: `main`
- Exigir *pull request* antes de fusionar
- Exigir que pase el check `prueba-de-humo`

## 3. Un cambio que rompe

Crea una rama y cambia el código de respuesta al crear un libro:

```bash
git switch -c fix/codigo-creacion
sed -i 's/status_code=201)/status_code=200)/' api/app/main.py
git commit -am "fix: change create status code"
git push -u origin fix/codigo-creacion
```

Abre un *pull request* hacia `main`.

- [ ] ¿Qué check falló? Copia la línea `FALLA` del log.
- [ ] ¿Te deja fusionar? ¿Qué regla lo impide?
- [ ] ¿Quién habría detectado este error sin el pipeline, y cuándo?

## 4. Arreglarlo en la misma rama

Revierte el cambio, haz *push* a la misma rama y observa cómo el *pull request* se vuelve a
probar solo. Cuando esté en verde, fusiónalo (o ciérralo, ya que no cambia nada).

## 5. Leer un fallo de construcción

En otra rama, rompe el `Dockerfile` (por ejemplo, cambia `requirements.txt` por
`requirements.tx`) y abre otro *pull request*.

- [ ] ¿En qué paso falla ahora? ¿Se ejecutó la prueba de humo? ¿Por qué?

Cierra el *pull request* sin fusionar y borra la rama.

## 6. Insignia de estado

Agrega al `README.md` de tu repositorio la insignia del workflow (Actions → CI → `…` →
*Create status badge*).

## ✅ Checklist

- [ ] `ci.yml` en tu repositorio con una ejecución en verde
- [ ] Regla en `main` que exige el check `prueba-de-humo`
- [ ] *Pull request* con regresión detenido por el pipeline, con la línea `FALLA` identificada
- [ ] Fallo de construcción identificado
- [ ] Insignia de estado en el README

Teoría relacionada: [`01-ci-cd-orientado-a-despliegue.md`](../../1-teoria/01-ci-cd-orientado-a-despliegue.md),
[`02-github-actions-y-ghcr.md`](../../1-teoria/02-github-actions-y-ghcr.md).
