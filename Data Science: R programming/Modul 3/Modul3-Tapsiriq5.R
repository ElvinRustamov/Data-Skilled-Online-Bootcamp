library(tidyverse)
library(dslabs)
library(dbplyr)
#install.packages("RMySQL")
library(RMySQL)
library(dplyr)
#install.packages("RSQLite")
library(RSQLite)


#1. "dslabs::stars" datasını import et. Elə import et ki, "data %>% show_query()" kodu error verməsin. Aşağıdakı taskların nəticələrini sql koduyla göstər.
db_stars= stars %>% tbl_memdb(name = "db_stars")

#Qeyd: Əgər show_query() əmri error verirsə deməli bəzi kodlar "dplyr" paketinin funksiyaları ilə yazılmayıb. Həmən funksiyanı "dplyr" paketinin funksiyasına çevirin.


#2. datanın təkrarlanmayan sətirlərinin sayını göstər.
query = db_stars %>% 
  distinct() %>% 
  summarise(n = n()) %>% 
  show_query()
query 


#3. datada "type" sütunu "M" olan minimum "magnitude" u tap.
query_1 = db_stars %>% 
  filter(type == 'M') %>% 
  summarise(min_mag = min(magnitude)) %>% 
  show_query()

query_1


#4. datada hər bir "type"ın ortalama "temp" və "magnitude" ı göstər.
query_2 = db_stars %>% 
  group_by(type) %>%
  summarise(mean_temp = mean(temp, na.rm = T),
            mean_magnitude = mean(magnitude, na.rm = T)) %>% 
  show_query()
query_2


#5. 5ci tapşırığın davamında "type" sütununu azalan sıra ilə düz.
query_3a = db_stars %>% 
  group_by(type) %>% 
  summarise(mean_temp = mean(temp, na.rm = T),
            mean_magnitude = mean(magnitude, na.rm = T)) %>% 
  arrange(desc(type)) %>% 
  show_query()

query_3a

query_3b = db_stars %>% 
  arrange(desc(type)) %>% 
  show_query()
query_3b


#6. "type" dəyişəninin hərbir dəyərinin "data"dakı ümumi sayını artan sıra ilə göstər.
query_4 = db_stars %>% 
  group_by(type) %>% 
  summarise(count_type = count(type)) %>% 
  arrange(count_type) %>% 
  show_query()

query_4


#7. "data"da hər bir "type"ın minimum "temp" və "magnitude" ı göstər, "type" in adını "sol" ilə dəyiş. Ilk 8 sətri saxla. Bu dataya "left_join" ilə bunu birləşdir - ("data"da hər bir "type"ın maximum "temp" və "magnitude" ı göstər, "type" in adını "sağ" ilə dəyiş. Son 8 sətri saxla.).
query_5 = db_stars %>%
  group_by(type) %>%
  summarise(min_temp = min(temp, na.rm = TRUE),
            min_magnitude = min(magnitude, na.rm = TRUE)) %>%
  slice_min(n = 8, order_by = type) %>%
  rename(sol = type) %>%
  left_join(
    db_stars %>%
      group_by(type) %>%
      summarise(max_temp = max(temp, na.rm = TRUE),
                max_magnitude = max(magnitude, na.rm = TRUE)) %>%
      slice_max(n = 8, order_by = type) %>%
      rename(sağ = type),
    by = c('sol' = 'sağ')
  ) %>%  show_query()

query_5
