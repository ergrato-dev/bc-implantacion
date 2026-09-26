# Práctica 01 — cloud-init: el Primer Arranque

<!-- 📝 Instrucción: práctica individual. Las partes 1 a 4 solo requieren cloud-init instalado
(viene en Ubuntu; en otros sistemas, usar un contenedor ubuntu con el paquete cloud-init). La
parte 5 requiere una VM real: Multipass en el equipo o la VM Ubuntu del laboratorio. -->

## Objetivo

Escribir y validar el `user-data` que deja un Ubuntu Server nuevo listo para que Ansible lo
configure, y comprobarlo en una VM si hay una disponible.

## Duración estimada

90 minutos.

## Preparación

Comprueba que tienes cloud-init:

```bash
cloud-init --version
```

Si no lo tienes (Windows, macOS u otra distribución), úsalo desde un contenedor:

```bash
docker run --rm -it -v "$PWD/../laboratorio/cloud-init:/ci" -w /ci ubuntu:24.04 \
  bash -c "apt-get update -qq && apt-get install -y -qq cloud-init >/dev/null && bash"
```

## 1. Leer el ejemplo

Lee [`user-data.yaml`](../laboratorio/cloud-init/user-data.yaml).

- [ ] ¿Qué medidas de la semana 6 aplica? ¿Y de la semana 8?
- [ ] ¿Por qué instala `python3` y nada más de la app?
- [ ] ¿Por qué no hay ninguna contraseña?

## 2. Validar

```bash
cd ../laboratorio/cloud-init
cloud-init schema --config-file user-data.yaml
```

Rompe el archivo a propósito, de a un error por vez, y valida cada vez:

1. Cambia `ssh_pwauth: false` por `ssh_pwauth: quizas`.
2. Cambia `packages:` por `paquetes:`.
3. Quita la primera línea (`#cloud-config`).

- [ ] ¿Cuál de los tres detectó el validador? ¿Qué habría pasado con cada uno en una VM real?

Restaura el archivo (`git checkout -- user-data.yaml`).

## 3. Tu llave

Crea una llave para Ansible (si no la creaste en la práctica 02) y pon **la pública** en
`ssh_authorized_keys`:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/ansible_lab -C "ansible@control"
cat ~/.ssh/ansible_lab.pub
```

Valida de nuevo.

## 4. Adaptarlo

Agrega al `user-data`, validando después de cada cambio:

- [ ] El grupo `despliegue` (módulo `groups`).
- [ ] Un archivo `/etc/motd` con el nombre del proyecto y "Administrado con Ansible: no hacer
      cambios a mano" (`write_files`).
- [ ] UFW instalado, con SSH permitido y activo (`packages` + `runcmd`). ¿En qué orden van los
      comandos para no quedar por fuera?

## 5. En una VM real (si tienes Multipass o la VM del laboratorio)

Con Multipass:

```bash
multipass launch 24.04 --name biblioteca-01 --cloud-init user-data.yaml
multipass exec biblioteca-01 -- cloud-init status --long
ssh -i ~/.ssh/ansible_lab ubuntu@$(multipass info biblioteca-01 --format csv | tail -1 | cut -d, -f3)
```

En la VM, comprueba cada cosa que declaraste: usuario, grupo, SSH sin contraseña, paquetes,
`motd`, UFW. Si algo falta: `sudo cat /var/log/cloud-init-output.log`.

Al terminar: `multipass delete --purge biblioteca-01`.

## ✅ Checklist

- [ ] `user-data` leído y explicado
- [ ] Tres errores provocados y el comportamiento del validador anotado
- [ ] Llave propia y tres adaptaciones, validadas
- [ ] (Si hubo VM) primer arranque comprobado punto por punto

Teoría relacionada: [`02-cloud-init.md`](../../1-teoria/02-cloud-init.md).
