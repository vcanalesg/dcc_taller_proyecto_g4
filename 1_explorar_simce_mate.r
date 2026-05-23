# Explorar datos
# Puntajes Simce 2024 segundo medio, matemáticas

# paquetes -----
library(tidyverse)
library(readr)
library(janitor)
library(ggplot2)

# datos -----

path <- "/Users/vcanalesg/Documents/diplomado_dcc/0_taller_proyecto/datos/"
df <- file.path(path, "simce2m2024_rbd_preliminar.csv") %>%
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

## revisar establecimientos que no tienen grupo socioeconómico
df %>%
    filter(is.na(cod_grupo)) %>%
    select(rbd, nom_rbd, prom_mate2m_rbd, prom_lect2m_rbd) %>%
    view()

# los establecimientos sin gse tampoco tienen puntajes simce

## revisar distribución de puntajes simce de matemáticas

df %>%
    filter(!is.na(prom_mate2m_rbd)) %>%
    summarise(media = mean(prom_mate2m_rbd),
              mediana = median(prom_mate2m_rbd),
              sd = sd(prom_mate2m_rbd),
              min = min(prom_mate2m_rbd),
              max = max(prom_mate2m_rbd))

ggplot(df, aes(x = prom_mate2m_rbd)) +
    geom_histogram(binwidth = 5, fill = "grey", color = "black") +
    labs(title = "Distribución de puntajes Simce de Matemáticas",
         x = "Puntaje Simce Matemáticas",
         y = "Frecuencia") +
    theme_minimal()

## revisar qué establecimientos tienen más de 400 puntos que es el máximo posible
df %>%
    filter(prom_mate2m_rbd > 400) %>%
    select(rbd, nom_rbd, prom_mate2m_rbd, cod_grupo)

# son escuelas de grupo socioeconómico alto, por lo que no entran en el análisis

## revisar distribucion de puntajes simce por grupo socioeconomico

df %>%
    filter(!is.na(cod_grupo) & !is.na(prom_mate2m_rbd)) %>%
    group_by(cod_grupo) %>%
    summarise(media = mean(prom_mate2m_rbd),
              mediana = median(prom_mate2m_rbd),
              sd = sd(prom_mate2m_rbd),
              min = min(prom_mate2m_rbd),
              max = max(prom_mate2m_rbd),
              n_establecimientos = n())


df %>%
    filter(!is.na(cod_grupo) & !is.na(prom_mate2m_rbd)) %>%
ggplot(aes(x = as.factor(cod_grupo), y = prom_mate2m_rbd)) +
    geom_boxplot() +
    labs(title = "Puntajes Simce de Matemáticas por Grupo Socioeconómico",
         x = "Grupo Socioeconómico",
         y = "Puntaje Simce Matemáticas") +
    theme_minimal()

df %>%
    filter(!is.na(cod_grupo) & !is.na(prom_mate2m_rbd)) %>%
    ggplot(aes(x = as.factor(cod_grupo), y = prom_mate2m_rbd)) +
    geom_violin() +
    labs(title = "Puntajes Simce de Matemáticas por Grupo Socioeconómico",
         x = "Grupo Socioeconómico",
         y = "Puntaje Simce Matemáticas") +
    theme_minimal()

df %>%
    filter(!is.na(cod_grupo) & !is.na(prom_mate2m_rbd)) %>%
    ggplot(aes(x = prom_mate2m_rbd)) +
    geom_histogram(binwidth = 5, fill = "grey", color = "black") +
    labs(title = "Distribución de puntajes Simce de Matemáticas",
         x = "Puntaje Simce Matemáticas",
         y = "Frecuencia") +
    theme_minimal() +
    facet_wrap(~ as.factor(cod_grupo))

## número de rbd por cod_grupo y distribucion de puntajes simce
# los puntajes simce de matemáticas se pueden categorizar en 1) insuficiente, 2) elemental, 3) adecuad
# def: 1) insuficiente:  menos de 252 puntos, 2) elemental: entre 252 y 318 puntos, 3) adecuado: 319 o más puntos

df %>%
    filter(!is.na(cod_grupo) & !is.na(prom_mate2m_rbd)) %>%
    mutate(categoria_simce = case_when(
        prom_mate2m_rbd < 252 ~ "Insuficiente",
        prom_mate2m_rbd >= 252 & prom_mate2m_rbd < 319 ~ "Elemental",
        prom_mate2m_rbd >= 319 ~ "Adecuado"
    )) %>%
    group_by(cod_grupo, categoria_simce) %>%
    summarise(n_establecimientos = n(), .groups = "drop") %>%
    pivot_wider(names_from = categoria_simce, values_from = n_establecimientos, values_fill = 0) 


#  cod_grupo Adecuado Elemental Insuficiente
#      <dbl>    <int>     <int>        <int>
# 1         1        2        93          598
# 2         2       15       264          588
# 3         3       33       389          248
# 4         4       35       244           52
# 5         5      212       198           23

## distribucion de rbd por cod_grupo y urbano / rural

df %>%
    mutate(cod_rural_rbd = if_else(cod_rural_rbd == 1, "Urbano", "Rural")) %>%
    filter(!is.na(cod_grupo) & !is.na(cod_rural_rbd)) %>%
    group_by(cod_grupo, cod_rural_rbd) %>%
    summarise(n_establecimientos = n(), .groups = "drop") %>%
    pivot_wider(names_from = cod_rural_rbd, values_from = n_establecimientos, values_fill = 0)

## distribucion de rbd por cod_grupo y dependencia 
df %>%
    mutate(cod_depe2 = case_when(
    cod_depe2 == 1 ~ "Municipal",  
    cod_depe2 == 2 ~ "Particular Subvencionado",
    cod_depe2 == 3 ~ "Particular Pagado",  
    cod_depe2 == 4 ~ "Servicio Local de Educación")) %>%
    filter(!is.na(cod_grupo) & !is.na(cod_depe2)) %>%
    group_by(cod_grupo, cod_depe2) %>%
    summarise(n_establecimientos = n(), .groups = "drop") %>%
    pivot_wider(names_from = cod_depe2, values_from = n_establecimientos, values_fill = 0) %>%
    view()

## distribución marcas de puntajes
df %>%
    filter(!is.na(marca_mate2m_rbd)) %>%
    count(marca_mate2m_rbd, cod_grupo) %>%
    arrange(desc(n))

df %>%
    filter(marca_mate2m_rbd %in% 1:2) %>%
    select(rbd, marca_mate2m_rbd, prom_mate2m_rbd, cod_grupo) %>%
    view()

## cantidad de escuelas por cod_grupo y que en marca_mate2m_rbd es NA
df %>%
    filter(is.na(marca_mate2m_rbd) & !is.na(cod_grupo)) %>%
    mutate(categoria_simce = case_when(
        prom_mate2m_rbd < 252 ~ "Insuficiente",
        prom_mate2m_rbd >= 252 & prom_mate2m_rbd < 319 ~ "Elemental",
        prom_mate2m_rbd >= 319 ~ "Adecuado"
    )) %>%
    group_by(cod_grupo, categoria_simce) %>%
    summarise(n_establecimientos = n(), .groups = "drop") %>%
    pivot_wider(names_from = categoria_simce, values_from = n_establecimientos, values_fill = 0)

# A tibble: 5 × 4
#  cod_grupo Adecuado Elemental Insuficiente
#      <dbl>    <int>     <int>        <int>
# 1         1        2        92          575
# 2         2       14       245          569
# 3         3       31       384          238
# 4         4       33       241           52
# 5         5      212       189           21

# se pierden 63 establecimientos para los cuales el puntaje no es representativo (1 de estos no tiene puntaje)

## revisar distribución de porcentaje de estudiantes con
# puntajes insuficientes

df %>%
    filter(!is.na(palu_eda_ins_mate2m_rbd)) %>%
    filter(is.na(marca_mate2m_rbd)) %>%
    group_by(cod_grupo) %>%
    summarise(media = mean(palu_eda_ins_mate2m_rbd),
              mediana = median(palu_eda_ins_mate2m_rbd),
              sd = sd(palu_eda_ins_mate2m_rbd),
              min = min(palu_eda_ins_mate2m_rbd),
              max = max(palu_eda_ins_mate2m_rbd))

# puntajes elementales
df %>%
    filter(!is.na(palu_eda_ele_mate2m_rbd)) %>%
    filter(is.na(marca_mate2m_rbd)) %>%
    group_by(cod_grupo) %>%
    summarise(media = mean(palu_eda_ele_mate2m_rbd),
              mediana = median(palu_eda_ele_mate2m_rbd),
              sd = sd(palu_eda_ele_mate2m_rbd),
              min = min(palu_eda_ele_mate2m_rbd),
              max = max(palu_eda_ele_mate2m_rbd))

# puntajes adecuados
df %>%
    filter(!is.na(palu_eda_ade_mate2m_rbd)) %>%
    filter(is.na(marca_mate2m_rbd)) %>%
    group_by(cod_grupo) %>%
    summarise(media = mean(palu_eda_ade_mate2m_rbd),
              mediana = median(palu_eda_ade_mate2m_rbd),
              sd = sd(palu_eda_ade_mate2m_rbd),
              min = min(palu_eda_ade_mate2m_rbd),
              max = max(palu_eda_ade_mate2m_rbd))

# gráfico distribución de porcentaje con puntaje insuficiente por grupo socioeconómico
df %>%
    filter(!is.na(palu_eda_ins_mate2m_rbd)) %>%
    filter(is.na(marca_mate2m_rbd)) %>%
    ggplot(aes(x = palu_eda_ins_mate2m_rbd)) +
    geom_histogram(bins = 30, fill = "grey", alpha = 0.7) +
    labs(title = "Porcentaje de estudiantes con puntaje insuficiente por grupo socioeconómico",
         x = "Grupo Socioeconómico",
         y = "Porcentaje de estudiantes con puntaje insuficiente") +
    theme_minimal() +
    facet_wrap(~ as.factor(cod_grupo))


# variables a considerar en el análisis:
# - cod_grupo
# - prom_mate2m_rbd
# - categoria_simce
# - cod_rural_rbd
# - dependencia (cod_depe2)