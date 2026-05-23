# Explorar datos
# Indicadores de desarrollo personal y social
# 2do medio

# paquetes -----

library(tidyverse)
library(janitor)
library(readr)

# datos --------

path <- "/Users/vcanalesg/Documents/diplomado_dcc/0_taller_proyecto/datos/"

df_sub <- file.path(path, "idps2M2024_rbd_niveles_preliminar.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

df_dim <- file.path(path, "idps2M2024_rbd_dim_preliminar.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

df_indicadores <- file.path(path, "idps2m2024_rbd_preliminar.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

glimpse(df_sub) # esta base no tiene cod_grupo
df_sub %>% filter(rbd == 1) %>%
    view()

# cada fila es una subdimensión (22 subdimensiones)
# las subdimensiones son:
# Autovaloración Académica 
# Promoción de la Autovaloración Académica 
# Interés y disposición al aprendizaje 
# Promoción de la motivación del aprendizaje 
# Cohesión social entre estudiantes 
# Apoyo y buen trato de los docentes 
# Ambiente organizado para el aprendizaje 
# Promoción de mecanismos constructivos de resolución de conflictos 
# Mecanismos de prevención y acción ante la violencia 
# Testimonios de violencia personal 
# Participación del estudiante 
# Promoción de la participación 
# Expresión de opiniones 
# Representación democrática 
# Promoción de la deliberación democrática 
# Identificación con el establecimiento 
# Actitud frente a la actividad física 
# Promoción de la vida activa 
# Actitud frente a la alimentación 
# Promoción de hábitos alimenticios 
# Actitud de autocuidado 
# Promoción de conductas de autocuidado 

glimpse(df_dim) # esta base tiene cod_grupo
df_dim %>% filter(rbd == 1) %>%
    view()

# cada fila es una dimensión (11 dimensiones)
# se presenta el promedio por dimensión
# las dimensiones son:
# Autopercepción y autovaloración académica
# Motivación escolar
# Ambiente de respeto
# Ambiente organizado
# Ambiente seguro
# Participación
# Vida democrática
# Sentido de pertenencia
# Hábitos de vida activa
# Hábitos alimenticios
# Hábitos de autocuidado

glimpse(df_indicadores)
# 4 observaciones por rbd, 1 por indicador
# los indicadores son:
# Autoestima Académica y Motivación Escolar
# Clima de Convivencia Escolar
# Participación y Formación Ciudadana
# Hábitos de Vida Saludable
# se presenta el promedio de cada indicador por rbd 

# explorar datos -----

# distribucion indicadores

indicadores <- c("AM", "CC", "HV", "PF")

for (i in indicadores) {
    tabla <- df_indicadores %>%
        filter(ind == i & !is.na(cod_grupo)) %>%
        group_by(cod_grupo) %>%
        summarise(promedio = mean(prom, na.rm = TRUE),
                  n = n(),
                  min = min(prom, na.rm = TRUE),
                  max = max(prom, na.rm = TRUE),
                  sd = sd(prom, na.rm = TRUE),
                  mediana = median(prom, na.rm = TRUE))
    print(paste("Indicador:", i))
    print(tabla)
}

# [1] "Indicador: AM"
# A tibble: 5 × 7
#   cod_grupo promedio     n   min   max    sd mediana
#      <dbl>    <dbl> <int> <dbl> <dbl> <dbl>   <dbl>
#1         1     74.4   693    64    95  4.21      74
#2         2     74.2   867    63    91  4.02      74
#3         3     73.8   671    61    89  4.15      74
#4         4     73.5   331    59    87  4.12      74
#5         5     75.3   433    63    88  4.25      75
# [1] "Indicador: CC"
# A tibble: 5 × 7
#  cod_grupo promedio     n   min   max    sd mediana
#      <dbl>    <dbl> <int> <dbl> <dbl> <dbl>   <dbl>
#1         1     75.2   693    63    95  4.56      75
#2         2     75.2   867    62    90  4.38      75
#3         3     75.3   671    62    88  4.49      75
#4         4     75.0   331    61    88  4.37      75
#5         5     78.3   433    63    90  4.44      78
# [1] "Indicador: HV"
# A tibble: 5 × 7
#   cod_grupo promedio     n   min   max    sd mediana
#      <dbl>    <dbl> <int> <dbl> <dbl> <dbl>   <dbl>
#1         1     72.2   693    45    87  4.75      72
#2         2     71.2   867    55    86  4.73      71
#3         3     69.8   671    51    82  5.11      70
#4         4     67.7   331    51    81  5.33      68
#5         5     67.3   433    36    79  5.31     67
# [1] "Indicador: PF"
# A tibble: 5 × 7
#  cod_grupo promedio     n   min   max    sd mediana
#      <dbl>    <dbl> <int> <dbl> <dbl> <dbl>   <dbl>
#1         1     77.3   693    64    97  5.04    77  
#2         2     77.1   867    60    94  4.88    77  
#3         3     77.0   671    63    91  4.95    77  
#4         4     76.6   331    59    92  4.96    76.5
#5         5     79.8   433    60    93  4.88    80  

# no se observan diferencias en la distribucion por grupo socioeconomico, aunque el grupo 5 tiene un promedio ligeramente superior en convivencia escolar

# contar valores perdidos para cada df
df_sub %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "n_perdidos") %>%
  arrange(desc(n_perdidos)) %>% 
  view()

# para los porcentajes hay valores perdidos

df_dim %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "n_perdidos") %>%
  arrange(desc(n_perdidos)) %>% 
  view()

# hay casos sin valores para cod_grupo y para el promedio

df_indicadores %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "n_perdidos") %>%
  arrange(desc(n_perdidos)) %>% 
  view()

# hay valores perdidos para el promedio de los indicadores
