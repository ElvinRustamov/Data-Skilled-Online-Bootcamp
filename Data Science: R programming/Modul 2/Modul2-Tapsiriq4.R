library(tidyverse)

#1. "data <- tidyr::us_rent_income" kodunu icra et. datada "variable" dəyişəninin unique dəyişənlərini göstər. Bunun üçün "forcats" paketindən istifadə et.
data = tidyr::us_rent_income
data$variable %>% fct_unique()


#2. datada "variable" dəyişəninin dəyərlərinin sayını göstər. Bunun üçün "forcats" paketindən istifadə et.
data$variable %>% fct_count()


#3. datada "variable" dəyişəninin "income" dəyərini "gəlir"ə, "rent" dəyərini "icarə"yə çevir.
data$variable %>% fct_collapse(gəlir = 'income') %>% fct_collapse(icarə = "rent")

