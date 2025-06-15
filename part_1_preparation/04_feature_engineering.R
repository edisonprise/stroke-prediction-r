# Usando cuartiles para clasificar grupos de edad
stroke_data$age_group <- cut(
  stroke_data$age,
  breaks = quantile(stroke_data$age, probs = c(0, 0.25, 0.5, 0.75, 1)),
  labels = c("young", "adult", "middle_aged", "elderly"),
  include.lowest = TRUE
)


stroke_data$bmi_category <- cut(
  stroke_data$bmi,
  breaks = quantile(stroke_data$bmi, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE),
  labels = c("low", "medium", "high", "very_high"),
  include.lowest = TRUE
)

stroke_data$risk_score <- stroke_data$hypertension + stroke_data$heart_disease

# Imputación de valores faltantes en BMI con la mediana
stroke_data$bmi[is.na(stroke_data$bmi)] <- median(stroke_data$bmi, na.rm = TRUE)

