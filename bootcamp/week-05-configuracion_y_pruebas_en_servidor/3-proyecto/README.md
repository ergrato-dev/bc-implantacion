# Proyecto Semana 5 — Configuración, Verificación y Migración Ejecutada

## 📋 Instrucciones

Completa la sección 6 del Plan de Implantación de tu proyecto real y agrega a la sección 2 la
evidencia de la migración ejecutada, usando
[`starter/entregable-s05-configuracion-y-verificacion.md`](starter/entregable-s05-configuracion-y-verificacion.md).

En el repositorio del proyecto:

- `.env.example` completo, con **todas** las variables y valores ficticios
- La app falla al arrancar con un mensaje claro si falta configuración obligatoria
- Endpoint de salud que verifica las dependencias críticas
- Healthchecks y rotación de logs en `deploy/compose.prod.yaml`
- `scripts/smoke-test.sh` ampliado con al menos una verificación propia

Y una migración ejecutada: los datos de tu proyecto (datos iniciales, o los del servidor de la
semana 4) movidos a la base en la nube siguiendo tu plan de la semana 2, con huellas comparadas.

## ❓ Preguntas Guía

- ¿Qué variables de tu proyecto son secretos? ¿Dónde vive cada una en cada ambiente?
- Si falta una variable, ¿tu proyecto lo dice al arrancar o falla después con un usuario?
- ¿Qué dependencias revisa tu endpoint de salud? ¿Alguna no debería revisarse?
- ¿Cuánto duró tu ventana de migración? ¿Cabe en la ventana que acordarías con el cliente?

## ✅ Checklist de Cierre

- [ ] Inventario de configuración completo por ambiente
- [ ] Servicios documentados con dependencias de arranque, reinicio y logs
- [ ] Endpoint de salud, prueba de humo ampliada y casos funcionales
- [ ] Lista de verificación posterior al despliegue
- [ ] Migración ejecutada con registro de la ventana, huellas iguales y prueba de humo tras el corte
- [ ] Ningún secreto en el repositorio ni en el entregable
