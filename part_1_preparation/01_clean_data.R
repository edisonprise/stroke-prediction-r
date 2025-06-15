# clean_data.R

# Reemplazar "N/A" en bmi por NA y convertir a numérico
stroke_data$bmi <- as.numeric(ifelse(stroke_data$bmi == "N/A", NA, stroke_data$bmi))

# Eliminar filas con NA
stroke_data <- na.omit(stroke_data)

# Convertir variables categóricas a factores
stroke_data$gender <- as.factor(stroke_data$gender)
stroke_data$ever_married <- as.factor(stroke_data$ever_married)
stroke_data$work_type <- as.factor(stroke_data$work_type)
stroke_data$Residence_type <- as.factor(stroke_data$Residence_type)
stroke_data$smoking_status <- as.factor(stroke_data$smoking_status)

# Convertir variable objetivo 'stroke' a factor
stroke_data$stroke <- as.factor(stroke_data$stroke)

# Verificar la estructura final
str(stroke_data)
summary(stroke_data)
