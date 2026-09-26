# Práctica 02 — Mantenimiento del Servidor

<!-- 📝 Instrucción: práctica en parejas sobre el laboratorio. Con la VM Ubuntu del laboratorio
se hace lo mismo con sudo; la diferencia principal está en la tabla del README del
laboratorio. -->

## Objetivo

Activar y verificar las actualizaciones automáticas de seguridad, programar una revisión
rutinaria del servidor y elaborar el calendario de mantenimiento con su tabla de EOL.

## Duración estimada

120 minutos.

## Preparación

```bash
cd ../laboratorio
docker compose up -d --build --wait
docker compose exec servidor bash
```

Todos los comandos van en la consola del servidor, salvo que se indique otra cosa.

## 1. Primera revisión

Lee [`revisar-servidor.sh`](../laboratorio/servidor/revisar-servidor.sh) y ejecútalo:

```bash
revisar-servidor; echo "código de salida: $?"
```

- [ ] ¿Qué problemas encontró?
- [ ] ¿Por qué el script guarda la salida de `apt-config dump` en una variable antes de buscar en
      ella? (Lee el comentario de la sección 4.)

## 2. ¿Qué está pendiente?

```bash
apt list --upgradable
apt list --upgradable 2>/dev/null | grep -- -security
```

- [ ] ¿Cuántos paquetes hay pendientes? ¿Cuántos son de seguridad?

## 3. Actualizaciones automáticas

```bash
cat /etc/apt/apt.conf.d/20auto-upgrades
apt-config dump | grep Periodic
```

El archivo dice `"1"`, pero la revisión dice que están desactivadas. Encuentra el responsable:

```bash
grep -rl Periodic /etc/apt/apt.conf.d/
```

- [ ] ¿Quién desactiva las tareas periódicas en esta imagen y por qué tendría sentido en un
      contenedor? ¿Existiría ese archivo en la VM?

Quítalo (solo en el laboratorio) y comprueba:

```bash
rm /etc/apt/apt.conf.d/docker-disable-periodic-update
revisar-servidor | grep automáticas
```

## 4. Qué instalaría y qué no

```bash
unattended-upgrade --dry-run -v 2>&1 | grep -E "Allowed origins|Packages that will be upgraded"
grep -A6 "Allowed-Origins" /etc/apt/apt.conf.d/50unattended-upgrades
```

- [ ] ¿Qué paquetes instalaría? Compáralos con la lista de la parte 2: ¿cuáles deja fuera y por qué?

Aplícalo (en la VM lo hace un temporizador cada día):

```bash
unattended-upgrade -v 2>&1 | tail -2
revisar-servidor | grep -E "seguridad|reinicio"
```

## 5. Reinicio pendiente

Simula que la actualización tocó el kernel:

```bash
touch /var/run/reboot-required
revisar-servidor | grep reinicio
```

- [ ] ¿Por qué `unattended-upgrades` no reinicia solo por defecto? ¿Cuándo reiniciarías?

Límpialo: `rm /var/run/reboot-required`.

## 6. Respaldos en la revisión

La revisión también comprueba la antigüedad del último respaldo. Simula un respaldo viejo y uno
reciente:

```bash
touch -d "3 days ago" /var/respaldos/biblioteca-viejo.dump
revisar-servidor | grep respaldo
touch /var/respaldos/biblioteca-$(date +%Y%m%d).dump
revisar-servidor | grep respaldo
```

## 7. Programarla

Revisión diaria a las 6:00, con el latido hacia Uptime Kuma de la semana 7 (en el laboratorio, la
URL puede ser ficticia):

```bash
cat > /etc/cron.d/revisar-servidor <<'EOF'
# m h dom mes dow usuario comando
0 6 * * * root URL_LATIDO=https://monitor.ejemplo.com/api/push/<token> /usr/local/bin/revisar-servidor >> /var/log/revisar-servidor.log 2>&1
EOF
chmod 644 /etc/cron.d/revisar-servidor
```

- [ ] ¿Por qué el latido se envía solo cuando **no** hay problemas?
- [ ] Agrega al script una verificación propia (por ejemplo, memoria libre con `free -m`, o
      tamaño de `/var/log`). Pruébala en verde y en rojo.

## 8. Imágenes en el servidor

En **tu equipo** (el servidor de Docker de las semanas 4 a 7):

```bash
docker image ls biblioteca
docker image ls localhost:5000/biblioteca
docker system df
docker image prune          # borra imágenes sin etiqueta
```

- [ ] ¿Cuántas versiones conservarías en el servidor para poder hacer rollback sin descargar?

## 9. EOL y calendario

Completa con datos de <https://endoflife.date> (anota la fecha de consulta):

| Componente | Versión | Fin de soporte | ¿Cuándo planear la actualización? |
|---|---|---|---|
| Ubuntu Server | 24.04 | | |
| PostgreSQL | 17 | | |
| Python | 3.13 | | |
| Node.js | 22 | | |

Y el calendario de mantenimiento de la app de referencia con la tabla de la teoría 01, sección 3:
tarea, frecuencia, automática o manual, responsable, ¿requiere ventana?

## ✅ Checklist

- [ ] Actualizaciones de seguridad automáticas activas y comprobadas, con la diferencia entre
      seguridad y el resto explicada
- [ ] Reinicio pendiente detectado
- [ ] Revisión rutinaria programada con latido, con una verificación propia
- [ ] Política de imágenes a conservar en el servidor
- [ ] Tabla de EOL con fuente y calendario de mantenimiento

Teoría relacionada: [`01-plan-de-mantenimiento.md`](../../1-teoria/01-plan-de-mantenimiento.md),
[`02-actualizaciones-y-dependencias.md`](../../1-teoria/02-actualizaciones-y-dependencias.md).
