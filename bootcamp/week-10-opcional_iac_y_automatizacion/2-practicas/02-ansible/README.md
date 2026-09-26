# Práctica 02 — Ansible: Instalar la App con un Playbook

<!-- 📝 Instrucción: práctica en parejas sobre el laboratorio. La primera ejecución del playbook
descarga paquetes e imágenes y construye la app dentro del servidor: puede tardar entre 5 y 15
minutos según la red. Arranca el laboratorio al inicio de la sesión. -->

## Objetivo

Instalar la app de referencia en un Ubuntu recién creado solo con un playbook, comprobar que es
idempotente, actualizar la versión cambiando una variable y extender el playbook sin romper la
idempotencia.

## Duración estimada

180 minutos.

## Preparación

```bash
cd ../laboratorio
docker compose up -d --build
```

## 1. Llegar al servidor

El servidor está recién creado: solo tiene el usuario `ubuntu` y espera una llave, como una VM de
nube. Crea la llave del nodo de control y ponla en el servidor (es lo que haría cloud-init en la
práctica 01):

```bash
mkdir -p ansible/llaves
ssh-keygen -t ed25519 -N "" -f ansible/llaves/lab -C "ansible@control"
docker compose cp ansible/llaves/lab.pub servidor:/home/ubuntu/.ssh/authorized_keys
docker compose exec servidor sh -c 'chown ubuntu:ubuntu /home/ubuntu/.ssh/authorized_keys && chmod 600 /home/ubuntu/.ssh/authorized_keys'
```

La llave del laboratorio no tiene frase de paso para que Ansible la use sin preguntar. En un
proyecto real se usa `ssh-agent`.

Desde el nodo de control:

```bash
docker compose exec control bash
ansible biblioteca -m ping
ansible biblioteca -a "df -h /"                      # comando suelto (ad hoc)
ansible biblioteca -m ansible.builtin.setup -a "filter=ansible_distribution*"
```

- [ ] ¿Qué información usa Ansible de `inventario.ini` y `ansible.cfg` para llegar?

## 2. Leer el playbook

Lee [`instalar-biblioteca.yml`](../laboratorio/ansible/instalar-biblioteca.yml), las variables
[`group_vars/biblioteca/vars.yml`](../laboratorio/ansible/group_vars/biblioteca/vars.yml) y las
plantillas de [`plantillas/`](../laboratorio/ansible/plantillas/env.j2).

Relaciona cada tarea con la sección del plan de la app de referencia
([`plan-implantacion.md`](../../../../referencia/docs/plan-implantacion.md)) que automatiza:

| Tarea | Sección del plan |
|---|---|
| Paquetes del sistema | |
| Firewall | |
| Carpeta de la instalación | |
| Configuración (.env) | |
| Prueba de humo | |

- [ ] ¿Qué tareas usan `command`? ¿Cómo evita cada una reportar `changed` siempre?

## 3. El secreto en Vault

La contraseña de la base no está en `vars.yml`: la espera en `vault_postgres_password`. Crea el
archivo cifrado (en el nodo de control):

```bash
ansible-vault create group_vars/biblioteca/vault.yml
```

Se abre un editor; escribe una línea con una contraseña generada por ti:

```yaml
vault_postgres_password: <pega aquí el resultado de: openssl rand -hex 24>
```

Guarda y comprueba:

```bash
cat group_vars/biblioteca/vault.yml             # cifrado
ansible-vault view group_vars/biblioteca/vault.yml
```

- [ ] ¿Se podría subir `vault.yml` a un repositorio? ¿Y la contraseña del vault?

## 4. Primera ejecución

```bash
ansible-playbook instalar-biblioteca.yml --ask-vault-pass
```

Mientras corre, lee la salida tarea por tarea. Al final, en **tu equipo**:

```bash
bash ../../../../referencia/scripts/smoke-test.sh https://biblioteca.lab.test:8443
```

con `CURL_OPTS="-k --resolve biblioteca.lab.test:8443:127.0.0.1"` delante.

- [ ] Copia la línea `PLAY RECAP`. ¿Cuántas tareas cambiaron?
- [ ] ¿Cuánto tardó? Compáralo con tu tiempo del simulacro de la semana 9.

## 5. Idempotencia

Ejecuta el playbook otra vez, sin cambiar nada.

- [ ] ¿Qué dice `PLAY RECAP`? ¿Se reinició algún contenedor?
- [ ] Lee el comentario de la tarea "Configuración del proxy desde la plantilla": ¿qué pasaba antes
      de usar una plantilla?

## 6. Deriva: un cambio a mano

Simula a alguien que "arregla algo rápido" en el servidor:

```bash
docker compose exec servidor bash -c 'sed -i "s/APP_VERSION=.*/APP_VERSION=9.9.9/" /opt/biblioteca/.env; ufw delete allow 80/tcp'
```

Ejecuta el playbook con `--check --diff` y después sin `--check`.

- [ ] ¿Qué detectó? ¿Por qué el diff del `.env` no muestra el contenido?
- [ ] ¿Qué dice el `PLAY RECAP` de una tercera ejecución?

## 7. Actualizar la versión

```bash
ansible-playbook instalar-biblioteca.yml --ask-vault-pass --check --diff -e app_version=1.1.0
ansible-playbook instalar-biblioteca.yml --ask-vault-pass -e app_version=1.1.0
```

- [ ] ¿Qué tareas cambiaron? ¿Se ejecutó el *handler*? ¿Qué versión responde la app?
- [ ] Este camino no hace respaldo ni rollback automático. ¿Qué agregarías para usar
      `desplegar.sh` (semana 7) en las actualizaciones?

## 8. Extender el playbook

Agrega, ejecutando dos veces después de cada cambio para comprobar `changed=0`:

- [ ] El usuario `luis` en el grupo `despliegue`, con una llave pública (módulos `user` y
      `ansible.posix.authorized_key`).
- [ ] `unattended-upgrades` instalado (semana 8).
- [ ] La regla de `sudo` de la semana 6 para el grupo `despliegue` (módulo `copy` con
      `validate: visudo -cf %s`).

Y una tarea **no** idempotente a propósito, para verla fallar la prueba:

```yaml
    - name: Registrar la instalación
      ansible.builtin.shell: echo "instalado $(date)" >> /opt/biblioteca/instalaciones.log
```

- [ ] ¿Cómo la harías idempotente? ¿Tiene sentido que lo sea?

## 9. Limpieza

```bash
exit                                                  # salir del nodo de control
docker compose exec control rm -f group_vars/biblioteca/vault.yml
docker compose down -v
```

## ✅ Checklist

- [ ] Servidor alcanzable por llave y comandos ad hoc ejecutados
- [ ] Tabla de tareas ↔ secciones del plan
- [ ] Secreto en Ansible Vault
- [ ] Instalación completa con prueba de humo en verde, y segunda ejecución con `changed=0`
- [ ] Deriva detectada con `--check --diff` y corregida
- [ ] Versión actualizada con una variable
- [ ] Tres extensiones idempotentes y una tarea no idempotente analizada

Teoría relacionada: [`03-ansible.md`](../../1-teoria/03-ansible.md).
