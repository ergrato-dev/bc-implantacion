# Práctica 03 — Publicar Archivos por SFTP

<!-- 📝 Instrucción: práctica individual sobre el laboratorio. Cada aprendiz genera SU llave; la
llave privada nunca se comparte ni se sube al repositorio. -->

## Objetivo

Publicar archivos en el servidor de forma segura: primero con contraseña, luego con llave SSH,
y conocer los límites de un servidor "solo SFTP".

## Duración estimada

120 minutos.

## Preparación

```bash
cd ../laboratorio
docker compose up -d --wait
```

## 1. Conexión con contraseña

```bash
sftp -P 2222 deploy@127.0.0.1
```

Acepta la huella del servidor y escribe la contraseña de laboratorio `deploy-lab`. Dentro de
`sftp>`:

```
pwd
ls
cd sitio
put publicar/index.html
ls -l
bye
```

Comprueba que quedó publicado:

```bash
curl -k --resolve sitio.lab.test:8443:127.0.0.1 https://sitio.lab.test:8443/
```

El `404` de la práctica 02 desapareció: SFTP escribe en el mismo volumen que Caddy sirve.

- [ ] ¿Por qué `pwd` muestra `/` si en el servidor la carpeta es `/home/deploy`? (pista: *chroot*)

## 2. Llave SSH

Genera un par de llaves solo para el laboratorio:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/lab_hosting -C "lab-hosting"
cp ~/.ssh/lab_hosting.pub llaves/
docker compose up -d --force-recreate sftp --wait
```

Conéctate con la llave (no debe pedir la contraseña del servidor):

```bash
sftp -P 2222 -i ~/.ssh/lab_hosting deploy@127.0.0.1
```

- [ ] ¿Cuál de los dos archivos (`lab_hosting` o `lab_hosting.pub`) va al servidor? ¿Por qué el
      otro nunca debe salir de tu equipo?

## 3. Transferencia no interactiva

Para scripts y despliegues, los comandos van en un archivo o por la entrada estándar:

```bash
printf 'cd sitio\nput publicar/index.html\nls -l\n' \
  | sftp -b - -P 2222 -i ~/.ssh/lab_hosting deploy@127.0.0.1
```

`-b -` detiene todo si un comando falla, y exige autenticación sin contraseña (llave).

## 4. `scp` contra un servidor solo SFTP

```bash
echo "<p>segunda versión</p>" > /tmp/v2.html
scp -P 2222 -i ~/.ssh/lab_hosting /tmp/v2.html deploy@127.0.0.1:sitio/
scp -s -P 2222 -i ~/.ssh/lab_hosting /tmp/v2.html deploy@127.0.0.1:sitio/
```

Según tu versión de OpenSSH (`ssh -V`), el primer comando puede fallar con
`This service allows sftp connections only.`: las versiones anteriores a la 9.0 usan el
protocolo SCP clásico, que requiere una terminal en el servidor. `-s` fuerza el protocolo SFTP.

## 5. `rsync` y sus requisitos

```bash
rsync -av -e "ssh -p 2222 -i ~/.ssh/lab_hosting" publicar/ deploy@127.0.0.1:sitio/
```

Falla: `rsync` necesita ejecutar `rsync` **en el servidor** a través de SSH, y este servidor solo
permite SFTP. Es una decisión de seguridad: el usuario `deploy` puede subir archivos pero no
ejecutar comandos.

- [ ] ¿En qué caso preferirías `rsync` y qué exige del servidor? (Si tienes acceso a la VM
      Ubuntu del laboratorio, pruébalo contra ella.)

## 6. FTP: solo para comparar

No montamos un servidor FTP: sus credenciales viajan en texto plano. Compara en la tabla de
[`04-transferencia-de-archivos.md`](../../1-teoria/04-transferencia-de-archivos.md) y responde:
si un proveedor de hosting solo ofrece FTP, ¿qué le exigirías o qué alternativa buscarías?

## 7. Limpieza

```bash
docker compose down -v
rm llaves/lab_hosting.pub
```

## ✅ Checklist

- [ ] Publiqué un archivo por SFTP y lo vi servido por Caddy
- [ ] Me conecté con llave SSH sin contraseña del servidor
- [ ] Hice una transferencia no interactiva con `sftp -b`
- [ ] Expliqué por qué `rsync` falla contra un servidor solo SFTP
- [ ] Justifiqué por qué FTP plano no se usa

Teoría relacionada:
[`04-transferencia-de-archivos.md`](../../1-teoria/04-transferencia-de-archivos.md).
