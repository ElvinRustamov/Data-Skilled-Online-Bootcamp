#22. Tapşırıq

#"bank.csv" datasını import et. datanı təmizlə.
#"Weight Of Evidence" tətbiq et.
#"Multicollinearity" problemini həll et. GLM modelini çarpaz validasiya ilə qur.
#Modelin performansını göstər. "Overfitting" və ya "Underfitting" varmı.

getwd()
setwd('C:/Users/maham/Desktop/R')

library(tidyverse)
library(rstudioapi)
library(car)
library(inspectdf)
library(caret)
library(glue)
library(highcharter)
library(h2o)
library(scorecard)

data = read.csv('bank.csv', sep = ';')

data %>% glimpse()


data$default = data$default %>% recode(" 'yes' = 1; 'no' = 0") %>% as_factor()
data$housing = data$housing %>% recode(" 'yes' = 1; 'no' = 0") %>% as_factor()
data$loan = data$loan %>% recode(" 'yes' = 1; 'no' = 0") %>% as_factor()

data$y = data$y %>% recode(" 'yes' = 1; 'no' = 0") %>% as_factor()

data %>% inspect_na()

target = 'y'


#"Weight Of Evidence" tətbiq et.
iv = data %>% 
  iv(y = target) %>% 
  as_tibble() %>% 
  mutate(info_value = round(info_value, 3)) %>% 
  arrange(desc(info_value))

ivars = iv %>% 
  filter(info_value > 0.02) %>% 
  pull(variable)

df.iv = data %>% select(all_of(target), all_of(ivars))

df.iv %>% dim()

df_list = df.iv %>% 
  split_df(target, ration = 0.8, seed = 1)

bins = df_list$train %>% woebin(target)

train_woe = df_list$train %>% woebin_ply(bins)
test_woe = df_list$test %>% woebin_ply(bins)

names = train_woe %>% 
  names() %>% str_replace_all('_woe', '')

names(train_woe) = names
names(test_woe) = names


#"Multicollinearity" problemini həll et. GLM modelini çarpaz validasiya ilə qur.

multicollinearity = function(data, target) {
  features = data %>% select(-all_of(target)) %>% names()
  f = as.formula(paste(target, paste(features, collapse = " + "), sep = ' ~ '))
  glm = glm(f, data = data, family = 'binomial')
  
  coef_na = attributes(alias(glm)$Complete)$dimnames[[1]]
  features = features[!features %in% coef_na]
  f = as.formula(paste(target, paste(features, collapse = " + "), sep = ' ~ '))
  glm = glm(f, data = data, family = 'binomial')
  
  while (glm %>% vif() %>%  arrange(desc(gvif)) %>% .[1,2] >= 2) {
    after_vif = glm %>% vif() %>% arrange(desc(gvif)) %>% pull(variable) %>% .[-1]
    f = as.formula(paste(target, paste(after_vif, collapse = " + "), sep = ' ~ '))
    glm = glm(f, data = data, family = 'binomial')
  }
  return(glm %>% vif() %>% pull(variable))
}

features = train_woe %>% multicollinearity(target)

h2o.init()

train_h2o = train_woe %>% select(target, all_of(features)) %>% as.h2o()
test_h2o = test_woe %>% select(target, all_of(features)) %>% as.h2o()

model = h2o.glm(
  x = features, y = target, family = 'binomial',
  training_frame = train_h2o, validation_frame = test_h2o,
  nfolds = 10, seed = 1, remove_collinear_columns = T,
  balance_classes = T, lambda = 0, compute_p_values = T)


#Modelin performansını göstər. "Overfitting" və ya "Underfitting" varmı.
y_pred_test = model %>% h2o.predict(test_h2o) %>% as.data.frame()
actual_value = df_list$test %>% pull(target)
predicted_value = y_pred_test$predict

actual_value %>% table()
predicted_value %>% table()

cm = table(actual_value, predicted_value)

tp = cm[2, 2] #true positive
tn = cm[1, 1] #true negative
fp = cm[1, 2] #false positive
fn = cm[2, 1] #false negative

precision = tp / (tp + fp)
recall_sen = tp / (tp + fn)
speci = tn / (tn + fn)
accuracy = (tp + tn) / (tp + tn + fn + fp)
f1_score = 2 * precision * recall_sen / (precision + recall_sen)
balanced_acc = (recall_sen + speci) / 2

tibble(precision, recall_sen, speci, accuracy, f1_score, balanced_acc)

threshold = model %>% h2o.performance(test_h2o) %>% h2o.find_threshold_by_max_metric('f1')

metrics = model %>% 
  h2o.performance(test_h2o) %>% 
  h2o.metric() %>% 
  select(threshold, precision, recall, tpr, fpr) %>% 
  add_column(random_tpr = runif(nrow(.), min = 0.001, max = 1)) %>% 
  mutate(random_fpr = random_tpr) %>% 
  arrange(random_tpr, random_fpr)


auc = model %>% h2o.performance(test_h2o) %>% h2o.auc() %>% round(2)

highchart() %>% 
  hc_add_series(metrics, 'scatter', hcaes(y=tpr, x=fpr), color='blue') %>% 
  hc_add_series(metrics, 'line', hcaes(y=random_tpr, x=random_fpr), color='red')


#Overfitting | underfitting
model %>% h2o.auc(train = T, valid = T, xval = T) %>% 
  as_tibble() %>% 
  round(2) %>% 
  mutate(data = c('train', 'test', 'cross_val')) %>% 
  mutate(gini = 2 * value - 1) %>% 
  select(data, auc = value, gini)

#underfitting ve overfitting yoxdur.







