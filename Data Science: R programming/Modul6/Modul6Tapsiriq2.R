#"timetk" paketindən "walmart_sales_weekly" datasını daxil et.

#"modeltime.h2o" paketi ilə bütün "ID"lər üçün model qur.

#Qeyd: "max_models" parametrindən istifadə etmə.

#Modeli qurduqdan sonsa "refit" elə və növbəti 2 ili proqnozlaşdır.

#Yekun modeli save et və R'a yenidən yüklə. 

library(tidyverse)
library(inspectdf)
library(timetk)
library(lubridate)
library(tidymodels)
library(modeltime.h2o)
library(rstudioapi)
library(modeltime.ensemble)

data = timetk::walmart_sales_weekly

train_size <- floor(0.8 * nrow(data))
train_data <- data[1:train_size, ]
test_data <- data[(train_size + 1):nrow(data), ]

h2o.init()
model_spec_h2o = automl_reg(mode = "regression") %>% 
  set_engine(
    'h2o', max_runtime_secs = 360,
    nfolds = 5, seed = 123,
    verbosity = NULL,
    max_runtime_secs_per_model = 3)

model_fit_h2o = model_spec_h2o %>% fit(Weekly_Sales ~ ., train_data)  

modeltime = model_fit_h2o %>%  modeltime_table()

modeltime %>% 
  modeltime_calibrate(test_data) %>% 
  modeltime_forecast(
    new_data = test_data,
    actual_data = data,
    keep_data = T) %>% 
  group_by(id) %>% 
  plot_modeltime_forecast(
    .facet_ncol = 2,
    .interactive = T)


data_prepared = bind_rows(train_data, test_data)

recipe_spec = recipe(Weekly_Sales ~ Date, train_data) %>% 
  step_timeseries_signature(Date) %>% 
  step_fourier(Date, period = 180, K = 2) %>% 
  step_dummy(all_nominal())

future = data_prepared %>% 
  group_by(id) %>% 
  future_frame(.length_out = '2 years', .date_var = Date) %>% 
  ungroup()

future_prepared = recipe_spec %>% prep() %>% bake(future)

refit = modeltime %>% modeltime_refit(data = data_prepared)


refit %>% 
  modeltime_forecast(
    new_data = future_prepared,
    actual_data = data_prepared(),
    keep_data = TRUE
  ) %>% 
  group_by(id) %>%  
  plot_modeltime_forecast(.facet_ncol = 2, .interactive = T)


path = dirname(getSourceEditorContext()$path)

model_fit_h2o %>% save_h2o_model(path = paste0(path, '/model_h2o'), overwrite = T)

model = load_h2o_model(path = paste0(path, '/model_h2o'))
