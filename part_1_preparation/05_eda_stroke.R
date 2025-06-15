# Exploratory Data Analysis (EDA) para Stroke Prediction Dataset

# Cargar paquetes necesarios
library(ggplot2)
install.packages("corrplot")
library(corrplot)

# Ver estructura del dataset
str(stroke_data)

# Ver primeras filas
head(stroke_data)

# Estadísticas resumen
summary(stroke_data)

# -----------------------------
# 1. Distribuciones univariadas
# -----------------------------

# Distribución de edad
ggplot(stroke_data, aes(x = age)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  labs(title = "Distribución de Edad", x = "Edad", y = "Frecuencia")

# Distribución del nivel de glucosa promedio
ggplot(stroke_data, aes(x = avg_glucose_level)) +
  geom_histogram(bins = 30, fill = "lightgreen", color = "black") +
  labs(title = "Distribución de Nivel de Glucosa", x = "Nivel de Glucosa", y = "Frecuencia")

# Distribución del índice de masa corporal (BMI)
ggplot(stroke_data, aes(x = bmi)) +
  geom_histogram(bins = 30, fill = "lightcoral", color = "black") +
  labs(title = "Distribución del IMC", x = "BMI", y = "Frecuencia")

# -----------------------------
# 2. Comparaciones con Stroke
# -----------------------------

# Edad vs Stroke
ggplot(stroke_data, aes(x = age, fill = as.factor(stroke))) +
  geom_histogram(position = "identity", alpha = 0.6, bins = 30) +
  labs(title = "Edad vs Stroke", fill = "Stroke")

# Nivel de glucosa vs Stroke
ggplot(stroke_data, aes(x = avg_glucose_level, fill = as.factor(stroke))) +
  geom_histogram(position = "identity", alpha = 0.6, bins = 30) +
  labs(title = "Nivel de Glucosa vs Stroke", fill = "Stroke")

# Stroke por género (Femenino vs No-Femenino)
ggplot(stroke_data, aes(x = as.factor(gender.Female), fill = as.factor(stroke))) +
  geom_bar(position = "dodge") +
  labs(title = "Stroke por Género (Femenino)", x = "Femenino (0 = No, 1 = Sí)", fill = "Stroke")

# -----------------------------
# 3. Correlaciones numéricas
# -----------------------------

# Seleccionar variables numéricas relevantes
numeric_vars <- stroke_data[, c("age", "avg_glucose_level", "bmi", "risk_score")]

# Calcular matriz de correlación
cor_matrix <- cor(numeric_vars, use = "complete.obs")

# Imprimir matriz de correlación
print(cor_matrix)

# Visualizar correlación
corrplot(cor_matrix, method = "color", type = "upper")

# -----------------------------
# 4. Insight (ejemplo para tu presentación)
# -----------------------------
# Puedes escribir algo como:
# - "La edad y el nivel de glucosa tienden a ser mayores en pacientes que han sufrido un stroke."
# - "Existe una ligera correlación positiva entre el riesgo combinado (hipertensión + enfermedad cardíaca) y la edad."
# - "La mayoría de los casos de stroke están concentrados en adultos mayores y personas con niveles altos de glucosa."

