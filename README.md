# 🧠 Stroke Prediction App / Aplicación de Predicción de ACV

## 🔍 Overview / Descripción general

This project aims to build and deploy a predictive model that estimates the likelihood of a stroke (cerebrovascular accident) based on various health and demographic indicators.

Este proyecto tiene como objetivo construir y desplegar un modelo predictivo que estime la probabilidad de sufrir un accidente cerebrovascular (ACV) en función de diversos indicadores de salud y datos demográficos.

---

## 📦 Dataset

The dataset used was taken from Kaggle:  
https://www.kaggle.com/datasets/fedesoriano/stroke-prediction-dataset

El conjunto de datos fue tomado de Kaggle.

---

## ⚙️ Tools Used / Herramientas utilizadas

- R and RStudio Cloud  
- tidyverse & tidymodels  
- themis (for class balancing)  
- R Shiny (for deployment)

---

## 🧪 Process Summary / Resumen del proceso

1. **Data Cleaning and Preparation / Limpieza y preparación de datos**
2. **Exploratory Data Analysis / Análisis exploratorio**
3. **Modeling (Logistic Regression & Random Forest) / Modelado**
4. **Model Evaluation / Evaluación**
5. **Deployment via Shiny / Despliegue con Shiny**

---

## 🌐 Live App

👉 [Click here to use the Stroke Prediction App](https://usuario.shinyapps.io/stroke-prediction/)  
⬅️ Replace this URL with the actual one after deployment.

---

## 🧠 Key Findings / Hallazgos clave

- Random Forest was the best performing model based on ROC AUC.
- The most important features were: age, average glucose level, BMI, and hypertension.
- Downsampling was essential due to class imbalance.

---

## 📝 Conclusion / Conclusión

This project demonstrated a full end-to-end machine learning pipeline using R. The final product is a deployable Shiny app that can assist in identifying patients at high risk of stroke, potentially guiding early intervention efforts.

Este proyecto demostró un flujo completo de aprendizaje automático en R. El producto final es una aplicación Shiny que puede ayudar a identificar pacientes con alto riesgo de ACV, facilitando intervenciones tempranas.

---

## 📁 Project Structure / Estructura del proyecto

```text
├── 01_load_clean.R         # Data loading and cleaning
├── 02_recipe.R             # Preprocessing recipe
├── 03_model_stroke.R       # Model training and tuning
├── 04_interpret_results.R  # Evaluation
├── 08_app_stroke.R         # Shiny app script
├── part_3_deployment/      # Folder used to deploy Shiny app
├── models/                 # Saved model objects
├── README.md               # This file


