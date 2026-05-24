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

## contar matrícula por educación de adultos
# no hay casos 
df %>%
  filter(cod_ense %in% c(3,6,8)) %>%
  count(cod_ense)

## revisar distribución de edad de estudiantes de segundo medio
df %>%
  filter(cod_ense2 %in% c(5,7) & cod_grado2 == 2) %>%
  summarise(media = mean(edad_alu, na.rm = TRUE),
            mediana = median(edad_alu, na.rm = TRUE),
            sd = sd(edad_alu, na.rm = TRUE),
            min = min(edad_alu, na.rm = TRUE),
            max = max(edad_alu, na.rm = TRUE))

df %>%
  filter(cod_ense2 %in% c(5,7) & cod_grado2 == 2) %>%
  ggplot(aes(x = edad_alu)) +
  geom_histogram(binwidth = 1, fill = "grey", color = "black") +
  labs(title = "Distribución de edad de estudiantes de segundo medio",
       x = "Edad del estudiante",
       y = "Frecuencia") +
  theme_minimal()


## revisar establecimientos con estudiantes de segundo medio que tienen más de 20 años
df %>%
  filter(cod_ense2 %in% c(5,7) & cod_grado2 == 2 & edad_alu > 20) %>%
  select(rbd, nom_rbd, cod_com_rbd, cod_com_alu, edad_alu) 

# 18 casos, la mayoría corresponde a escuelas hospitalarias


