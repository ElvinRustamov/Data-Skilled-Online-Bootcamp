#Tapşırıqlar
#1. stars datasını dslabs paketindən R'a daxil et. Adı "data" olsun. datanın təkrarlanmayan sətirlərinin sayını göstər.

#Qeyd: "dplyr" paketinin funksiyalarından istifadə etmə. Yəni R'ın öz funksiyasını istifadə et.

library(dslabs)
data = dslabs::stars

nrow(unique(data))
nrow(data[!duplicated(data), ])

#base::nrow() -> True



#2. datada "type" sütunu "M" olan minimum "magnitude" u tap.

#Qeyd: "dplyr" paketinin funksiyalarından istifadə etmə. Yəni R'ın öz funksiyasını istifadə et.

subset(data[which(data$type == 'M'),], magnitude == min(magnitude))


#3. datada hər bir "type"ın ortalama "temp" və "magnitude" ı göstər.

#Qeyd: "dplyr" paketinin funksiyalarından istifadə etmə. Yəni R'ın öz funksiyasını istifadə et.

transform(data,
          temp_mean = ave(temp, type, FUN = mean),
          magnitude_mean = ave(magnitude, type, FUN = mean))


###
data_2 = transform(data,
              temp_mean = ave(temp, type, FUN = mean),
              magnitude_mean = ave(magnitude, type, FUN = mean))

data_2 = data_2[!duplicated(data_2$type), 4:6]
data_2

#4. 3cü tapşırığın davamında "type" sütununu azalan sıra ilə düz.

#Qeyd: "dplyr" paketinin funksiyalarından istifadə etmə. Yəni R'ın öz funksiyasını istifadə et.

data_2[order(data_2$type, decreasing = TRUE), ]



#5. datadan 2 data əmələ gətirmək lazımdır. 1ci data "min" adında: "data"da hər bir "type"ın minimum "temp" və "magnitude" ı göstər, "type" in adını "sol" ilə dəyiş. 2ci data "max" adında: "data"da hər bir "type"ın maximum "temp" və "magnitude" ı göstər, "type" in adını "sağ" ilə dəyiş. Sonra bu 2 datanı inner, full, left, right üsulları ilə join elə.

#Qeyd: "dplyr" paketinin funksiyalarından istifadə etmə. Yəni R'ın öz funksiyasını istifadə et.

sol = transform(data,
                temp_min = ave(temp, type, FUN = min),
                magnitude_min = ave(magnitude, type, FUN = min))
sol = sol[!duplicated(sol$type), 4:6]
names(sol)[1] <- 'sol'


sağ = transform(data,
                temp_max = ave(temp, type, FUN = max),
                magnitude_max = ave(magnitude, type, FUN = max))
sağ = sağ[!duplicated(sağ$type), 4:6]
names(sağ)[1] <- 'sağ'

#Inner
sol %>% merge(sağ, by.x='sol', by.y = 'sağ')

#Full
sol %>% merge(sağ, by.x='sol', by.y = 'sağ', all=T)

#Left
sol %>% merge(sağ, by.x='sol', by.y = 'sağ', all.x=T)

#Right
sol %>% merge(sağ, by.x='sol', by.y = 'sağ', all.y=T)


#Qeyd: "min" və "max" datalarını əmələ gətirmək üçün "dplyr" istifadə oluna bilər.