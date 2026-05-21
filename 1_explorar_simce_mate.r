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