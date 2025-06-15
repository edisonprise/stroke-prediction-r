# 06_interpret_results.R

library(tidymodels)
library(ggplot2)
library(tidyr)

# 1) Métricas finales
final_results <- collect_metrics(final_res)
print(final_results)

# 2) Curva ROC
test_preds <- collect_predictions(final_res)
roc_data <- roc_curve(test_preds, truth = stroke, .pred_1)

ggplot(roc_data, aes(x = 1 - specificity, y = sensitivity)) +
  geom_path(linewidth = 1.2, color = "blue") +
  geom_abline(lty = 2, color = "gray") +
  labs(title = "ROC Curve (Test set)",
       x = "1 - Specificity", y = "Sensitivity") +
  theme_minimal()

# 3) Matriz de confusión (threshold = 0.5)
conf_mat_tbl <- conf_mat(test_preds, truth = stroke, estimate = .pred_class)
autoplot(conf_mat_tbl, type = "heatmap") +
  scale_fill_viridis_c() +
  labs(title = "Confusion Matrix (threshold = 0.5)")

# 4) Performance vs. Threshold
# a) Sensibilidad / especificidad ya en roc_data
# b) Accuracy calculada manualmente
acc_data <- roc_data %>%
  rowwise() %>%
  mutate(
    accuracy = mean(
      if_else(test_preds$.pred_1 >= .threshold, "1", "0") == 
        test_preds$stroke, na.rm = TRUE
    )
  ) %>%
  select(.threshold, accuracy)

perf <- roc_data %>%
  select(.threshold, sensitivity, specificity) %>%
  left_join(acc_data, by = ".threshold")

perf_long <- perf %>%
  pivot_longer(-.threshold, names_to = "metric", values_to = "value")

ggplot(perf_long, aes(x = .threshold, y = value, color = metric)) +
  geom_line(linewidth = 1) +
  labs(title = "Performance vs. Threshold",
       x = "Probability Threshold",
       y = "Metric Value") +
  theme_minimal()
