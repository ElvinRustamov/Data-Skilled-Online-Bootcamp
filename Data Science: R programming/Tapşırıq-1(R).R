# 1. 1 ilə 10 arasında yerləşən tək rəqəmlərin cəmini (1 və 10 daxil) "Cəm" ilə adlandır
cəm = 1 + 3 + 5 + 7 + 9
# cəm -> 1 + 3 + 5 + 7 + 9
# 1 + 3 + 5 + 7 + 9 -> cəm


# 2. "Cəm" ilə adlandırılan dəyərin data tipini göstər.
typeof(1 + 3 + 5 + 7 + 9) #output: double <- Answer
class(1 + 3 + 5 + 7 + 9)  #output: numeric


# 3. "Cəm" dəyərin data tipini göstər.
typeof(cəm) #output: double <- Answer
class(cəm)  #output: numeric


# 4. "Cəm" ilə adlandırılan dəyərin data tipini "integer" etmək mümkündürmü? Deyilsə səbəbi? Mümkündürsə kodu yaz.
cəm = 1L + 3L + 5L + 7L + 9L
typeof(cəm)

#Ikinci yol:
cəm_2 = as.integer(cəm)
typeof(cəm_2)

# 5. "Cəm" 1 ilə 10 arasındakı cüt ədədlərin cəmindən böyükdürmü? 
cəm > 2 + 4 + 6 + 8 + 10 #Output: False. Xeyr böyük deyil.

#ikinci yol:
cəm_cüt = 2 + 4 + 6 + 8 + 10
cəm > cəm_cüt
