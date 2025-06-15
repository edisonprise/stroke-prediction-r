# 01_load_and_split.R

# Cargar librerías necesarias
library(tidymodels)
library(themis)

# Cargar datos
stroke_data <- read.csv("stroke_clean_imputed.csv")

# Asegurar que la variable objetivo es factor
stroke_data$stroke <- as.factor(stroke_data$stroke)

# Asegurar que la variable gender tiene todos los niveles posibles
stroke_data$gender <- factor(stroke_data$gender, levels = c("Male", "Female", "Other"))

# Dividir datos (estratificado por stroke)
set.seed(123)
data_split <- initial_split(stroke_data, prop = 0.8, strata = stroke)
stroke_train <- training(data_split)
stroke_test <- testing(data_split)

# Crear receta con imputación, dummies, normalización y balanceo
stroke_recipe <- recipe(stroke ~ ., data = stroke_train) %>%
  step_impute_mode(all_nominal_predictors()) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors(), one_hot = TRUE) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_downsample(stroke)

# Preparar (opcional)
prep(stroke_recipe)

# Guardar objetos
saveRDS(data_split, "data_split.rds")
saveRDS(stroke_recipe, "stroke_recipe.rds")

