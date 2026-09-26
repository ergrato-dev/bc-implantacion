# "Servidor" Ubuntu del laboratorio: SSH, sudo, UFW, cron, restic y cliente de PostgreSQL 17.
# Simula la VM Ubuntu del laboratorio para practicar usuarios, acceso y respaldos.
FROM ubuntu:24.04

RUN apt-get update \
 && apt-get install -y --no-install-recommends openssh-server sudo ufw cron restic netcat-openbsd \
      postgresql-common ca-certificates curl nano less \
 && /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y \
 && apt-get install -y --no-install-recommends postgresql-client-17 \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /run/sshd

COPY arrancar.sh /usr/local/bin/arrancar.sh

EXPOSE 22
CMD ["bash", "/usr/local/bin/arrancar.sh"]
