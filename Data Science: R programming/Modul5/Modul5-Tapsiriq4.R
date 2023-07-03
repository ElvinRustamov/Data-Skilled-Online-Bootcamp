#install.packages("timetk")
library(timetk)
library(tidyverse)
library(inspectdf)
library(lubridate)

#"data <- timetk::walmart_sales_weekly %>% filter(id == '1_3') %>% select(Date, Weekly_Sales)" kodunu run et. 
#Time Series'i günlük, aylıq, həftəlik vizuallaşdır.

data <- timetk::walmart_sales_weekly %>% filter(id == '1_3') %>% select(Date, Weekly_Sales)
data %>% glimpse()
data %>% inspect_na()

data %>% 
  mutate(Date = floor_date(Date, unit = 'month')) %>% 
  group_by(Date) %>% 
  summarise(Weekly_Sales = mean(Weekly_Sales)) %>% 
  ungroup() %>% 
  plot_time_series(
    .date_var = Date,
    .value = Weekly_Sales,
    .interactive = T
  )


data %>% 
  mutate(Date = floor_date(Date, unit = 'day')) %>% 
  group_by(Date) %>% 
  summarise(Weekly_Sales = mean(Weekly_Sales)) %>% 
  ungroup() %>% 
  plot_time_series(
    .date_var = Date,
    .value = Weekly_Sales,
    .interactive = T
  )



data %>% 
  mutate(Date = floor_date(Date, unit = 'week')) %>% 
  group_by(Date) %>% 
  summarise(Weekly_Sales = mean(Weekly_Sales)) %>% 
  ungroup() %>% 
  plot_time_series(
    .date_var = Date,
    .value = Weekly_Sales,
    .interactive = T
  )


#datada mövsümiliyi vizuallaşdır.
data %>% plot_seasonal_diagnostics(
  Date, Weekly_Sales,
  .interactive = Ts
)


data %>% plot_seasonal_diagnostics(
  Date, Weekly_Sales,
  .feature_set = c('week', 'month.lbl'),
  .interactive = T
)


#Asılı dəyişəndə outlier'ları vizuallaşdır. 
data %>% 
  plot_anomaly_diagnostics(
    .date = Date,
    .value = Weekly_Sales,
    .interactive = T,
    .title = 'Anomaly Diagnostic',
    .anom_color = 'red',
    .max_anomalies = 0.1
  )



