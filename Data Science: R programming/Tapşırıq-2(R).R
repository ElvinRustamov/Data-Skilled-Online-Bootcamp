#Tapşırıqlar
#1. Dəyərləri 1a, 2b, 3c, 4d olan bir vektor yarat. "vektor" ilə adlandır. ----
vektor = c('1a', '2b', '3c', '4d')

  
#2. "vektor" un tipinə bax. ----
class(vector)
  

#3. 1 ilə 1000 arasında yerləşən tək ədədləri (1 və 1000 daxil) "tək_ədədlər" ilə adlandır. ----
tək_ədədlər = seq(1,1000, 2)


#4. "tək_ədədlər_4" vektorunu yaradın. Dəyərləri "tək_ədədlər" vektorunun 4 dəfə təkrarı olsun. ----
tək_ədədlər_4 = rep(tək_ədədlər, 4)


#5. "tək_ədədlər" vektorunun cüt indekslərində yerləşən ədədləri göstər. ----
length(tək_ədədlər) #Dəqiqləşdirmək üçün. Uzunluq: 500
tək_ədədlər[c(seq(2, 500, 2))]

  
#6. 1 ilə 1000 arasında yerləşən (1 və 1000 daxil) tək ədədlər ilə cüt ədədləri ----
  
  #  sütun şəklində birləşdir. Nəticəni "data" ilə adlandır.
data = cbind(tək_ədədlər, tək_ədədlər[c(seq(2, 500, 2))])

  
#7. "data" ı data.frame formatına çevir. ----
data = as.data.frame(data)
  

#8. "data" nın tək indeksli sətirlərini və bütün sütunlarını göstər. ----
data[seq(1, 500, 2),]  


#9. "datalar" adında list yarat. Bu listin içində daha öncə yaradılan "vektor", ----
  
  #  tək_ədədlər", "tək_ədədlər_4", "data" dataları olsun.
datalar = list(vektor, tək_ədədlər, tək_ədədlər_4, data)
datalar[[1]]
datalar[[2]]
datalar[[3]]
datalar[[4]]
