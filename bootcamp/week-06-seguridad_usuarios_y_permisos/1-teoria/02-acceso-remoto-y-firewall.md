# Acceso Remoto Seguro y Firewall

## 🎯 Objetivos

- Configurar el acceso SSH con llaves y deshabilitar las contraseñas
- Endurecer el servidor SSH sin quedarse por fuera
- Definir reglas de firewall con UFW a partir de una política de "negar por defecto"
- Reconocer por qué Docker puede saltarse el firewall y cómo evitarlo

## 📋 Contenido

### 1. Llaves en lugar de contraseñas

En la semana 3 usaste una llave para SFTP. En el servidor, la llave es **la** forma de entrar:

| | Contraseña | Llave SSH |
|---|---|---|
| Ataque por fuerza bruta | Posible: los bots lo intentan todo el día | Inviable |
| Qué viaja al servidor | La contraseña (cifrada en el canal) | Solo una firma: la llave privada no sale del equipo |
| Si se filtra | Hay que cambiarla en el servidor | Se borra una línea de `authorized_keys` |
| Protección local | — | Frase de paso (*passphrase*) sobre la llave privada |

```bash
ssh-keygen -t ed25519 -C "ana@portatil"               # en TU equipo, con frase de paso
ssh-copy-id -i ~/.ssh/id_ed25519.pub ana@servidor     # copia la pública al servidor
ssh ana@servidor                                      # ya no pide la contraseña de la cuenta
```

La llave pública queda en `~/.ssh/authorized_keys` del usuario (carpeta `700`, archivo `600`).
Cada persona tiene **su** llave: al irse alguien del equipo, se borra su línea y su cuenta.

### 2. Endurecer el servidor SSH

Un archivo propio en `/etc/ssh/sshd_config.d/` (no se toca el principal, que cambia con las
actualizaciones):

```
# /etc/ssh/sshd_config.d/10-endurecer.conf
PermitRootLogin no
PasswordAuthentication no
KbdInteractiveAuthentication no
AllowGroups sudo despliegue
```

| Opción | Efecto |
|---|---|
| `PermitRootLogin no` | Nadie entra como `root`: se entra con la cuenta propia y se usa `sudo` |
| `PasswordAuthentication no` | Solo llaves: la fuerza bruta deja de tener sentido |
| `AllowGroups` | Solo los grupos listados pueden iniciar sesión, aunque existan otras cuentas |

Procedimiento seguro para aplicar el cambio:

1. **Deja una sesión SSH abierta** y no la cierres hasta terminar.
2. Valida la sintaxis: `sudo sshd -t` (sin salida = correcto).
3. Recarga: `sudo systemctl reload ssh`. Las sesiones abiertas no se cortan.
4. Desde **otra** terminal, prueba entrar con llave y comprueba que la contraseña ya no se acepta.
5. Solo entonces cierra la primera sesión.

`sudo sshd -T` muestra la configuración efectiva. En `sshd_config` gana el **primer** valor que
se lee: por eso los archivos de `sshd_config.d/` se incluyen al principio.

### 3. Firewall con UFW

UFW (*Uncomplicated Firewall*) es la interfaz de Ubuntu para las reglas de filtrado del kernel.
Política: **negar todo lo que entra** y abrir solo lo necesario.

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH              # ANTES de habilitar: si no, te quedas por fuera
sudo ufw allow 80,443/tcp           # HTTP y HTTPS para Caddy
sudo ufw enable
sudo ufw status verbose
```

| Puerto | ¿Abierto? | Por qué |
|---|:---:|---|
| 22 (SSH) | ✅ | Administración. Mejor aún: solo desde la red del equipo (`ufw allow from <red> to any port 22`) |
| 80 / 443 | ✅ | El proxy atiende a los usuarios |
| 8000 (app) | ❌ | Solo la alcanza el proxy por la red interna de Docker |
| 5432 (PostgreSQL) | ❌ | Nunca expuesto a Internet |

### 4. ⚠️ Docker y UFW

Docker escribe sus propias reglas de filtrado para los puertos publicados, **antes** que las de
UFW. Un `ports: - "5432:5432"` deja la base accesible desde Internet aunque `ufw status` diga que
el puerto está cerrado.

| Cómo se publica | Resultado |
|---|---|
| `"5432:5432"` | Abierto a todo el mundo, sin importar UFW |
| `"127.0.0.1:5432:5432"` | Solo desde el propio servidor (por ejemplo, con un túnel SSH) |
| Sin `ports:` | Solo desde otros contenedores de la misma red: lo correcto para la base |

Regla práctica: en producción solo el proxy publica puertos (`compose.prod.yaml` de la app de
referencia ya lo hace así). Compruébalo con `docker compose ps` y, desde **otro** equipo, con
`nc -zv <servidor> 5432`.

### 5. Otras medidas habituales

- **Actualizaciones de seguridad automáticas** (`unattended-upgrades`): semana 8.
- **Bloqueo de IP con intentos fallidos** (`fail2ban`): útil si SSH queda abierto a Internet.
- **Revisar accesos**: `last`, `sudo journalctl -u ssh`, `/var/log/auth.log`.

### 6. Aplicación al proyecto real

Define qué puertos abre el servidor de tu proyecto y por qué, quién entra por SSH y con qué
llave, y cómo verificas que la base no está expuesta.

## 📚 Recursos Adicionales

Ver [`4-recursos/webgrafia/`](../4-recursos/webgrafia/README.md).
