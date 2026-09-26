# "Servidor" Ubuntu del laboratorio de la semana 8: actualizaciones y rutinas de mantenimiento.
# La imagen se construye SIN actualizar los paquetes a propósito, para que haya
# actualizaciones pendientes que revisar.
FROM ubuntu:24.04

RUN apt-get update \
 && apt-get install -y --no-install-recommends unattended-upgrades cron curl ca-certificates nano less \
 && mkdir -p /var/respaldos

COPY --chmod=755 revisar-servidor.sh /usr/local/bin/revisar-servidor

CMD ["bash", "-c", "cron && exec sleep infinity"]
