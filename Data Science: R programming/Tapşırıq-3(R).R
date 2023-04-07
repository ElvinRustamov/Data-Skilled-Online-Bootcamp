#Tapşırıqlar
#1. "data" adında 'data.frame" yarat. 1ci sütun "a" adında 1a, 2b, 3c, 4d, 5e, 6f dəyərlərindən ibarət olsun. 2ci sütun "b" adında hə və yox dəyərlərinin 3 dəfə təkrarından ibarət olsun. 3cü sütun "c" adında 2dən 19a qədər olan ədədlərin 3 dənədən bir sıralanmasından ibarət olsun.
data = data.frame(
  a = c('1a', '2b', '3c', '4d', '5e', '6f'),
  b = rep(c('yes', 'no'), 3),
  c = seq(2, 19, 3)
)


#2. "data"da "d" sütunu yarat. Bu sütun "a" və "b" sütunlarının " - " ilə birləşməsindən ibarət olsun. Bu tapşırığı 2 üsulla həll edin. İkisindən biri loop ilə yazılsın.
vector = c()
for (i in 1:nrow(data)){
  result = paste(data[['a']][i], data[['b']][i], sep = ' - ')
  vector = c(vector, result)
}
data[['d']] = vector

### Ikinci usul
result1 = paste(data[['a']][1], data[['b']][1], sep = ' - ')
result2 = paste(data[['a']][2], data[['b']][2], sep = ' - ')
result3 = paste(data[['a']][3], data[['b']][3], sep = ' - ')
result4 = paste(data[['a']][4], data[['b']][4], sep = ' - ')
result5 = paste(data[['a']][5], data[['b']][5], sep = ' - ')
result6 = paste(data[['a']][6], data[['b']][6], sep = ' - ')
v = c(result1, result2, result3, result4, result5, result6)
data[['d']] = v


#3. "data"da "e" sütunu yarat. Bu sütun "c" sütununun kvatratı olsun. Bu tapşırığı 2 üsulla həll edin. İkisindən biri loop ilə yazılsın.
vector = c()
for (i in 1:nrow(data)){
  result = data[['c']][i] ** 2
  vector = c(vector, result)
}

data[['e']] = vector

###Ikinci usul
result1 = data[['c']][1] ** 2
result2 = data[['c']][2] ** 2
result3 = data[['c']][3] ** 2
result4 = data[['c']][4] ** 2
result5 = data[['c']][5] ** 2
result6 = data[['c']][6] ** 2
data[['e']] = c(result1, result2, result3, result4, result5, result6)


#4. "data"da "f" sütunu yaradın. Bu sütunun məntiqi: "c" sütunun 2 misli "e" sütununun yarısından böyükdürsə "böyük", böyük deyilsə "kiçik", bərabərdirsə "bərabər" dəyərləri yazılsın.
vector_f = c()
for (i in 1:nrow(data)){
  vector_f = c(vector_f, ifelse(data[['c']][i] * 2 > data[['e']][i] / 2, 'böyük', ifelse(data[['c']][i] == data[['e']][i] / 2, 'bərabər', 'kiçik')))
}
data[['f']] = vector_f

###

v_f = c()
for (i in 1:nrow(data)) {
  if (data[['c']][i] * 2 > data[['e']][i] / 2) {
    v_f = c(v_f, 'böyük')
  } else if (data[['c']][i] * 2 < data[['e']][i] / 2) {
    v_f = c(v_f, 'kiçik')
  } else {
    v_f = c(v_f, 'bərabər')
  }
}

data[['f']] = v_f


#5. 4cü tapşırığı yerinə yetirən bir funksiya yaradın. Funksiyanın adı "funksiyam" olsun. "funksiyam" vasitəsi ilə "data"da "F" sütununu yaradın.

#Qeyd: nəticədə "f" və "F" sütunları birbirinə bərabər olacaqlar.

funksiyam = function(dataframe, column_1, column_2, new_column) {
  v = c()
  for (i in 1:nrow(dataframe)) {
    if (dataframe[[column_1]][i] * 2 > dataframe[[column_2]][i] / 2) {
      v = c(v, 'böyük')
    } else if (dataframe[[column_1]][i] * 2 < dataframe[[column_2]][i] / 2) {
      v = c(v, 'kiçik')
    } else {
      v = c(v, 'bərabər')
    }
  }
  
  dataframe[[new_column]] = v
  return (dataframe)
}
funksiyam(data, 'c', 'e', 'F')


