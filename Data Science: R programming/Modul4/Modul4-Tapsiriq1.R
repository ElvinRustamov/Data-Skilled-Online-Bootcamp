#21. Tapşırıq

#"mlr3data" paketindən "kc_housing" datasını import et. datanı təmizlə.
#Outlier'ları həll et.
#"One Hote Encoding" tətbiq.
#"Multicollinearity" problemini həll et.
#Dəyişənləri standartlaşdır.
#GLM (Generalized Linear Model) modelini Çarpaz Validasiya ilə qur.
#Modelin performansını göstər.
#"Overfitting" və ya "Underfitting" varmı?

library(dplyr)
library(tidyverse)
library(data.table)
library(inspectdf)
library(mice)
library(recipes)
library(graphics)
library(caret)
library(h2o)
library(Metrics)
library(plotly)
library(glue)
library(patchwork)


data = mlr3data::kc_housing
data_checking = copy(data)


#Data Cleaning
data %>% glimpse()

data$yr_built <- as.Date(paste(data$yr_built, "-01-01", sep = ""), "%Y-%m-%d")
data$date <- as.Date(data$date, format="%Y-%m-%d")

#View column contains 90% of 0. This column don't give me any information.
(sum(data$view == 0) / data %>% nrow()) * 100
(sum(data$view != 0) / data %>% nrow()) * 100

data$view = NULL

#I don't wanna fill NA values. 
#Because if a column has a 50% NA and I fill NA, for me it spoils my calculations.
#For that I delete if a column has 50% and greater NA values.

columns = data %>% 
  inspect_na() %>% 
  filter(pcnt < 50) %>% 
  pull(col_name)

data = data %>% select(all_of(columns))

target = 'price'

df.num = data %>% 
  select_if(is.numeric) %>% 
  select(all_of(target), everything())

df.date = data %>% 
  select_if(is.Date)

#Actually I need just numeric values. For that delete date and yr_built column.
data$date = NULL
data$yr_built = NULL

#Outlier'ları həll et.
outliers = function(data, target) {
  numeric_values = data %>% 
    select_if(is.numeric) %>% 
    select(all_of(target), everything()) %>% 
    names()
  
  for_vars = c()
  for (i in 1:length(numeric_values)) {
    OutVals = boxplot(data[[numeric_values[i]]], plot=F)$out
    if (length(OutVals) > 0) {
      for_vars[i] = numeric_values[i]
    }
  }
  
  
  for_vars = for_vars %>% as.data.frame() %>% drop_na() %>% pull(.)
  for_vars %>% length()
  
  
  for (i in for_vars) {
    OutVals = boxplot((data[[i]]), plot=F)$out
    mean = mean(data[[i]], na.rm=T)
    
    o3 = ifelse(OutVals > mean, OutVals, NA) %>% na.omit() %>% as.matrix() %>% .[,1]
    o1 = ifelse(OutVals < mean, OutVals, NA) %>% na.omit() %>% as.matrix() %>% .[,1]
    
    val3 = quantile(data[[i]], 0.75, na.rm = T) + 1.5 * IQR(data[[i]], na.rm = T)
    data[which(data[[i]] %in% o3), i] = val3
    
    val1 = quantile(data[[i]], 0.25, na.rm = T) - 1.5 * IQR(data[[i]], na.rm = T)
    data[which(data[[i]] %in% o1), i] = val1
  }
  return(data)
}

df.num = df.num %>% outliers(target = target)


#"One Hote Encoding" tətbiq.

#I can use one hote encoding just on waterfront. But it is not necessary. 
#Because machine understands True is 1 and False is 0


#"Multicollinearity" problemini həll et.

features = data %>% select(-all_of(target)) %>% names()
#f = as.formula(paste(target, paste(features, collapse = " + "), sep = ' ~ '))
#glm = glm(f, data = data)
#glm %>% summary()

coef_na = attributes(alias(glm)$Complete)$dimnames[[1]]
features = features[!features %in% coef_na]
f = as.formula(paste(target, paste(features, collapse = " + "), sep = ' ~ '))
glm = glm(f, data = data)
glm %>% summary()


#Dəyişənləri standartlaşdır.
#In data variable I have two Datetime variables. Because of that I use df.num variable.
data[, -1] = data[, -1] %>% scale() %>% as.data.frame()


#GLM (Generalized Linear Model) modelini Çarpaz Validasiya ilə qur.
h2o.init()

h2o_data = data %>% as.h2o()

h2o_data = h2o_data %>% h2o.splitFrame(ratios = 0.8, seed = 1)
train = h2o_data[[1]]
test = h2o_data[[2]]

features = data %>% select(-all_of(target)) %>% names()

model = h2o.glm(
  x = features, y = target,
  training_frame = train,
  validation_frame = test,
  nfolds = 10, seed = 1,
  lambda = 0, compute_p_values = T)


#Modelin performansını göstər.
y_pred = model %>% h2o.predict(test) %>% as.data.frame()
pred = y_pred$predict


actual = test %>% as.data.frame() %>% pull(all_of(target))

eval_func = function(x, y) summary(lm(y ~ x))
eval_sum = eval_func(actual, pred)

eval_sum$adj.r.squared %>% round(2)
mae(actual, pred) %>% round(1)
rmse(actual, pred) %>% round(1)

plotting = cbind(pred, actual) %>%  as.data.frame()
Adjusted_R2 = eval_sum$adj.r.squared

g = plotting %>% 
  ggplot(aes(pred, actual)) +
  geom_point(color = 'green') +
  geom_smooth(method = lm) +
  labs(x = 'Predicted Value',
       y = 'Real Value',
       title = glue("Test: Adjusted R2 = {round(enexpr(Adjusted_R2),2)}"))
g %>% ggplotly()


#"Overfitting" və ya "Underfitting" varmı?
y_pred_train = model %>%  h2o.predict(train) %>% as.data.frame()
pred_train = y_pred_train$predict

actual_train = train %>% as.data.frame() %>% pull(all_of(target))
eval_sum = eval_func(actual_train, pred_train)

eval_sum$adj.r.squared %>% round(2)
mae(actual_train, pred_train) %>% round(1)
rmse(actual_train, pred_train) %>% round(1)


plotting_train = cbind(pred_train, actual_train) %>%  as.data.frame()
Adjusted_R2_train = eval_sum$adj.r.squared

g_train = plotting_train %>% 
  ggplot(aes(pred_train, actual_train)) +
  geom_point(color = 'green') +
  geom_smooth(method = lm) +
  labs(x = 'Predicted Value',
       y = 'Real Value',
       title = glue("Test: Adjusted R2 = {round(enexpr(Adjusted_R2_train),2)}"))
g_train %>% ggplotly()

g_train + g

tibble(train_mae = mae(actual_train, pred_train) %>% round(1),
       train_rmse = rmse(actual_train, pred_train) %>% round(1),
       test_mae = mae(actual, pred) %>% round(1),
       test_rmse = rmse(actual, pred) %>% round(1))

#Both of them have same r squared score. But I think my model is a little bit underfit. 
#Because train mae and rmse higher than test mae and rmse. But in general I can say my model is neither overfit nor underfit.