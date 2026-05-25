# Preparar datos
# Preprocesamiento datos de establecimiento

# paquetes -----

library(tidyverse)
library(janitor)
library(readr)

# cargar datos -----

path <- "/Users/vcanalesg/Documents/diplomado_dcc/0_taller_proyecto/datos/"

# simce 2do medio 2024
simce <- file.path(path, "simce2m2024_rbd_preliminar.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

# matricula 2024
matricula <- file.path(path, "20240913_Matrícula_unica_2024_20240430_WEB.csv") %>% 
  read_delim(delim = ";") %>%
  clean_names()

# idps 2024
idps_sub <- file.path(path, "idps2M2024_rbd_niveles_preliminar.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

idps_dim <- file.path(path, "idps2M2024_rbd_dim_preliminar.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

idps_indicadores <- file.path(path, "idps2m2024_rbd_preliminar.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

# docentes por sector y curso
docentes <- file.path(path, "20260316_Docentes_por_curso_y_subsector_2025_20260202_PUBL.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

# evaluación docente 2024
evaluacion_docente <- file.path(path, "20251118_EVALUACION_DOCENTE_2024_20251118_PUBL.csv") %>%
  read_delim(delim = ";") %>%
  clean_names()

# preparar datos matricula -----

matricula %>%
  count(cod_grado2)

matricula_rbd <- matricula %>%
  filter(!cod_ense %in% c(3,6,8)) %>% # dejar fuera educación de adultos
  mutate(marca_2do_medio = ifelse(cod_ense2 %in% c(5,7) & cod_grado2 == 2, 1L, 0L),
         marca_misma_comuna = ifelse(cod_com_rbd == cod_com_alu, 1L, 0L),
         marca_media = ifelse(cod_ense2 %in% c(5,7), 1L, 0L),
         marca_basica = ifelse(cod_ense2 == 2, 1L, 0L),
         escolaridad = case_when(
            cod_ense2 == 1 ~ 0L, # parvularia
            cod_ense2 == 2 & cod_grado2 != 99 ~ cod_grado2, # básica
            cod_ense %in% c(5,7) & cod_grado2 != 99 ~ cod_grado2 + 8L, # media
            TRUE ~ NA_integer_),
        # variables para construir rezago escolar siguiendo como se construye en encuesta casen
        # se asume que una persona debe tener 6 años cumplidos para ingresar al sistema escolar (enseñanza básica)
         curso = case_when(
          cod_grado2 == 99 | is.na(cod_grado2) | !cod_ense2 != 1 ~ NA_integer_,
          TRUE ~ cod_grado2 + 6L),
        # rezago se construye como la diferencia entre la edad y el curso que debería estar
         rezago = ifelse(!is.na(edad_alu) & !is.na(curso), edad_alu - curso, NA_integer_),
         rezago_media = case_when(
          rezago >= 2 & marca_media == 1 & edad_alu <= 21~ 1L,
          rezago < 2 & marca_media == 1 & edad_alu <= 21 ~ 0L,
          rezago >= 2 & marca_media == 1 & escolaridad >= 12 & edad_alu <= 21 ~ 0L,
          TRUE ~ NA_integer_),
          rezago_2do_medio = case_when(
            rezago >= 2 & marca_2do_medio == 1 & edad_alu <= 21 ~ 1L,
            rezago < 2 & marca_2do_medio == 1 & edad_alu <= 21 ~ 0L,
            rezago >= 2 & marca_2do_medio == 1 & escolaridad >= 12 & edad_alu <= 21 ~ 0L,
            TRUE ~ NA_integer_)) %>% 
  group_by(rbd) %>%
  summarise(n_matricula_2do_medio = sum(marca_2do_medio, na.rm = TRUE),
            n_misma_comuna_rbd = sum(marca_misma_comuna, na.rm = TRUE),
            n_matricula_media = sum(marca_media, na.rm = TRUE),
            n_matricula_basica = sum(marca_basica, na.rm = TRUE),
            n_mujer = sum(gen_alu == 2, na.rm = TRUE),
            n_mujer_2do_medio = sum(marca_2do_medio == 1 & gen_alu == 2, na.rm = TRUE),
            n_mujer_media = sum(marca_media == 1 & gen_alu == 2, na.rm = TRUE),
            n_mujer_basica = sum(marca_basica == 1 & gen_alu == 2, na.rm = TRUE),
            n_matricula = n(),
            p_mujer = n_mujer / n_matricula,
            p_mujer_2do_medio = n_mujer_2do_medio / n_matricula_2do_medio,
            p_mujer_media = n_mujer_media / n_matricula_media,
            p_mujer_basica = n_mujer_basica / n_matricula_basica,
            prom_edad_2do_medio = mean(edad_alu[marca_2do_medio == 1], na.rm = TRUE),
            median_edad_2do_medio = median(edad_alu[marca_2do_medio == 1], na.rm = TRUE),
            n_rezago_2do_medio = sum(rezago_2do_medio == 1, na.rm = TRUE),
            p_rezago_2do_medio = n_rezago_2do_medio / n_matricula_2do_medio,
            n_rezago_media = sum(rezago_media == 1, na.rm = TRUE),
            p_rezago_media = n_rezago_media / n_matricula_media) %>% 
  ungroup()

## preparar datos idps -----
# 4 indicadores

idps_indicadores_rbd <- idps_indicadores %>%
  pivot_wider(names_from = ind, values_from = prom, names_prefix = "ind_") %>%
  clean_names() %>%
  select(rbd, ind_am, ind_cc, ind_hv, ind_pf) %>%
  group_by(rbd) %>%
  summarise(across(c(ind_am, ind_cc, ind_hv, ind_pf), ~ mean(.x, na.rm = TRUE)), .groups = "drop")      
  
glimpse(idps_indicadores_rbd)

# 11 dimensiones
idps_dim_rbd <- idps_dim %>%
  pivot_wider(names_from = dim, values_from = prom, names_prefix = "dim_") %>%
  clean_names() %>%
  select(rbd, starts_with("dim_")) %>%
  group_by(rbd) %>%
  summarise(across(starts_with("dim_"), ~ mean(.x, na.rm = TRUE)), .groups = "drop")

glimpse(idps_dim_rbd)

## 22 subdimensiones
idps_sub_rbd <- idps_sub %>%
  pivot_wider(names_from = sdim, values_from = c('niv_bajo_por', 'niv_medio_por', 'niv_alto_por')) %>%
  clean_names() %>%
  select(rbd, starts_with("niv_"), -ends_with("_por")) %>%
  group_by(rbd) %>%
  summarise(across(starts_with("niv_"), ~ mean(.x, na.rm = TRUE)), .groups = "drop")

## preparar datos docentes -----
# docentes enseñanza media
docentes_2domedio_rbd <- docentes %>%
  # filtrar por docentes de 2do medio
  filter(cod_ense %in% c(310, 363, 410,463, 510,563,610,663,710,763,810,863,910, 963)) %>%
  filter(cod_grado == 2) %>%
  # para cursos de formación general
  filter(tipo_subsector == 2) %>%
  # para cursos de tipo obligatorio
  filter(obl_subsector == 1) %>%
  # construir edad docente
  mutate(doc_anio_nacimiento = as.numeric(substr(doc_fec_nac, 1, 4)),
         doc_edad = ifelse(doc_fec_nac == 190001, NA, 2024 - doc_anio_nacimiento)) %>%
  group_by(rbd) %>%
  summarise(
    n_docentes_rbd = n(),
    promedio_doc_edad = mean(doc_edad, na.rm = TRUE),
    mediana_doc_edad = median(doc_edad, na.rm = TRUE),
    n_doc_mujeres = sum(doc_genero == 2, na.rm = TRUE),
    p_doc_mujeres = n_doc_mujeres / n_docentes_rbd
  )

glimpse(docentes_2domedio_rbd)

# revisar distribución n_docentes_rbd
# docentes_2domedio_rbd %>%
#   ggplot(aes(x = n_docentes_rbd)) +
#  geom_histogram(bins = 30) +
#  scale_x_continuous(breaks = seq(from = 0, to = 170, by = 10))

# docentes_2domedio_rbd %>%
# filter(n_docentes_rbd > 100) %>%
#  select(rbd)
# docentes %>%
#  filter(rbd == 280) %>%
#  select(nom_rbd)  

# glimpse(docentes)

# juntar datos por rbd ------

rbd <- simce %>%
  left_join(matricula_rbd, by = 'rbd') %>%
  left_join(idps_indicadores_rbd, by = 'rbd') %>%
  left_join(idps_dim_rbd, by = 'rbd') %>%
  left_join(idps_sub_rbd, by = 'rbd') %>%
  left_join(docentes_2domedio_rbd, by = 'rbd')

glimpse(rbd)

# exportar resultados para análisis -------

arrow::write_parquet(rbd, file.path(path, 'rbd_consolidado.parquet'))
