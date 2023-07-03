#"imbalance" paketindəki "wisconsin" datasına "Boruta" nı da tətbiq edərək model qur. 
#Hədəf dəyişəndə balanssızlığı həll etdikdə nəticə yaxşılaşırmı?
install.packages('randomForest')
library(tidyverse)
library(imbalance)
library(Boruta)
library(caret)
library(randomForest)
install.packages('ROSE')
library(ROSE)


data = imbalance::wisconsin

data %>% glimpse()

set.seed(123)
train_slice <- sample(1:nrow(data), 0.7 * nrow(data))
train_data <- data[train_slice, ]
test_data <- data[-train_slice, ]

train_features <- train_data[, -ncol(train_data)]
train_target <- train_data$Class
test_features <- test_data[, -ncol(test_data)]
test_target <- test_data$Class

boruta_ <- Boruta(train_features, train_target)
selected_features <- getSelectedAttributes(boruta_, withTentative = FALSE)

train_features_selected <- train_features[, selected_features]
test_features_selected <- test_features[, selected_features]

model <- randomForest(train_features_selected, train_target)
predictions <- predict(model, test_features_selected)

confusionMatrix(predictions, test_target)

accuracy = (sum(predictions == test_target) / length(test_target)) %>% round(2)
accuracy #98


boruto.df = boruta_ %>% attStats() 
boruto.df %>% filter(decision == 'Confirmed') %>% rownames()

# balanssızlığı hell edereq model qurma
set.seed(123)
train_slice <- sample(1:nrow(data), 0.7 * nrow(data))
train_data <- data[train_slice, ]
test_data <- data[-train_slice, ]
train_oversampled <- ovun.sample(Class ~ ., data = train_data, method = "over", N = nrow(train_data), seed = 123)$data

train_features <- train_oversampled[, -ncol(train_data)]
train_target <- train_oversampled$Class
test_features <- test_data[, -ncol(test_data)]
test_target <- test_data$Class


boruta_ <- Boruta(train_features, train_target)
selected_features <- getSelectedAttributes(boruta_, withTentative = FALSE)

train_features_selected <- train_features[, selected_features]
test_features_selected <- test_features[, selected_features]

model <- randomForest(train_features_selected, train_target)
predictions <- predict(model, test_features_selected)

confusionMatrix(predictions, test_target)

accuracy = (sum(predictions == test_target) / length(test_target)) %>% round(2)
accuracy #95

#Accuracy 95 % endi. Ama ikinci model daha uygundur. 
#Ne ucun pozitiv ve negativ deyerlerin sayi artdiqca gelecekde model her iki deyeri bir-birinden daha yaxsi ayird ede bilecek.