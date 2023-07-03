#"cancer_tumor.csv" datasını daxil et. "h2o" ilə "autoencoder" modellini qur.

#Modelləşmə üçün doğru dəyişənləri seç.

#Anomaliyaları aşkarladıqdan sonra onları vizuallaşdır. 

library(h2o)
library(ggplot2)

h2o.init()

data = h2o.importFile("C:/Users/maham/Desktop/R/Modul6/Cancer-tumor.csv")
data$id = NULL

splits = h2o.splitFrame(data, ratios = c(0.8), seed = 123)
train_set = splits[[1]]
test_set = splits[[2]]

autoencoder_model <- h2o.deeplearning(
  x = colnames(train_set),       
  training_frame = train_set,     
  validation_frame = test_set,   
  activation = "Tanh",             
  autoencoder = TRUE,            
  hidden = c(10, 5, 10),           
  epochs = 100,                    
  variable_importances = TRUE)   

reconstruction_error = h2o.anomaly(autoencoder_model, test_set)

threshold = 0.05

reconstruction_error_df = data.frame(
  Row = 1:nrow(reconstruction_error),
  Reconstruction.MSE = as.vector(reconstruction_error$Reconstruction.MSE)
)

anomalies = subset(reconstruction_error_df, Reconstruction.MSE > threshold)

ggplot(reconstruction_error_df, aes(x = Row, y = Reconstruction.MSE)) +
  geom_line() +
  geom_point(data = anomalies, color = "red") +
  ylab("Reconstruction MSE") +
  ggtitle("Anomaly Detection")
