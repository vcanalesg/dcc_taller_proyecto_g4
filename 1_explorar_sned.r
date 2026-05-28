# Explorar datos
# Sistema Nacional de Evaluacion de Desempeño

# El SNED evalua a los colegios cada dos años utilizando seis factores clave definidos por ley:

# Efectividad: Resultados academicos (SIMCE).
# Superacion: Evolucion y mejora de los resultados a lo largo del tiempo.
# Iniciativa: Implementacion de innovaciones educativas.
# Mejoramiento de las condiciones de trabajo: Entorno laboral del establecimiento.
# Igualdad de oportunidades: Inclusion y retencion de alumnos.
# Integracion y participacion: Involucramiento de profesores, padres y apoderados.

# Establecimientos educacionales subvencionados, aquellos pertenecientes a Servicios Locales de Educacion y 
# aquellos regidos por el Decreto Ley N° 3166 de 1980

# paquetes ------

library(tidyverse)
library(readr)
library(janitor)

options(scipen = 999)

# datos --------

path <- "/Users/vcanalesg/Documents/diplomado_dcc/0_taller_proyecto/datos/"

locale_es <- locale(decimal_mark = ",", grouping_mark = ".")

df <- file.path(path, "20240503_SNED_2024_2025.csv") |>
  read_delim(delim = ";", locale = locale_es) |>
  clean_names()

df %>% select(ends_with('integrar')) %>% head()

# explorar datos ------

# pasar coma a punto para variables leidas como character
df <- df %>%
   mutate(efectivr = as.numeric(gsub(',', '.', efectivr)),
          superar = as.numeric(gsub(',','.', superar)))


# datos que tienen valor negativo pasarlos a 0 siguiendo la escala en el diccionario de variables
df <- df %>%
    mutate(
        across(starts_with(c('efectivr','superar', 'mejorar','iniciar', 'integrar', 'igualdr')),
         ~ ifelse(.x < 0, 0, .x)))

glimpse(df)


# contar valores perdidos

df %>% summarise(across(everything(), ~ sum(is.na(.x)))) %>%
    pivot_longer(everything(), names_to = 'variable', values_to = 'n_perdidos') %>% 
    arrange(desc(n_perdidos)) %>%
    view()

# revisar que rbd es unico
nrow(df) == length(unique(df$rbd))

# revisar distribucion de puntajes 

dimensiones <- c('efectivr','superar', 'mejorar','iniciar', 'integrar', 'igualdr')

for (dim in dimensiones) {
    print(dim)
    df %>%
     summarise(media = mean(.data[[dim]], na.rm = TRUE),
               mediana = median(.data[[dim]], na.rm = TRUE),
               sd = sd(.data[[dim]], na.rm = TRUE),
               min = min(.data[[dim]], na.rm = TRUE),
               max = max(.data[[dim]], na.rm = TRUE)) %>%
    print()
}

# relacion entre las características

df %>%
  select(indicer, all_of(dimensiones)) %>%
  pivot_longer(cols = all_of(dimensiones), names_to = "dimension", values_to = "puntaje") %>%
  ggplot(aes(x = indicer, y = puntaje)) +
  geom_point(alpha = 0.3, size = 0.8) +
  facet_wrap(~ dimension, scales = "free_y") +
  labs(x = "Índice SNED", y = "Puntaje dimensión") +
  theme_minimal()

pairs(~efectivr + superar + mejorar + iniciar + integrar + igualdr, data = df)
