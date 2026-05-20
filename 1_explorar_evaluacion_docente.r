# Explorar datos
# Evaluación docente

# paquetes ---------
library(tidyverse)
library(readr)
library(janitor)
library(ggplot2)

# cargar datos -----

path <- "/Users/vcanalesg/Documents/diplomado_dcc/0_taller_de_proyecto/datos/"
df <- file.path(path, "20251118_EVALUACION_DOCENTE_2024_20251118_PUBL.csv") %>%
  read_csv() %>%
  clean_names()

glimpse(df)