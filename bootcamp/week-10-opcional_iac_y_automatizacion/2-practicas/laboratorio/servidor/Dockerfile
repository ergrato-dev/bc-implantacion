# "Servidor" Ubuntu recién instalado para la semana 10: systemd, SSH y Python, nada más.
# Como en las imágenes de nube, trae el usuario "ubuntu" con sudo sin contraseña y espera que
# alguien le ponga una llave pública. Todo lo demás (Docker, usuarios, firewall, la app) lo
# instala Ansible. Corre privilegiado porque dentro corren systemd y Docker (solo laboratorio).
FROM ubuntu:24.04

RUN apt-get update \
 && apt-get install -y --no-install-recommends systemd systemd-sysv openssh-server sudo python3 ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-ubuntu && chmod 440 /etc/sudoers.d/90-ubuntu \
 && install -d -o ubuntu -g ubuntu -m 700 /home/ubuntu/.ssh \
 && systemctl enable ssh

STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
