# Práctica 02 — Healthchecks y Pruebas Posteriores al Despliegue

<!-- 📝 Instrucción: práctica en parejas sobre el laboratorio. En el paso 5 cada pareja agrega
una verificación propia a la prueba de humo de SU copia (~/biblioteca). -->

## Objetivo

Observar cómo reacciona el healthcheck ante la caída de una dependencia, ampliar la prueba de
humo y ejecutar casos funcionales.

## Duración estimada

120 minutos.

## Preparación

```bash
cd ../laboratorio
docker compose up -d --build --wait
docker compose ps
```

## 1. Estado de salud

```bash
docker inspect --format '{{json .State.Health}}' lab-s05-app-1
```

Ubica en el `Dockerfile` de la app de referencia la instrucción `HEALTHCHECK` y relaciona cada
parámetro (`interval`, `timeout`, `start-period`, `retries`) con lo que ves.

## 2. Caída de la base de datos

En una terminal, observa el estado cada 5 segundos:

```bash
watch -n 5 docker compose ps app
```

En otra, detén la base a la que apunta la app:

```bash
docker compose stop origen
curl -i http://localhost:8000/api/health
```

Espera alrededor de 40 segundos.

- [ ] ¿Qué código HTTP devuelve `/api/health`? ¿Qué muestra `docker compose ps`?
- [ ] ¿Docker reinició el contenedor de la app? ¿Por qué no?
- [ ] ¿Serviría de algo reiniciarlo?

Vuelve a arrancar la base y observa cómo la app regresa sola a `healthy`:

```bash
docker compose start origen
```

## 3. Prueba de humo

```bash
bash ../../../../referencia/scripts/smoke-test.sh
```

Léela y responde:

- [ ] ¿Por qué incluye casos que **deben** fallar (`409`, `422`)?
- [ ] ¿Cómo evita dejar datos basura o chocar con datos existentes?

Ejecútala con la base detenida y anota qué pruebas fallan.

## 4. Casos funcionales

Abre <http://localhost:8000> y ejecuta:

| ID | Caso | Pasos | Resultado esperado | Obtenido |
|---|---|---|---|---|
| F-01 | Agregar libro válido | Llenar los 4 campos, "Agregar libro" | Aparece en la tabla | |
| F-02 | ISBN duplicado | Repetir un ISBN existente | Mensaje "ya existe un libro con ese ISBN" | |
| F-03 | Año fuera de rango | Año `1200` | Mensaje de datos inválidos, no se agrega | |
| F-04 | Persistencia | Recargar la página | Los libros siguen | |
| F-05 | Persistencia tras reinicio | `docker compose restart app` y recargar | Los libros siguen | |
| F-06 | Versión visible | Revisar el encabezado | Muestra la versión desplegada | |

Agrega dos casos propios.

## 5. Ampliar la prueba de humo (en `~/biblioteca`)

Agrega a `scripts/smoke-test.sh` una verificación nueva, por ejemplo:

- que `/api/libros` devuelva un JSON que empiece por `[`
- que `/api/version` no sea `dev` (en un servidor nunca debería estar sin versión)
- que el encabezado `Content-Type` de `/api/health` sea `application/json`

Pruébala en verde y **en rojo** (provoca la condición que debe detectar).

## 6. Lista posterior al despliegue

Con la lista de la teoría 03, redacta la lista de verificación posterior al despliegue de la app
de referencia en el servidor de la semana 4.

## 7. Limpieza

```bash
docker compose down
```

(Sin `-v`: los datos se usan en la práctica 03.)

## ✅ Checklist

- [ ] Observé y expliqué el paso de `healthy` a `unhealthy` y de vuelta
- [ ] Expliqué por qué Docker no reinicia un contenedor `unhealthy`
- [ ] Ejecuté los casos funcionales y agregué dos propios
- [ ] Amplié la prueba de humo y la vi fallar cuando debía
- [ ] Redacté la lista posterior al despliegue

Teoría relacionada: [`03-healthchecks-y-pruebas.md`](../../1-teoria/03-healthchecks-y-pruebas.md).
