library(tidyverse)


#1. "data <- tidyr::billboard" kodunu icra et. Yalnız "wk" ilə başlayan sütunları "key" sütununa topla.
data = tidyr::billboard
data = data %>% gather(key="key", value="value", starts_with("wk"))


#2. "date.entered" sütununu "il", "ay", "gün" sütunlarına parçala. "sep" arqumentini də istifadə elə.
data = data %>%  separate(date.entered, c("il", "ay", "gün"), sep="-")


#3."data <- tidyr::fish_encounters" kodunu icra et. "station" qruplarına görə "seen" dəyişənini cəmlə və yeni sütunun adı "cəm" olsun. "station" dəyişənindəki dəyərləri sütunlara yay.
data <- tidyr::fish_encounters
data %>%
  group_by(station) %>%
  summarize(cəm = sum(seen)) %>% 
  spread(key = station, value = cəm) -> data