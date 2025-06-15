# Cargar librerías
library(tidymodels)
library(themis)
set.seed(123)

# Crear carpetas necesarias
if (!dir.exists("models")) dir.create("models")
if (!dir.exists("Build-deploy-stroke-prediction-model.R/2nd Part prediction")) {
  dir.create("Build-deploy-stroke-prediction-model.R/2nd Part prediction", recursive = TRUE)
}

# Cargar datos
data_split <- readRDS("data_split.rds")
stroke_recipe <- readRDS("stroke_recipe.rds")
train_data <- training(data_split)
train_data$stroke <- as.factor(train_data$stroke)

# 1. Especificaciones de modelos
log_reg_spec <- logistic_reg(penalty = tune(), mixture = 1) %>%
  set_engine("glmnet") %>%
  set_mode("classification")

rf_spec <- rand_forest(mtry = tune(), min_n = tune(), trees = 1000) %>%
  set_engine("ranger") %>%
  set_mode("classification")

# 2. Validación cruzada
folds <- vfold_cv(train_data, v = 5, strata = stroke)

# 3. Workflows
log_reg_wf <- workflow() %>% add_model(log_reg_spec) %>% add_recipe(stroke_recipe)
rf_wf <- workflow() %>% add_model(rf_spec) %>% add_recipe(stroke_recipe)

# 4. Tuning
log_reg_grid <- grid_regular(penalty(range = c(-4, 0)), levels = 5)
rf_grid <- grid_regular(mtry(range = c(2, 10)), min_n(range = c(5, 20)), levels = 4)

log_reg_tune <- tune_grid(
  log_reg_wf, resamples = folds, grid = log_reg_grid,
  metrics = metric_set(roc_auc, accuracy),
  control = control_grid(save_pred = TRUE)
)

rf_tune <- tune_grid(
  rf_wf, resamples = folds, grid = rf_grid,
  metrics = metric_set(roc_auc, accuracy),
  control = control_grid(save_pred = TRUE)
)

# Guardar tuning
saveRDS(log_reg_tune, "Build-deploy-stroke-prediction-model.R/2nd Part prediction/log_reg_tune.rds")
saveRDS(rf_tune, "Build-deploy-stroke-prediction-model.R/2nd Part prediction/rf_tune.rds")

# 5. Mejor modelo y ajuste final
best_rf <- select_best(rf_tune, "roc_auc")
if (is.null(best_rf)) stop("❌ No se encontró el mejor modelo para RF.")

final_wf <- finalize_workflow(rf_wf, best_rf)
final_fit <- last_fit(final_wf, split = data_split, metrics = metric_set(roc_auc, accuracy))

# Guardar final_fit
saveRDS(final_fit, "Build-deploy-stroke-prediction-model.R/2nd Part prediction/final_fit.rds")
saveRDS(final_fit, "models/final_fit.rds")

cat("✅ Script completado: final_fit guardado\n")


