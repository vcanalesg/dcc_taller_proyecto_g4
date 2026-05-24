# Explorar datos
# Docentes por curso y sector
# Se usan datos de 2025 porque 2024 no está disponible

# paquetes ------
library(tidyverse)
library(readr)
library(janitor)

# cargar datos ----

path <- "/Users/vcanalesg/Documents/diplomado_dcc/0_taller_proyecto/datos/"

docentes <- file.path(path, "20260316_Docentes_por_curso_y_subsector_2025_20260202_PUBL.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

glimpse(docentes)

# explorar datos ----

## contar número de valores perdidos por variable

docentes %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(cols = everything(), names_to = "variable", values_to = "n_perdidos") %>%
  arrange(desc(n_perdidos)) %>%
  view()

# valores perdidos en decreto de evaluacion y nombre de plan de estudios

## distribución de número de sectores
docentes %>%
  group_by(nom_subsector, tipo_subsector) %>%
  summarise(n_docentes = n()) %>%
  arrange(desc(n_docentes)) %>%
  view()

## número de docentes que imparten clases por curso
docentes %>%
  filter(cod_ense %in% c(310, 363, 410,463, 510,563,610,663,710,763,810,863,910, 963)) %>%
  group_by(cod_grado) %>%
  summarise(n_docentes = n()) %>%
  arrange(desc(n_docentes)) %>%
  view()

## número de docentes que imparten cursos de formación general
docentes %>%
  filter(cod_ense %in% c(310, 363, 410,463, 510,563,610,663,710,763,810,863,910, 963)) %>%
  filter(cod_grado == 2) %>%
  filter(tipo_subsector == 2) %>%
  filter(obl_subsector == 1) %>%
  group_by(nom_subsector) %>%
  summarise(n_docentes = n()) %>%
  arrange(desc(n_docentes)) %>%
  view()
