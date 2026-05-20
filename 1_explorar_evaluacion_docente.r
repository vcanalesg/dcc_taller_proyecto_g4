# Explorar datos
# Evaluación docente

# paquetes ---------
library(tidyverse)
library(readr)
library(janitor)
library(ggplot2)

# cargar datos -----

path <- "/Users/vcanalesg/Documents/diplomado_dcc/0_taller_proyecto/datos/"
df <- file.path(path, "20251118_EVALUACION_DOCENTE_2024_20251118_PUBL.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

glimpse(df)

# explorar variables -----

## contar valores perdidos por variable
df %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "n_perdidos") %>%
  arrange(desc(n_perdidos))

## la variable pf_esc se encuentra vacía, porque este sistema de evaluación quedó invalidado en
## 2023 con la derogación establecida en el artículo 70 del Estatuto Docente

## revisar que mrun del profesor sea único
length(unique(df$mrun)) == nrow(df)

## revisar que cada mrun esté asociado a solo un rbd
df %>%
  count(mrun, rbd) %>%
  filter(n > 1)

## revisar distribución por sexo
df %>%
  count(doc_genero) %>%
  mutate(porcentaje = n / sum(n) * 100)

# la mayoria de los docentes son mujeres
#  doc_genero     n porcentaje
#       <dbl> <int>      <dbl>
#1          1  6417       25.5
#2          2 18780       74.5

## calcular edad de los docentes a partir de su fecha de nacimiento
# los primeros cuatro dígitos corresponden al año de nacimiento
# los siguientes dos dígitos corresponden al mes de nacimiento
# se asume que la evaluación es a final de año, por lo que se puede ignorar el mes en el cálculo de la edad

df <- df %>%
  mutate(
    doc_anio_nacimiento = as.numeric(substr(doc_fec_nac, 1, 4)),
    doc_edad = ifelse(doc_fec_nac == 190001, NA, 2024 - doc_anio_nacimiento))

## revisar distribución de edad
df %>%
  summarise(
    edad_min = min(doc_edad, na.rm = TRUE),
    edad_max = max(doc_edad, na.rm = TRUE),
    edad_promedio = mean(doc_edad, na.rm = TRUE),
    edad_mediana = median(doc_edad, na.rm = TRUE),
    edad_sd = sd(doc_edad, na.rm = TRUE)
  )

ggplot(df, aes(x = doc_edad)) +
  geom_histogram(binwidth = 5, fill = "#7c7c84", color = "black") +
  labs(title = "Distribución de edad de los docentes",
       x = "Edad",
       y = "Frecuencia") +
  scale_x_continuous(breaks = seq(25, 80, by = 5)) +
  theme_minimal()

## revisar distribución del puntaje de portafolio
df %>%
  summarise(
    pf_pje_min = min(pf_pje, na.rm = TRUE),
    pf_pje_max = max(pf_pje, na.rm = TRUE),
    pf_pje_promedio = mean(pf_pje, na.rm = TRUE),
    pf_pje_mediana = median(pf_pje, na.rm = TRUE),
    pf_pje_sd = sd(pf_pje, na.rm = TRUE)
  )

ggplot(df, aes(x = pf_pje)) +
  geom_line(stat = "density") +
  labs(title = "Distribución del puntaje de portafolio",
       x = "Puntaje de portafolio",
       y = "Densidad") +
  theme_minimal()

## revisar categoría de portafolio docente
# En el Sistema de Reconocimiento y Carrera Docente chileno, 
# la evaluación del desempeño se divide en 5 Tramos de Desarrollo
# Profesional (Acceso, Inicial, Temprano, Avanzado y Experto). 
#El puntaje final del Portafolio se expresa en 5 niveles de logro identificados con letras (A, B, C, D y E),
# donde A es el puntaje máximo y E el más bajo

df %>%
  count(pf_cat_carrera) %>%
  mutate(porcentaje = n / sum(n) * 100)

# ideas para el análisis:
## - calcular mediana evaluación docente por establecimiento
## - calcular mediana de edad de profesores por establecimiento
## - calcular distribución de categorías de portafolio por establecimiento
## - calcular distribucion por tramo de edad de los docentes
## - calcular distribución por sexo por establecimiento
## - calcular número de docentes por establecimiento
## - revisar si se puede distinguir entre docentes de básica y media
## - revisar si se puede distinguir qué materias imparten los docentes
## - revisar si se puede y tiene sentido trabajar con un subconjunto de profesores para ver los resultados de matemáticas en el Simce
