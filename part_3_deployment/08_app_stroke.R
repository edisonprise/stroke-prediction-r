# 08_app_stroke.R

library(shiny)
library(tidymodels)
library(themis)
library(readr)

# Cargar modelo entrenado y receta
final_fit <- readRDS("models/final_fit.rds")
stroke_recipe <- readRDS("stroke_recipe.rds")

# Extraer el workflow del modelo final
final_wf <- extract_workflow(final_fit)

ui <- fluidPage(
  titlePanel("Predicción de Stroke (ACV)"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("age", "Edad", value = 60, min = 0, max = 100),
      selectInput("hypertension", "¿Tiene hipertensión?", choices = c("No" = 0, "Sí" = 1)),
      selectInput("heart_disease", "¿Tiene enfermedad cardíaca?", choices = c("No" = 0, "Sí" = 1)),
      selectInput("ever_married", "¿Está casado/a?", choices = c("No", "Yes")),
      selectInput("work_type", "Tipo de trabajo", 
                  choices = c("Private", "Self-employed", "Govt_job", "children", "Never_worked")),
      selectInput("Residence_type", "Zona de residencia", choices = c("Urban", "Rural")),
      numericInput("avg_glucose_level", "Nivel promedio de glucosa", value = 100),
      numericInput("bmi", "Índice de masa corporal (BMI)", value = 25),
      selectInput("smoking_status", "Estado de fumador", 
                  choices = c("formerly smoked", "never smoked", "smokes", "Unknown")),
      actionButton("predict", "Predecir")
    ),
    
    mainPanel(
      h3("Resultado:"),
      verbatimTextOutput("prediction_output")
    )
  )
)

server <- function(input, output) {
  
  new_data <- eventReactive(input$predict, {
    tibble(
      id = 1,  # Agregamos 'id' para evitar el error
      gender = "Female",  # Valor por defecto si no está en el input
      age = input$age,
      hypertension = as.integer(input$hypertension),
      heart_disease = as.integer(input$heart_disease),
      ever_married = input$ever_married,
      work_type = input$work_type,
      Residence_type = input$Residence_type,
      avg_glucose_level = input$avg_glucose_level,
      bmi = input$bmi,
      smoking_status = input$smoking_status
    )
  })
  
  output$prediction_output <- renderPrint({
    req(new_data())
    
    pred <- predict(final_wf, new_data(), type = "prob") %>%
      bind_cols(predict(final_wf, new_data(), type = "class"))
    
    prob <- round(pred$.pred_1 * 100, 2)
    result <- pred$.pred_class
    
    cat("Probabilidad de ACV (stroke):", prob, "%\n")
    cat("Clasificación:", ifelse(result == 1, "ALTO RIESGO", "BAJO RIESGO"))
  })
}

shinyApp(ui = ui, server = server)


