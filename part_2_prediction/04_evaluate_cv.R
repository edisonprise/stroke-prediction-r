# 04_evaluate_cv.R
library(tidymodels)

# Cargar resultados de tuning
log_reg_tune <- readRDS("log_reg_tune.rds")
rf_tune      <- readRDS("rf_tune.rds")

# Extraer métricas clave de CV
log_metrics <- collect_metrics(log_reg_tune) %>%
  filter(.metric %in% c("accuracy", "roc_auc")) %>%
  mutate(model = "Logistic Lasso")

rf_metrics <- collect_metrics(rf_tune) %>%
  filter(.metric %in% c("accuracy", "roc_auc")) %>%
  mutate(model = "Random Forest")

# Combinar y mostrar
all_cv <- bind_rows(log_metrics, rf_metrics) %>%
  select(model, .metric, mean, std_err)

print(all_cv)

