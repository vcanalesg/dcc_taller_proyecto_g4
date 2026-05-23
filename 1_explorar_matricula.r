# Explorar datos
# Matrícula 2024

# paquetes -----

library(tidyverse)
library(janitor)
library(readr)

# datos -----

path <- "/Users/vcanalesg/Documents/diplomado_dcc/0_taller_proyecto/datos/"

df <- file.path(path, "20240913_Matrícula_unica_2024_20240430_WEB.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

glimpse(df)

# explorar datos -----

## contar valores perdidos por variable
df %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "n_perdidos") %>%
  arrange(desc(n_perdidos)) %>% 
  view()

# tabla de datos por estudiante
# hay valores perdidos para edad y comuna de residencia estudiante

## revisar matricula para segundo medio sin considerar educacion de adultos
#

df %>%
 filter(cod_ense2 %in% c(5,7) & cod_grado == 2) %>%
 nrow()

#  255095 estudiantes de segundo medio

