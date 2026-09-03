# Guión hablado — Presentación final

**Factores que inciden en el logro de aprendizaje en escuelas con bajo nivel socioeconómico**
Taller de Proyecto · Diplomado en Ciencia e Ingeniería de Datos · Universidad de Chile · Grupo 4
Felipe Riquelme · Jorge Sepúlveda · Manuel Sanhueza · Osvaldo Vázquez · Verónica Canales

**Formato:** 40 minutos de exposición + 5 de preguntas
**Deck:** `Grupo4_taller_de_proyecto_final_v2.pptx` — 32 láminas de contenido + cierre + anexo.
La correspondencia entre cada slide de este guión y su lámina en el deck, con los tiempos reales,
está en `docs/mapa-deck-guion.md`.
**Fuentes de las cifras:** `EDAyPreprocesamiento_01.ipynb` (E1), `tarea_clustering.ipynb` (E2),
`ClusteringyClasificacion.ipynb` (E3). Las marcadas *[verificado]* fueron re-ejecutadas en la
auditoría (ver `docs/00-inventario-y-auditoria.md`).

> **Columna vertebral del relato.** Controlando el contexto, sobra variación explicada por factores
> sobre los que una escuela sí puede intervenir. Todo bloque tiene que volver a esa frase.
>
> **Criterio que ordena todo:** factores **accionables** desde el establecimiento (convivencia,
> asistencia, estereotipos de género, participación) frente a factores **estructurales** que la
> escuela no controla (GSE, IVE, dependencia, zona).

---

## Reparto de expositores

| Bloque | Expone | Minutos |
|---|---|---:|
| 1. Problema, pregunta y ambas tareas | **Verónica Canales** | 4 |
| 2. Exploración de datos | **Verónica Canales** | 8 |
| 3. Clustering | **Felipe Riquelme** | 10 |
| 4. Clasificadores | **Manuel Sanhueza** | 10 |
| 5. Conclusiones | **Jorge Sepúlveda** | 5 |

Verónica encadena los bloques 1 y 2 sin traspaso (12 minutos seguidos): conviene marcar una pausa
clara al pasar del encuadre a los datos, en la lámina del embudo.

---

> **Uso del proyecto.** No es focalizar recursos ni clasificar escuelas para intervenirlas. Es
> identificar **sobre qué puede actuar una escuela y su comunidad educativa con los recursos que ya
> tiene**. De ahí se siguen dos decisiones metodológicas que hay que defender explícitamente: el
> clasificador es un instrumento de medición y no el producto, y **las dos clases pesan lo mismo**,
> lo que fija balanced accuracy —no F1— como criterio del umbral.

---

# BLOQUE 1 — Sobre el proyecto · 4 min · Expone: Verónica Canales

### Slide 1 — Portada (00:00 acumulado | 0:20 | Expone: Verónica Canales) [EXISTENTE]

**Qué se ve:** Título del proyecto e integrantes del Grupo 4.

**Guión:**
Buenos días. Somos el Grupo 4. Durante este semestre trabajamos sobre una pregunta que en Chile
tiene casi sesenta años de discusión y ninguna respuesta cómoda: por qué dos escuelas igual de
pobres obtienen resultados distintos. Vamos a mostrarles qué encontramos y, sobre todo, qué no
podemos afirmar con lo que encontramos.

**Transición:** Partamos por el problema, que es de política pública y no de negocio.

**Rúbrica:** 1. Sobre el proyecto.

---

### Slide 2 — El GSE predice el logro, pero hay escuelas que lo superan (00:20 | 1:10 | Expone: Verónica Canales) [FUSIONAR s2 + s3]

**Qué se ve:** Boxplot del puntaje SIMCE Matemática 2°M por grupo socioeconómico, con los cortes 252
y 319; al costado, la portada de *¿Quién dijo que no se puede?* de Bellei y otros.

**Guión:**
En Chile el resultado de aprendizaje está ordenado por el nivel socioeconómico del establecimiento,
y la ordenación es casi perfecta. En el SIMCE de Matemática de segundo medio 2024, el promedio va de
228,9 puntos en las escuelas de grupo socioeconómico bajo a 317,7 en las de grupo alto. Son 89
puntos de brecha, cuando la desviación estándar dentro del grupo bajo es de 21,7. Esto no es una
novedad: es el hallazgo central del Informe Coleman en 1966 y se ha replicado desde entonces.

De ese dato se pueden sacar dos lecturas. La primera es fatalista: la escuela no puede hacer nada
porque el destino está escrito en el origen familiar. La segunda es la que documentó Bellei con su
equipo el 2004, estudiando escuelas efectivas en sectores de pobreza: dentro de cada nivel
socioeconómico hay una dispersión enorme, y hay establecimientos que obtienen resultados muy por
encima de lo que su contexto predice.

Nosotros trabajamos sobre esa dispersión interna. No sobre la brecha entre grupos, que ya está
descrita, sino sobre lo que pasa **adentro** del grupo más desaventajado.

**Transición:** Esa decisión se traduce en una pregunta bastante concreta.

**Rúbrica:** 1. Sobre el proyecto — contexto y relevancia.

---

### Slide 3 — Pregunta de investigación y objetivo (01:30 | 0:50 | Expone: Verónica Canales) [FUSIONAR s4 + s5]

**Qué se ve:** La pregunta en grande; abajo, entidad de análisis, comportamiento a estudiar y
objetivo.

**Guión:**
La pregunta es: qué caracteriza a las escuelas de nivel socioeconómico bajo que alcanzan mejores
logros de aprendizaje que otras escuelas **en condiciones similares**.

Las tres últimas palabras son el trabajo entero. Comparar una escuela vulnerable con una de Vitacura
no dice nada que no sepamos. Lo que queremos es comparar escuelas vulnerables entre sí, con el
contexto emparejado, y ver qué queda.

La unidad de análisis es el establecimiento, no el estudiante: la llave es el RBD. Filtramos a
enseñanza media, grupos socioeconómico bajo y medio-bajo. Quedan 1.429 establecimientos, que
atienden al 46% de la matrícula nacional. El comportamiento a estudiar es el logro en SIMCE
Matemática de segundo medio.

Y una aclaración de encuadre que condiciona todo lo que sigue: acá no hay cliente ni ingresos, y el
producto **no es una predicción**. No estamos construyendo un sistema que clasifique escuelas para
repartir recursos. Lo que buscamos es identificar **sobre qué factores puede actuar una escuela y su
comunidad educativa, con los recursos que ya tiene**. El destinatario es esa comunidad. Eso cambia
qué cuenta como un buen modelo, y volvemos sobre eso al final.

**Transición:** Para responder la pregunta armamos dos tareas complementarias.

**Rúbrica:** 1. Sobre el proyecto — objetivo y entidad.

---

### Slide 4 — Dos tareas para una pregunta: perfilar y predecir (02:20 | 1:40 | Expone: Verónica Canales) [MODIFICAR — s20 corregida + mitad de s21, movidas acá]

**Qué se ve:** Dos columnas. Izquierda, clustering: entidad, variables de agrupamiento, variables
reservadas. Derecha, clasificación: target, predictores, modelos. Abajo, una franja con la
distinción accionable / estructural.

**Guión:**
La primera tarea es de **clustering**. Agrupamos establecimientos por cómo funcionan, usando tres
variables de proceso: clima y convivencia escolar, tasa de asistencia de segundo medio y un índice
de estereotipos de género construido a partir del cuestionario de estudiantes. Dejamos
deliberadamente fuera del agrupamiento el resultado y el contexto. Esa exclusión es el corazón del
diseño y la explicamos en detalle más adelante.

La segunda es de **clasificación**. Predecimos si un establecimiento supera el nivel Insuficiente en
Matemática, o sea si pasa los 252 puntos que define la Agencia. Es un target binario, y está
desbalanceado: solo uno de cada cuatro lo supera. Y una precisión importante: **el clasificador es un
instrumento, no el producto.** Lo usamos para medir cuánto pesa cada factor y en qué forma, no para
etiquetar escuelas. Por eso las dos clases nos importan igual: caracterizar bien a las que superan el
nivel y a las que no es lo mismo que entender el contraste entre unas y otras.

Las dos tareas responden cosas distintas. El clustering responde *qué perfiles existen*; la
clasificación responde *qué variables pesan y cuánto*. Y las dos se leen con el mismo criterio, que
es el que ordena toda la presentación: separar los factores **accionables desde el establecimiento**
—convivencia, asistencia, estereotipos entre estudiantes, participación— de los factores
**estructurales que la escuela no controla**: el nivel socioeconómico, el índice de vulnerabilidad,
la dependencia administrativa y la zona.

Si toda la variación estuviera en lo estructural, este trabajo terminaría acá y la conclusión sería
que la escuela no puede hacer nada. Lo que vamos a mostrar es que no es así.

**Transición:** Antes de los modelos, déjenme mostrarles cómo llegamos a esos 1.429 establecimientos. *(Sin traspaso: Verónica continúa con el bloque 2.)*

**Rúbrica:** 1. Sobre el proyecto — definición de ambas tareas.

---

# BLOQUE 2 — Exploración de datos · 8 min · Expone: Verónica Canales

### Slide 5 — De 3.000 a 1.429: cómo se construyó la muestra (04:00 | 1:30 | Expone: Verónica Canales) [MODIFICAR s6]

**Qué se ve:** Embudo de seis pasos con los n de cada etapa.

**Guión:**
Partimos de los 3.000 establecimientos con SIMCE de Matemática de segundo medio 2024.

Primer filtro, la variable objetivo. La Agencia marca 97 casos en que el puntaje no es
representativo. De esos, 68 los recuperamos con el resultado del mismo establecimiento en el SIMCE
2023, asumiendo que su propio desempeño del año anterior predice mejor que una imputación por
promedio de grupo. Los 29 restantes se eliminan. Quedan 2.966.

Segundo, confiabilidad: sacamos 19 establecimientos que reportan puntaje con seis o menos
estudiantes evaluados, aplicando el mismo criterio que la propia Agencia usa para no publicar.
Quedan 2.947.

Tercero, la población de interés: 678 de grupo bajo y 855 de medio-bajo, 1.533 en total. Menos 7 sin
indicadores de desarrollo personal y social, 1.526.

Y el último paso es el que más nos enseñó. Eliminamos 97 establecimientos donde más del 10% de los
estudiantes no respondió las preguntas de género. Quedan 1.429. *[Corrección respecto del deck: son
97 por género; el caso sin dato de asistencia está dentro de esos 97, no es adicional.]*

Auditamos esa exclusión y **no es aleatoria** *[verificado]*. Los 97 excluidos tienen una mediana de
29 estudiantes evaluados contra 64 de los incluidos; son 18,6% rurales contra 8,5%; y solo 3 de los
97 superan el corte, contra 24,8% de los que quedaron. Sacamos, sin querer, las escuelas más chicas,
más rurales y de peor rendimiento. Volvemos sobre esto en las conclusiones, porque condiciona hasta
dónde llegan nuestros resultados.

**Transición:** Con eso definido, veamos qué escuelas son estas.

**Rúbrica:** 2.1 Exploración descriptiva — tamaños y tratamiento de valores perdidos.

---

### Slide 6 — Con qué escuelas trabajamos: composición, descriptivos y outliers (05:30 | 1:30 | Expone: Verónica Canales) [FUSIONAR s7 + s10 + s11]

**Qué se ve:** Barras de composición (GSE, dependencia, zona), la tabla de estadísticos descriptivos
y un panel de outliers del puntaje.

**Guión:**
La población quedó repartida en 44% de grupo bajo y 56% de medio-bajo. Por dependencia, 53% son
particulares subvencionados, 38% municipales y 8% SLEP. Son 91% urbanos, y se concentran en la
Región Metropolitana con 31%, seguida de Valparaíso con 11% y Biobío con 9%. *[La distribución
regional viene de la lámina 7 del deck; no encontré la salida que la produce — ver `[FALTA-10]`.]*

De la tabla de descriptivos hay que mirar una cosa: **la poca dispersión de los indicadores de
proceso**. Los cuatro indicadores de desarrollo personal y social están todos entre 71,7 y 77,2
puntos de media, en una escala de 0 a 100, con desviaciones estándar de cuatro o cinco puntos. Lo
mismo el índice de vulnerabilidad, con media 0,89 y desviación 0,06. Esto tiene dos consecuencias
que arrastramos todo el trabajo: primero, que estamos buscando señal en rangos estrechos; segundo,
que ningún método de agrupamiento va a encontrar poblaciones nítidamente separadas, porque los datos
no están separados.

La variable con más casos extremos es el puntaje, con 3,3% de outliers por criterio de rango
intercuartil, y todos hacia arriba: escuelas que llegan hasta 361 puntos. **No los tratamos como
ruido.** Son literalmente el objeto de estudio: son las escuelas que superan su contexto.

**Transición:** Miremos entonces esa variable de resultado.

**Rúbrica:** 2.1 Exploración descriptiva — frecuencias, descriptivos, outliers.

---

### Slide 7 — El resultado a explicar: distribución y target binario (07:00 | 1:20 | Expone: Verónica Canales) [FUSIONAR s8 + s16]

**Qué se ve:** Histograma del puntaje con el corte 252 marcado, y a la derecha la conversión de tres
niveles a dos clases.

**Guión:**
El puntaje promedia 238 puntos, con mediana 233 y rango de 189 a 361. La distribución tiene
asimetría 1,18 y curtosis 2,08: la masa se agolpa bajo el corte y unas pocas escuelas se despegan
hacia arriba.

Al aplicar los estándares de aprendizaje de la Agencia quedan 1.075 establecimientos Insuficientes,
339 Elementales y **15 Adecuados**. Con quince casos ningún modelo aprende esa clase. Por eso
colapsamos a un target binario: superar o no superar el nivel Insuficiente, con el corte oficial en
252 puntos. Queda 75,2% contra 24,8%.

Dos cosas honestas sobre ese target. Una: dicotomizar una variable continua vuelve arbitraria la
etiqueta cerca del corte. Una escuela con 251 y otra con 253 quedan en clases distintas siendo
indistinguibles dentro del error de medición de la prueba, y **295 establecimientos, el 20,6% de la
base, están a menos de diez puntos del corte** *[verificado]*. Eso explica buena parte del error que
van a ver después: no es un defecto del modelo, es una propiedad del target. Dos: la clase que nos
interesa —la que supera— es la minoritaria, así que la accuracy va a ser una métrica inútil y no la
vamos a usar para decidir nada.

**Transición:** ¿Con qué variables tratamos de explicar esto?

**Rúbrica:** 2.2 Exploración respecto al objetivo — definición del target.

---

### Slide 8 — Seis fuentes y los dos indicadores que construimos (08:20 | 1:20 | Expone: Verónica Canales) [MODIFICAR s9]

**Qué se ve:** Tabla de fuentes e indicadores; al pie, la validación psicométrica del índice de
género.

**Guión:**
Cruzamos seis fuentes por RBD: el SIMCE, los indicadores de desarrollo personal y social, el
cuestionario de estudiantes, la asistencia anual 2024 de MINEDUC, la base de carrera docente y el
índice de vulnerabilidad de JUNAEB.

Dos indicadores no venían hechos y los construimos nosotros. El de **estereotipos de género** sale
de seis preguntas ordinales del cuestionario de estudiantes, del tipo "hay profesiones más adecuadas
para las mujeres que para los hombres". Como son ordinales, no usamos correlación de Pearson sino
policórica; el alfa de Cronbach ordinal da 0,919 y el análisis factorial extrae **un solo factor que
explica el 71,5% de la varianza**, con cargas entre 0,750 y 0,882. O sea, las seis preguntas miden
efectivamente una sola cosa. Lo calculamos para 112.206 estudiantes y lo agregamos a nivel de
establecimiento.

El segundo lo construimos y **lo descartamos**: un índice de clima laboral docente y otro de
coordinación con el equipo directivo, con el mismo procedimiento factorial. Los sacamos porque el
28% de los establecimientos no tenía dato. Fue bastante trabajo que no llegó al resultado, y es una
de las lecciones que traemos al final.

**Transición:** Veamos cuánto discrimina cada variable por sí sola.

**Rúbrica:** 2.1 y 2.2 — datos usados y enriquecimiento.

---

### Slide 9 — Poder discriminante: correlaciones, AUC y tamaño de efecto (09:40 | 1:40 | Expone: Verónica Canales) [MODIFICAR s17]

**Qué se ve:** Tabla de ocho variables con r contra el puntaje, AUC univariado, Cohen's d y sentido.

**Guión:**
Esta tabla es el resumen de la exploración respecto al objetivo. Tres lecturas.

Primera: **el clima escolar es el mejor predictor individual**. AUC 0,704, y la mayor diferencia
entre grupos, con un d de Cohen de 0,76. En números concretos, las escuelas que superan el nivel
promedian 77,6 puntos de convivencia contra 74,4 de las que no.

Segunda: **la asistencia va inmediatamente después**, con AUC 0,697. La brecha es de casi cuatro
puntos porcentuales de asistencia anual: 88,7% contra 85,1%. Y los estereotipos de género operan en
sentido inverso, como esperábamos por la literatura: a mayor acuerdo con creencias estereotipadas,
menor probabilidad de superar el nivel, con r de −0,240.

Tercera, y es la que importa para la pregunta: **las tres variables que encabezan son accionables
desde la escuela**. Las estructurales quedan abajo. El índice de vulnerabilidad tiene AUC 0,596, y
el porcentaje de docentes en tramo avanzado o experto tiene 0,539, que es prácticamente azar. Ese
último dato nos sorprendió y lo verificamos por dos vías distintas; volvemos sobre él.

Y una advertencia: ninguna variable predice por sí sola. Los AUC se mueven entre 0,54 y 0,70. Por
eso el enfoque tiene que ser multivariado.

**Transición:** Falta la mitad categórica, y una decisión de selección de variables.

**Rúbrica:** 2.2 Exploración respecto al objetivo — asociación univariada.

---

### Slide 10 — Categóricas y por qué un solo indicador de clima (11:20 | 0:40 | Expone: Verónica Canales) [FUSIONAR s18 + s19]

**Qué se ve:** Tabla de las tres categóricas con V de Cramér, y el argumento de correlación entre
los cuatro IDPS.

**Guión:**
De las categóricas, la dependencia administrativa es la más asociada: V de Cramér 0,241. Un tercio
de los particulares subvencionados supera el nivel, contra 14,3% de los municipales y 10,8% de los
SLEP. El grupo socioeconómico sigue discriminando incluso dentro de nuestra población restringida,
con 0,213. La zona urbano-rural no aporta: 0,016.

Y una decisión de selección. Los cuatro indicadores de desarrollo personal y social correlacionan
entre 0,69 y 0,89 entre sí. Son constructos distintos por diseño, pero en la práctica la escuela que
puntúa alto en uno puntúa alto en todos. Meter los cuatro sería aportar cuatro veces la misma
dimensión al cálculo de distancias y repartir los coeficientes de forma inestable. Nos quedamos con
**clima y convivencia**: es el que mejor discrimina y el más accionable desde la gestión.

**Transición:** Con las variables elegidas, vamos al primer modelo. Felipe.

**Rúbrica:** 2.2 — categóricas y selección de variables.

---

# BLOQUE 3 — Clustering · 10 min · Expone: Felipe Riquelme

### Slide 11 — Qué agrupamos y, sobre todo, qué dejamos fuera (12:00 | 1:20 | Expone: Felipe Riquelme) [NUEVA]

**Qué se ve:** Tres bloques de variables — "agrupan", "contexto: reservado", "resultado: reservado" —
con una línea que separa el primero de los otros dos.

**Guión:**
Esta lámina es una decisión de diseño, no un paso técnico, y de ella depende que el resultado
signifique algo.

Agrupamos con **tres variables de proceso**: convivencia, asistencia y estereotipos de género. Y
reservamos dos bloques.

El primero es obvio: el resultado. Si el puntaje entra como insumo, los grupos se separan por logro
**por construcción**, y decir después que un grupo rinde más que otro no prueba absolutamente nada.

El segundo es el que vale explicar: dejamos fuera el **contexto**, el índice de vulnerabilidad y la
dotación docente. La razón no es que no importen —importan mucho—, sino que al no usarlos para
agrupar podemos **verificar después** si los grupos quedaron comparables en nivel socioeconómico. Si
quedan comparables, tenemos el "en condiciones similares" de la pregunta de investigación medido, no
supuesto.

En lo técnico, un solo paso de preprocesamiento: estandarización. Las tres variables están en
escalas incomparables —convivencia va de 62 a 92, asistencia de 0,52 a 0,99, y género es un z-score—
y los dos algoritmos usan distancia euclidiana. Sin estandarizar, la convivencia dominaría la
distancia por completo y el resultado sería un artefacto de la unidad de medida.

**Transición:** Con el espacio definido, cómo elegimos el número de grupos.

**Rúbrica:** 3 — datos usados (10%).

---

### Slide 12 — Cómo elegimos k: métricas, discrepancia y estabilidad (13:20 | 1:40 | Expone: Felipe Riquelme) [NUEVA]

**Qué se ve:** Tres paneles de silhouette, Davies-Bouldin y Calinski-Harabasz contra k, para K-Means
y aglomerativo de Ward.

**Guión:**
Probamos dos algoritmos, K-Means y aglomerativo con enlace de Ward, con k de 2 a 8, y tres métricas
internas. La regla la fijamos **antes** de mirar los resultados: se adopta el máximo de silhouette.

Gana K-Means con k igual a 2, silhouette 0,257. Calinski-Harabasz coincide, con su máximo también en
k igual a 2. Y acá va una discrepancia que preferimos declarar en vez de omitir: **Davies-Bouldin no
acompaña**. Su mínimo está en k igual a 8 y mejora de forma casi monótona al aumentar k, que es el
comportamiento típico de esa métrica, porque premia particiones más finas. Con k igual a 8 tendríamos
grupos chicos, solapados y sin interpretación posible. Mantuvimos la regla declarada.

Ahora, lo importante: **0,257 es estructura moderada, no fuerte**. Y no vamos a maquillarlo. Ya vimos
en la exploración que estas variables tienen poca dispersión y distribuciones unimodales; lo que
tenemos es un **gradiente de calidad de procesos que estamos segmentando**, no dos poblaciones
naturalmente separadas. Los grupos hay que leerlos como tendencias promedio con solapamiento.

Dos verificaciones más *[verificado en la auditoría]*. Entre semillas, la partición es
prácticamente idéntica: veinte semillas distintas dan un índice de Rand ajustado mínimo de 0,986.
Entre algoritmos, no: 0,411 contra Ward y 0,642 contra un modelo de mezclas gaussianas. La lectura
correcta es que **el eje que separa es sólido y no depende del azar, pero la frontera exacta depende
del método**. Es exactamente lo que uno espera de un continuo.

Y algo que conviene decir explícitamente: **el target no participó en ningún momento de la elección
de k**. El cruce entre grupo y resultado que viene ahora es un análisis posterior.

**Transición:** Veamos los dos grupos que aparecen.

**Rúbrica:** 3 — algoritmos usados y ajuste de parámetros (10%).

---

### Slide 13 — Los dos grupos que aparecen (15:00 | 1:30 | Expone: Felipe Riquelme) [NUEVA]

**Qué se ve:** `cluster_pca.png` — proyección PCA 2D con centroides — y al lado el perfil promedio en
escala original.

**Guión:**
Para poder mirar un espacio de tres dimensiones lo proyectamos con componentes principales.
Insistimos en un punto: **el PCA es solo para visualizar, el agrupamiento se hizo en las tres
variables originales estandarizadas.**

El primer componente recoge 44,4% de la varianza y carga casi por igual en convivencia, con 0,669, y
asistencia, con 0,666. Es un **eje de calidad de procesos escolares**, y es el eje horizontal, el que
separa a los dos grupos. El segundo componente, con 32,0%, está dominado por las creencias de género,
con carga 0,944, y ahí los grupos casi no se distinguen. Entre los dos retienen 76,4% de la varianza,
así que la figura representa fielmente el espacio y no es una proyección engañosa.

Fíjense en que **las dos nubes se tocan**: no hay un espacio vacío entre ellas. Eso es el silhouette
de 0,257 dibujado.

Los perfiles: el Cluster 0 son 640 establecimientos, el 44,8%, con convivencia 78,1, asistencia 0,895
y creencias de género bajo la media. El Cluster 1 son 789, el 55,2%, con convivencia 72,9, asistencia
0,832 y creencias de género sobre la media. Los llamamos, simplemente, **procesos escolares
favorables** y **procesos escolares más débiles**.

**Transición:** Y ahora el resultado que da sentido a haber dejado el contexto afuera.

**Rúbrica:** 3 — visualización de grupos (parte del 20%).

---

### Slide 14 — Mismas condiciones, resultados distintos (16:30 | 2:00 | Expone: Felipe Riquelme) [NUEVA]

**Qué se ve:** `cluster_heatmap.png`. Cinco filas en z-score; una línea negra horizontal separa las
tres variables que agrupan de las dos de contexto que no agruparon.

**Guión:**
Esta figura cuenta la historia sola, y es la única lámina que les pediría que recuerden.

**Sobre la línea negra** están las tres variables con las que agrupamos. Los colores son intensos y
opuestos: los grupos se distinguen fuerte, como corresponde.

**Bajo la línea** están las dos variables de contexto, que no participaron. Y están casi blancas.
Los z-scores son −0,02 y +0,01. En escala original: el índice de vulnerabilidad promedia 0,888 en un
grupo y 0,890 en el otro. Una diferencia de dos milésimas, frente a una desviación estándar de seis
centésimas. La dotación docente formal también empata: 31,2% contra 33,2% de profesores en tramo
avanzado o superior.

O sea: **los dos grupos son socioeconómicamente indistinguibles.**

Y sin embargo. El Cluster 0 promedia 248,4 puntos y el Cluster 1 promedia 229,6. Son **18,9 puntos de
brecha**. Y sobre el corte de 252: **41,6% contra 11,2%**. Treinta puntos porcentuales. Casi cuatro
veces más escuelas superando el nivel.

**[PAUSA]**

Esto es, literalmente, el "en condiciones similares" de nuestra pregunta de investigación. No lo
asumimos: lo verificamos. Con el nivel socioeconómico igualado, lo que separa a las escuelas que
rinden mejor son sus procesos internos.

Y la advertencia va acá, dicha por nosotros y no en el turno de preguntas: los grupos quedaron
igualados en vulnerabilidad, **pero no en dependencia administrativa**. El Cluster 0 es 68,1%
particular subvencionado y el Cluster 1 es 47,5% municipal. Parte de esta brecha puede ser efecto de
sector y no de los procesos que medimos. El diseño empareja en nivel socioeconómico, no en todo lo
demás.

**Transición:** Bajemos de los promedios a establecimientos concretos.

**Rúbrica:** 3 — interpretación de grupos (parte del 20%).

---

### Slide 15 — Cinco escuelas típicas de cada grupo (18:30 | 1:30 | Expone: Felipe Riquelme) [NUEVA]

**Qué se ve:** Dos tablas de cinco establecimientos con nombre, comuna, dependencia, las tres
variables de agrupamiento, el IVE y el puntaje.

**Guión:**
El criterio para elegirlos es la menor distancia euclidiana al centroide del propio grupo, en el
mismo espacio estandarizado con que se ajustó el modelo. Cerca del centroide significa caso típico,
no caso de frontera.

Los típicos del **Cluster 0** son el Colegio Los Pensamientos de La Granja, el Centro Educacional
London de La Florida, el Colegio Cristóbal Colón de Coquimbo, el Liceo Particular Libertad de
Villarrica y el Colegio San Juan Bautista de Ovalle. Convivencia entre 77 y 79, asistencia sobre
0,89, y los cinco particulares subvencionados.

Los típicos del **Cluster 1** son el Liceo Nueva Zelandia de Santa Juana, el Liceo Bicentenario
Domingo Santa María de Iquique, el Liceo de Yungay, el Liceo Carelmapu de Maullín y el Liceo Gabriela
Mistral de Independencia. Convivencia 73 o 74, asistencia entre 0,82 y 0,84, y predominan los
municipales.

Dos lecturas que se desprenden directo de estas tablas. La primera: **el contexto varía libremente
dentro de cada grupo**, porque no participó del agrupamiento. Entre estos cinco casos típicos del
Cluster 0, el índice de vulnerabilidad va de 0,828 a 0,964 y el porcentaje de docentes avanzados va
de 5,3% a 42,6%.

La segunda, y es la honestidad que corresponde: **pertenecer a un grupo no determina el resultado de
una escuela concreta**. Entre estos mismos cinco casos típicos hay uno con 233 puntos y otro con 295.
En el Cluster 1 hay uno con 216 y otro con 249. Lo que mostramos son diferencias de promedios con
fuerte solapamiento individual, no un pronóstico para un establecimiento en particular.

**Transición:** Queda una pregunta obvia, y la corrimos.

**Rúbrica:** 3 — revisión de casos en cada grupo (parte del 20%).

---

### Slide 16 — Robustez: ¿y si el contexto sí entra al agrupamiento? (20:00 | 2:00 | Expone: Felipe Riquelme) [NUEVA]

**Qué se ve:** Tabla de cuatro perfiles con clima, género, IVE, n, puntaje y porcentaje que supera;
al costado, la curva plana de silhouette.

**Guión:**
La pregunta obvia frente a lo anterior es: ¿y qué pasa si **no** dejamos el contexto afuera? Lo
corrimos como análisis de robustez, con un espacio distinto: un índice de clima que promedia los
cuatro indicadores de desarrollo personal y social, el índice de género, y el índice de
vulnerabilidad **adentro**. Cuatro grupos.

Dos cosas de método antes del resultado. Una: aplicamos el estadístico de Hopkins **antes** de
agrupar, porque K-Means siempre devuelve una partición exista o no estructura. Da 0,819, sobre el
umbral de referencia de 0,75, así que los datos no son ruido uniforme. Dos: acá la curva de
silhouette es **plana**, entre 0,23 y 0,25 para todo k. No hay un k óptimo. Elegimos cuatro por
interpretabilidad y lo declaramos como lo que es: una decisión de lectura, no un hallazgo.

El resultado. La tasa de logro va de **12,7% a 46,9%** entre perfiles, construidos sin usar el
resultado. El ANOVA rechaza la igualdad de medias con F de 50,3, el chi-cuadrado entre perfil y
target da p del orden de diez a la menos veinticinco, y cinco de las seis comparaciones por pares son
significativas con corrección de Bonferroni.

Y la sexta, la que no es significativa, es la interesante: el perfil de **clima favorable con alta
vulnerabilidad** rinde 21,8%, y el de **clima débil con baja vulnerabilidad** rinde 24,1%. Empatan.
Un buen clima escolar no compensa por sí solo la diferencia de contexto.

**[PAUSA]**

Los dos análisis no se contradicen, y leerlos juntos es más útil que quedarse con uno. La
vulnerabilidad **fija el techo**; los procesos **mueven dentro de ese techo**. El primer modelo
iguala el contexto para aislar cuánto queda por procesos, y queda bastante: 18,9 puntos. El segundo
deja variar el contexto y muestra que pesa. Para política pública las dos cosas importan, pero a
niveles distintos: el techo lo tiene que mover el Estado; dentro del techo puede actuar la escuela.

**Transición:** Vamos entonces a medir cuánto pesa cada factor. Manuel.

**Rúbrica:** 3 — algoritmos alternativos, estabilidad e interpretación.

---

# BLOQUE 4 — Clasificadores · 10 min · Expone: Manuel Sanhueza

### Slide 17 — Qué predecimos, con qué y cómo lo validamos (22:00 | 1:30 | Expone: Manuel Sanhueza) [FUSIONAR mitad de s21 + s22]

**Qué se ve:** Target y balance, lista de predictores, los tres modelos y el protocolo de ajuste.

**Guión:**
Predecimos el target binario: superar o no los 252 puntos. 1.075 contra 354, o sea 24,8% de clase
positiva.

Los predictores son seis: convivencia, estereotipos de género, índice de vulnerabilidad, asistencia,
porcentaje de docentes en tramo avanzado o superior, y dependencia administrativa como variables
indicadoras con municipal de referencia. Dejamos fuera el puntaje, porque el target se construye a
partir de él y sería fuga de información pura; el grupo socioeconómico, por redundancia con el
índice de vulnerabilidad; y la zona, por falta de señal.

Tres modelos: un **baseline** que predice siempre la clase mayoritaria, como vara mínima; una
**regresión logística**, por interpretabilidad; y un **Random Forest**, para capturar no
linealidades.

Sobre el desbalance, y esto conviene decirlo con precisión: usamos `class_weight="balanced"`, **sin
remuestreo**. No generamos casos sintéticos. Con 354 positivos reales, preferimos ponderar lo que
tenemos antes que inventar establecimientos que no existen.

El protocolo: partición 75-25 estratificada, y `GridSearchCV` con `StratifiedKFold` de cinco
pliegues optimizando AUC, con el escalado dentro del pipeline para que se ajuste en cada pliegue
solo con su entrenamiento. En la logística el AUC es plano en todo el rango de C, de 0,7762 a
0,7769; fijamos C igual a 0,1 porque valores menores encogen los coeficientes y les quitan lectura.
En el bosque probamos nueve combinaciones y gana `min_samples_leaf` igual a 15, con 0,7838. El dato
interesante ahí es que **importa el tamaño de la hoja y no la profundidad**: las tres mejores
combinaciones son las tres que tienen hoja 15, cualquiera sea la profundidad, y con hoja igual a 1 el
AUC cae a 0,7672 *[verificado]*. El modelo pide restricción, no flexibilidad.

**Transición:** Veamos cómo rinden contra el piso.

**Rúbrica:** 4 — algoritmos, datos e hiperparámetros (10%).

---

### Slide 18 — Tres modelos contra el piso (23:30 | 1:40 | Expone: Manuel Sanhueza) [EXISTENTE s23]

**Qué se ve:** Tabla comparativa de los tres modelos y las curvas ROC y Precision-Recall.

**Guión:**
Primero, cuál es la cifra que reportamos. El split único da 0,817 para la logística y 0,810 para el
bosque. **No es esa la que reportamos**, porque la de un split único es optimista: depende de qué
escuelas cayeron en el conjunto de prueba. Reportamos la de validación cruzada: **0,783 con
desviación 0,014** para la logística y **0,788 con desviación 0,004** para el bosque.

El baseline queda en 0,500 de AUC y 0,500 de balanced accuracy. Al predecir siempre "insuficiente"
no ordena a nadie y no detecta ni un solo establecimiento de la clase que nos interesa. Ese es el
piso real, y los dos modelos con información lo superan con holgura.

Ahora, entre ellos: **0,783 contra 0,788 son cinco milésimas**, con desviaciones de catorce y cuatro
milésimas. No hay ganador estadístico.

Elegimos la logística, y quiero ser explícito en que **no es un premio de consolación**. En un
problema de política pública, el modelo tiene que poder discutirse con quien va a usarlo. Una frase
como "por cada desviación estándar de convivencia, la chance de superar el nivel se multiplica por
1,69" es una afirmación que un equipo directivo puede evaluar, contrastar con su experiencia y
rechazar si le parece falsa. Trescientos árboles con el mismo AUC no entregan esa frase. Cuando la
diferencia de desempeño cabe dentro del error, la interpretabilidad no es un costo: es la
decisión correcta.

**Transición:** Con el modelo elegido, viene la decisión que más discutimos.

**Rúbrica:** 4 — métricas de efectividad (parte del 20%).

---

### Slide 19 — Histograma de scores y elección del umbral (25:10 | 2:00 | Expone: Manuel Sanhueza) [MODIFICAR s24]

**Qué se ve:** Histograma de scores separado por clase real, y el barrido de umbral con dos columnas
nuevas: sensibilidad y especificidad, más la curva de balanced accuracy.

**Guión:**
El histograma muestra dos distribuciones desplazadas pero superpuestas. Eso es exactamente lo que
mide el AUC: el modelo **ordena bien** a los establecimientos, pero no existe ningún corte que separe
las clases sin error.

Hay que elegir un corte, y para elegirlo hay que declarar primero qué nos importa. En este proyecto
**las dos clases pesan lo mismo**. No estamos armando una lista de escuelas para intervenir:
queremos caracterizar igual de bien a las que superan el nivel y a las que no, porque el contraste
entre ambas es lo que responde la pregunta. Equivocarse en una o en la otra cuesta lo mismo.

Y acá hay una trampa que vale la pena mostrar, porque nos pasó a nosotros. **F1 no expresa eso.** El
F1 de la clase positiva ignora por completo los verdaderos negativos: se calcula sin mirar ni una vez
a las escuelas que no superan el nivel. Es la métrica menos simétrica que hay. Y el F1 macro, que sí
promedia las dos clases, tampoco sirve del todo acá: cada F1 incluye la precisión, que depende de la
prevalencia, así que con un 75 a 25 el macro se deja arrastrar por la clase mayoritaria.

**[PAUSA]**

La métrica que sí dice "las dos clases pesan lo mismo" es la **balanced accuracy**: el promedio del
recall de cada clase, con independencia de su tamaño. Equivalente al J de Youden.

Y hay un argumento que ni siquiera requiere buscar. Entrenamos con `class_weight="balanced"`, que
reentrena el modelo como si las clases fueran mitad y mitad. Sobre esa probabilidad recalibrada, y
con costos simétricos, **el corte óptimo es 0,50 por construcción**.

Lo comprobamos empíricamente, y no sobre los 358 del split sino sobre los 1.429 con predicciones
fuera de fold, que es una curva mucho más estable *[verificado]*. La balanced accuracy y el J de
Youden alcanzan su máximo **exactamente en 0,50**. Y la firma es inconfundible: en ese punto la
sensibilidad es 0,718 y la especificidad 0,708. Prácticamente iguales. El modelo es igual de bueno
con las dos clases, que es literalmente lo que pedimos.

Si subiéramos a 0,60 compraríamos especificidad —0,817— vendiendo sensibilidad —0,576—. Sería la
decisión correcta si nos importara más una clase que la otra. No es nuestro caso.

Fijamos el umbral en **0,50**. Que es donde estaba, pero ahora por una razón declarada y no porque lo
haya elegido una métrica que no representa lo que nos importa.

**Transición:** Estas son las métricas a ese umbral.

**Rúbrica:** 4 — histograma de scores y umbral de decisión (parte del 20%).

---

### Slide 20 — Métricas al umbral elegido (27:10 | 1:20 | Expone: Manuel Sanhueza) [EXISTENTE s25]

**Qué se ve:** Matriz de confusión a umbral 0,50 y tabla de precisión, recall y F1 por clase.

**Guión:**
Sobre los 358 establecimientos del conjunto de prueba, con umbral 0,50: 195 aciertos en la clase
Insuficiente, 74 falsos positivos, 68 aciertos en la clase que supera y 21 falsos negativos.

Por clase: en Insuficiente, precisión 0,903 y recall 0,725. En Elemental o adecuado, precisión 0,479
y recall 0,764. El F1 macro queda en 0,696 y la balanced accuracy en 0,744.

Y acá hay que leer con cuidado, porque la tabla parece decir algo que no dice. La precisión de la
clase positiva es 0,479, que suena mal. Pero **la precisión depende de la prevalencia**: con solo
24,8% de casos positivos, cualquier modelo que recupere tres cuartos de ellos va a arrastrar falsos
positivos. Lo que hay que mirar bajo nuestro criterio son los dos recalls: 0,725 y 0,764. Ahí el
modelo está equilibrado, que es lo que buscábamos.

Un segundo comentario, que conecta con lo que vimos del target. Recuerden que 295 establecimientos
están a menos de diez puntos del corte. Una parte importante de estos 95 errores son escuelas que
quedaron del otro lado de una línea que, a efectos prácticos, es arbitraria. **No todo el error del
modelo es error del modelo.**

Y un tercero que importa para lo que viene: los **falsos positivos** no son solo error. Son
establecimientos cuyo perfil de procesos se parece al de los que superan el nivel, y que aun así no
lo superan. Igual que los falsos negativos, son casos que vale la pena mirar de cerca.

**Transición:** ¿Y qué variables están detrás de estas predicciones?

**Rúbrica:** 4 — métricas de efectividad (parte del 20%).

---

### Slide 21 — Qué factores pesan: permutación, odds ratios y SHAP (28:30 | 1:50 | Expone: Manuel Sanhueza) [EXISTENTE s26]

**Qué se ve:** Importancia por permutación de la logística, tabla de odds ratios, barra de SHAP del
bosque y las dos curvas de forma del efecto.

**Guión:**
Tres lecturas complementarias.

**Importancia por permutación sobre la logística**, que mide cuánto AUC se pierde al romper cada
variable: encabeza convivencia con 0,099, sigue ser particular subvencionado con 0,086, y después
asistencia con 0,063. El índice de vulnerabilidad aporta 0,035 y las creencias de género 0,020. Y el
porcentaje de docentes en tramo avanzado da **0,009 con desviación 0,010: indistinguible de cero**.
Por eso, aunque su coeficiente sea positivo, **no lo interpretamos**. Es el mismo resultado que
habíamos visto en el análisis univariado con AUC 0,539, obtenido por otra vía.

**Odds ratios**, que es la lectura sustantiva: por cada desviación estándar, convivencia multiplica
la chance por 1,69 y asistencia por 1,64. Los estereotipos de género juegan en contra, con 0,72, y el
índice de vulnerabilidad también, con 0,75.

**SHAP sobre el bosque** reordena sin cambiar el elenco: asistencia 0,100, convivencia 0,076,
particular subvencionado y vulnerabilidad 0,061, género 0,059. Las mismas cinco variables arriba en
los dos modelos, con distinto orden porque el bosque captura no linealidades.

Y lo más útil para gestión escolar es **la forma del efecto**. Los dos efectos principales tienen
forma de S. La asistencia pesa fuerte bajo 0,80, concentra toda la pendiente entre 0,82 y 0,89, y **se
aplana sobre 0,90**. La convivencia hace lo mismo: bajo 72 el efecto es negativo, el tramo 72 a 79
concentra la pendiente, y sobre 80 se estabiliza. La consecuencia práctica es directa: **el margen
está en sacar a un establecimiento del tramo bajo, no en llevar de 0,92 a 0,95 a uno que ya está
bien.** Eso ya no es una descripción: es una indicación de dónde poner el esfuerzo disponible.

Y ahora la objeción que nos corresponde hacer a nosotros. Convivencia y estereotipos de género se
miden con un cuestionario que responden **los mismos estudiantes que rinden la prueba, el mismo
día**. Es perfectamente plausible que un buen rendimiento produzca un mejor clima percibido, y no al
revés; y parte de la correlación puede venir simplemente de compartir el instrumento de medición.
No podemos descartarlo con estos datos. Lo que sí podemos decir es que **la asistencia no tiene ese
problema**: es registro administrativo, independiente del cuestionario y de la prueba. Y es la
variable que más pesa en el bosque.

**Transición:** Bajemos a establecimientos concretos.

**Rúbrica:** 4 — interpretación; responde "qué factores".

---

### Slide 22 — Las que superan su pronóstico: revisión de casos (30:20 | 1:40 | Expone: Manuel Sanhueza) [NUEVA]

**Qué se ve:** Tabla de los cuatro cuadrantes con sus medias, los waterfall SHAP de dos casos, y la
tabla de falsos negativos con nombre y comuna.

**Guión:**
Los cuatro cuadrantes del modelo: 195 aciertos negativos, 68 aciertos positivos, 74 falsos positivos
y 21 falsos negativos. Y los errores, acá, son más informativos que los aciertos.

Los **21 falsos negativos** son el grupo más interesante del trabajo. Promedian 267 puntos: rinden muy
por encima de lo que sus condiciones predicen. Con nombre: el Liceo Bicentenario de Excelencia
Técnica de Loncoche, con índice de vulnerabilidad 0,98 —casi el máximo posible— recibe un score de
0,19 y saca 258 puntos. El Liceo Industrial José Tomás de Urmeneta de Coquimbo, score 0,22, saca 267.
El Colegio Robinson Cabrera Beltrán de Retiro, score 0,29, saca 282. En el desglose SHAP del primero,
**ninguna** variable juega a su favor: supera el nivel a pesar de todo lo que el modelo alcanza a
observar. Estas son las escuelas efectivas de Bellei, identificadas con datos administrativos. Son la
prueba de existencia de que el contexto no determina el resultado, y son donde hay que ir a mirar qué
prácticas explican la diferencia, porque **no están en nuestras variables**.

Los **74 falsos positivos** son el espejo: buena convivencia, 77,5 de promedio, y buena asistencia,
0,89, pero 232 puntos. Tienen el perfil de proceso de los que superan el nivel y no lo superan. Son
igual de interesantes, en la dirección contraria.

Y el contraste que más nos enseñó. Tomen dos establecimientos con score casi idéntico: 0,807 y 0,812.
Su descomposición SHAP es prácticamente la misma variable por variable. Uno saca 236 puntos y el otro
256. Lo que los separa **no está en lo que el modelo mide**. Esa es la lectura correcta del techo de
0,79 de AUC: no es una limitación del algoritmo, es una limitación de la información disponible. Y
marca el límite de hasta dónde llega un análisis con datos administrativos: identifica **dónde
mirar**, no reemplaza ir a mirar.

**Transición:** Jorge cierra con las conclusiones.

**Rúbrica:** 4 — revisión de casos (parte del 20%).

---

# BLOQUE 5 — Conclusiones · 5 min · Expone: Jorge Sepúlveda

### Slide 23 — Comparación de clasificadores y cuál elegimos (32:00 | 1:30 | Expone: Jorge Sepúlveda) [NUEVA]

**Qué se ve:** Tabla de los tres modelos con AUC de CV y desviación, y tres viñetas con el criterio
de elección.

**Guión:**
Comparamos tres modelos. El baseline de clase mayoritaria queda en 0,500 y sirve para lo único que
sirve: fijar el piso. La regresión logística obtiene 0,783 con desviación 0,014 en validación
cruzada. El Random Forest, 0,788 con desviación 0,004.

**Elegimos la regresión logística**, y el criterio es de política pública, no de métrica. Tres
razones.

Primera: la diferencia de cinco milésimas cabe holgadamente dentro del error de estimación. No
estamos renunciando a desempeño, porque no hay desempeño que renunciar.

Segunda: el análisis SHAP nos dio la explicación de por qué el bosque no gana. Las curvas de efecto
son monótonas y **los efectos se suman más que se multiplican**. No hay interacciones fuertes que un
modelo aditivo se esté perdiendo. Un bosque en estos datos gasta flexibilidad modelando quiebres que
no existen.

Tercera, y es la decisiva: un modelo que va a informar decisiones sobre escuelas públicas **tiene que
poder auditarse**. Un AUC de 0,78 con coeficientes legibles vale más aquí que uno de 0,82 en una caja
negra, porque el producto no es la predicción: es el argumento.

Dicho eso, el bosque no lo descartamos, y nos sirvió para algo que la logística sola no podía dar:
**la forma de los efectos**. Las curvas en S de asistencia y convivencia salen del análisis SHAP
sobre el bosque, y son la parte más accionable de todo el trabajo. Los dos modelos se usaron para
cosas distintas: la logística para cuantificar, el bosque para ver la forma.

**Transición:** ¿Y qué hace una escuela con esto?

**Rúbrica:** 5 — comparación de clasificadores y mejor resultado (5%).

---

### Slide 24 — Sobre qué puede actuar una escuela con lo que ya tiene (33:30 | 1:40 | Expone: Jorge Sepúlveda) [NUEVA]

**Qué se ve:** Dos columnas: "sobre esto no decide la escuela" y "sobre esto sí". A la derecha, las
dos curvas en S con las zonas de mayor y menor retorno marcadas.

**Guión:**
Quiero ser explícito en para qué sirve esto, porque no es para hacer un ranking ni para repartir
plata. **Es para que una comunidad educativa sepa dónde poner el esfuerzo que ya está haciendo.**

De un lado, lo que la escuela no decide: su grupo socioeconómico, su índice de vulnerabilidad, su
dependencia administrativa, su zona. Eso pesa, y mucho. Del otro lado, lo que sí: la convivencia, la
asistencia y las creencias que circulan entre sus estudiantes. Nuestro resultado es que **ese
segundo lado no está vacío**: entre escuelas con vulnerabilidad idéntica —0,888 contra 0,890— hay
18,9 puntos de diferencia y treinta puntos porcentuales sobre el corte.

Y podemos ser más específicos que "mejore la convivencia", que no le sirve a nadie. Tres cosas
concretas.

Primera: **las dos palancas tienen rendimientos decrecientes**. Si su asistencia está bajo 0,80 o su
convivencia bajo 72 puntos, ahí está concentrado prácticamente todo el margen. Si ya está sobre 0,90
y sobre 80, la siguiente unidad de esfuerzo rinde poco, y conviene ponerla en otra parte. Eso importa
justamente porque el esfuerzo disponible es limitado.

Segunda: **las creencias de género son una palanca de costo cero en recursos**. No requieren
presupuesto, requieren práctica pedagógica. Y son la única variable de nuestro modelo que apunta a
algo que la escuela puede trabajar en el aula mañana.

Tercera, y es la que más cuesta decir: **el porcentaje de docentes en tramo avanzado no discrimina.**
Una escuela que está esperando a que le lleguen mejores docentes para mejorar, según estos datos,
está esperando algo que no explica la diferencia.

**[PAUSA]**

Y el mensaje que ordena todo lo que mostramos: **controlando el contexto, sobra variación explicada
por factores sobre los que una escuela sí puede intervenir.** El grupo socioeconómico, el índice de
vulnerabilidad, la dependencia y la zona explican mucho. No lo explican todo. Lo que queda es el
espacio de la comunidad educativa, y es sobre ese espacio que este trabajo dice algo.

**Transición:** Con una condición importante, que es lo que viene.

**Rúbrica:** 5 — impacto de la predicción (5%).

---

### Slide 25 — Lo que no permite concluir, y qué haríamos distinto (35:10 | 1:50 | Expone: Jorge Sepúlveda) [NUEVA]

**Qué se ve:** Dos columnas. Izquierda, "lo que no podemos afirmar", tres viñetas. Derecha,
"conocimiento adquirido", tres viñetas más el aprendizaje de cierre.

**Guión:**
Primero, los límites, y son fuertes.

**Nada de lo que mostramos es causal.** Es un corte transversal y observacional de un solo año.
Cuando decimos que la convivencia se asocia al logro, decimos exactamente eso: se asocia. No estamos
diciendo que subir la convivencia suba el puntaje. Y hay tres razones concretas para esa cautela, que
ya fuimos declarando: la causalidad puede correr al revés, porque una escuela que funciona bien
probablemente genera mejor clima percibido; convivencia y género comparten instrumento de medición
con la prueba, lo que infla la correlación por método común; y los grupos que comparamos quedaron
igualados en vulnerabilidad pero no en dependencia administrativa.

**[PAUSA]**

Segundo, conocimiento adquirido. Y partimos por lo que hicimos mal, que es lo que más aprendimos.

**Uno.** Excluimos 97 establecimientos por no respuesta en el cuestionario de género, tratando ese
faltante como si fuera aleatorio. Al auditarlo descubrimos que no lo es: los excluidos tienen una
mediana de 29 estudiantes evaluados contra 64 de los incluidos, son 18,6% rurales contra 8,5%, y
**solo 3 de los 97 superan el corte, contra 24,8%**. Sacamos exactamente las escuelas más chicas, más
rurales y de peor rendimiento, que son justamente aquellas para las que la pregunta más importa. Y
hay una ironía incómoda: son escuelas chicas, donde diez estudiantes que no contestan el cuestionario
bastan para superar el umbral de no respuesta. **El criterio de calidad de datos nos sesgó la muestra
por tamaño.** La lección: no
basta con que el porcentaje de faltantes sea bajo, hay que verificar **quién** falta. Si lo
rehiciéramos, imputaríamos con indicador de faltante en vez de eliminar.

**Dos.** En la exploración identificamos que la composición socioeconómica según SEP —el porcentaje
de alumnos preferentes— era la mayor ganancia individual de todo el preprocesamiento, y se nos quedó
fuera de la base final del modelo. Lo verificamos: agregándola, el AUC de validación cruzada sube de
0,783 a **0,806** *[verificado]*. Es la mejora más grande disponible y no está en el modelo que
presentamos. El problema no fue analítico, fue de trazabilidad entre una decisión documentada y la
base que efectivamente se usó.

**Tres.** Construimos dos indicadores de clima laboral docente y coordinación directiva, con análisis
factorial completo, y los descartamos por 28% de no respuesta. La lección es evaluar la cobertura de
una fuente **antes** de invertir en construir un indicador con ella, no después.

Y lo que sí nos llevamos. Que la parte difícil de este proyecto no fue modelar: fue decidir qué
cuenta como condición y qué cuenta como característica. Esa decisión no la resuelve ninguna métrica.
Muchas gracias.

**Transición:** —

**Rúbrica:** 5 — conocimiento adquirido (5%).

---

# 1. Cambios al deck

| Lámina en `(3).pdf` | Acción | Destino | Detalle |
|---|---|---|---|
| s1 | Mantener | S1 | — |
| s2, s3 | **Fusionar** | S2 | Boxplot por GSE + referencia a Bellei en una sola lámina |
| s4, s5 | **Fusionar** | S3 | Pregunta arriba, objetivo y entidad abajo |
| **s20** | **Mover a bloque 1 y CORREGIR** | S4 | Hoy declara agrupar con 4 IDPS + género y comparar K-Means / jerárquico / GMM. Reemplazar por: 3 variables de proceso (convivencia, asistencia, género), K-Means y Ward |
| s21 | **Dividir** | S4 y S17 | La definición del target y el objetivo van a S4; predictores, modelos y evaluación a S17 |
| s6 | Modificar | S5 | Cambiar "96 con 10% o más sin dato en género y 1 sin asistencia" por **"97 por no respuesta en género"**. Agregar el perfil de los 97 excluidos |
| s7, s10, s11 | **Fusionar** | S6 | Composición + descriptivos + **un** panel de outliers |
| s8, s16 | **Fusionar** | S7 | Histograma con corte + conversión a target binario. Agregar los 295 casos en la banda de ±10 puntos |
| s9 | Modificar | S8 | Agregar al pie: α 0,919, un factor con 71,5% de la varianza, y la mención de los índices docentes descartados |
| s12, s13, s14 | **A anexo** | — | Segundo panel de outliers y las dos matrices de dispersión |
| s15 | **Eliminar** | — | Redundante con S9 y S10 |
| s17 | Modificar | S9 | Corregir 74,5 → **74,4** y 85,0% → **85,1%**. Agregar la lectura accionable / estructural |
| s18, s19 | **Fusionar** | S10 | **Quitar el bullet repetido "el tramo de carrera docente no discrimina (AUC 0,539)"**, que no corresponde en una lámina de categóricas |
| — | **NUEVAS** | S11–S16 | Bloque completo de resultados de clustering |
| s22 | Fusionar | S17 | Se integra al protocolo |
| s23 | Mantener | S18 | Ya correcta |
| s24 | **Modificar** | S19 | Agregar al barrido las columnas de **sensibilidad, especificidad y balanced accuracy**, y **declarar el umbral 0,50 justificándolo por el criterio de clases con igual peso**. Quitar la frase "el F1 es máximo en 0,50", que es un criterio equivocado para este objetivo |
| s25 | Mantener | S20 | Correcta a umbral 0,50. Agregar la nota de que bajo nuestro criterio se leen los dos *recalls* (0,725 y 0,764) y no la precisión, que depende de la prevalencia |
| s26 | Mantener + agregar | S21 | Agregar el párrafo de sesgo de método común y causalidad inversa |
| — | **NUEVA** | S22 | Revisión de casos de clasificación (hoy ausente, y la rúbrica la pide) |
| — | **NUEVAS** | S23–S25 | Bloque completo de conclusiones |
| s27, s28, s29 | Mantener | Cierre | — |

**Resumen:** 26 láminas de contenido → **25**. Diez nuevas, una eliminada, doce fusionadas en cinco,
tres al anexo, y cuatro con corrección de cifras o de contenido.

### Figuras que hay que llevar al deck

| Lámina | Archivo | Estado |
|---|---|---|
| S13 | `cluster_pca.png` | ✅ Existe |
| S14 | `cluster_heatmap.png` | ✅ Existe |
| S13 o anexo | `cluster_boxplots.png` | ✅ Existe |
| S18 | `laminas_clasificacion/L4-3_roc_precision_recall.png` | ✅ Existe |
| S19 | `L4-4_histograma_scores.png`, `L4-4b_barrido_umbral.png` | ✅ Existen |
| S21 | `L4-6_importancia_permutacion.png`, `L4-6b_shap_bar.png`, `L4-6d_shap_forma_*.png` | ✅ Existen |
| S20 | `L4-5_matriz_confusion.png` | ✅ Existe (a 0,50, que es el umbral adoptado) |
| S22 | `L4-7_shap_caso_*.png`, `tabla_revision_casos.csv`, `tabla_falsos_negativos.csv` | ✅ Existen (a 0,50) |
| S12 | Figura de métricas vs k (3 paneles) | ❌ Ver `[FALTA-3]` |
| S16 | Figura de los 4 perfiles | ❌ Ver `[FALTA-4]` |
| S19 | Curva de balanced accuracy vs umbral | ❌ Ver `[FALTA-1]` |

`L4-8_focalizacion_score.png` **se saca**: la focalización por score no es el uso de este proyecto.

---

# 2. Vacíos

Cada uno indica exactamente qué hay que correr. **Ninguno bloquea la presentación.**

**`[FALTA-1]` · Barrido de umbral con métricas simétricas y predicciones fuera de fold.**
*Necesario para la tabla y la curva de S19.*
El barrido actual (E1 celda 173) tiene precisión, recall y F1 de la clase positiva, en pasos de 0,05
y sobre el split de 358. Hay que agregar **sensibilidad, especificidad, balanced accuracy y J de
Youden**, y calcularlo sobre `cross_val_predict` para tener los 1.429 scores fuera de fold, que da
una curva mucho más estable. Los valores ya están verificados en esta auditoría: el máximo de
balanced accuracy y de Youden cae exactamente en 0,50 (0,7127 y 0,4254), con sensibilidad 0,718 y
especificidad 0,708. Si no se alcanza a correr, la tabla se puede armar con esas cifras y declarar
que provienen de la verificación.

**`[FALTA-2]` · Las cinco celdas de E1 sin salida guardada** (168, 177, 186, 188, 190).
Producen el AUC de test, la tabla comparativa de validación cruzada y los tres gráficos SHAP. Las
re-ejecuté y **reproducen exacto**, pero el notebook que se entrega no las tiene. Re-ejecutar el
notebook completo y guardar antes de subirlo.

**`[FALTA-3]` · Figura de métricas de clustering contra k.** *Necesaria para S12.*
Existe como salida en E2 celda 14 pero no está exportada a PNG. Agregar `plt.savefig` y exportar.

**`[FALTA-4]` · Figuras del clustering k=4.** *Necesarias para S16.*
La tabla de perfiles y el gráfico de porcentaje que supera están en E3 celdas 23 y 30, sin exportar.
Agregar `plt.savefig`.

**`[FALTA-5]` · Estabilidad entre semillas y ARI contra GMM para k=2.**
Las cifras que uso en S12 (ARI mínimo 0,986 entre veinte semillas; 0,642 contra GMM) las calculé en
esta auditoría; **no están en ningún notebook**. Agregar una celda a E2 con el bucle de semillas y el
ajuste de `GaussianMixture(n_components=2)`.

**`[FALTA-6]` · Nombres de los casos representativos del k=2.**
E2 celda 26 entrega solo el RBD. Los nombres que uso en S15 los obtuve cruzando con
`simce2m2024_rbd_preliminar.parquet`. Agregar ese merge a la celda.

**`[FALTA-7]` · Perfil de los 97 establecimientos excluidos.**
Las cifras de S5 y S25 (mediana 29 vs 64 evaluados, 3,1% vs 24,8% sobre el corte, 18,6% vs 8,5%
rurales, Mann-Whitney p = 9,5e−18) las calculé reconstruyendo la base de 1.526. **No están en ningún
notebook.** Agregar una celda a E1 después de la 47 que compare excluidos contra incluidos.

**`[FALTA-8]` · Verificación de la afirmación "primera posición en el 95% de las réplicas (1.000)"**
de la lámina 19 del deck. **No encontré ningún bootstrap en ningún notebook.** O se corre y se deja
la evidencia, o se saca la frase de la lámina. Es la única afirmación del deck que no pude respaldar.

**`[FALTA-9]` · Análisis de sensibilidad sin los 68 establecimientos imputados con SIMCE 2023.**
No existe. Correr la clasificación excluyéndolos y comparar el AUC de validación cruzada. Es una
celda y blinda la pregunta más probable sobre la imputación.

**`[FALTA-10]` · Concentración regional (31% RM, 11% Valparaíso, 9% Biobío) de la lámina 7.**
Aparece en el deck; no encontré la salida que la produce. Verificar o citar el conteo directo sobre
`base_tareas`.

---

# 3. Hallazgos de la auditoría técnica

Detalle completo en `docs/00-inventario-y-auditoria.md`. Acá, cada hallazgo con qué hacer si no hay
tiempo de rehacerlo.

| # | Hallazgo | Severidad | Si no hay tiempo de rehacerlo |
|---|---|---|---|
| H1 | La exclusión de los 97 establecimientos **no es aleatoria**: correlaciona fuerte con el tamaño, y solo 3 de 97 superan el corte | 🔴 Alta | **Declararlo en S5 y S25.** No hace falta rehacer nada: dicho por el equipo suma más que corregido en silencio. Ya está en el guión |
| H3 | `pct_preferentes` quedó fuera del modelo pese a que el EDA decidió incluirla. CV 0,783 → **0,806** | 🔴 Alta | **Declararlo en S25** como aprendizaje de trazabilidad, con la cifra verificada. Ya está en el guión |
| H4 | Cinco celdas de resultados de E1 sin salida guardada | 🔴 Alta | Re-ejecutar y guardar el notebook antes de entregarlo. Los números son correctos; el riesgo es de entregable |
| H5 | Dos clusterings ejecutados con mensajes distintos | 🔴 Alta | **Resuelto en el guión**: k=2 como principal, k=4 como robustez en S16, con la síntesis "el contexto fija el techo, los procesos mueven dentro" |
| H6 | Lámina de SMOTE / RandomizedSearchCV | ✅ Resuelta | Ya eliminada en el deck (3). Verificado: no existe SMOTE ni remuestreo en ningún notebook |
| H7 | La lámina 20 declara variables y algoritmos que no coinciden con nada ejecutado | 🟠 Media | **Hay que corregirla sí o sí**: es la definición de la tarea y contradice a la lámina 19. Es reescribir dos viñetas |
| H8 | El umbral 0,50 se justificaba por F1 de la clase positiva, que es la métrica **menos** apropiada cuando las dos clases pesan igual: ignora los verdaderos negativos | 🟠 Media | **El umbral 0,50 es correcto; lo que había que cambiar era el argumento.** Resuelto en S19: el criterio es balanced accuracy, cuyo máximo fuera de fold cae exactamente en 0,50, y coincide con el óptimo teórico de un modelo entrenado con `class_weight="balanced"`. **No hay que regenerar ninguna figura.** Si no se corre `[FALTA-1]`, basta con no repetir la frase del F1 |
| H9 | Sesgo de método común y causalidad inversa ausentes del deck | 🟠 Media | Es texto, no análisis. Ya está redactado en S21 y S25 |
| H9b | La clasificación no tiene revisión de casos, que la rúbrica pide explícitamente | 🟠 Media | **Es la lámina nueva de mayor retorno.** Todo el material ya está exportado en `laminas_clasificacion/` |
| H10 | Imputación con SIMCE 2023 sin sensibilidad, teniendo la advertencia de la Agencia en las referencias | 🟠 Media | Si no se corre `[FALTA-9]`, tener la respuesta preparada (pregunta 6 del listado siguiente) |
| H11 | Estabilidad de clusters no reportada | 🟠 Media | Las cifras están verificadas y en S12. Si no se agregan al notebook, presentarlas como verificación de la auditoría |
| H12 | Lámina 6 dice "96 + 1" en vez de 97 | 🟡 Baja | Corregir el texto. Un minuto |
| H13 | AUC 0,539 repetido en la lámina 18 | 🟡 Baja | Borrar el bullet |
| H15 | E2 afirma que las correlaciones entre las 3 variables de agrupamiento son bajas (máx. 0,29) y luego PC1 concentra 44,4% | 🟡 Baja | Ambas son ciertas. No decir "bajas" en voz alta; decir "parcialmente independientes" |
| H17 | 74,5 vs 74,4 en convivencia y 85,0% vs 85,1% en asistencia | 🟡 Baja | Corregir en la lámina 17 |

---

# 4. Preguntas probables del jurado

**1. El clima escolar lo reportan los mismos estudiantes que rinden la prueba, el mismo día. ¿Cómo
saben que el buen clima no es consecuencia del buen rendimiento y no su causa?**
No lo sabemos, y por eso lo decimos nosotros en la lámina 21 en vez de esperar la pregunta. Hay dos
problemas superpuestos: causalidad inversa y varianza de método común. Con un corte transversal y un
solo instrumento no se pueden separar. Tres cosas mitigan parcialmente: la asistencia es registro
administrativo, es independiente del cuestionario, y es la variable de mayor peso en el bosque; la
convivencia mantiene su asociación controlando por vulnerabilidad y dependencia; y el orden de las
variables coincide con lo que reporta la literatura de escuelas efectivas. Pero nada de eso es
identificación causal. Para eso haría falta un panel de al menos dos años, o una medición del clima
independiente de la aplicación del SIMCE.

**2. ¿Por qué k igual a 2? Con un silhouette de 0,257 podría ser cualquier k.**
Fijamos la regla antes de mirar: máximo silhouette. K-Means con k igual a 2 lo maximiza y
Calinski-Harabasz coincide. Davies-Bouldin no acompaña —su mínimo está en k igual a 8— y lo dejamos
declarado en vez de omitirlo, porque esa métrica premia sistemáticamente particiones más finas y k
igual a 8 no habría dado perfiles interpretables. Y como el silhouette es bajo, corrimos la
alternativa completa con k igual a 4 y otro espacio de variables, que es la lámina 16. No escondimos
la ambigüedad: la presentamos.

**3. Un silhouette bajo suele significar que no hay grupos. ¿No están inventando una estructura?**
Es una objeción correcta y la respuesta es que **no son grupos naturales, son tramos de un
continuo**, y lo decimos así en la lámina 12. Ya en la exploración se veía: los indicadores tienen
desviaciones de cuatro o cinco puntos en una escala de cien. El test de Hopkins da 0,819, que
descarta ruido uniforme pero no garantiza grupos separados —una nube gaussiana también supera ese
umbral—. Lo que sostenemos no es que existan dos tipos de escuela, sino que al segmentar el gradiente
de procesos aparece una diferencia de 18,9 puntos entre segmentos socioeconómicamente idénticos. Esa
afirmación no requiere que los grupos estén separados.

**4. Si el Random Forest tiene mejor AUC de validación cruzada, ¿por qué presentan la logística?**
Porque 0,783 contra 0,788 son cinco milésimas, con desviaciones de catorce y cuatro milésimas: no hay
diferencia estadística que defender. Y porque SHAP nos mostró **por qué** el bosque no gana: los
efectos son monótonos y se suman más que se multiplican, así que no hay interacciones que un modelo
aditivo se pierda. Dado el empate, elegimos el modelo que produce un argumento discutible por un
equipo directivo. En política pública el entregable no es la predicción, es el argumento.

**5. ¿Cómo justifican el umbral de 0,50?**
Primero declarando el criterio: en este proyecto **las dos clases pesan lo mismo**, porque no estamos
armando listas de escuelas sino caracterizando el contraste entre las que superan el nivel y las que
no. Y ahí hay una trampa que vale la pena nombrar: **F1 no expresa eso**. El F1 de la clase positiva
ignora por completo los verdaderos negativos, y el F1 macro se deja arrastrar por la clase
mayoritaria porque incluye la precisión, que depende de la prevalencia. La métrica que sí traduce
"las dos clases pesan igual" es la **balanced accuracy**, o su equivalente, el J de Youden.
Calculada sobre los 1.429 scores fuera de fold, su máximo cae **exactamente en 0,50**, con
sensibilidad 0,718 y especificidad 0,708: el modelo es igual de bueno con ambas clases. Y coincide
con el argumento teórico: al entrenar con `class_weight="balanced"` el modelo queda calibrado a un
prior de 50/50, así que bajo costos simétricos el corte óptimo es 0,50 por construcción. Si nos
importara más una clase que la otra, 0,60 daría 0,817 de especificidad a costa de bajar la
sensibilidad a 0,576. No es nuestro caso.

**5b. Pero ustedes eligieron el umbral mirando los mismos datos con que lo evalúan.**
Es una observación correcta y por eso lo calculamos sobre predicciones fuera de fold, no sobre el
conjunto de prueba: cada establecimiento recibe un score de un modelo que no lo vio en su
entrenamiento. Queda un residuo de optimismo, porque el punto se elige mirando esa curva. En nuestro
caso el efecto es menor por dos razones: la curva es plana entre 0,45 y 0,55, así que la elección no
está fina; y el 0,50 no lo elegimos por búsqueda, sino que es el valor que predice la teoría y que la
curva confirma.

**6. Imputaron 68 establecimientos con el SIMCE 2023. La propia Agencia advierte que ciertas
comparaciones entre años son incorrectas.**
Es correcto y la advertencia está en nuestras referencias. Dos matices. Primero, no estamos comparando
años ni midiendo cambio: usamos el resultado 2023 como **mejor predictor disponible** del desempeño
del mismo establecimiento, frente a la alternativa que era imputar por media de grupo, que borra toda
la variación individual que justamente queremos estudiar. Segundo, son 68 de 1.429, un 4,8%. Dicho
eso, **no corrimos el análisis de sensibilidad excluyéndolos**, y deberíamos haberlo hecho: es una
celda. Está en nuestra lista de pendientes.

**7. ¿Por qué descartaron tres de los cuatro indicadores de desarrollo personal y social?**
Porque correlacionan entre 0,69 y 0,89 entre sí. En el clustering, incluir los cuatro es aportar
cuatro veces la misma dimensión al cálculo de distancias, y el espacio queda dominado por un
constructo repetido. En la clasificación, coeficientes de variables casi idénticas se reparten de
forma inestable y dejan de ser interpretables. Elegimos convivencia por dos razones: es el que mejor
discrimina de los cuatro, con AUC 0,704, y es la dimensión más accionable desde la gestión escolar.
La alternativa —un índice compuesto— la usamos en el análisis de robustez con k igual a 4.

**8. ¿Cómo puede ser que el tramo de carrera docente no prediga nada?**
Nos sorprendió y lo verificamos por tres vías independientes: AUC univariado 0,539, importancia por
permutación 0,009 con desviación 0,010 —indistinguible de cero— y en el clustering la correlación con
el puntaje es −0,033. Hay dos lecturas posibles. Una es que el tramo mide credenciales y evaluación
formal, no práctica de aula. La otra, más incómoda, es de composición: la asignación de docentes
avanzados a establecimientos vulnerables no es aleatoria. Con estos datos no podemos distinguirlas.
Lo que sí afirmamos es que **el tramo, tal como está medido, no discrimina en esta población**, y por
eso no interpretamos su coeficiente aunque salga positivo.

**9. La muestra son 1.429 de 1.526. ¿Los 97 que sacaron eran comparables?**
No, y es el hallazgo que más nos costó. Los auditamos: tienen una mediana de 29 estudiantes evaluados
contra 64 de los incluidos, son 18,6% rurales contra 8,5%, y **solo 3 de los 97 superan el corte,
frente a 24,8% de los que quedaron**. La prueba de Mann-Whitney sobre el tamaño da p del orden de diez
a la menos dieciocho. O sea, excluimos las escuelas más chicas, más rurales y de peor rendimiento.
Consecuencia concreta: nuestras conclusiones valen para establecimientos de tamaño medio y grande, y
el modelo no fue entrenado en el segmento más vulnerable. Si lo rehiciéramos, imputaríamos con
indicador de faltante en lugar de eliminar.

**10. Si mañana se sienta con el director de un liceo municipal, ¿qué le dice?**
Cuatro cosas, y ninguna cuesta plata. Primero: su índice de vulnerabilidad no determina su resultado.
Mostramos dos grupos de escuelas con vulnerabilidad idéntica —0,888 y 0,890— donde uno tiene 41,6% de
establecimientos sobre el nivel y el otro 11,2%. Segundo: las dos palancas que aparecen arriba en
todos nuestros modelos son asistencia y convivencia, y ambas tienen rendimientos decrecientes, así
que le podemos decir **dónde** poner el esfuerzo que ya está haciendo: si su asistencia está bajo
0,80 o su convivencia bajo 72, ahí está concentrado el margen; si ya está sobre 0,90 y sobre 80, esa
energía rinde más en otra parte. Tercero: los estereotipos de género de sus estudiantes pesan y se
trabajan en el aula, sin presupuesto. Cuarto, y con la misma claridad: esto es una asociación, no una
promesa. No podemos garantizarle que subir la asistencia le suba el puntaje, y con un corte
transversal nadie puede. Lo que sí le podemos decir es dónde mirar, y mostrarle escuelas concretas en
su mismo contexto que lo lograron.

---

# 5. Checklist de rúbrica

| Ítem de la rúbrica | % | Láminas que lo cubren | Estado |
|---|---|---|---|
| **1. Sobre el proyecto** — problema, objetivo, definición de ambas tareas | — | S2, S3, **S4** | ✅ Con S4 corregida |
| **2. Exploración de datos** | **30%** | | |
| 2.1 Exploración descriptiva (tamaños, frecuencias, outliers, correlaciones) | 10% | S5 (embudo y faltantes), S6 (composición, descriptivos, outliers), S8 (fuentes) | ✅ |
| 2.2 Exploración respecto al objetivo | 20% | S7 (target), **S9** (r, AUC, Cohen's d), **S10** (categóricas y selección) | ✅ |
| **3. Clustering** | **30%** | | |
| Algoritmos usados, datos usados, ajuste de parámetros | 10% | **S11** (datos y estandarización), **S12** (algoritmos, k, métricas, estabilidad) | ⚠️ Requiere `[FALTA-3]` |
| Visualización de grupos | ~7% | **S13** (PCA), **S14** (mapa de calor) | ✅ |
| Revisión de casos en cada grupo | ~7% | **S15** (5 casos por grupo, con nombre) | ⚠️ Requiere `[FALTA-6]` |
| Interpretación de grupos | ~6% | **S14** (hallazgo central), **S16** (robustez k=4) | ⚠️ Requiere `[FALTA-4]` |
| **4. Clasificadores** | **30%** | | |
| Algoritmos, datos, ajuste de hiperparámetros | 10% | **S17** | ✅ |
| Histograma de scores y umbral de decisión | ~7% | **S19** | ✅ Mejora con `[FALTA-1]` |
| Métricas de efectividad | ~7% | **S18** (comparación y CV), **S20** (matriz y reporte a 0,50) | ✅ |
| Revisión de casos | ~6% | **S22** (cuadrantes, falsos negativos con nombre, SHAP individual) | ✅ Material ya exportado a 0,50 |
| **5. Conclusiones** | **10%** | | |
| Comparación de clasificadores, mejor resultado, impacto de la predicción | 5% | **S23** (comparación y elección), **S24** (sobre qué puede actuar la escuela) | ✅ |
| Conocimiento adquirido | 5% | **S25** (tres errores propios + aprendizaje de cierre) | ✅ |

**Cobertura:** los 100% de la rúbrica quedan cubiertos. Tres ítems del bloque de clustering mejoran si
se generan figuras cuyos números ya están verificados (`[FALTA-3]`, `[FALTA-4]`, `[FALTA-6]`), y el
bloque de clasificación **no requiere regenerar nada**: al adoptar 0,50 como umbral, todas las figuras
y tablas exportadas en `laminas_clasificacion/` sirven tal como están. Ninguno requiere volver a
modelar.

**Interpretación tuya de la ponderación método / resultados** (10% frente a 20% en los bloques 2, 3 y
4): en el guión, el bloque 3 dedica 3 de 10 minutos a método (S11 y S12) y 7 a resultados
(S13 a S16); el bloque 4 dedica 3:10 de 10 a método (S17 y la primera mitad de S18) y el resto a
resultados. Se respeta el tercio / dos tercios.
