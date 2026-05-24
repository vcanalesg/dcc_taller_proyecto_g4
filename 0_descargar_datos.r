# Descargar y extraer datos

# paquetes ------
library(tidyverse)
library(janitor)
library(archive)
library(httr)

# descargar datos ----

tabla_url <- tribble(
    ~nombre, ~descripcion, ~url, ~tipo,
    "Matricula-por-estudiante-2024", "Matrícula por estudiante 2024", "https://datosabiertos.mineduc.cl/wp-content/uploads/2024/11/Matricula-por-estudiante-2024.rar", "rar",
    "Directorio-Oficial-Sostenedores-2024", "Directorio de sostenedores 2024", "https://datosabiertos.mineduc.cl/wp-content/uploads/2024/11/Directorio-Oficial-Sostenedores-2024.rar", "rar",
    "SNED-2024-2025", "Sistema Nacional de Evaluación 2024-2025", "https://datosabiertos.mineduc.cl/wp-content/uploads/2024/05/SNED-2024-2025.rar", "rar",
    "Evaluacion-Docente-2024", "Evaluación de docentes 2024", "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/03/Evaluacion-Docente-2024.rar", "rar",
    "Directorio-Docentes-2024", "Directorio de docentes 2024", "https://datosabiertos.mineduc.cl/wp-content/uploads/2024/08/Directorio-Docentes-2024.rar", "rar",
    "Resumen-Docentes-EE-2024", "Resumen de docentes 2024", "https://datosabiertos.mineduc.cl/wp-content/uploads/2024/08/Resumen-Docentes-EE-2024.zip", "zip",
    "Docentes-por-curso-y-subsector-2025", "Docentes por curso y subsector 2025", "https://datosabiertos.mineduc.cl/wp-content/uploads/2026/04/Docentes-por-curso-y-subsector-2025.rar", "rar")


# función para descargar y extraer archivos
descargar_y_extraer <- function(nombre, url, tipo = c("rar", "zip"),
                                path = "/Users/vcanalesg/Documents/diplomado_dcc/0_taller_proyecto/datos/", ...) {
    destfile <- file.path(path, paste0(nombre, ".", tipo))

    # 1) verificar que la URL responde
    status <- tryCatch(httr::HEAD(url)$status_code, error = function(e) NA)
    if (!isTRUE(status == 200)) {
        print(paste0("[ERROR] URL no accesible (", nombre, "): status = ", status))
        return(invisible(NULL))
    }
    print(paste0("[OK] URL accesible (", nombre, ")"))

    # 2) revisar si el archivo ya existe
    if (file.exists(destfile)) {
        print(paste0("[SKIP] Archivo ya existe, se omite descarga: ", destfile))
        return(invisible(NULL))
    }

    # 3) descargar
    download.file(url, destfile, mode = "wb")
    if (file.exists(destfile)) {
        print(paste0("[OK] Descarga exitosa: ", destfile))
    } else {
        print(paste0("[ERROR] Falló la descarga: ", destfile))
        return(invisible(NULL))
    }

    # 4) extraer (solo si se descargó en esta iteración)
    archive_extract(destfile, dir = path)
    print(paste0("[OK] Extracción exitosa: ", nombre))
}

# aplicar funcion a tabla de urls
tabla_url %>%
    pmap(descargar_y_extraer)


