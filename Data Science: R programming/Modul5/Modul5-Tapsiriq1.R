library(tidyverse)
library(rstudioapi)
library(car)
library(inspectdf)
library(caret)
library(glue)
library(highcharter)
library(h2o)
library(scorecard)
library(lime)
library(dplyr)
library(data.table)
library(mice)
library(recipes)
library(graphics)
library(Metrics)
library(plotly)
library(patchwork)

#1. "mlr3data" paketindəki "kc_housing" datasına "h2o" ilə reqressiya modeli qur.
data = mlr3data::kc_housing

#columns = data %>% 
#  inspect_na() %>% 
#  filter(pcnt < 50) %>% 
#  pull(col_name)

#data = data %>% select(all_of(columns))

h2o.init()
h2o_data = data %>% as.h2o() 

h2o_data = h2o_data %>% h2o.splitFrame(ratios = 0.8, seed = 1)

train = h2o_data[[1]]
test = h2o_data[[2]]

target = 'price'

features = data %>% select(-all_of(target)) %>% names()

model = h2o.automl(
  x = features,
  y = target,
  training_frame = train,
  validation_frame = test,
  leaderboard_frame = test,
  stopping_metric = 'MAE',
  seed = 1,
  max_runtime_secs = 360
)

model@leaderboard %>% as.data.frame()
model = model@leader


#2. Bu reqressiya modelinin nəticələrini və performansını göstər.
y_pred = model %>% h2o.predict(test) %>% as.data.frame()
pred = y_pred$predict

actual = test %>% as.data.frame() %>% pull(all_of(target))

eval_func = function(x, y) summary(lm(y~x))
eval_sum = eval_func(actual, pred)

eval_sum$adj.r.squared %>% round(2)
mae(actual, pred) %>% round(1)
mse(actual, pred) %>% round(1)
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


y_pred_train = model %>% h2o.predict(train) %>% as.data.frame()
pred_train = y_pred_train$predict

actual_train = train %>% as.data.frame() %>% pull(all_of(target))

eval_sum = eval_func(actual_train, pred_train)
eval_sum$adj.r.squared %>% round(2)
mae(actual_train, pred_train) %>% round(1)
mse(actual_train, pred_train) %>% round(1)
rmse(actual_train, pred_train) %>% round(1)

plotting__train = cbind(pred_train, actual_train) %>%  as.data.frame()
Adjusted_R2 = eval_sum$adj.r.squared

g_train = plotting__train %>% 
  ggplot(aes(pred_train, actual_train)) +
  geom_point(color = 'green') +
  geom_smooth(method = lm) +
  labs(x = 'Predicted Value',
       y = 'Real Value',
       title = glue("Train: Adjusted R2 = {round(enexpr(Adjusted_R2),2)}"))
g_train %>% ggplotly()

g_train + g

#Model cox az overfit olub.


#3. "bank.csv" datasına "h2o" ilə klassifikasiya modeli qur.
getwd()
setwd('C:/Users/maham/Desktop/R')

data = read.csv('bank.csv', sep = ';')

data %>% glimpse()

data$y = data$y %>% recode("'yes' = 1; 'no' = 0") %>% as_factor()
data$y %>% table() %>% prop.table() %>% round(2)

data %>% inspect_na()

data = tibble::rowid_to_column(data, "id")

h2o.init()
h2o_data = data %>% as.h2o() 

h2o_data = h2o_data %>% h2o.splitFrame(ratios = 0.8, seed = 1)

train = h2o_data[[1]]
test = h2o_data[[2]]

target = 'y'

features = data %>% select(-y, -id) %>% names()

model = h2o.automl(
  x = features,
  y = target,
  training_frame = train,
  validation_frame = test,
  leaderboard_frame = test,
  stopping_metric = 'AUC',
  nfolds = 10,
  seed = 1,
  balance_classes = TRUE,
  exclude_algos = 'GLM',
  max_runtime_secs = 300
)

model@leaderboard %>% as.data.frame()
best_model = model@leader

y_pred = best_model %>% h2o.predict(test) %>% as.data.frame()

#4. Bu klassifikasiya modelinin nəticələrini və performansını göstər.
actual_value = test %>% as.data.frame() %>% pull(all_of(target))
predicted_value = y_pred$predict

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

#5. Klassifikasiya modelinin qara qutusunun izahını göstər.
ids = test %>% as.data.frame() %>% pull(id) %>% unique()
black_box_explanation = function(train, features, leader_model, column, cases, n) {
  lime_obj = train %>% as.data.frame() %>% 
    select(all_of(features)) %>% 
    lime(leader_model, bin_continuous = F)
  
  test = test %>% as.data.frame()
  
  expleaner = test[test[[column]] %in% cases, ] %>% 
    select(all_of(features)) %>% 
    lime::explain(lime_obj, n_labels = 1, n_features = n)
  
  return(expleaner %>% plot_features())
}

black_box_explanation(
  train = train,
  features = features,
  leader_model = best_model,
  column = 'id',
  cases = ids[1:6],
  n = 6
  )

