# Práctica 04 — Estimación de Costos

<!-- 📝 Instrucción: práctica en equipo. Los precios cambian: cada equipo anota la fecha de
consulta y el enlace de cada valor. No se evalúa el número exacto sino el método. -->

## Objetivo

Estimar el costo mensual y anual de alojar la app de referencia con usuarios reales en tres
alternativas, y recomendar una.

## Duración estimada

90 minutos.

## Escenario

La biblioteca abrirá el sistema a 300 usuarios, con picos de 50 usuarios concurrentes en horario
laboral. Requisitos **recomendados** (semana 1): 2 vCPU, 2 GB de RAM, 20 GB de disco, respaldo
diario con retención de 30 días. La base de datos no superará 5 GB en tres años.

## 1. Alternativas

| # | Alternativa | Qué cotizar |
|---|---|---|
| A | VPS en una gran nube (IaaS) | 1 VM de 2 vCPU / 2 GB + disco 20 GB + snapshots o almacenamiento para respaldos |
| B | PaaS + base gestionada | Plan pago de Render que cumpla 2 GB de RAM + plan pago de Neon o Supabase |
| C | Servidor propio | Equipo que cumpla los requisitos, amortizado a 3 años, + energía estimada |

Usa las calculadoras de la teoría [`04-costos-y-free-tier.md`](../../1-teoria/04-costos-y-free-tier.md)
y las páginas de precios de cada proveedor.

## 2. Tabla de estimación

| Concepto | A — IaaS | B — PaaS | C — Propio |
|---|---|---|---|
| Cómputo | | | |
| Almacenamiento | | | |
| Respaldos | | | |
| Otros (IP, transferencia, energía) | | | |
| **Total mensual** | | | |
| **Total anual** | | | |
| Horas de administración estimadas al mes | | | |
| Fuente y fecha de consulta | | | |

## 3. Costos ocultos

Para cada alternativa, identifica al menos un costo que no aparece en la calculadora (ej. horas
de parches, renovación de dominio, reemplazo de un disco).

## 4. Recomendación

Redacta una recomendación de 5-8 líneas para el cliente: cuál alternativa, por qué, y qué
riesgo acepta.

## 5. Free tier: ¿alcanza?

¿Podría la biblioteca operar con los planes gratuitos de la práctica 03? Responde con los límites
concretos que consultaste (suspensión, almacenamiento, horas de cómputo).

## ✅ Checklist

- [ ] Tres alternativas cotizadas con fuente y fecha
- [ ] Costos ocultos identificados
- [ ] Recomendación justificada, incluyendo horas de administración
- [ ] Respuesta fundamentada sobre el free tier
