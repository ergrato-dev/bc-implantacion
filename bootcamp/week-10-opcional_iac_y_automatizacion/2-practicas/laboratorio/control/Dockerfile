# Nodo de control de Ansible: desde aquí se configura el servidor por SSH.
FROM python:3.13-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends openssh-client \
 && rm -rf /var/lib/apt/lists/* \
 && pip install --no-cache-dir "ansible==12.*"

WORKDIR /trabajo
CMD ["sleep", "infinity"]
