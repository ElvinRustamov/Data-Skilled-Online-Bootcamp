library(xgboost)
library(tidyverse)
library(mice)
library(caTools)
library(parsnip)
library(rBayesianOptimization)
library(Metrics)
library(inspectdf)

set.seed(1)



#1. "mlr3data" paketindəki "bike_sharing" datasına "xgboost" ilə reqressiya modeli qur.
data = mlr3data::bike_sharing

data %>% glimpse()

data = data %>% mutate(holiday = as_factor(holiday),
                       working_day = as_factor(working_day))

target = 'count'

data %>% inspect_na()

split = data %>% pull(target) %>% sample.split(SplitRatio = 0.8)
train = data %>% subset(split == T)
test = data %>% subset(split == F)

regression = boost_tree(
  mode = 'regression') %>% 
  set_engine(engine = 'xgboost') %>% 
  fit(count ~ ., data = train)


#2. Xgboost modelinin performansını göstər.
pred = regression %>% 
  predict(test %>%  select(-all_of(target))) %>% 
  pull(.pred)

actual = test %>% pull(target)
eval_func = function(x, y) summary(lm(y~x))
eval_sum = eval_func(actual, pred)

eval_sum$adj.r.squared %>% round(2)
mae(actual, pred) %>% round(1)
rmse(actual, pred) %>% round(1)
mse(actual, pred) %>% round(1)

#3. "Bayesian optimization" ilə optimal hiperparametrlərdən sonra modelin performansını göstər.

xgboost_fit = function(mtry, trees, learn_rate, tree_depth) {
  regression = boost_tree(
    mode = 'regression',
    mtry = mtry,
    trees = trees,
    learn_rate = learn_rate,
    tree_depth = tree_depth) %>% 
    set_engine(engine = 'xgboost') %>% 
    fit(count ~ ., data = train)
  
  pred = regression %>% 
    predict(test %>%  select(-all_of(target))) %>% 
    pull(.pred)
  
  actual = test %>% pull(target)
  eval_sum = eval_func(actual, pred)
  score = list(Score = eval_sum$adj.r.squared, Pred = 0)
}

search_bound_xgboost = list(mtry = c(10L, 100L), trees = c(10L, 150L), learn_rate = c(0.01, 0.5), tree_depth = c(2L, 10L))
search_grid_xgboost = data.frame(
  mtry = runif(30, 10L, 100L),
  trees = runif(30, 10L, 150L),
  learn_rate = runif(30, 0.01, 0.5),
  tree_depth = runif(30, 2L, 10L) %>% round()
)

bayes_xgboost = BayesianOptimization(
  FUN = xgboost_fit,
  bounds = search_bound_xgboost,
  init_grid_dt = search_grid_xgboost,
  init_points = 5,
  n_iter = 5
)

obj = bayes_xgboost$Best_Par

regression = boost_tree(
  mode = 'regression',
  mtry = obj[1],
  trees = obj[2],
  learn_rate = obj[3],
  tree_depth = obj[4]) %>% 
  set_engine(engine = 'xgboost') %>% 
  fit(count ~., data = train)

pred = regression %>% 
  predict(test %>%  select(-all_of(target))) %>% 
  pull(.pred)

actual = test %>% pull(target)
eval_func = function(x, y) summary(lm(y~x))
eval_sum = eval_func(actual, pred)

eval_sum$adj.r.squared %>% round(2)
mae(actual, pred) %>% round(1)
rmse(actual, pred) %>% round(1)
mse(actual, pred) %>% round(1)
