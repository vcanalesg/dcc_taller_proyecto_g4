# Explorar datos
# Sistema Nacional de Evaluacion de Desempeño

# El SNED evalua a los colegios cada dos años utilizando seis factores clave definidos por ley:

# Efectividad: Resultados academicos (SIMCE).
# Superacion: Evolucion y mejora de los resultados a lo largo del tiempo.
# Iniciativa: Implementacion de innovaciones educativas.
# Mejoramiento de las condiciones de trabajo: 
# Entorno laboral del establecimiento.
# Igualdad de oportunidades: Inclusion y retencion de alumnos.
# Integracion y participacion: Involucramiento de profesores, padres y apoderados.

# Establecimientos educacionales subvencionados, aquellos pertenecientes a Servicios Locales de Educacion y 
# aquellos regidos por el Decreto Ley N° 3166 de 1980

# paquetes ------

library(tidyverse)
library(readr)
library(janitor)


# datos --------

path <- "/Users/vcanalesg/Documents/diplomado_dcc/0_taller_proyecto/datos/"

df <- file.path(path, '20240503_SNED_2024_2025.csv') %>%
    read_delim(delim = ";") %>%
    clean_names()

glimpse(df)

# explorar datos ------

# las variables efectivr, superar estan como character
# se deben pasar a numeric

df <- df %>%
        mutate(efectivr_num = as.numeric(gsub(',', '.', efectivr)),
               superar_num = as.numeric(gsub(',', '.', superar)),
               mejorar_num = as.numeric(gsub(',', '.', mejorar)),
               iniciar_num = as.numeric(gsub(',', '.', iniciar)),
               integrar_num = gsub(',', '.', integrar),
               igualdr_num = gsub(',', '.', igualdr),
               efectivr_num = as.numeric(efectivr_num),
               superar_num = as.numeric(superar_num))

# contar valores perdidos

df %>% summarise(across(everything(), ~ sum(is.na(.x)))) %>%
    pivot_longer(everything(), names_to = 'variable', values_to = 'n_perdidos') %>% 
    arrange(desc(n_perdidos)) %>%
    view()

# revisar que rbd es unico
nrow(df) == length(unique(df$rbd))

# revisar distribucion de puntajes 

dimensiones <- c('efectivr_num','superar_num', 'mejorar','iniciar', 'integrar', 'igualdr')

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

df %>%
 filter(!is.na(efectivr)) %>%
 ggplot(aes(x = mejorar)) +
 geom_histogram()
