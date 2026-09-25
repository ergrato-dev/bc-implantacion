#!/bin/sh
# atmoz/sftp ejecuta los scripts de /etc/sftp.d/ al arrancar.
# El volumen del sitio se crea como root; el usuario deploy necesita escribir en él.
chown 1001:1001 /home/deploy/sitio
