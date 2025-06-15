# 02_impute_missing.R

# Cargar librerías necesarias
library(tidyverse)

# Cargar datos
stroke_data <- read.csv("../1st Part preparation/stroke.csv")

# Limpiar y convertir 'bmi'
stroke_data <- stroke_data %>%
  mutate(
    bmi = ifelse(bmi == "N/A" | bmi == "", NA, bmi),
    bmi = as.numeric(bmi),
    bmi = if_else(is.na(bmi), mean(bmi, na.rm = TRUE), bmi)
  )

# Imputar 'smoking_status': tratar 'Unknown' como NA y reemplazar con "never smoked"
stroke_data <- stroke_data %>%
  mutate(
    smoking_status = na_if(smoking_status, "Unknown"),
    smoking_status = replace_na(smoking_status, "never smoked"),
    smoking_status = as.factor(smoking_status)
  )

# Guardar dataset limpio e imputado
write.csv(stroke_data, "stroke_clean_imputed.csv", row.names = FALSE)

