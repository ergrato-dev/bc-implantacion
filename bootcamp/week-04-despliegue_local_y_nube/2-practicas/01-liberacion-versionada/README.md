# Práctica 01 — Liberar la Versión 1.0.0 y la 1.1.0

<!-- 📝 Instrucción: práctica en parejas. Cada pareja trabaja en SU copia de la app de
referencia (fork o carpeta copiada con git init), porque va a crear etiquetas. -->

## Objetivo

Producir dos versiones liberadas de la app de referencia —etiqueta Git, imagen con versión y
notas de versión— listas para desplegar en las prácticas 02 y 03.

## Duración estimada

120 minutos.

## Preparación

Copia la app de referencia a un repositorio propio:

```bash
cp -r bc-implantacion/referencia ~/biblioteca
cd ~/biblioteca
rm -rf web/node_modules .env .github     # los workflows y Dependabot se agregan en las semanas 7 y 8
git init -b main && git add . && git commit -m "chore: import reference app"
```

Crea un repositorio vacío en tu cuenta de GitHub llamado `biblioteca` y súbelo
(`git remote add origin ...` y `git push -u origin main`): lo necesitas en la práctica 03.

Prueba que funciona en local:

```bash
cp .env.example .env
docker compose up -d --build --wait
bash scripts/smoke-test.sh
docker compose down
```

## 1. Liberar 1.0.0

```bash
docker build -t biblioteca:1.0.0 --build-arg APP_VERSION=1.0.0 .
git tag -a v1.0.0 -m "Versión 1.0.0: catálogo de libros"
git push origin v1.0.0
```

Crea `CHANGELOG.md` con la entrada de la versión:

```markdown
# Registro de cambios

## 1.0.0 — <fecha>

### Agregado
- Catálogo de libros: listar y agregar
- Healthcheck en /api/health
```

- [ ] `docker image ls biblioteca` muestra la etiqueta `1.0.0`
- [ ] `git tag --list` muestra `v1.0.0`

## 2. Un cambio para la siguiente versión

Haz dos cambios:

1. Nueva migración `api/migrations/002_indice_titulo.sql`:

   ```sql
   -- Migración 002: índice para búsquedas por título.
   CREATE INDEX idx_libros_titulo ON libros (titulo);
   ```

2. En `web/src/App.jsx`, cambia `<h1>Biblioteca</h1>` por `<h1>Biblioteca Municipal</h1>`.

Haz commit con Conventional Commits.

## 3. Decidir el número de versión

- [ ] ¿Es `1.0.1`, `1.1.0` o `2.0.0`? Justifica con las reglas de SemVer.

Respuesta esperada: `1.1.0` — agrega funcionalidad (índice, cambio visible) sin romper nada.

## 4. Liberar 1.1.0

```bash
docker build -t biblioteca:1.1.0 --build-arg APP_VERSION=1.1.0 .
git tag -a v1.1.0 -m "Versión 1.1.0: índice por título y nuevo nombre"
git push origin v1.1.0
```

Agrega la entrada al `CHANGELOG.md` **con la sección "Al actualizar"**: ¿qué migración se aplica?
¿Se puede volver a 1.0.0 sin restaurar la base? ¿Por qué?

## 5. Probar la imagen antes de desplegarla

Levanta la imagen `1.1.0` con la base de desarrollo y ejecuta la prueba de humo:

```bash
sed -i 's/^APP_VERSION=.*/APP_VERSION=1.1.0/' .env
docker compose up -d --wait
bash scripts/smoke-test.sh
docker compose down -v
```

La línea `INFO versión desplegada` debe decir `1.1.0`.

## 6. Pregunta de análisis

¿Por qué no se usa la etiqueta `latest` para desplegar? Da un escenario concreto en el que
`latest` cause un problema en producción.

## ✅ Checklist

- [ ] Dos versiones liberadas: etiquetas Git publicadas e imágenes locales
- [ ] `CHANGELOG.md` con ambas versiones y la sección "Al actualizar"
- [ ] Versión 1.1.0 justificada con SemVer
- [ ] Prueba de humo en verde con la imagen 1.1.0

Teoría relacionada: [`01-liberacion-del-software.md`](../../1-teoria/01-liberacion-del-software.md).
