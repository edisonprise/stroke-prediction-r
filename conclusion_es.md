---
title: "conclusion_es.md"
author: "Edinson Cespedes"
date: "2025-06-15"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

```
## 🧾 Conclusiones y Hallazgos Clave

### 🧠 ¿Qué aprendí durante el proceso?

Durante este proyecto, aprendí a aplicar un flujo de trabajo completo de ciencia de datos utilizando R para abordar un problema real de salud pública: la predicción de accidentes cerebrovasculares (stroke). Esto incluyó la limpieza de datos, análisis exploratorio, entrenamiento de modelos, evaluación de desempeño y despliegue de un modelo predictivo mediante R Shiny.

### 📊 ¿Los resultados fueron los esperados?

Algunas variables clave como la edad, el nivel de glucosa y la hipertensión tuvieron el impacto esperado. Sin embargo, fue interesante descubrir que el modelo de Random Forest superó al modelo de regresión logística en métricas como AUC y F1-score.

### 🔑 Hallazgos clave

- El modelo final (Random Forest) alcanzó un rendimiento sólido:
  - **Precisión (Accuracy):** 71.5%
  - **Sensibilidad:** 71.2%
  - **Especificidad:** 77.2%
  - **F1-score:** 82.5%
  - **AUC ROC:** 82.1%
- La aplicación Shiny permite ingresar datos de un paciente y obtener predicciones inmediatas sobre su riesgo de stroke.
- La solución es funcional y puede ser usada como herramienta de apoyo en contextos clínicos.
- Futuras mejoras pueden incluir:
  - Nuevos datos clínicos más detallados
  - Interpretabilidad con herramientas como LIME o SHAP
  - Despliegue mediante API con Vetiver

---

