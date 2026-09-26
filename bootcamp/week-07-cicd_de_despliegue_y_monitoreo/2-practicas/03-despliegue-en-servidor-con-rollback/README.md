# Práctica 03 — Despliegue en Servidor con Rollback Automático

<!-- 📝 Instrucción: práctica en parejas sobre el laboratorio. Una persona hace de "pipeline"
(construye y publica versiones en el registro) y la otra de operador del servidor (despliega).
Con la VM Ubuntu del laboratorio, el procedimiento es el mismo en /opt/biblioteca, con el
registro GHCR en lugar del local. -->

## Objetivo

Desplegar versiones en el servidor trayéndolas de un registro (arrastre), con respaldo,
migración, verificación y rollback automático, y provocar los tres tipos de fallo que el script
debe atrapar.

## Duración estimada

120 minutos.

## Preparación

```bash
cd ../laboratorio
cp .env.example .env
docker compose up -d --wait registro db kuma alertas
cp ../../../../referencia/deploy/desplegar.sh ../../../../referencia/scripts/smoke-test.sh .
```

Lee [`desplegar.sh`](../../../../referencia/deploy/desplegar.sh) completo.

- [ ] ¿Qué pasos corren **antes** de que la versión nueva atienda usuarios?
- [ ] ¿Qué hace `trap ... ERR` y por qué se desactiva antes del paso 4?
- [ ] ¿Por qué el script **no** exporta las variables de `.env`? (Lee el comentario.)

## 1. El "pipeline" publica dos versiones

Hace el papel del job `publicar` de `release.yml`, con el registro local en lugar de GHCR:

```bash
publicar() {   # $1 versión, $2 carpeta del código
  docker build -q --build-arg APP_VERSION="$1" -t "localhost:5000/biblioteca:$1" "$2" \
    && docker push -q "localhost:5000/biblioteca:$1"
}
publicar 1.0.0 ../../../../referencia
publicar 1.1.0 ../../../../referencia
curl -s http://localhost:5000/v2/biblioteca/tags/list
```

`publicar` es una función de esta terminal: si abres otra, vuelve a definirla.

## 2. Instalar 1.0.0

```bash
docker compose up -d --wait app
bash smoke-test.sh
```

## 3. Actualizar a 1.1.0

```bash
bash desplegar.sh 1.1.0
cat despliegues.log
ls respaldos/
grep APP_VERSION .env
```

- [ ] ¿Cuánto tardó? ¿Cuántos segundos estuvo la app sin responder? Mídelo en otra terminal con
      `while true; do curl -s -o /dev/null -w "%{http_code} " localhost:8000/api/health; sleep 0.5; done`
      mientras repites el despliegue con `bash desplegar.sh 1.0.0` y luego `bash desplegar.sh 1.1.0`.

## 4. Fallo 1: la versión no existe

```bash
bash desplegar.sh 9.9.9; echo "código de salida: $?"
tail -2 despliegues.log
curl -s localhost:8000/api/version
```

## 5. Fallo 2: una migración rota

En tu copia `~/biblioteca`, agrega una migración que falla y publícala como `1.2.0`:

```bash
echo "SELECT 1/0;" > ~/biblioteca/api/migrations/099_rota.sql
publicar 1.2.0 ~/biblioteca
rm ~/biblioteca/api/migrations/099_rota.sql
bash desplegar.sh 1.2.0; echo "código de salida: $?"
tail -2 despliegues.log
curl -s localhost:8000/api/version
```

- [ ] ¿En qué paso se detuvo? ¿La app dejó de responder en algún momento?
- [ ] ¿Quedó la migración a medias en la base? Revisa `schema_migrations`:
      `docker compose exec db psql -U biblioteca -d biblioteca -c "SELECT * FROM schema_migrations"`

## 6. Fallo 3: una regresión

Publica como `1.3.0` una versión que devuelve `200` en lugar de `201` al crear un libro:

```bash
sed -i 's/status_code=201)/status_code=200)/' ~/biblioteca/api/app/main.py
publicar 1.3.0 ~/biblioteca
git -C ~/biblioteca checkout -- api/app/main.py
bash desplegar.sh 1.3.0; echo "código de salida: $?"
tail -3 despliegues.log
```

- [ ] ¿Qué detectó el fallo? ¿La versión rota llegó a atender usuarios? ¿Cuánto tiempo?
- [ ] ¿Qué datos pudo haber escrito la versión rota mientras estuvo arriba?

## 7. Rollback manual

Supón que 1.1.0 tiene un error que la prueba de humo no detecta y hay que volver a 1.0.0:

```bash
bash desplegar.sh 1.0.0
```

- [ ] ¿Por qué el rollback manual es "desplegar la versión anterior" y no un comando especial?
- [ ] ¿Qué harías si la 1.1.0 hubiera traído una migración que la 1.0.0 no soporta? (teoría 03,
      sección 5)

Deja la app en `1.1.0` para la práctica 04.

## 8. En la VM del laboratorio

Escribe los pasos para usar este mismo procedimiento en `/opt/biblioteca` con GHCR:

- [ ] ¿Qué cambia en `.env` (`IMAGEN`, `URL_APP`)?
- [ ] ¿Quién ejecuta `desplegar.sh` y con qué permisos? (Semana 6: el grupo `docker` equivale a
      `root`.)
- [ ] ¿Cómo se entera el operador de que hay una versión nueva que desplegar?

## ✅ Checklist

- [ ] Dos versiones publicadas en el registro y desplegadas con `desplegar.sh`
- [ ] Tiempo sin servicio medido durante un despliegue
- [ ] Versión inexistente, migración rota y regresión detenidas, con la app anterior en servicio
- [ ] `despliegues.log` y respaldos previos a cada despliegue revisados
- [ ] Rollback manual ejecutado y pasos para la VM escritos

Teoría relacionada: [`03-despliegue-y-rollback.md`](../../1-teoria/03-despliegue-y-rollback.md).
