#"data <- timetk::walmart_sales_weekly %>% filter(id == '1_3') %>% select(Date, Weekly_Sales)" kodunu run et. "h2o" ilə model qur.

#"modeltime" paketinin alqoritmaları("auto_arima","prophet","glmnet","randomForest","prophet_xgboost") ilə model qur.

#Sonda bütün qurulan modellərin RMSE metriklərini göstər. 




library(timetk)
library(h2o)
library(tidyverse)
library(modeltime)
library(lubridate)
library(highcharter)
library(tidymodels)
library(forecast)



data = timetk::walmart_sales_weekly %>%
  filter(id == '1_3') %>%
  select(Date, Weekly_Sales)

h2o.init()
data_h2o = as.h2o(data)

splits = h2o.splitFrame(data_h2o, ratios = c(0.8), seed = 1234)
train_h2o = splits[[1]]
test_h2o = splits[[2]]

#h2o
model_h2o = h2o.glm(
  x = "Date",
  y = "Weekly_Sales",
  training_frame = train_h2o
)
predictions_h2o = h2o.predict(model_h2o, newdata = test_h2o)

rmse_h2o = sqrt(mean((as.numeric(predictions_h2o) - as.numeric(test_h2o$Weekly_Sales))^2))

print(rmse_h2o)



train_size = floor(0.8 * nrow(data))
train_data = data[1:train_size, ]
test_data = data[(train_size + 1):nrow(data), ]

#arima
model_fit_arima = arima_reg() %>% set_engine('auto_arima') %>% fit(Weekly_Sales ~ Date, train_data)

#prophet
model_fit_prophet = prophet_reg(seasonality_yearly = TRUE) %>% set_engine('prophet') %>%  fit(Weekly_Sales ~ Date, train_data)

recipe_spec = recipe(Weekly_Sales ~ Date, train_data) %>% 
  step_timeseries_signature(Date) %>% 
  step_fourier(Date, period = 180, K = 2) %>% 
  step_dummy(all_nominal())

recipe_spec %>% prep() %>% juice() %>% View()

#glm
model_spec_glmnet = linear_reg(penalty = 0.01, mixture = 0.5) %>% set_engine('glmnet')
workflow_fit_glmnet = workflow() %>% 
  add_model(model_spec_glmnet) %>% 
  add_recipe(recipe_spec %>%  step_rm(Date)) %>% 
  fit(train_data)

#randomForest
model_spec_rf = rand_forest(trees = 500, min_n = 50) %>% set_engine('randomForest') %>% set_mode('regression')
workflow_fit_rf = workflow() %>% 
  add_model(model_spec_rf) %>% 
  add_recipe(recipe_spec %>%  step_rm(Date)) %>% 
  fit(train_data)


#xgboost
model_spec_xg = prophet_boost(seasonality_yearly = T) %>% set_engine('prophet_xgboost')
workflow_fit_xg = workflow() %>% 
  add_model(model_spec_xg) %>% 
  add_recipe(recipe_spec) %>% 
  fit(train_data)


models = modeltime_table(
  model_fit_arima,
  model_fit_prophet,
  workflow_fit_glmnet,
  workflow_fit_rf,
  workflow_fit_xg) %>% 
  modeltime_calibrate(test_data)

models %>%  modeltime_forecast(actual_data = data) %>% 
  plot_modeltime_forecast(.interactive = T,
                          .plotly_slider = T)


models %>% modeltime_accuracy() %>% table_modeltime_accuracy(.interactive = T)
