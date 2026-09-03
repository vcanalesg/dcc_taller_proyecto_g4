# Mapa guión ↔ deck y tiempos recalculados

**Archivo generado:** `Grupo4_taller_de_proyecto_final_v2.pptx`
**40 láminas:** 32 de contenido + gracias + 2 de referencias + separador de anexo + 4 de anexo.
El original `Grupo4_taller_de_proyecto_final.pptx` **no se tocó**.

> El guión de `docs/guion-presentacion.md` planificaba 25 láminas. El deck real tiene **32 de
> contenido** porque no fusioné láminas existentes que ya estaban bien resueltas (composición,
> descriptivos, rendimiento, target, fuentes): en vez de rehacerlas y arriesgar el diseño, moví al
> **anexo** las redundantes. El presupuesto de 40 minutos se mantiene; abajo va el reparto real.

---

## Bloque 1 — Problema, pregunta y ambas tareas · 4:30

| Deck | mm:ss | Min | Guión | Lámina |
|---:|---|---:|---|---|
| 1 | 00:00 | 0:20 | S1 | Portada |
| 2 | 00:20 | 1:00 | S2 | El problema: el GSE ordena el logro |
| 3 | 01:20 | 0:40 | S2 | ¿Quién dijo que no se puede? (Bellei) |
| 4 | 02:00 | 0:30 | S3 | Pregunta de investigación |
| 5 | 02:30 | 0:40 | S3 | Objetivo y entidad |
| 6 | 03:10 | 0:40 | S4 | **Tarea de clustering — CORREGIDA y movida acá** |
| 7 | 03:50 | 0:40 | S4 | Tarea de predicción — movida acá |

## Bloque 2 — Exploración · 8:30

| Deck | mm:ss | Min | Guión | Lámina |
|---:|---|---:|---|---|
| 8 | 04:30 | 1:20 | S5 | Embudo 3.000 → 1.429 — **corregido a 97** |
| 9 | 05:50 | 0:45 | S6 | Características de los establecimientos |
| 10 | 06:35 | 0:45 | S6 | Estadísticos descriptivos |
| 11 | 07:20 | 0:45 | S7 | Rendimiento de los establecimientos |
| 12 | 08:05 | 0:50 | S7 | Definición del target binario |
| 13 | 08:55 | 0:40 | S8 | Fuentes de datos |
| 14 | 09:35 | 0:35 | S6 | Análisis de outliers |
| 15 | 10:10 | 1:30 | S9 | Poder discriminante — **74,4 y 85,1 corregidos** |
| 16 | 11:40 | 0:50 | S10 | Variables categóricas — **bullet repetido eliminado** |
| 17 | 12:30 | 0:30 | S10 | Selección de variables: un solo IDPS |

## Bloque 3 — Clustering · 10:00 · **seis láminas nuevas**

| Deck | mm:ss | Min | Guión | Lámina |
|---:|---|---:|---|---|
| 18 | 13:00 | 1:20 | S11 | Qué agrupamos y qué dejamos fuera |
| 19 | 14:20 | 1:40 | S12 | Cómo elegimos k — figura nueva de métricas vs k |
| 20 | 16:00 | 1:30 | S13 | Los dos grupos (PCA + perfiles) |
| 21 | 17:30 | 2:00 | S14 | **Mismas condiciones, resultados distintos** `[PAUSA]` |
| 22 | 19:30 | 1:30 | S15 | Cinco escuelas típicas por grupo, con nombre |
| 23 | 21:00 | 2:00 | S16 | Robustez k=4 — figura nueva de perfiles |

## Bloque 4 — Clasificadores · 10:00

| Deck | mm:ss | Min | Guión | Lámina |
|---:|---|---:|---|---|
| 24 | 23:00 | 1:30 | S17 | Ajuste de hiperparámetros y desbalance |
| 25 | 24:30 | 1:40 | S18 | Evaluación de los modelos |
| 26 | 26:10 | 2:00 | S19 | **Umbral — rehecha con balanced accuracy** `[PAUSA]` |
| 27 | 28:10 | 1:20 | S20 | Métricas de efectividad a 0,50 + nota de lectura |
| 28 | 29:30 | 1:50 | S21 | Qué factores se asocian al rendimiento |
| 29 | 31:20 | 1:40 | S22 | Revisión de casos |

## Bloque 5 — Conclusiones · 5:00 · **tres láminas nuevas**

| Deck | mm:ss | Min | Guión | Lámina |
|---:|---|---:|---|---|
| 30 | 33:00 | 1:30 | S23 | Comparación de clasificadores y cuál elegimos |
| 31 | 34:30 | 1:40 | S24 | Sobre qué puede actuar una escuela `[PAUSA]` |
| 32 | 36:10 | 1:50 | S25 | Lo que no permite concluir y qué haríamos distinto `[PAUSA]` |

**Cierre 38:00 · margen 2:00 · preguntas 5:00**

Láminas 33–35: gracias y referencias. Láminas 36–40: anexo.

---

## Qué cambió respecto del pptx original

### Láminas nuevas (9)
Clustering 18–23 y conclusiones 30–32, construidas con la tipografía y paleta del deck
(Raleway 26 pt `#0F172A` para el título, Raleway SemiBold 12 pt `#2563EB` para el subtítulo,
Source Sans Pro 11,5 pt `#16202C` para el cuerpo, cabecera de tabla `#2563EB`).

### Correcciones de contenido
| Lámina | Cambio |
|---|---|
| 8 (ex 6) | «96 con 10% o más sin dato en género y 1 sin asistencia» → «**97** … (uno de ellos, además, sin asistencia)» |
| 15 (ex 17) | 74,5 → **74,4** · 85,0% → **85,1%** |
| 16 (ex 18) | Eliminado el bullet repetido «El tramo de carrera docente no discrimina / AUC 0,539» |
| 6 (ex 20) | Variables de agrupación: los 4 IDPS + género → **las 3 de proceso realmente usadas**. Algoritmos: K-Means (final, k=2), Ward (contraste), GMM (estabilidad). Se agrega qué queda reservado y la regla de decisión |
| 26 (ex 24) | **Rehecha**: fuera las dos figuras y la tabla de F1; entra la figura de balanced accuracy, la tabla con sensibilidad/especificidad y la justificación del umbral 0,50 |
| 27 (ex 25) | Nota: bajo el criterio de clases con igual peso se leen los dos recalls, no la precisión |

### Movidas al anexo (37–40)
Fuentes en detalle no, se mantiene en el flujo. Al anexo: segundo panel de outliers, las dos
matrices de dispersión y la síntesis de relaciones clave.

### Reordenamiento
Las dos definiciones de tarea pasaron del final de la exploración al **bloque 1**, y los resultados
de clustering quedaron **antes** que los de clasificación, como pide la rúbrica.

---

## Figuras generadas para este deck

| Archivo | Usada en | Contenido |
|---|---|---|
| `figuras_nuevas/fig_metricas_k.png` | 19 | Silhouette, Davies-Bouldin y Calinski-Harabasz vs k, K-Means y Ward, con la discrepancia de DB anotada |
| `figuras_nuevas/fig_perfiles_k4.png` | 23 | Heatmap de los 4 perfiles (color por z-score, cifras en escala original) + % que supera por perfil |
| `figuras_nuevas/fig_umbral_balanced.png` | 26 | Histograma de scores fuera de fold + curvas de sensibilidad, especificidad, balanced accuracy y F1 macro |

Cierra `[FALTA-1]`, `[FALTA-3]` y `[FALTA-4]` del guión.

## Vacíos que siguen abiertos

- `[FALTA-2]` Re-ejecutar y guardar `EDAyPreprocesamiento_01.ipynb` (5 celdas sin salida).
- `[FALTA-5]` `[FALTA-6]` `[FALTA-7]` Agregar a los notebooks las celdas de estabilidad entre
  semillas, nombres de casos representativos y perfil de los 97 excluidos. Las cifras ya están en
  el deck; falta dejarlas reproducibles en el notebook.
- `[FALTA-8]` La frase «primera posición en el 95% de las réplicas (1.000)» de la lámina 17 sigue
  **sin respaldo en ningún notebook**. O se corre el bootstrap, o se saca la frase.
- `[FALTA-9]` Sensibilidad sin los 68 imputados con SIMCE 2023.
- `[FALTA-10]` Verificar la distribución regional (31% RM, 11% Valparaíso, 9% Biobío) de la lámina 9.
