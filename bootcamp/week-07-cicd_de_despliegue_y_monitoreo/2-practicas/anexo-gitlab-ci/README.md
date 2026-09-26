# Anexo — Pipeline en GitLab CI

<!-- 📝 Instrucción: lectura guiada, sin ejecución obligatoria. Si la institución ofrece GitLab
con un runner, el instructor puede convertirla en práctica con un repositorio de prueba. -->

## Objetivo

Leer [`.gitlab-ci.yml`](.gitlab-ci.yml) y relacionar cada parte con `ci.yml`, `release.yml` y
`desplegar.sh` de la app de referencia.

## Duración estimada

30 minutos (dentro del trabajo autónomo).

## Preguntas

- [ ] ¿Qué línea equivale a `on: pull_request` de `ci.yml`?
- [ ] ¿Por qué cada job usa `-p "ci-$CI_JOB_ID"` y un `after_script` que borra todo? ¿Qué
      pasaría en un runner compartido sin eso?
- [ ] Dos jobs de prueba al mismo tiempo en el mismo runner publicarían el puerto 8000 a la vez.
      ¿Cómo lo resolverías?
- [ ] ¿Qué reemplaza a `secrets.GITHUB_TOKEN` para publicar en el registro?
- [ ] `desplegar-servidor` hace despliegue por **empuje**. ¿Por qué aquí es posible y con GitHub
      Actions en la VM del laboratorio no?
- [ ] ¿Qué hace `when: manual`? ¿Y `resource_group`? ¿Cuál es su equivalente en `release.yml`?
- [ ] La cuenta de despliegue solo puede ejecutar `sudo /usr/local/bin/desplegar-biblioteca`.
      ¿Por qué no se le da acceso directo a `docker` ni se le permite `sudo` sobre
      `/opt/biblioteca/desplegar.sh`? (Pista: permisos de `/opt/biblioteca`, semana 6.)

## Si tienes GitLab y un runner

1. Sube tu `~/biblioteca` a un proyecto de GitLab con este archivo en la raíz.
2. Cambia `tags` por los del runner que te asignen.
3. Verifica la sintaxis en **Build → Pipeline editor**, que valida el archivo antes de guardarlo.

Teoría relacionada: [`05-anexo-gitlab-ci.md`](../../1-teoria/05-anexo-gitlab-ci.md).
