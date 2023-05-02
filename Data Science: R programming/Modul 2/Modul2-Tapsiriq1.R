library(tidyverse)

#1. dslabs paketindən gapminder datasını "data" adıyla daxil et. datanın tipini göstər.
data = dslabs::gapminder
class(data)


#2. datanı tibble formatına çevir.
data = data %>% as_tibble()
class(data)


#3. "infant_mortality" sütununu "population" sütununa böl və "nisbət" adında yeni sütun yarat. Bu hesablamanı "tibble" paketinin funksiyası vasitəsi ilə həll et.
data = data %>% mutate(nisbət = (data$infant_mortality / data$population))


#4. "id" sütunu yarat və bu sütunu sətir adına çevir.
data = data %>% add_column(id = 1:nrow(.), .before="country") %>% column_to_rownames(var = "id")