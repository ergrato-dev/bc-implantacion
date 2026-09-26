# Práctica 01 — Dependencias y Vulnerabilidades

<!-- 📝 Instrucción: práctica en parejas sobre ~/biblioteca (GitHub, con el CI de la semana 7) y
el laboratorio. Dependabot tarda unos minutos en abrir sus primeros pull requests: configúralo al
empezar y haz las partes 3 a 5 mientras tanto. -->

## Objetivo

Automatizar la detección de actualizaciones, auditar dependencias e imagen, y llevar una
corrección de seguridad hasta una versión liberada.

## Duración estimada

150 minutos.

## 1. Dependabot

Lee [`referencia/.github/dependabot.yml`](../../../../referencia/.github/dependabot.yml) y cópialo a
tu repositorio:

```bash
cd ~/biblioteca
git switch main && git pull
cp ~/bc-implantacion/referencia/.github/dependabot.yml .github/    # ajusta la ruta
git add .github/dependabot.yml && git commit -m "ci: add dependabot configuration"
```

Súbelo por *pull request* (la regla de `main` de la semana 7 lo exige). En GitHub:
**Settings → Code security** → activa *Dependabot alerts* y *Dependabot security updates*.

- [ ] ¿Por qué se ignoran las versiones mayores de `node`?

## 2. Los pull requests de Dependabot

Cuando aparezcan (pestaña *Pull requests*, autor `dependabot`), completa:

| # | Qué actualiza | Tipo (parche, menor, mayor) | ¿CI en verde? | Decisión y por qué |
|---|---|---|:---:|---|
| | | | | |

Reglas del equipo para decidir: teoría 02, sección 3. Si un *pull request* falla con
`ERESOLVE`, busca en el log qué versión de qué paquete exige: quizá depende de otro *pull
request* que hay que fusionar primero (después comenta `@dependabot rebase` en el que falló). Fusiona al menos un grupo de menores con CI
en verde. Si hay un salto mayor, lee sus notas de versión (enlace en el *pull request*) y anota
qué cambia.

## 3. Auditar un proyecto heredado

```bash
cd ~/bc-implantacion/bootcamp/week-08-mantenimiento_soporte_y_capacitacion/2-practicas/laboratorio   # ajusta la ruta
docker run --rm -v "$PWD/auditoria:/a:ro" python:3.13-slim sh -c \
  "pip install -q pip-audit && pip-audit -r /a/requirements-antiguo.txt --no-deps --disable-pip"
```

- [ ] ¿Cuántas vulnerabilidades hay y en qué paquetes?
- [ ] Para `requests`: ¿a qué versión mínima hay que subir para corregir todas?
- [ ] Subir `urllib3` de 1.26 a 2.x, ¿es parche, menor o mayor? ¿Qué riesgo tiene?

## 4. Auditar la app de referencia

Dependencias de Python y de Node:

```bash
cd ~/biblioteca
docker run --rm -v "$PWD/api:/api:ro" python:3.13-slim sh -c \
  "pip install -q pip-audit && pip-audit -r /api/requirements.txt"
docker run --rm -v "$PWD/web:/w:ro" -w /w -e npm_config_update_notifier=false node:22-alpine npm audit
docker run --rm -v "$PWD/web:/w:ro" -w /w -e npm_config_update_notifier=false node:22-alpine npm outdated
```

La imagen completa, con Trivy:

```bash
docker build -t biblioteca:auditoria .
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v trivy-cache:/root/.cache \
  aquasec/trivy image --severity HIGH,CRITICAL --ignore-unfixed biblioteca:auditoria
```

- [ ] ¿Trivy encontró algo que `pip-audit` no? Anota paquete, versión instalada y corregida.
- [ ] ¿Ese paquete está en `requirements.txt`? Encuentra de dónde viene:
      `docker run --rm --entrypoint sh biblioteca:auditoria -c 'find / -name "msgpack*" 2>/dev/null'`
- [ ] ¿La app usa ese paquete mientras atiende usuarios?

## 5. Corregir quitando lo que sobra

`pip` solo hace falta para **instalar** las dependencias, no para ejecutar la app. En tu
`Dockerfile`, cambia la línea de instalación por:

```dockerfile
RUN pip install --no-cache-dir -r requirements.txt && pip uninstall -y pip
```

Reconstruye, vuelve a escanear con Trivy y ejecuta la prueba de humo:

```bash
docker build -t biblioteca:auditoria .
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v trivy-cache:/root/.cache \
  aquasec/trivy image --severity HIGH,CRITICAL --ignore-unfixed biblioteca:auditoria
cp .env.example .env && APP_VERSION=auditoria docker compose up -d --no-build --wait
bash scripts/smoke-test.sh && docker compose down
```

- [ ] ¿Cuántos hallazgos quedan? ¿La app sigue funcionando?
- [ ] ¿Qué perderías sin `pip` en la imagen? ¿Te importa en producción?

## 6. Liberar la corrección

Sube el cambio por *pull request*, fusiona con CI en verde y libera una versión de **parche** con
el pipeline de la semana 7 (`git tag -a v1.3.1 ...`). Anota en `CHANGELOG.md`, sección
"Seguridad", qué se corrigió.

- [ ] ¿Por qué es parche y no menor?

## ✅ Checklist

- [ ] Dependabot configurado, con alertas y actualizaciones de seguridad activas
- [ ] Tabla de decisiones de los pull requests de Dependabot; al menos uno fusionado
- [ ] Auditoría del proyecto heredado con versiones mínimas seguras identificadas
- [ ] Hallazgo de Trivy rastreado hasta su origen
- [ ] Imagen corregida, escaneada de nuevo y liberada como versión de parche

Teoría relacionada: [`02-actualizaciones-y-dependencias.md`](../../1-teoria/02-actualizaciones-y-dependencias.md).
