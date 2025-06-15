# 02_recipe.R

# Cargar librerías
library(tidymodels)
library(themis)  # para downsampling

# Cargar el split
data_split <- readRDS("data_split.rds")
stroke_train <- training(data_split)

# Asegurar que las variables categóricas tengan los mismos niveles
stroke_train$gender <- factor(stroke_train$gender, levels = c("Male", "Female", "Other"))

# Crear receta de preprocesamiento
stroke_recipe <- recipe(stroke ~ ., data = stroke_train) %>%
  step_rm(id) %>%  # ← ahora sí se ejecuta correctamente
  step_impute_mode(all_nominal_predictors()) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_rm(contains("gender_Other")) %>%  # eliminar dummy con pocos casos
  step_zv(all_predictors()) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_downsample(stroke)

# Guardar la receta
saveRDS(stroke_recipe, "stroke_recipe.rds")

# (opcional) Ver receta preparada
# prep(stroke_recipe) %>% 
#   juice() %>% 
#   glimpse()

message("✅ Receta creada y guardada como stroke_recipe.rds")

