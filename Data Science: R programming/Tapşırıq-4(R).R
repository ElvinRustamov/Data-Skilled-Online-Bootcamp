#Tapşırıqlar
#1. stars datasını dslabs paketindən R'a daxil et. Adı "data" olsun.

library(dslabs)
data = dslabs::stars


#2. datadakı dəyişənlərin tipini göstər.

sapply(data, class)
###
str(data)


#3. datanın təkrarlanmayan sətirlərinin sayını göstər.

data %>% distinct() %>% nrow()
nrow(distinct(data))


#4. datada "type" sütunu "M" olan minimum "magnitude" u tap.

data %>% filter(type == 'M') %>% summarise(Min_Magnitude = min(magnitude))


#5. datada hər bir "type"ın ortalama "temp" və "magnitude" ı göstər.

data %>% group_by(type) %>% summarise(Average_Temp = mean(temp), 
                                      Average_magnitude = mean(magnitude))


#6. 5ci tapşırığın davamında "type" sütununu azalan sıra ilə düz.

data %>% group_by(type) %>% summarise(Average_Temp = mean(temp), 
                                      Average_magnitude = mean(magnitude)) %>% arrange(desc(type))


#7. "type" dəyişəninin hərbir dəyərinin "data"dakı ümumi sayını artan sıra ilə göstər.

data %>% count(type) %>% arrange(n)


#8. datadan 2 data əmələ gətirmək lazımdır. 1ci data "min" adında: "data"da hər bir "type"ın minimum "temp" və "magnitude" ı göstər, "type" in adını "sol" ilə dəyiş. Ilk 8 sətri saxla. 2ci data "max" adında: "data"da hər bir "type"ın maximum "temp" və "magnitude" ı göstər, "type" in adını "sağ" ilə dəyiş. Son 8 sətri saxla. Sonra bu 2 datanı inner, full, left, right üsulları ilə join elə.

sol = data %>% group_by(sol = type) %>% summarise(MinTemp = min(temp),
                                            MinMagnitute = min(magnitude)) %>% head(8)

sağ = data %>% group_by(sağ = type) %>% summarise(MaxTemp = max(temp),
                                            MaxMagnitute = max(magnitude)) %>% head(8)

sol %>% inner_join(sağ, by=c('sol'='sağ'))

sol %>% full_join(sağ, by=c('sol'='sağ'), keep=T)

sol %>% left_join(sağ, by=c('sol'='sağ'))

sol %>% right_join(sağ, by=c('sol'='sağ'))


