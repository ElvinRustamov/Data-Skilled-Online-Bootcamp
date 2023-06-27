#FƏRZİYYƏLƏRİ YOXLAMAQ
library(ggplot2)
#Tapşırıq 1:
#  Aşağıdakı dəyişənlərin həm numerikal, həm də qrafikal üsullardan istifadə edərək normal paylanıb-paylanmadığını müəyyən edin.
#a)	bankloan.csv faylında balance dəyişəni
bank_data = read.csv('bankloan.csv')

shapiro.test(bank_data$balance) # P deyeri 0.05-den boyuk olmadigi ucun normal paylanma yoxdur.

average = mean(bank_data$balance)
std = sd(bank_data$balance)

ggplot(data = bank_data, aes(x = balance)) +
  geom_histogram(aes(y = after_stat(density)), fill = 'red', binwidth = 1000) + 
  stat_function(fun = dnorm, args = list(mean = average, sd = std), aes(x = balance), color = 1, linewidth = 1)


#b)	countries.csv faylında literacy dəyişəni
countries = read.csv('countries.csv')

shapiro.test(countries$literacy) # P deyeri 0.05-den boyuk olmadigi ucun normal paylanma yoxdur.

average = mean(countries$literacy)
std = sd(countries$literacy)

ggplot(data = countries, aes(x = literacy)) +
  geom_histogram(aes(y = after_stat(density)), fill = 'red', binwidth = 1) + 
  stat_function(fun = dnorm, args = list(mean = average, sd = std), aes(x = literacy), color = 1, linewidth = 1)


#c)	mobilenet.csv faylında hours dəyişəni
mobilenet = read.csv('mobilenet.csv')

shapiro.test(mobilenet$hours) # P deyeri 0.05-den boyuk olmadigi ucun normal paylanma yoxdur.

average = mean(mobilenet$hours)
std = sd(mobilenet$hours)

ggplot(data = mobilenet, aes(x = hours)) +
  geom_histogram(aes(y = after_stat(density)), fill = 'red') + 
  stat_function(fun = dnorm, args = list(mean = average, sd = std), aes(x = hours), color = 1, linewidth = 1)


#Tapşırıq 2:
#  Tapşırıq 1-də istifadə edilən dəyişənlərdə “outliers” olub-olmadığını müəyyənləşdirin.

outliers_bank = scale(bank_data$balance, scale = T)
sort(outliers_bank, decreasing = T) # Outliers var


outliers_countries = scale(countries$literacy, scale = T)
sort(outliers_countries, decreasing = T) # Outliers yoxdur


outliers_mobil = scale(mobilenet$hours, scale = T)
sort(outliers_mobil, decreasing = T) # Outliers yoxdur





