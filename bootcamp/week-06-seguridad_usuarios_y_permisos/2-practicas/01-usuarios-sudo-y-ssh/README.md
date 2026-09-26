# Práctica 01 — Usuarios, sudo, SSH y Firewall

<!-- 📝 Instrucción: práctica en parejas. Una persona administra el servidor (consola root) y la
otra entra por SSH como usuaria; a mitad de práctica se intercambian. Con la VM Ubuntu del
laboratorio, se hace lo mismo con sudo en lugar de la consola root. -->

## Objetivo

Preparar el servidor con cuentas por persona, un grupo de despliegue con privilegios limitados,
acceso SSH solo con llave y un firewall que niega por defecto.

## Duración estimada

150 minutos.

## Preparación

```bash
cd ../laboratorio
cp .env.example .env
docker compose up -d --build --wait
docker compose exec servidor bash          # consola de administración (root)
```

Los comandos marcados con **[servidor]** van en esa consola; los marcados con **[tu equipo]**, en
otra terminal, dentro de `laboratorio/`.

## 1. Cuentas por persona

**[servidor]**

```bash
groupadd despliegue
adduser --comment "" ana                   # administradora: define una contraseña
usermod -aG sudo ana
adduser --comment "" luis                  # operador: define una contraseña
usermod -aG despliegue luis
id ana; id luis
getent passwd | tail -4
```

- [ ] ¿Para qué necesita `ana` una contraseña si va a entrar con llave?
- [ ] ¿Qué pasaría si ejecutaras `usermod -G despliegue ana` (sin `-a`)?

## 2. Carpeta de despliegue compartida

**[servidor]**

```bash
install -d -o root -g despliegue -m 2770 /opt/biblioteca
touch /opt/biblioteca/.env
chown root:despliegue /opt/biblioteca/.env && chmod 640 /opt/biblioteca/.env
ls -la /opt/biblioteca
su - luis -c 'cat /opt/biblioteca/.env && echo "luis lee .env"; touch /opt/biblioteca/nota && ls -l /opt/biblioteca/nota'
su - ana -c 'ls /opt/biblioteca' || echo "ana no entra"
```

- [ ] ¿A qué grupo pertenece `nota`? ¿Qué letra de `drwxrws---` lo explica?
- [ ] `ana` es administradora y aun así no entra sin `sudo`. ¿Es correcto?
- [ ] ¿Puede `luis` modificar `.env`? ¿Debería?

## 3. sudo limitado

El grupo `despliegue` solo podrá reiniciar la app. **[servidor]**

```bash
cat > /usr/local/bin/reiniciar-biblioteca <<'EOF'
#!/usr/bin/env bash
# Reinicia la app. En la VM real: docker compose -f /opt/biblioteca/compose.yaml restart app
set -euo pipefail
echo "$(date -Is) reinicio solicitado por ${SUDO_USER:-desconocido}" >> /var/log/biblioteca-reinicios.log
echo "App reiniciada (simulado)"
EOF
chmod 755 /usr/local/bin/reiniciar-biblioteca

echo '%despliegue ALL=(root) NOPASSWD: /usr/local/bin/reiniciar-biblioteca' > /etc/sudoers.d/despliegue
chmod 440 /etc/sudoers.d/despliegue
visudo -cf /etc/sudoers.d/despliegue
```

Prueba como `luis`:

```bash
su - luis -c 'sudo -l'
su - luis -c 'sudo /usr/local/bin/reiniciar-biblioteca'
su - luis -c 'sudo -n cat /etc/shadow' || echo "denegado"
cat /var/log/biblioteca-reinicios.log
```

- [ ] ¿Quién es dueño del script? ¿Qué pasaría si fuera de `luis`?
- [ ] Explica por qué `luis ALL=(root) NOPASSWD: /usr/bin/docker *` equivale a darle `root`.

## 4. Llave SSH

**[tu equipo]** — crea una llave solo para este laboratorio, **con** frase de paso:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/lab_s06 -C "lab-s06"
ssh-copy-id -p 2226 -i ~/.ssh/lab_s06.pub ana@127.0.0.1      # pide la contraseña de ana
ssh -p 2226 -i ~/.ssh/lab_s06 ana@127.0.0.1                  # pide la frase de paso, no la contraseña
```

Ya dentro, como `ana`:

```bash
ls -la ~/.ssh
sudo whoami                                                  # pide la contraseña de ana
```

- [ ] ¿Qué pidió cada comando: la frase de paso de la llave o la contraseña de la cuenta? ¿Por qué?

Repite `ssh-copy-id` para `luis` con la misma llave (en el mundo real, cada persona usa la suya).

## 5. Endurecer SSH

⚠️ **Deja abierta la sesión SSH de `ana`** hasta terminar este paso. **[servidor]**

```bash
cat > /etc/ssh/sshd_config.d/10-endurecer.conf <<'EOF'
# Endurecimiento del acceso SSH: solo llaves, sin root, solo usuarios del equipo.
PermitRootLogin no
PasswordAuthentication no
KbdInteractiveAuthentication no
AllowGroups sudo despliegue
EOF
sshd -t && kill -HUP 1 && echo "recargado"
sshd -T | grep -E "^(permitrootlogin|passwordauthentication|allowgroups)"
```

**[tu equipo]** — en una terminal **nueva**:

```bash
ssh -p 2226 -o PubkeyAuthentication=no luis@127.0.0.1        # debe rechazar
ssh -p 2226 -i ~/.ssh/lab_s06 luis@127.0.0.1 'whoami'        # debe funcionar
```

- [ ] Compara el mensaje `Permission denied (...)` de antes y después del cambio. ¿Qué método
      desapareció?
- [ ] Crea una cuenta `invitado` con llave pero sin grupo. ¿Puede entrar? ¿Qué opción lo impide?

## 6. Firewall

**[servidor]** — simula un servicio que nadie debería alcanzar:

```bash
nc -lk 8080 &
```

**[tu equipo]** — pruébalo desde otro contenedor de la red:

```bash
docker compose exec db nc -zv -w 2 servidor 8080
docker compose exec db nc -zv -w 2 servidor 22
```

**[servidor]**

```bash
ufw default deny incoming
ufw default allow outgoing
ufw allow OpenSSH
ufw allow 80,443/tcp
ufw enable
ufw status verbose
```

Repite las dos pruebas con `nc`.

- [ ] ¿Qué pasa con el 8080? ¿Y con el 22?
- [ ] ¿Por qué `ufw allow OpenSSH` va **antes** de `ufw enable` en una VM real?
- [ ] Revisa `referencia/deploy/compose.prod.yaml`: ¿qué servicios publican puertos? ¿Qué
      pasaría con UFW si la base publicara `"5432:5432"`?

## 7. Limpieza

```bash
ssh-keygen -R "[127.0.0.1]:2226"
```

No borres el laboratorio si vas a seguir con la práctica 02.

## ✅ Checklist

- [ ] Cuentas por persona con grupos correctos
- [ ] Carpeta de despliegue con setgid y `.env` en `640`
- [ ] `sudo` limitado a un comando y probado con un comando prohibido
- [ ] Entrada con llave y frase de paso; contraseña rechazada después de endurecer
- [ ] UFW negando por defecto, con evidencia de un puerto bloqueado y uno permitido
- [ ] Riesgo de Docker frente a UFW explicado

Teoría relacionada: [`01-usuarios-grupos-y-permisos.md`](../../1-teoria/01-usuarios-grupos-y-permisos.md),
[`02-acceso-remoto-y-firewall.md`](../../1-teoria/02-acceso-remoto-y-firewall.md).
