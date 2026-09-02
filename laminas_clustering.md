# Punteo de láminas — Componente Clustering (30%)

*Taller de Proyecto · Diplomado en Ingeniería y Ciencia de Datos · Grupo 4*

**Pregunta de investigación:** ¿Qué caracteriza a las escuelas de nivel socioeconómico bajo
que alcanzan mejores logros de aprendizaje que otras escuelas en condiciones similares?

> **Mensaje único del bloque.** Con el nivel socioeconómico prácticamente igualado entre los
> dos grupos, lo que separa a las escuelas que rinden mejor no es su contexto: son sus
> procesos internos.

Todas las cifras provienen de la ejecución de [`tarea_clustering.ipynb`](tarea_clustering.ipynb)
sobre `datos/base_tareas_filtrada.parquet` (1.429 establecimientos). Modelo final: K-Means,
k=2, `random_state=42`.

---

## Lámina 1 — Qué agrupamos, y sobre todo qué dejamos fuera

*Cubre el componente «datos usados» (10% de la rúbrica).*

- Unidad de análisis: el **establecimiento** (`rbd`), no el estudiante. 1.429 escuelas de GSE
  bajo y medio-bajo.
- Agrupamos con **solo 3 variables de proceso escolar**: `convivencia`, `asistencia_2m` y
  `promedio_estandarizado_genero`.
- Dejamos fuera del agrupamiento las **variables objetivo** (`prom_mate2m_rbd`, `target_bin`)
  y las **de contexto** (`ive_media`, `pct_tramo_avanzado_mas`).
- **Por qué importa:** si el logro entra como insumo, los grupos se separan por logro *por
  construcción* y no explican nada. Y al dejar el IVE fuera, después podemos **verificar** si
  los grupos quedaron comparables en nivel socioeconómico.

**Insumo:** tabla de selección de variables (sección «Columnas disponibles y selección»).

**Nota del expositor:** esta es la decisión de diseño que hace que el resultado signifique
algo. Vale gastar 30 segundos en ella.

---

## Lámina 2 — Cómo elegimos el modelo

*Cubre los componentes «algoritmos usados» y «ajuste de parámetros» (10% de la rúbrica).*

- Dos algoritmos comparados: **K-Means** y **Agglomerative (Ward)**, ambos con k de 2 a 8.
- Preprocesamiento: `StandardScaler`, porque las tres variables están en escalas
  incomparables y ambos algoritmos usan distancia euclidiana.
- Tres métricas internas: **silhouette**, **Davies-Bouldin** y **Calinski-Harabasz**.
- Regla fijada **antes** de mirar los resultados: se adopta el máximo de silhouette.
- Ganador: **K-Means con k=2**, silhouette 0,257. Calinski-Harabasz coincide (548,1);
  Agglomerative queda por debajo en todo el rango (máx. 0,214).
- Reproducible: `random_state=42`, `n_init=25`.

> **Declarar en la lámina, no esconder.** Davies-Bouldin no acompaña: su mínimo está en k=8.
> Lo descartamos porque fragmenta la muestra sin ganar interpretación, y dejamos la
> discrepancia escrita.

**Insumo:** tabla de métricas + figura de 3 paneles (métricas vs. k).

---

## Lámina 3 — Los dos grupos que aparecen

*Cubre «visualización de grupos» (parte del 20% de la rúbrica).*

| | Cluster 0 — procesos favorables | Cluster 1 — procesos más débiles |
|---|---|---|
| n | 640 · 44,8% | 789 · 55,2% |
| `convivencia` | 78,1 | 72,9 |
| `asistencia_2m` | 0,895 | 0,832 |
| `promedio_estandarizado_genero` | −0,107 | +0,080 |

- En el PCA, **PC1 (44,4%) es el eje de procesos**: carga casi por igual en convivencia
  (+0,669) y asistencia (+0,666). Es el eje que separa a los grupos.
- PC2 (32,0%) está dominado por creencias de género (+0,944), donde los grupos se distinguen
  mucho menos.
- Los dos componentes retienen **76,4%** de la varianza: la figura 2D representa fielmente el
  espacio, no es una proyección engañosa.

**Insumos:** `cluster_pca.png` y `cluster_heatmap.png`.

---

## Lámina 4 — El hallazgo: mismas condiciones, resultados distintos

*Lámina clave del bloque.*

| Indicador | Cluster 0 | Cluster 1 |
|---|---:|---:|
| *Condiciones — no se usaron para agrupar* | | |
| IVE medio (vulnerabilidad) | 0,888 | 0,890 |
| % docentes tramo avanzado+ | 31,2% | 33,2% |
| *Resultado — tampoco se usó para agrupar* | | |
| **Puntaje Matemática 2° medio** | **248,4** | **229,6** |
| **% sobre 252 puntos** | **41,6%** | **11,2%** |

- Los grupos quedaron **prácticamente idénticos en vulnerabilidad**: una diferencia de 0,002
  frente a una desviación estándar de ~0,06. También empatan en dotación docente.
- Y aun así difieren en **18,9 puntos** de promedio y en **30,4 puntos porcentuales** sobre el
  umbral.
- Esto es, literalmente, el «**en condiciones similares**» de la pregunta de investigación: no
  lo asumimos, lo verificamos.

**Insumo:** `cluster_heatmap.png` — sobre la línea negra los colores son intensos (procesos);
bajo la línea son casi blancos (contexto). La imagen cuenta la historia sola.

**Nota del expositor:** si la audiencia recuerda una sola lámina, tiene que ser esta.

---

## Lámina 5 — Qué caracteriza a las que rinden mejor

*Cubre «interpretación de grupos» (parte del 20% de la rúbrica).*

- **Asistencia:** 0,895 vs. 0,832.
- **Convivencia escolar:** 78,1 vs. 72,9.
- **Creencias de género menos estereotipadas:** −0,107 vs. +0,080.
- Las correlaciones directas con el puntaje **ordenan igual** esos rasgos: convivencia
  +0,364, asistencia +0,329, género −0,240.
- Las variables de contexto son las más débiles de toda la base: IVE −0,141 y % docentes
  tramo avanzado −0,033, prácticamente nula.
- Ese último dato **coincide con lo que el grupo ya había encontrado por otra vía** en
  `EDAyPreprocesamiento_01.ipynb` (celda 180): su importancia por permutación era
  indistinguible de cero.

**Insumos:** tabla de perfiles + tabla de correlaciones con el resultado.

---

## Lámina 6 — Casos representativos de cada grupo

*Cubre «revisión de casos en cada grupo» (parte del 20% de la rúbrica).*

- Criterio: los **5 establecimientos más cercanos al centroide** de su grupo, en el espacio
  estandarizado. Cerca del centroide = caso típico, no caso de frontera.
- Típicos del **Cluster 0**: convivencia 77–79, asistencia sobre 0,89; los cinco particulares
  subvencionados.
- Típicos del **Cluster 1**: convivencia 73–74, asistencia 0,82–0,84; predominan municipales.
- Detalle que vale mostrar: dentro de los típicos del Cluster 0 el IVE va de 0,828 a 0,964 y
  el % de docentes avanzados de 5,3% a 42,6%. Como no participaron del agrupamiento, **varían
  libremente**.

> **Honestidad que suma puntos.** Entre los casos típicos del Cluster 0 hay escuelas de 233 y
> de 295 puntos; en el Cluster 1, de 216 y 249. **Pertenecer a un grupo no determina el
> resultado de una escuela concreta**: las diferencias son de promedios.

---

## Lámina 7 — Lo que no podemos afirmar

- **No es causal.** Es descriptivo y correlacional: un corte transversal con tres variables.
- Los grupos están igualados en IVE pero **no en dependencia**: el Cluster 0 es 68,1%
  particular subvencionado y el Cluster 1 es 47,5% municipal. Parte de la brecha puede ser
  efecto de sector.
- La estructura es **moderada** (silhouette 0,257): describe un gradiente de calidad de
  procesos, no dos poblaciones separadas.
- Los dos algoritmos **no coinciden del todo** (ARI 0,411): la frontera exacta depende del
  método.
- Hay **fuerte solapamiento individual**: desviaciones de 27,5 y 18,7 puntos dentro de cada
  grupo.

**Nota del expositor:** incluir esta lámina anticipa las preguntas del jurado y demuestra
control del método. No sacarla por falta de tiempo.

---

## Si hay que recortar

- Las láminas **3 y 6** se pueden fusionar sin perder el argumento.
- Las láminas **1, 4 y 7** son las que no conviene tocar: sostienen el diseño del análisis, el
  hallazgo y su alcance.

## Figuras disponibles

| Archivo | Contenido |
|---|---|
| `cluster_pca.png` | Los dos grupos proyectados en PCA 2D, con centroides |
| `cluster_heatmap.png` | Perfil promedio por grupo en z-score; línea que separa las variables que agrupan de las que no |
| `cluster_boxplots.png` | Distribución por grupo: 3 variables de clustering + 2 de contexto + resultado |
