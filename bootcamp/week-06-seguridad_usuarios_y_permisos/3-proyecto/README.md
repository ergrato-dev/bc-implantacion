# Proyecto Semana 6 — Seguridad, Usuarios y Plan de Respaldo Final

## 📋 Instrucciones

Completa la sección 7 del Plan de Implantación de tu proyecto real y reemplaza la sección 3 (plan
de respaldo v0 de la semana 2) por el plan final, usando
[`starter/entregable-s06-seguridad-y-respaldo.md`](starter/entregable-s06-seguridad-y-respaldo.md).

En el servidor de tu proyecto (VM Ubuntu del laboratorio o el "servidor" simulado de la semana 4):

- Cuentas por persona, grupo de despliegue y `sudo` limitado
- SSH solo con llave, sin `root`, y UFW negando por defecto
- La app conectada con un rol de base de datos sin permisos de DDL; migraciones con el rol dueño
- Respaldo cifrado automático con restic y cron, con una copia fuera del sitio

En el repositorio del proyecto:

- Script de roles (sin contraseñas reales) y script de respaldo versionados
- `.env.example` actualizado con las cadenas de conexión por rol (valores ficticios)
- Ningún secreto en el historial: revísalo y, si encuentras uno, **rótalo** y documéntalo

Y una restauración de desastre ejecutada por **otra persona** del equipo siguiendo solo el
procedimiento escrito, con el tiempo medido.

Si tu proyecto usa la base en la nube (Neon o Supabase), el rol de la app se crea allí y el
respaldo se toma desde el servidor o desde tu equipo con `pg_dump` hacia restic: el servicio
gestionado tiene sus propios respaldos, pero no reemplazan a una copia que controla el equipo.

## ❓ Preguntas Guía

- Si mañana se va una persona del equipo, ¿qué cuentas, llaves y secretos hay que cambiar?
- ¿Qué puede hacer tu app en la base si alguien encuentra una inyección SQL?
- ¿Dónde está la contraseña de restic si el servidor desaparece?
- ¿Tu restauración de desastre cumple el RTO que acordaste en la semana 2?

## ✅ Checklist de Cierre

- [ ] Matriz de usuarios del sistema operativo y de roles de la base, con pruebas negativas
- [ ] Puertos abiertos justificados y evidencia de que la base no está expuesta
- [ ] Inventario de secretos con ubicación, permisos y procedimiento de rotación
- [ ] Plan de respaldo final: script, cron, cifrado, 3-2-1, retención
- [ ] Restauración de desastre por otra persona, con huellas iguales y tiempo medido
- [ ] Ningún secreto en el repositorio ni en el entregable
