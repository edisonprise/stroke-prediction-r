# 03_transform_data.R

# Cargar librerías necesarias
library(tidyverse)

# Cargar datos limpios e imputados
stroke_data <- read.csv("stroke_clean_imputed.csv")

# Asegurarse de que la variable objetivo sea factor
stroke_data$stroke <- as.factor(stroke_data$stroke)

# 1. Eliminar columna ID si existe
if ("id" %in% colnames(stroke_data)) {
  stroke_data$id <- NULL
}

# 2. Escalar solo columnas numéricas (evita errores con columnas categóricas)
num_cols <- c("age", "avg_glucose_level", "bmi")

stroke_data[num_cols] <- lapply(stroke_data[num_cols], function(x) scale(as.numeric(x)))

# 3. Convertir variables categóricas a dummies (excluyendo 'stroke')
if (!require(caret)) install.packages("caret", dependencies = TRUE)
library(caret)

dummies <- dummyVars(stroke ~ ., data = stroke_data)
stroke_transformed <- predict(dummies, newdata = stroke_data)

# 4. Combinar con variable objetivo
stroke_transformed <- data.frame(stroke_transformed, stroke = stroke_data$stroke)

# Verificar estructura
str(stroke_transformed)

# Guardar si deseas
write.csv(stroke_transformed, "stroke_transformed.csv", row.names = FALSE)

