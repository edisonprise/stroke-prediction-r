# 🧠 Stroke Prediction with R - Machine Learning Project

## 📌 Overview

This project builds and deploys a machine learning model to predict the likelihood of a stroke based on clinical and demographic patient data. It was developed using R, `tidymodels`, and deployed with `Shiny`.

## 📂 Project Structure

├── 1st Part preparation/
│ ├── 01_load_clean.R
│ ├── 02_recipe.R
│ └── data_split.rds
├── 2nd Part prediction/
│ ├── 03_model_stroke.R
│ ├── 04_tune_models.R
│ ├── 05_evaluate_test.R
│ └── 06_interpret_results.R
├── 3rd Part deployment/
│ ├── 07_save_model.R
│ └── 08_app_stroke.R
├── models/
│ ├── final_fit.rds
│ └── stroke_recipe.rds
├── README.md
└── stroke_data.csv


## 🚀 How to Run

1. Clone the repository
2. Run all scripts in order: `01_load_clean.R` → `08_app_stroke.R`
3. Launch the Shiny app with:
```r
source("3rd Part deployment/08_app_stroke.R")

