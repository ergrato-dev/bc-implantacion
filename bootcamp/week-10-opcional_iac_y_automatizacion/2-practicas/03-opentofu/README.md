# Práctica 03 — OpenTofu: la App como Infraestructura

<!-- 📝 Instrucción: práctica individual o en parejas. No requiere cuentas: el proveedor es el
Docker del propio equipo. OpenTofu corre en un contenedor, no hace falta instalarlo. -->

## Objetivo

Crear, cambiar y destruir la infraestructura de la app de referencia desde código, leyendo cada
plan antes de aplicarlo, y proteger los datos de una destrucción accidental.

## Duración estimada

120 minutos.

## Preparación

La imagen de la app debe existir en tu equipo:

```bash
cd ../laboratorio/opentofu
docker build -t biblioteca:1.0.0 --build-arg APP_VERSION=1.0.0 ../../../../../referencia
docker build -t biblioteca:1.1.0 --build-arg APP_VERSION=1.1.0 ../../../../../referencia
```

OpenTofu en un contenedor, como una función de tu terminal (con tus permisos sobre la carpeta y
acceso al Docker local):

```bash
tofu() {
  docker run --rm -it --user "$(id -u):$(id -g)" --group-add "$(stat -c %g /var/run/docker.sock)" \
    -e HOME=/iac/.home -e TF_VAR_postgres_password \
    -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD:/iac" -w /iac \
    ghcr.io/opentofu/opentofu:latest "$@"
}
tofu version
```

La contraseña de la base llega por variable de entorno, sin quedar en el historial:

```bash
read -rs TF_VAR_postgres_password && export TF_VAR_postgres_password
```

## 1. Leer el código

Lee [`main.tf`](../laboratorio/opentofu/main.tf).

- [ ] ¿Qué recursos declara? ¿Cuál depende de cuál?
- [ ] ¿Qué hace `wait = true` en los contenedores? ¿Con qué opción de Compose se parece?
- [ ] ¿Por qué `postgres_password` no tiene valor por defecto?

## 2. init, plan, apply

```bash
tofu init
tofu plan
```

- [ ] ¿Cuántos recursos va a crear? ¿Aparece la contraseña en el plan?

```bash
tofu apply            # escribe "yes" después de leer el plan
bash ../../../../../referencia/scripts/smoke-test.sh http://localhost:8100
tofu plan             # otra vez
```

- [ ] ¿Qué dice el segundo `plan`? ¿Qué propiedad de la teoría 01 demuestra?

## 3. El estado

```bash
ls -la
grep -c POSTGRES_PASSWORD terraform.tfstate
```

- [ ] ¿La contraseña está en el estado? ¿En texto plano? Revisa `.gitignore` de la carpeta.

## 4. Deriva

Borra el contenedor de la app "a mano":

```bash
docker rm -f biblioteca-tofu-app
tofu plan
tofu apply
```

- [ ] ¿Qué detectó el plan? ¿Qué hizo `apply`?

## 5. Cambiar la versión

```bash
tofu plan -var app_version=1.1.0
```

- [ ] ¿La app se modifica en su lugar (`~`) o se reemplaza (`-/+`)? ¿Qué línea lo fuerza?
- [ ] ¿Qué pasa con la base? ¿Y con los datos?

Aplica y comprueba la versión en `http://localhost:8100/api/version`.

## 6. Un cambio peligroso

Sal de la terminal y vuelve a entrar (o ejecuta `read -rs TF_VAR_postgres_password` otra vez) con
una contraseña **distinta**, y planea:

```bash
tofu plan -var app_version=1.1.0
```

- [ ] ¿Qué recursos se reemplazarían? Si aplicaras, ¿la base aceptaría la contraseña nueva?
      (Pista: PostgreSQL solo usa `POSTGRES_PASSWORD` al crear un volumen vacío.)
- [ ] ¿Qué te dice esto sobre leer el plan **siempre** antes de `apply`?

No apliques. Vuelve a la contraseña original.

## 7. Proteger los datos

Agrega al volumen:

```hcl
  lifecycle {
    prevent_destroy = true
  }
```

```bash
tofu destroy
```

- [ ] ¿Qué pasó? ¿Qué tendrías que hacer para destruir de verdad?
- [ ] ¿`prevent_destroy` reemplaza al respaldo de la semana 6? ¿Por qué?

## 8. Limpieza

Quita el bloque `lifecycle` y destruye todo:

```bash
tofu destroy
rm -rf .terraform .terraform.lock.hcl terraform.tfstate* .home
```

## ✅ Checklist

- [ ] Infraestructura creada desde código, verificada con la prueba de humo
- [ ] Segundo plan sin cambios, explicado
- [ ] Secreto en el estado identificado
- [ ] Deriva detectada y corregida
- [ ] Cambio de versión y cambio peligroso analizados en el plan antes de aplicar
- [ ] `prevent_destroy` probado

Teoría relacionada: [`04-opentofu.md`](../../1-teoria/04-opentofu.md).
