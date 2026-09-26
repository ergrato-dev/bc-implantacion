# ✅ Lista de Verificación del Instructor

Lo que conviene comprobar **antes de cada curso**: los planes gratuitos, las versiones y las
imágenes cambian entre una cohorte y otra. Anota la fecha de cada verificación.

---

## 1. Dos semanas antes

### Entorno del aula

- [ ] Equipos de los aprendices con lo de [`setup-entorno.md`](setup-entorno.md) (RAM, disco,
      WSL2 en Windows, Docker funcionando)
- [ ] Imágenes precargadas para no saturar la red el día de cada práctica:

  ```bash
  bash scripts/precargar-imagenes.sh --guardar imagenes.tar   # una vez, en tu equipo
  docker load -i imagenes.tar                                 # en cada equipo, sin Internet
  ```

- [ ] La red del aula permite salir a Docker Hub, `ghcr.io`, `github.com`, los repositorios de
      Ubuntu (apt), PyPI y npm: los laboratorios construyen imágenes en clase
- [ ] Trivy (semana 8) descarga su base de vulnerabilidades en el primer uso: pruébalo una vez
      desde la red del aula

### App de referencia

- [ ] Arranca y pasa la prueba de humo:

  ```bash
  cd referencia && cp .env.example .env
  docker compose up -d --build --wait && bash scripts/smoke-test.sh
  docker compose down -v && rm .env
  ```

- [ ] `bash scripts/verificar-enlaces.sh` sin problemas

### Versiones

Consulta [endoflife.date](https://endoflife.date/) y anota la fecha. Si algún componente pierde
soporte **durante** el curso, actualízalo antes de empezar (y vuelve a probar la app):

| Componente | Dónde está fijado | Versión actual | Fin de soporte |
|---|---|---|---|
| Ubuntu Server | Laboratorios (`ubuntu:24.04`), teoría | 24.04 | |
| PostgreSQL | `postgres:17-alpine` en composes | 17 | |
| Python | `referencia/Dockerfile` (`python:3.13-slim`) | 3.13 | |
| Node.js | `referencia/Dockerfile` (`node:22-alpine`) | 22 | |
| `actions/checkout` | `referencia/.github/workflows/` | v7 | — |

### Planes gratuitos (semanas 4, 5 y 7)

Verifica en las páginas oficiales y actualiza la teoría 04 de la semana 4 si algo cambió:

- [ ] **Render** ([plan gratuito](https://render.com/docs/free)): sin tarjeta; suspensión por
      inactividad (15 min al 2026-09); horas mensuales (750); vencimiento del PostgreSQL gratuito
      (30 días)
- [ ] **Render con imagen** (semana 7, práctica 02): crea una vez un servicio web gratuito desde
      una imagen **pública** de GHCR y comprueba que despliega. Si el plan gratuito no lo permite,
      la práctica se hace hasta publicar en GHCR y el despliegue se practica en el servidor
      (práctica 03)
- [ ] **Neon** o **Supabase**: sin tarjeta; límites de almacenamiento y cómputo; pausa por
      inactividad
- [ ] **GitHub**: minutos de Actions para repositorios privados; GHCR gratuito para imágenes
      públicas

### Servidor del laboratorio (si hay VM)

- [ ] Una VM Ubuntu Server LTS por equipo (o compartida con cuentas por persona)
- [ ] Acceso SSH **por llave**; Docker y Compose instalados; salida a Internet para `apt` y
      `ghcr.io`
- [ ] Puertos disponibles para cada equipo (80/443 o alternativos)
- [ ] Ninguna IP, host ni credencial del laboratorio en el repositorio ni en los materiales
      publicados

### Evaluación

- [ ] Claves de respuesta de los cuestionarios y soluciones de `3-proyecto/` en un lugar
      **privado** (las carpetas `solution/` están excluidas del repositorio a propósito)

---

## 2. Antes de semanas puntuales

| Semana | Preparar |
|---|---|
| 4 | Recordar a los aprendices crear las cuentas (GitHub, Render, Neon) al inicio de la sesión |
| 7 | Probar `ci.yml` y `release.yml` en un repositorio de prueba; confirmar el punto de Render con imagen |
| 8 | Probar Dependabot en un repositorio de prueba: las versiones mayores que proponga cambian con el tiempo |
| 9 | **Gate**: parejas de equipos (quién instala a quién), observadores, tiempo máximo, servidores limpios, formato del [registro del simulacro](../bootcamp/week-09-aceptacion_y_entrega_formal/3-proyecto/starter/registro-del-simulacro.md) |
| 10 (opcional) | En macOS el laboratorio con systemd puede no funcionar: tener VM del laboratorio o Multipass como alternativa |

---

## 3. Al terminar el curso

- [ ] Borrar repositorios, paquetes de GHCR y servicios de prueba creados para verificar
- [ ] Anotar aquí lo que cambió (planes, versiones, prácticas que tardaron más de lo previsto)
      para la siguiente cohorte

| Fecha | Qué cambió | Qué se ajustó |
|---|---|---|
| | | |
