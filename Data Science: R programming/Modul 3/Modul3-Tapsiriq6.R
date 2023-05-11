#"data <- ggplot2::msleep" kodunu icra et.
data = ggplot2::msleep
data %>% glimpse()
data[!complete.cases(data), ] %>% View()
data <- as.data.frame(data)
#1. Numerik dəyişənlərin NA’lərini 1 dəyişənənin faktorlarına görə "median" ilə doldur.
numeric_columns = colnames(select_if(data, function(x) is.numeric(x) && anyNA(x)))

fill_with_median <- function(df, category, column2) {
  median_column = median(df[df$genus == category, column2][[1]], na.rm=T)
  df[which(is.na(df[column2]) & df$genus == category), column2] <- median_column
  return(df)
}

for (column_name in numeric_columns) {
  for (category in unique(data$genus)) {
    data = fill_with_median(data, category, column_name)
  }
}
# Datada NA qalmasinin sebebi Tursiops bir dene olmasi ve deyeri NA olmasidir. 
#Vore column-dan istifade etmemeyimin sebebi icerisinde NA olmasidir.
#Order column-dan istifade etmemeyimin sebebi order column-un icersinde olan bezi deyererin diger uc sutunda deyerli NA-dir.Meselen Pilosa.
#Bu sutunlari muqayise etdikde datadaki NA doldurarken en az NA sayi saxlayan genus column-dur.


#2. Kateqorik dəyişənlərin NA’lərini 1 dəyişənənin faktorlarına görə "mode" ilə doldur.
chracter_columns = colnames(select_if(data, function(x) is.character(x) && anyNA(x)))
data$vore = data$vore %>% as.factor()
data$conservation = data$conservation %>% as.factor()
categorical_columns = colnames(select_if(data, is.factor))

#Data olan conservation column-a baxan zaman NA heddinden artiq cox oldugunu musahide etdim.
#Ve bir deyiskende NA sayi umumi datanin 70% teskil edilse o column silinmesinin daha faydali olacagini dusunurem.

(data[which(is.na(data$conservation)), 'conservation'] %>% count() / data['conservation'] %>% count()) * 100
# Output: 35%. Ama genus deyiseninin faktoruna gore mode ile doldurduqda, bu columnda olan yanlisliq artacaq.


mode <- function(x) {
  table <- table(x)
  mode <- as.character(names(table)[table == max(table)])
  return(mode)
}

fill_with_mode <- function(df, category, column) {
  x <- df[df$genus == category, column]
  x <- x[!is.na(x)]
  mode_value <- mode(x)
  df[is.na(df[column]) & df$genus == category, column] <- rep(mode_value, length.out = sum(is.na(df[column]) & df$genus == category))
  return(df)
}

factor_columns <- colnames(data)[sapply(data, is.factor)]

for (column_name in factor_columns) {
  for (category in unique(data$genus)) {
    data <- fill_with_mode(data, category, column_name)
  }
}

data %>% View()


#3. "Outlier"ları həll elə.
library(graphics)

numeric_values = data %>% 
  select_if(is.numeric) %>% 
  names()

for_vars = c()
for (i in 1:length(numeric_values)) {
  OutVals = boxplot(data[[numeric_values[i]]], plot=F)$out
  if (length(OutVals) > 0) {
    for_vars[i] = numeric_values[i]
  }
}


for_vars = for_vars %>% as.data.frame() %>% drop_na() %>% pull(.)
for_vars %>% length()


for (i in for_vars) {
  OutVals = boxplot((data[[i]]), plot=F)$out
  mean = mean(data[[i]], na.rm=T)
  
  o3 = ifelse(OutVals > mean, OutVals, NA) %>% na.omit() %>% as.matrix() %>% .[,1]
  o1 = ifelse(OutVals < mean, OutVals, NA) %>% na.omit() %>% as.matrix() %>% .[,1]
  
  val3 = quantile(data[[i]], 0.75, na.rm = T) + 1.5 * IQR(data[[i]], na.rm = T)
  data[which(data[[i]] %in% o3), i] = val3
  
  val1 = quantile(data[[i]], 0.25, na.rm = T) - 1.5 * IQR(data[[i]], na.rm = T)
  data[which(data[[i]] %in% o1), i] = val1
}


