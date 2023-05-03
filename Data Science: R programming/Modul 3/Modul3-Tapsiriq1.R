library(tidyverse)
library(fs)
library(readxl)
library(writexl)
library(rstudioapi)

#1. "churn.csv" faylını R'a daxil et.
path = dirname(getSourceEditorContext()$path)
setwd(path)

data = read.csv("churn.csv")


#2. datanı "xlsx" formatında export et.
data %>% write_xlsx("churn.xlsx")


#3. datada hər "job" qrupunu ayrı-ayrı export et.
data %>% 
  group_by(job) %>% 
  group_split() %>% 
  walk(function(x) {
    write_csv(x, path = str_c('C:', './data/', unique(x$job), '.csv'))
  })