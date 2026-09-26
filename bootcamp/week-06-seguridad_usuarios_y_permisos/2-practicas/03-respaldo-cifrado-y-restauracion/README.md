# Práctica 03 — Respaldo Cifrado Automático y Restauración de Desastre

<!-- 📝 Instrucción: práctica en equipo. Requiere la práctica 02 terminada (roles creados y app
con biblioteca_app). En la parte 8 alguien del equipo que NO configuró el respaldo ejecuta la
restauración leyendo solo el procedimiento: es el ensayo del gate de la semana 9. -->

## Objetivo

Automatizar un respaldo cifrado con restic y cron, con copia fuera del sitio en modo
solo-agregar, y probar una restauración completa después de perder el servidor y la base.

## Duración estimada

180 minutos.

## Preparación

```bash
cd ../laboratorio
docker compose up -d --wait
grep ^DATABASE_URL .env                     # debe ser biblioteca_app (práctica 02)
docker compose exec servidor bash           # consola root del servidor
```

Todos los comandos, salvo que se indique otra cosa, van en la consola del servidor.

## 1. Usuario de servicio y script

```bash
useradd --system --create-home --home-dir /var/lib/respaldo --shell /usr/sbin/nologin respaldo
install -d -m 755 /opt/respaldo
install -m 755 /opt/respaldo-lab/respaldar.sh /opt/respaldo/respaldar.sh
install -d -o respaldo -g respaldo -m 700 /var/respaldos
install -d -o respaldo -g respaldo -m 750 /var/log/respaldo
su - respaldo -c whoami            # "This account is currently not available."
```

Lee [`respaldo/respaldar.sh`](../laboratorio/respaldo/respaldar.sh) completo.

- [ ] ¿Qué rol de la base usa? ¿Por qué ese y no `biblioteca_owner`?
- [ ] ¿Por qué el volcado va a una carpeta temporal con `umask 077` y se borra con `trap`?

## 2. Secretos del respaldo

```bash
echo "db:5432:biblioteca:biblioteca_respaldo:respaldo-lab" > /var/lib/respaldo/.pgpass
chown respaldo:respaldo /var/lib/respaldo/.pgpass && chmod 600 /var/lib/respaldo/.pgpass

install -d -m 700 -o respaldo -g respaldo /etc/restic
head -c 32 /dev/urandom | base64 > /etc/restic/password
chown respaldo:respaldo /etc/restic/password && chmod 600 /etc/restic/password
cat /etc/restic/password
```

⚠️ **Guarda esa contraseña fuera del servidor ahora** (gestor de contraseñas del equipo; para el
laboratorio, un archivo en tu equipo fuera del repositorio). La vas a necesitar en la parte 8.

## 3. Repositorios

```bash
restic_r() { sudo -u respaldo RESTIC_PASSWORD_FILE=/etc/restic/password restic "$@"; }
restic_r -r /var/respaldos/restic init
restic_r -r rest:http://externo:8000/biblioteca init
```

`restic_r` es una función de esta consola: si abres otra, vuelve a definirla.

## 4. Primer respaldo

```bash
sudo -u respaldo /opt/respaldo/respaldar.sh
restic_r -r /var/respaldos/restic snapshots
restic_r -r rest:http://externo:8000/biblioteca snapshots
ls /var/respaldos/restic
grep -rl "Libro de prueba" /var/respaldos/restic | wc -l
```

- [ ] El volcado contiene "Libro de prueba". ¿Por qué `grep` no lo encuentra en el repositorio?

## 5. Programarlo con cron

Para el laboratorio, cada minuto:

```bash
cat > /etc/cron.d/respaldo-biblioteca <<'EOF'
# m h dom mes dow usuario comando
* * * * * respaldo /opt/respaldo/respaldar.sh >> /var/log/respaldo/respaldo.log 2>&1
EOF
chmod 644 /etc/cron.d/respaldo-biblioteca
```

Espera dos minutos y revisa:

```bash
cat /var/log/respaldo/respaldo.log
restic_r -r /var/respaldos/restic snapshots
```

- [ ] ¿Cuántas instantáneas hay en el repositorio local? ¿Y en el externo? ¿Por qué no coinciden?
- [ ] Escribe la línea de cron para las 2:15 a. m. todos los días.

Detén el cron del laboratorio: `rm /etc/cron.d/respaldo-biblioteca`.

## 6. La copia solo-agregar

Simula que alguien con la cuenta `respaldo` intenta borrar los respaldos externos:

```bash
restic_r -r rest:http://externo:8000/biblioteca forget --tag db --keep-last 1 2>&1 \
  | grep -o "server response: 403 Forbidden" | sort -u
restic_r -r rest:http://externo:8000/biblioteca snapshots
```

El `forget` tarda cerca de un minuto porque restic reintenta antes de rendirse. Si lo
interrumpes, el repositorio queda bloqueado: libéralo con `restic_r -r ... unlock`.

- [ ] ¿Qué respondió el servidor externo? ¿Siguen todas las instantáneas?
- [ ] ¿Quién aplica la retención en el externo y desde dónde?

## 7. Sin contraseña no hay respaldo

```bash
echo "otra-clave" > /tmp/mala
RESTIC_PASSWORD_FILE=/tmp/mala restic -r /var/respaldos/restic snapshots
rm /tmp/mala
```

## 8. Desastre y restauración

Anota la huella de producción y la hora. Luego **destruye el servidor y la base**
(desde **tu equipo**, en `laboratorio/`):

```bash
docker compose exec -T db psql -U postgres -d biblioteca -tA -f /sql/validar.sql > huella-antes.txt
date
docker compose rm -sf servidor db app
docker volume rm lab-s06_datos
docker compose up -d --wait db servidor
```

Solo sobrevivió el servidor `externo`. La restauración la hace otra persona del equipo:

1. Roles de la base (el volcado no los trae):

   ```bash
   docker compose exec -T db psql -v ON_ERROR_STOP=1 -U postgres -d biblioteca -f /sql/01-roles.sql
   ```

2. Contraseña de restic desde donde la guardaste (reemplaza la ruta):

   ```bash
   docker compose exec -T servidor sh -c 'install -d -m 700 /etc/restic && cat > /etc/restic/password && chmod 600 /etc/restic/password' < /ruta/donde/la/guardaste
   ```

3. Restaurar desde la copia fuera del sitio:

   ```bash
   docker compose exec -T -e PGPASSWORD=admin-lab servidor bash -c '
     export RESTIC_PASSWORD_FILE=/etc/restic/password
     restic -r rest:http://externo:8000/biblioteca snapshots --latest 1
     restic -r rest:http://externo:8000/biblioteca dump latest biblioteca.dump > /root/biblioteca.dump
     pg_restore -h db -U postgres -d biblioteca /root/biblioteca.dump
     rm /root/biblioteca.dump'
   ```

4. Validar y volver a servicio:

   ```bash
   docker compose exec -T db psql -U postgres -d biblioteca -tA -f /sql/validar.sql > huella-despues.txt
   diff huella-antes.txt huella-despues.txt && echo "HUELLAS IDÉNTICAS"
   docker compose up -d --wait app
   bash ../../../../referencia/scripts/smoke-test.sh
   date
   ```

Si rotaste la contraseña de `biblioteca_app` en la práctica 02, la app no arranca: revisa
`docker compose logs app`. `01-roles.sql` recreó el rol con la contraseña de laboratorio, no con
la vigente. Aplica la de `.env` y vuelve a levantar la app:

```bash
docker compose exec -T db psql -U postgres -d biblioteca -c "ALTER ROLE biblioteca_app PASSWORD '<la de .env>'"
docker compose up -d --wait app
```

- [ ] ¿Por qué un script de roles que se versiona no debería llevar contraseñas? ¿De dónde las
      tomarías al reconstruir?
- [ ] ¿Cuánto tardó desde la destrucción hasta la prueba de humo en verde? ¿Cumple un RTO de 4 h?
- [ ] ¿Qué datos se habrían perdido si el último respaldo fuera de hace 24 h? ¿Qué RPO tienes?
- [ ] La app volvió con `biblioteca_app`. ¿Quién es dueño de las tablas restauradas y por qué no
      hizo falta `02-permisos.sql`? ¿Qué permiso de `02-permisos.sql` **sí** se perdió?
- [ ] ¿Qué paso del procedimiento fue ambiguo para quien restauró? Corrígelo.

## 9. Limpieza

```bash
docker compose down -v
rm -f huella-*.txt
```

## ✅ Checklist

- [ ] Usuario de servicio sin sesión, script en `/opt` y secretos en `600`
- [ ] Repositorio local y externo inicializados; contraseña guardada fuera del servidor
- [ ] Respaldo ejecutado por cron, con log
- [ ] Retención aplicada en el local y borrado rechazado en el externo
- [ ] Restauración de desastre por otra persona, con huellas idénticas y tiempo medido
- [ ] Procedimiento corregido después del ensayo

Teoría relacionada: [`05-respaldo-automatizado-y-cifrado.md`](../../1-teoria/05-respaldo-automatizado-y-cifrado.md).
