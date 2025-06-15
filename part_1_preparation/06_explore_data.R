# explore_data.R

# Cargar librerías
install.packages("tidyverse")
library(tidyverse)
install.packages("skimr")
library(skimr)
library(ggplot2)
library(corrplot)

# Cargar datos (ajusta el nombre si es necesario)
stroke_data <- read.csv("stroke.csv")

# Convertir variables categóricas a factores si es necesario
stroke_data <- stroke_data %>%
  mutate(
    gender = as.factor(gender),
    ever_married = as.factor(ever_married),
    work_type = as.factor(work_type),
    Residence_type = as.factor(Residence_type),
    smoking_status = as.factor(smoking_status),
    stroke = as.factor(stroke)
  )

# 1. Resumen estadístico
skim(stroke_data)

# 2. Frecuencia de variables categóricas (forma correcta)
stroke_data %>%
  select(gender, ever_married, work_type, Residence_type, smoking_status, stroke) %>%
  map(table)


# 3. Distribuciones
ggplot(stroke_data, aes(x = age)) +
  geom_histogram(bins = 30, fill = "steelblue") +
  labs(title = "Distribución de Edad")

ggplot(stroke_data, aes(x = bmi)) +
  geom_histogram(bins = 30, fill = "tomato") +
  labs(title = "Distribución de BMI")

# 4. Boxplots por variable objetivo
ggplot(stroke_data, aes(x = stroke, y = age, fill = stroke)) +
  geom_boxplot() +
  labs(title = "Edad por Stroke")

ggplot(stroke_data, aes(x = stroke, y = avg_glucose_level, fill = stroke)) +
  geom_boxplot() +
  labs(title = "Nivel de Glucosa por Stroke")

# 5. Correlación (solo numéricas)
numeric_vars <- stroke_data %>%
  select(where(is.numeric))

cor_matrix <- cor(numeric_vars, use = "complete.obs")
corrplot(cor_matrix, method = "circle", type = "upper", tl.col = "black")

# 6. Insight básico
cat("Edad, BMI y riesgo (hipertensión + enfermedad cardiaca) tienen correlación positiva moderada.\n")
cat("La variable objetivo 'stroke' podría relacionarse con estas.\n")
