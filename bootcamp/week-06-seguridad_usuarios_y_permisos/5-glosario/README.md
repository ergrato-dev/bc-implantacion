# 🎓 Glosario — Semana 6

| Término | Definición breve |
|---|---|
| **Mínimo privilegio** | Dar a cada persona o proceso solo los permisos que necesita |
| **Defensa en profundidad** | Varias capas de protección: si una falla, la siguiente contiene el daño |
| **`root`** | Superusuario de Linux (UID 0): puede hacer cualquier cosa |
| **Usuario de servicio** | Cuenta sin sesión interactiva (`nologin`) que ejecuta un proceso |
| **Grupo** | Conjunto de usuarios que comparten permisos |
| **`chmod` / `chown`** | Cambian los permisos y el dueño de un archivo |
| **setgid (carpeta)** | Hace que lo creado dentro herede el grupo de la carpeta |
| **`sudo`** | Ejecuta un comando como otro usuario, con registro |
| **`sudoers`** | Reglas de quién puede ejecutar qué con `sudo`; se validan con `visudo` |
| **Llave SSH** | Par de llaves (privada y pública) para autenticarse sin contraseña |
| **Frase de paso** | Contraseña que protege la llave privada en el equipo de su dueño |
| **`authorized_keys`** | Archivo del servidor con las llaves públicas que pueden entrar a una cuenta |
| **`sshd_config`** | Configuración del servidor SSH |
| **Firewall** | Filtro que decide qué conexiones entran y salen |
| **UFW** | *Uncomplicated Firewall*, interfaz de firewall de Ubuntu |
| **Rol (PostgreSQL)** | Usuario o grupo de la base de datos |
| **Superusuario (PostgreSQL)** | Rol que salta todas las verificaciones de permisos |
| **`GRANT` / `REVOKE`** | Otorgan o quitan privilegios |
| **`ALTER DEFAULT PRIVILEGES`** | Privilegios que recibirán los objetos creados en el futuro |
| **`pg_read_all_data`** | Rol predefinido que puede leer todas las tablas |
| **`pg_hba.conf`** | Archivo que decide cómo se autentica cada conexión a PostgreSQL |
| **Prueba negativa** | Verificación de que algo prohibido efectivamente falla |
| **Secreto** | Dato que da acceso: contraseña, llave, token |
| **Rotación** | Reemplazar un secreto por uno nuevo e invalidar el anterior |
| **restic** | Herramienta de respaldo con cifrado, deduplicación e instantáneas |
| **Repositorio (restic)** | Lugar donde restic guarda los respaldos cifrados |
| **Instantánea** | Estado de lo respaldado en un momento dado |
| **`forget` / `prune`** | Aplicar la retención y liberar el espacio que ya no se usa |
| **Solo-agregar** | Repositorio que acepta respaldos nuevos pero no permite borrar |
| **cron** | Programador de tareas periódicas de Linux |
| **Restauración de desastre** | Recuperar el servicio en un servidor nuevo a partir de los respaldos |
