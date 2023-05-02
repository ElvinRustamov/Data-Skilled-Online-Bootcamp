library(tidyverse)


#1. "data <- dplyr::storms" kodunu icra et. "lat", "long", "wind", "pressure", "ts_diameter", "hu_diameter" dəyişənlərinin ortamalarını tap.
data = dplyr::storms
ortalama <- function(data, cols) {
  data %>%
    select(all_of(cols)) %>%
    map_dbl(mean, na.rm = TRUE)
}
data %>% ortalama(c("lat", "long", "wind", "pressure", "tropicalstorm_force_diameter", "hurricane_force_diameter"))


##Qeyd: Bunun üçün "ortalama" adında funksiya yarat və "purrr" paketinin funksiyalarından istifadə et.

#2. 1ci tapşırığı funksiya yaratmadan birbaşa "purrr" paketinin. funksiyalarından istifadə edərək həll et.
cols = c("lat", "long", "wind", "pressure", "tropicalstorm_force_diameter", "hurricane_force_diameter")
data[cols] %>% map_dbl(~mean(., na.rm = T))


#3. "nisbət" adında funksiya yarat. Hesablanması: hərbir dəyər max dəyərə bölünsün. Bunu "lat", "long", "wind", "pressure" dəyişənlərinə tətbiq elə. Nəticəni tibble data formatında göstər.
nisbət = function(data) {
  data %>%
    select(lat, long, wind, pressure) %>%
    map(~ . / max(., na.rm = TRUE)) %>%
    set_names(paste0(names(data)[1:4], "_ratio")) %>%
    bind_cols()
}


data %>% nisbət()
result = data %>% nisbət()
class(result)
##Qeyd: "purrr" paketinin funksiyalarından istifadə et. 1ci tapşırıqda istifadə edilən funksiyadan fərqli funksiya olsa daha yaxşı olar.