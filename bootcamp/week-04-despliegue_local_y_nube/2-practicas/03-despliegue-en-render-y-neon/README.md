# Práctica 03 — Desplegar en Render con PostgreSQL en Neon

<!-- 📝 Instrucción: práctica individual o en parejas. Requiere cuentas gratuitas en GitHub,
Render y Neon (o Supabase). Ninguna exige tarjeta de crédito en el plan gratuito al momento de
escribir esta guía; si eso cambia, el instructor define una alternativa. Las pantallas de los
proveedores cambian con frecuencia: si un botón no coincide, busca la opción equivalente en su
documentación. -->

## Objetivo

Desplegar la app de referencia en un PaaS con base de datos gestionada, usando la misma imagen
(Dockerfile) que en el servidor local y configurando todo por variables de entorno.

## Duración estimada

150 minutos.

## Preparación

- Tu repositorio `biblioteca` en GitHub (práctica 01), con `render.yaml` en la raíz.
- Mueve el Blueprint a la raíz y ajusta la ruta, porque en tu repositorio la app **es** la raíz:

  ```bash
  cd ~/biblioteca
  git mv deploy/render.yaml render.yaml
  sed -i 's/^    rootDir: referencia$/    rootDir: ./' render.yaml
  git commit -m "chore: move render blueprint to repo root" && git push
  ```

## 1. Base de datos en Neon

1. Crea una cuenta en Neon y un proyecto nuevo. Elige la región más cercana a la región que
   usarás en Render.
2. Copia la **cadena de conexión** (*connection string*). Tiene esta forma:

   ```
   postgresql://usuario:clave@ep-xxxx.region.aws.neon.tech/neondb?sslmode=require
   ```

3. **No** la pegues en el repositorio, en un chat ni en un documento compartido: contiene la
   contraseña.

- [ ] ¿Por qué la cadena incluye `sslmode=require`?

## 2. Servicio en Render

1. Crea una cuenta en Render e inicia sesión con GitHub.
2. Crea un **Blueprint** desde tu repositorio `biblioteca`: Render lee `render.yaml`.
3. Cuando pida `DATABASE_URL`, pega la cadena de conexión de Neon.
4. Espera a que termine la construcción. Revisa los **logs**: debe aparecer
   `Migración aplicada: 001_libros`.

Render asigna una URL del tipo `https://biblioteca-xxxx.onrender.com`.

## 3. Verificar

```bash
bash scripts/smoke-test.sh https://biblioteca-xxxx.onrender.com
```

Abre la URL en el navegador y agrega un libro.

- [ ] ¿Qué versión reporta? ¿De dónde sale ese valor?
- [ ] ¿Quién emitió el certificado HTTPS? (candado del navegador)

## 4. Suspensión por inactividad

Espera sin usar la app el tiempo de inactividad del plan gratuito (consúltalo en la
documentación de Render) y mide la primera petición:

```bash
time curl -s https://biblioteca-xxxx.onrender.com/api/health
time curl -s https://biblioteca-xxxx.onrender.com/api/health
```

- [ ] ¿Cuánto tardó la primera? ¿Y la segunda? ¿Qué implica para un usuario real?

## 5. Nueva versión

Cambia `APP_VERSION` a `1.1.0` en `render.yaml` (o en el panel de Render), haz commit y push de
tu versión 1.1.0 si no lo hiciste. Render vuelve a desplegar. Verifica con la prueba de humo.

- [ ] ¿Cómo harías rollback en Render? Busca en su documentación la opción de volver a un
      despliegue anterior y compárala con el rollback de la práctica 02.

## 6. Datos en la base gestionada

En la consola SQL de Neon:

```sql
SELECT * FROM schema_migrations;
SELECT count(*) FROM libros;
```

¿Qué ofrece el plan gratuito de Neon para respaldos o restauración a un punto en el tiempo? Anota
el dato y su fuente: lo usarás en el plan de respaldo.

## 7. Cierre

Deja el servicio desplegado hasta la semana 5 (allí migrarás datos hacia Neon). Si prefieres
detenerlo, suspéndelo desde el panel; no borres la base.

## ✅ Checklist

- [ ] App desplegada en Render con base en Neon, prueba de humo en verde
- [ ] `DATABASE_URL` configurada solo en el panel, nunca en el repositorio
- [ ] Arranque en frío medido y explicado
- [ ] Nueva versión desplegada y método de rollback identificado
- [ ] Capacidad de respaldo del plan gratuito documentada con su fuente

Teoría relacionada: [`03-cloud-computing.md`](../../1-teoria/03-cloud-computing.md),
[`04-costos-y-free-tier.md`](../../1-teoria/04-costos-y-free-tier.md).
