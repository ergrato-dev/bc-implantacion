#!/usr/bin/env bash
# Arranca los dos servicios del "servidor": cron (en segundo plano) y SSH (en primer plano).
set -e
ssh-keygen -A                 # llaves de host, si faltan
cron
exec /usr/sbin/sshd -D -e
