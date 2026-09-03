# Etapa 1 — Inventario de evidencia y auditoría técnica

*Insumo para el guión de la presentación final. Grupo 4.*
Toda cifra de este documento tiene procedencia declarada. Las marcadas **[verificado]** fueron
re-ejecutadas contra los parquet del repo en esta auditoría.

---

## A. Inventario de fuentes

| # | Artefacto | Estado | Qué aporta |
|---|---|---|---|
| E1 | `EDAyPreprocesamiento_01.ipynb` | 194 celdas · 103 de código con salida · **5 celdas de resultados SIN salida guardada** (168, 177, 186, 188, 190) | EDA completo + clasificación (logística / RF / SHAP) |
| E2 | `tarea_clustering.ipynb` | 34 celdas, **ejecutado completo** (2-sep) | Clustering **k=2** sobre 3 variables de proceso |
| E3 | `ClusteringyClasificacion.ipynb` | 43 celdas, **ejecutado completo** (23-ago) | Clustering **k=4** sobre clima+género+IVE, con Hopkins, ANOVA, χ², Bonferroni |
| E4 | `tarea_clasificacion.ipynb` | 33 celdas, **CERO ejecutadas** | **Fuera de alcance por instrucción del usuario.** No se cita nada de este notebook |
| E5 | `laminas_clustering.md` | Redactado | 7 láminas de clustering ya escritas sobre E2 |
| E6 | `laminas_clasificacion/` | 14 PNG + 4 CSV | Figuras y tablas de clasificación listas |
| E7 | `Grupo4_taller_de_proyecto_final (3).pdf` | **29 páginas** (26 contenido + gracias + 2 referencias) | Deck vigente. Reemplaza a `(2).pdf` |
| E8 | `clases/2026_08_06_2_Rubrica_presentacion_final.pdf` | — | Rúbrica: **40 + 5 min por grupo** |

---

## B. Evidencia disponible, por bloque

### B.1 Población y limpieza (E1)

| Paso | n | Fuente |
|---|---|---|
| SIMCE Mat. 2°M 2024, todos los GSE | 3.000 | E1 c6 |
| 97 casos con `marca_mate2m_rbd` 1–4 → **68 imputados con SIMCE 2023**, 29 no rescatables | 2.966 | E1 c10, c12 |
| −19 con ≤6 evaluados y puntaje reportado | 2.947 | E1 c17 |
| GSE bajo (678) + medio-bajo (855) | 1.533 | E1 c28 |
| −7 sin IDPS | 1.526 | E1 c36 |
| −97 por ≥10% de no respuesta en ítems de género | **1.429** | E1 c47, c161 |

Target: corte oficial 252. Insuficiente 1.075 (75,2%) · Elemental 339 (23,7%) · Adecuado 15 (1,0%)
→ binario 1.075 / 354 (24,8%). *(E1 c29, c163)*

### B.2 Construcción del índice de género (E1)

α de Cronbach ordinal **0,919**; correlación policórica media 0,655; 1 factor con **71,5%** de la
varianza; cargas 0,750–0,882; 112.206 de 117.652 estudiantes con los 6 ítems (95,4%). El *factor
score* correlaciona **1,000** con el promedio simple. *(E1 c54–c60)*

### B.3 Poder discriminante univariado — **[verificado]**, reproduce exacto la lámina 17 del deck (3)

| Variable | r con puntaje | AUC | Cohen's d |
|---|---:|---:|---:|
| Clima y convivencia | 0,364 | 0,704 | 0,76 |
| Asistencia 2°M | 0,329 | 0,697 | 0,68 |
| Autoestima y motivación | 0,322 | 0,684 | 0,69 |
| Participación | 0,306 | 0,681 | 0,67 |
| Vida saludable | 0,220 | 0,635 | 0,48 |
| Estereotipos de género | −0,240 | 0,629 | −0,47 |
| IVE | −0,141 | 0,596 | −0,25 |
| % docentes tramo avanzado+ | −0,033 | 0,539 | −0,12 |

Brechas: convivencia 77,6 vs 74,4 · asistencia 88,7% vs 85,1%.
Correlaciones entre los 4 IDPS: **0,685 a 0,884** (E1 c40).
Categóricas (deck (3) s18): dependencia Cramér's V 0,241 · GSE 0,213 · zona 0,016.

### B.4 Clustering E2 — k=2, variables de proceso (el que está en `laminas_clustering.md`)

- Variables: `convivencia`, `asistencia_2m`, `promedio_estandarizado_genero`. **StandardScaler sí
  aplicado** (E2 c11). PCA **solo para visualizar**, no para agrupar (E2 c20).
- Métricas (E2 c13): KMeans k=2 silhouette **0,2568**, DB 1,4438, CH **548,1** (máximo). Agglomerative
  máx. 0,2142. Davies-Bouldin discrepa (mínimo en k=8) y está declarado.
- ARI KMeans vs Ward (k=2): **0,411**. Tamaños 640 / 789.
- PCA: PC1 44,4% (convivencia +0,669, asistencia +0,666), PC2 32,0% (género +0,944); acumulado 76,4%.
- Perfiles (E2 c29):

| | Cluster 0 (n=640) | Cluster 1 (n=789) |
|---|---:|---:|
| convivencia | 78,1 | 72,9 |
| asistencia | 0,895 | 0,832 |
| género (z) | −0,107 | +0,080 |
| *IVE (no agrupa)* | 0,888 | 0,890 |
| *% docentes avanzado+ (no agrupa)* | 31,2 | 33,2 |
| **puntaje** | **248,4** | **229,6** |
| **% sobre 252** | **41,6** | **11,2** |

- Dependencia: C0 68,1% part. subv. / 26,7% municipal / 5,2% SLEP; C1 47,5% municipal / 41,4% part.
  subv. / 11,0% SLEP.
- Casos representativos con nombre **[verificado]**: C0 → Colegio Los Pensamientos (La Granja),
  Centro Educacional London (La Florida), Colegio Cristóbal Colón (Coquimbo), Liceo Part. Libertad
  (Villarrica), Colegio San Juan Bautista (Ovalle). C1 → Liceo Nueva Zelandia (Santa Juana), Liceo
  Bicentenario Domingo Santa María (Iquique), Liceo de Yungay, Liceo Carelmapu (Maullín), Liceo
  Gabriela Mistral (Independencia).
- **Estabilidad entre semillas [verificado]**: 20 semillas, ARI mínimo **0,986**, medio 0,997.
- **Estabilidad entre algoritmos [verificado]**: ARI vs Ward 0,411 · vs GMM **0,642** (silhouette GMM
  0,231, tamaños 853/576).

### B.5 Clustering E3 — k=4, clima + género + IVE (alternativa ejecutada)

- Variables: `idps_index` (promedio de los 4 IDPS estandarizados), género, `ive_media`. StandardScaler sí.
- **Hopkins 0,819** (10 repeticiones) — E2 no tiene este test.
- Silhouette **plana**: 0,240 / 0,250 / 0,251 / 0,237 / 0,232 / 0,230 / 0,232 para k=2…8. k=4 elegido
  **por interpretabilidad**, declarando que la métrica es indiferente.
- ARI k-means vs Ward 0,279 · vs GMM 0,503. Silhouette final 0,251.
- **Estabilidad entre semillas [verificado]**: 20 semillas, ARI mínimo 0,939, medio 0,982.
- Perfiles y logro:

| Perfil | Clima | Género | IVE | n | Puntaje | % supera |
|---|---:|---:|---:|---:|---:|---:|
| 1 Clima favorable, baja vulnerabilidad | +0,72 | −0,27 | 0,88 | 309 | 251,8 | **46,9** |
| 2 Clima débil, baja vulnerabilidad | −0,28 | +0,02 | 0,80 | 266 | 237,3 | 24,1 |
| 3 Clima favorable, alta vulnerabilidad | +0,50 | +0,21 | 0,93 | 404 | 236,2 | 21,8 |
| 0 Clima débil, alta vulnerabilidad | −0,78 | −0,02 | 0,91 | 450 | 230,6 | **12,7** |

- ANOVA F=50,33 p=6,4e−31; χ²(perfil × target) = 118,77, gl=3, p=1,4e−25; 5 de 6 pares
  significativos con Bonferroni (la excepción: perfil 2 vs 3, dif 1,03 pts, p=1,000).
- 12 casos representativos **con nombre y comuna** ya tabulados.

### B.6 Clasificación (E1) — **todo re-ejecutado y reproduce exacto**

| Modelo | AUC test | AUC 5-fold | sd | F1 macro | bal. acc |
|---|---:|---:|---:|---:|---:|
| Baseline (clase mayoritaria) | 0,500 | 0,500 | 0,000 | 0,429 | 0,500 |
| Regresión logística (C=0,1) | **0,817** | **0,783** | 0,014 | 0,696 | 0,744 |
| Random Forest (`min_samples_leaf=15`) | 0,810 | 0,788 | 0,004 | 0,709 | 0,735 |

Grid logística: AUC CV 0,7762–0,7769 en todo el rango de C (plano). Grid RF: mejor 0,7838.

Barrido de umbral (logística, test n=358) — **[verificado, con la columna que faltaba]**:

| Umbral | Precisión (+) | Recall (+) | F1 | n predichos + | **Recall clase negativa** |
|---:|---:|---:|---:|---:|---:|
| 0,45 | 0,444 | 0,798 | 0,570 | 160 | 0,669 |
| **0,50** | 0,479 | 0,764 | **0,589** | 142 | 0,725 |
| 0,55 | 0,513 | 0,663 | 0,578 | 115 | 0,792 |
| **0,60** | **0,591** | 0,584 | 0,588 | 88 | **0,866** |
| 0,65 | 0,595 | 0,494 | 0,540 | 74 | 0,888 |

Matriz de confusión a 0,50: 195 aciertos negativos, 74 FP, 68 aciertos positivos, 21 FN.
Importancia por permutación (logística): convivencia 0,099 · part. subv. 0,086 · asistencia 0,063 ·
IVE 0,035 · género 0,020 · tramo docente 0,009 ± 0,010 · SLEP 0,001.
SHAP sobre RF (valor base 0,502): asistencia 0,100 · convivencia 0,076 · part. subv. 0,061 · IVE
0,061 · género 0,059; efectos en S con saturación (asistencia se aplana sobre 0,90; convivencia
sobre 80). Caso par: FP 0,807 (236 pts) y acierto 0,812 (256 pts) con descomposición casi idéntica.
Focalización: los 50 de menor score son **100%** realmente Insuficiente (tasa base 75,1%); los 100
primeros, 97%.
Falsos negativos con nombre: Liceo Bicentenario de Excelencia Técnica (Loncoche, IVE 0,98, 258 pts),
Liceo Industrial José Tomás de Urmeneta (Coquimbo, 267), Colegio Robinson Cabrera Beltrán (Retiro,
282), entre otros.

---

## C. Hallazgos de la auditoría técnica

### 🔴 ALTA

**H1 · La exclusión de los 97 establecimientos NO es aleatoria, y sesga todo hacia arriba.**
**[verificado — reconstruí la base de 1.526 exacta y comparé los 97 excluidos contra los 1.429]**

| | Excluidos (97) | Incluidos (1.429) |
|---|---:|---:|
| Estudiantes evaluados (mediana) | **29** | **64** |
| Puntaje medio | 221,2 | 238,0 |
| **% que supera 252** | **3,1%** | **24,8%** |
| % rural | 18,6% | 8,5% |
| % GSE bajo | 50,5% | 43,7% |

Mann-Whitney sobre el tamaño: p = 9,5e−18. Los 97 son las escuelas **más chicas, más rurales y de
peor rendimiento**: solo 3 de 97 superan el corte. La prevalencia real en los 1.526 es **23,4%**, no
24,8%. Esto responde de frente la pregunta que planteaste: el faltante correlaciona fuertemente con
el tamaño. Consecuencia para el relato: las conclusiones valen para escuelas de tamaño medio o
grande; el modelo no fue entrenado en las más pequeñas y vulnerables, que son justamente las que un
sostenedor querría focalizar. **Esto tiene que estar dicho por el equipo, y es además el mejor
material para "conocimiento adquirido".**

**H2 · ~~`tarea_clasificacion.ipynb`~~ — RETIRADO DEL ALCANCE.** Por instrucción del usuario ese
notebook no se considera. Consecuencia práctica: **su redacción sobre sesgo de método común y
causalidad inversa —la mejor del repo— no puede citarse**, y hay que escribir esa advertencia
desde cero en el guión (ver H9).

**H3 · `pct_preferentes` fue descartada en silencio, y era la variable de mayor ganancia.**
El EDA concluye textualmente que era la mayor ganancia de todo el preprocesamiento (CV 0,780 →
0,809) y decide **agregarla**. Está en `base_tareas.parquet` pero **no** en
`base_tareas_filtrada.parquet`, así que quedó fuera del modelo final y del clustering, sin
justificación escrita. **[verificado]**: agregándola, la CV sube de **0,7828 a 0,8060 (+0,023)**.

**H4 · Las cinco celdas que producen los números titulares del deck no tienen salida guardada**
(E1 168, 177, 186, 188, 190: AUC de test, tabla comparativa de CV y los tres gráficos SHAP).
Mitigación: **las re-ejecuté y reproducen exacto** (0,8174 / 0,8102 / 0,7828±0,0143 /
0,7881±0,0042). El riesgo es de entregable, no de veracidad: hay que re-ejecutar y guardar antes de
subir el notebook.

**H5 · Conviven dos clusterings ejecutados con mensajes distintos.** E2 (k=2, procesos, IVE igualado
→ "los procesos separan") y E3 (k=4, con IVE dentro → "la vulnerabilidad fija el techo"). Hay que
decidir cuál es el principal. No son contradictorios —E3 mete el IVE en el espacio y E2 lo deja
fuera a propósito— pero presentar los dos sin explicar la relación es un flanco abierto.

### 🟠 MEDIA

**H6 · ✅ RESUELTO en el deck (3).** La lámina falsa de SMOTE / RandomizedSearchCV fue eliminada.
La nueva s22 declara correctamente lo que se hizo: `GridSearchCV` con `StratifiedKFold(k=5)`
optimizando AUC-ROC y `class_weight="balanced"` **sin remuestreo**. Verificado contra E1 c163–c166.
El dato nuevo que aporta ("con hoja = 1 el AUC cae a 0,7672") es consistente con el grid.

**H7 · La lámina 20 (ex 28) sigue sin describir ninguno de los dos clusterings ejecutados.** Declara
agrupar con los 4 IDPS + género y comparar K-Means / jerárquico / GMM. E2 agrupa con convivencia +
asistencia + género (KMeans y Ward). E3 agrupa con `idps_index` + género + IVE (KMeans, Ward y GMM).
Además contradice la lámina 19, que argumenta usar **un solo** IDPS. **NO resuelto.**

**H8 · El umbral sigue sin justificarse por su uso, y ahora ni siquiera se declara cuál se adopta.**
La nueva s24 muestra el barrido y dice que el F1 es máximo en 0,50 con 0,60 "casi empatado", pero
**no enuncia la decisión**; la s25 reporta la efectividad a 0,50 sin decirlo. F1 en 0,50 es 0,589 y en
0,60 es 0,588: empate técnico. Los dos usos de política pública separan claramente:
*focalizar apoyo* → 0,60 da recall de la clase negativa **0,866** vs 0,725; *seleccionar casos de
estudio* → 0,60 da precisión **0,591** con 88 candidatos vs 0,479 con 142. En ambos usos 0,60 es
mejor que 0,50. La justificación actual ("mejor recall, no dejar pasar escuelas") define un uso que
nunca se enuncia.

**H9 · Sesgo de método común y causalidad inversa: sigue sin estar en el deck.** Convivencia y
estereotipos de género salen del cuestionario que responden **los mismos estudiantes, el mismo día**
que rinden la prueba. Es la objeción más fuerte que puede recibir el grupo, y hay que escribirla
desde cero (E4 está fuera de alcance).

**H9b · La clasificación no tiene revisión de casos, y la rúbrica la pide explícitamente.** El 20%
del bloque 4 es *"histograma de scores y umbral, métricas de efectividad, **revisión de casos**"*.
El deck (3) cubre las dos primeras (s24, s25) y omite la tercera. El material ya existe y está
exportado: `tabla_revision_casos.csv`, `tabla_falsos_negativos.csv` y los tres waterfall de SHAP
(`L4-7_*.png`). Es puntaje que hoy se está dejando sobre la mesa.

**H10 · Comparabilidad de la imputación con SIMCE 2023.** 68 establecimientos recibieron el puntaje
del año anterior. La propia Agencia advierte sobre comparaciones entre aplicaciones, y está en las
referencias del deck (s30) — o sea, el grupo conoce la advertencia y aun así imputó sin
sensibilidad. Son 4,8% de los 1.429; el análisis de sensibilidad (correr todo sin ellos) es barato.

**H11 · Estabilidad de clusters: buena noticia no aprovechada. [verificado]** Ambas particiones son
casi perfectamente reproducibles entre semillas (ARI ≥ 0,94; en E2, ≥ 0,986). Lo que cambia es el
**algoritmo**: ARI 0,411 con Ward y 0,642 con GMM. Traducción honesta y defendible: *el resultado no
depende del azar, pero la frontera exacta sí depende del método* — coherente con un gradiente.

### 🟡 BAJA

- **H12** · Lámina 6: sigue diciendo "96 con 10% o más sin dato en género y 1 sin asistencia". El
  notebook elimina **97 por género**, y 1.526 − 97 = 1.429 exacto: el caso sin asistencia está
  **dentro** de esos 97, no es adicional. **NO resuelto en el deck (3).**
- **H13** · El bullet "el tramo de carrera docente no discrimina (AUC 0,539)" aparece en s17 y se
  repite en s18, donde no corresponde (s18 es de categóricas). **NO resuelto en el deck (3).**
- **H17** · s17 dice que los que no superan promedian "74,5" en convivencia; el valor exacto sobre
  los 1.429 es **74,4**. Redondeo, sin consecuencia.
- **H14** · El silhouette de E2 (0,257) está bien reportado como "estructura moderada". Correcto y
  hay que sostenerlo, no disculparlo.
- **H15** · Contradicción menor de E2: la celda 9 afirma que las correlaciones entre las 3 variables
  de agrupamiento "son bajas (la mayor 0,29)", pero luego PC1 concentra 44,4% cargando parejo en
  convivencia y asistencia. Ambas cosas son ciertas; la redacción invita a la pregunta.
- **H16** · El deck usa `depe` con 3 categorías (Municipal / Part. subv. / SLEP) pero
  `base_tareas_filtrada` conserva el mapeo con "Part. pagado", que no aparece en la población. Sin
  efecto en resultados.

---

## D. Delta deck (2) → deck (3)

31 páginas → **29** (26 de contenido). Revisado íntegro.

### Resuelto

| Punto | Cómo quedó |
|---|---|
| Lámina falsa de SMOTE / RandomizedSearchCV | **Eliminada.** La nueva s22 declara `GridSearchCV` + `StratifiedKFold(k=5)` + `class_weight="balanced"` sin remuestreo. Correcto |
| Cuatro láminas vacías (solo título) | **Desarrolladas** en s22 (ajuste), s23 (evaluación), s24 (histograma y umbral), s25 (efectividad), s26 (factores) |
| Lámina de ítems de estereotipos de género | **Eliminada** — era uno de los candidatos a recorte |
| Falta de variables predictoras declaradas | s21 ahora las lista |
| Orden relativo clustering/clasificación | La definición de clustering (s20) ahora precede a la de clasificación (s21) |

Cifras nuevas verificadas contra E1: s22 (C plano 0,7762–0,7769; RF `min_samples_leaf=15` → 0,7838),
s23 (tabla comparativa completa), s24 (barrido 0,40–0,60), s25 (`classification_report` a umbral
0,50), s26 (permutación, odds ratios y SHAP). **Todo correcto.**

### Sigue pendiente

| # | Qué falta | Rúbrica en juego |
|---|---|---|
| 1 | **Cero resultados de clustering.** El deck define la tarea (s20) y nunca la ejecuta | **20% completo** |
| 2 | **Cero conclusiones.** El deck termina en s26 y salta a "gracias" | **10% completo** |
| 3 | **Sin revisión de casos en clasificación** (H9b) | Parte del 20% del bloque 4 |
| 4 | s20 declara variables y algoritmos que no coinciden con nada ejecutado (H7) | 10% de clustering |
| 5 | Desbalance de peso: **14 láminas de exploración (s6–s19) contra 0 de resultados de clustering** | 30% vs 30% |
| 6 | El umbral no se declara ni se justifica por su uso (H8) | Parte del 20% del bloque 4 |
| 7 | Sin advertencia de causalidad inversa ni de sesgo de método común (H9) | Conclusiones |
| 8 | s6 "96 + 1" en vez de 97 (H12); AUC 0,539 repetido en s18 (H13) | Menor |
