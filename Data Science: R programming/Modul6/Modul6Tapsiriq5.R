#"movies.csv" datasını daxil et.

#"genres" dəyişənindəki faktorlar üçün "Apriori" modelini qur.

#Əldə olunan qaydaları vizuallaşdır. 

install.packages("arules")
install.packages("arulesViz")

library(arules)
library(arulesViz)
library(tidyverse)

movies = read.csv("movies.csv", header = TRUE, stringsAsFactors = FALSE)

genres = strsplit(movies$genres, "\\|")

genres = as.data.frame(do.call(rbind, genres))

transactions = as(genres, "transactions")

rules = apriori(transactions, parameter = list(support = 0.1, confidence = 0.5))

plot(rules, method = "matrix")

plot(rules, method = "graph")
