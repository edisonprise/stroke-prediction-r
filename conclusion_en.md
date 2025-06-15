---
title: "conclusion_en.md"
author: "Edinson Cespedes"
date: "2025-06-15"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
## 🧾 Conclusions and Key Findings

### 🧠 What did I learn throughout the process?

During this project, I learned how to apply a complete data science workflow using R to address a real-world public health problem: stroke prediction. This included data cleaning, exploratory analysis, model training, performance evaluation, and deployment via an interactive R Shiny app.

### 📊 Were the results what I expected?

Some variables such as age, glucose level, and hypertension had the expected impact. However, I was surprised to find that the Random Forest model outperformed logistic regression in terms of AUC and F1-score.

### 🔑 Key findings

- The final model (Random Forest) achieved solid performance:
  - **Accuracy:** 71.5%
  - **Sensitivity:** 71.2%
  - **Specificity:** 77.2%
  - **F1-score:** 82.5%
  - **ROC AUC:** 82.1%
- The Shiny app allows user input and provides real-time predictions for stroke risk.
- The solution is functional and can serve as a clinical decision support tool.
- Potential future improvements include:
  - More detailed clinical datasets
  - Model interpretability with LIME or SHAP
  - API deployment using Vetiver

---
