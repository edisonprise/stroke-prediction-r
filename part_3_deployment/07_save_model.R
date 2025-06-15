# Cargar librerías necesarias
library(tidymodels)

# Asegúrate de haber ejecutado tu entrenamiento final con last_fit()
# Aquí asumimos que `final_fit` contiene tu modelo entrenado con `last_fit()`
# y que `stroke_recipe` es tu receta final ya preparada

# 1. Extraer el workflow del resultado de last_fit
final_model <- extract_workflow(final_fit)

# 2. Guardar el modelo final entrenado
saveRDS(final_model, "final_model.rds")

# 3. Guardar la receta utilizada para preprocesamiento
saveRDS(stroke_recipe, "stroke_recipe.rds")

cat("✅ Modelo y receta guardados con éxito.\n")
