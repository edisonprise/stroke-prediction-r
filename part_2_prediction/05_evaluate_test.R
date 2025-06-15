# 05_evaluate_test.R
library(tidymodels)
library(ggplot2)

# 1. Carga del split y de la receta
data_split   <- readRDS("data_split.rds")
stroke_recipe <- readRDS("stroke_recipe.rds")

# 2. Definición del modelo ganador
#    — Supongamos que eliges Random Forest con los mejores parámetros de rf_tune
rf_tune      <- readRDS("rf_tune.rds")
best_rf_pars <- select_best(rf_tune, "roc_auc")

rf_spec <- rand_forest(
  mtry = best_rf_pars$mtry,
  min_n = best_rf_pars$min_n,
  trees = 1000
) %>%
  set_engine("ranger") %>%
  set_mode("classification")

# 3. Workflow final
final_wf <- workflow() %>%
  add_recipe(stroke_recipe) %>%
  add_model(rf_spec)

# 4. Ajuste final y evaluación en test con last_fit()
final_res <- last_fit(final_wf, split = data_split, metrics = metric_set(accuracy, sens, spec, f_meas, roc_auc))

# 5. Métricas finales
collect_metrics(final_res)

# 6. Curva ROC en test
test_preds <- collect_predictions(final_res)
roc_data   <- roc_curve(test_preds, truth = stroke, .pred_1)

ggplot(roc_data, aes(x = 1 - specificity, y = sensitivity)) +
  geom_path() +
  geom_abline(lty = 2) +
  labs(title = "ROC Curve – Random Forest (Test)",
       x = "1 - Specificity", y = "Sensitivity") +
  theme_minimal()
