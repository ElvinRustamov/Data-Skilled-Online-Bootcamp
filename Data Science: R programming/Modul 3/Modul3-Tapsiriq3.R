library(tidyverse)
require(ggplot2)
library(inspectdf)
#install.packages("naniar")
library(naniar)
#install.packages('correlationfunnel')
library(correlationfunnel)


#1. "data <- ggplot2::msleep" kodunu icra et. datanın "NA" faizlərini plotla göstər.
data <- ggplot2::msleep
data %>% inspect_na() %>% show_plot()


#2. datada correlasiyaları plotla göstər.
data %>%  inspect_cor() %>% show_plot()


#3. datada ortaq "NA"ləri plotla göstər.
data %>% gg_miss_upset()


#4. "data <- "correlationfunnel::marketing_campaign_tbl" kodunu icra et. datada dəyişənlərin "TERM_DEPOSIT" dəyişəninin"yes" dəyəri ilə olan korrelasiyalarını interaktiv plotla göstər.
data = correlationfunnel::marketing_campaign_tbl %>% binarize(one_hot = T)
correlation = data %>% correlate(target = TERM_DEPOSIT__yes)

correlation %>% plot_correlation_funnel(interactive=T)

