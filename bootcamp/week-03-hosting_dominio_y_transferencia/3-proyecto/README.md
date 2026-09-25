# Proyecto Semana 3 — Estrategia de Hosting y Dominio

## 📋 Instrucciones

Completa la sección 4 del Plan de Implantación de tu proyecto real
(`docs/plan-implantacion.md`, copiado de
[`docs/plan-implantacion-template.md`](../../../docs/plan-implantacion-template.md)) usando
[`starter/entregable-s03-hosting-y-dominio.md`](starter/entregable-s03-hosting-y-dominio.md)
como guía detallada.

Además, en el repositorio del proyecto:

- Agrega un `Caddyfile` (o configuración equivalente) que publique tu proyecto detrás de un
  reverse proxy con los nombres de dominio que elegiste, y pruébalo localmente con
  `tls internal` y `curl --resolve`, como en la práctica 02.

Esta semana se **decide y prueba en local**; el despliegue real en la nube es la semana 4.

## ❓ Preguntas Guía

- ¿Qué componentes tiene tu proyecto y cuál es el tipo de hosting adecuado para cada uno?
- ¿Qué nombre de dominio usará el cliente y quién lo pagará y renovará?
- ¿Qué puertos de tu servidor deben quedar abiertos a Internet y cuáles no?
- ¿Qué archivos, además de la imagen o el código, hay que llevar al servidor? ¿Cómo?

## ✅ Checklist de Cierre

- [ ] Tipo de hosting elegido y justificado por componente
- [ ] Dominio definido con tabla de registros DNS y TTL
- [ ] Diagrama o descripción del camino de una petición (dominio → DNS → proxy → servicio)
- [ ] Configuración del reverse proxy en el repositorio, probada localmente con evidencia
- [ ] Método de transferencia de archivos con autenticación por llave
- [ ] Sin IPs, hosts, usuarios ni contraseñas reales
