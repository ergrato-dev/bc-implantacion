# Práctica 01 — Configuración por Ambiente

<!-- 📝 Instrucción: práctica en parejas sobre el laboratorio y sobre la copia de la app de
referencia de la semana 4 (~/biblioteca). -->

## Objetivo

Controlar la configuración de la app solo con variables de entorno, entender su precedencia en
Docker Compose y hacer que la app falle rápido y con un mensaje claro.

## Duración estimada

120 minutos.

## Preparación

```bash
cd ../laboratorio
cp .env.example .env
docker compose up -d --build --wait
```

## 1. Ver la configuración resuelta

```bash
docker compose config app
```

- [ ] ¿Qué valor tiene `DATABASE_URL`? ¿De qué archivo salió?
- [ ] ¿Por qué no deberías pegar esta salida en un chat o en un issue?

## 2. Precedencia

```bash
DATABASE_URL=postgresql://prueba:prueba@otro:5432/otra docker compose config app | grep DATABASE_URL
```

Crea `.env.pruebas` con otra `DATABASE_URL` y compara:

```bash
docker compose --env-file .env.pruebas config app | grep DATABASE_URL
```

- [ ] Ordena de mayor a menor prioridad: terminal, `.env`, `--env-file`.
- [ ] ¿`--env-file` se suma a `.env` o lo reemplaza? Demuéstralo.

## 3. Variable obligatoria

Renombra temporalmente `.env` y ejecuta `docker compose config`:

```bash
mv .env .env.bak && docker compose config; mv .env.bak .env
```

Ubica en `compose.yaml` la sintaxis que produce ese mensaje.

## 4. La app sin configuración

Ejecuta la imagen sin variables:

```bash
docker run --rm biblioteca:lab-s05
```

Y con una base inexistente:

```bash
docker run --rm -e DATABASE_URL=postgresql://x:y@no-existe:5432/z biblioteca:lab-s05
```

- [ ] ¿Arrancó en algún caso? ¿Es un buen comportamiento?
- [ ] ¿El mensaje del primer caso le sirve a quien instala? ¿Qué le falta?

## 5. Mejorar el mensaje (en `~/biblioteca`)

En tu copia de la app, cambia la lectura de `DATABASE_URL` en `api/app/main.py` para que, si falta,
el proceso termine con un mensaje claro en español en lugar de un `KeyError`. Pista: `sys.exit()`
con un texto termina el proceso con código `1` y muestra el texto.

Reconstruye y comprueba:

```bash
cd ~/biblioteca
docker build -t biblioteca:dev .
docker run --rm biblioteca:dev; echo "código de salida: $?"
```

## 6. Rotación de logs

Revisa la configuración de logs del contenedor de la app del laboratorio:

```bash
docker inspect --format '{{json .HostConfig.LogConfig}}' lab-s05-app-1
```

Compárala con `referencia/deploy/compose.prod.yaml` (bloque `x-logging`).

- [ ] ¿Qué pasaría en seis meses con la configuración del laboratorio en un servidor real?

## 7. Inventario de configuración

Completa para la app de referencia:

| Variable | ¿Secreto? | Desarrollo | Servidor | Nube | Si falta… |
|---|:---:|---|---|---|---|
| `DATABASE_URL` | | | | | |
| `APP_VERSION` | | | | | |
| `PORT` | | | | | |

## ✅ Checklist

- [ ] Expliqué la precedencia de variables con evidencia
- [ ] Probé el comportamiento con variable faltante y con base inexistente
- [ ] Mejoré el mensaje de error de la app y lo comprobé con el código de salida
- [ ] Identifiqué el riesgo de logs sin rotación
- [ ] Completé el inventario de configuración

Teoría relacionada: [`01-configuracion-por-ambientes.md`](../../1-teoria/01-configuracion-por-ambientes.md),
[`02-servicios-requeridos.md`](../../1-teoria/02-servicios-requeridos.md).
