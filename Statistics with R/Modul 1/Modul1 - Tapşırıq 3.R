#TEZLİK VƏ ÇARPAZ CƏDVƏLLƏRİN YARADILMASI Tapşırıq 3
# ---------------------------

#Tapşırıq 1.
#directmasil.csv faylında, R-də müvafiq əmrlərdən istifadə edərək, gəlir (income), təhsil (educ) və yaş (age) dəyişənləri üçün tezlik cədvəlləri (frequency tables) yaradın.
directmail_csv = read.csv("directmail.csv")

#table_income = table(directmail_csv$income, exclude=NULL)
#csum_income = cumsum(table_income)
#prop_income = prop.table(table_income)
#n = nrow(directmail_csv)
#cfreq_income = csum_income / n 
#table_income_last = cbind(table_income, csum_income, prop_income, cfreq = cfreq_income)


func_frequency_tables = function(x) {
  table_ = table(directmail_csv[x], exclude=NULL)
  csum_ = cumsum(table_)
  prop_ = prop.table(table_)
  n = nrow(directmail_csv)
  cfreq = csum_ / n 
  
  table_last = cbind(table = table_, csum = csum_, prop = prop_, cfreq = cfreq)
  
  table_last
}

income = func_frequency_tables('income')
print("Table Name: Income")
print(income)
educ = func_frequency_tables('educ')
print("Table Name: Educ")
print(educ)
age = func_frequency_tables('age')
print("Table Name: Age")
print(age)



#Tapşırıq 2.
#newspapers.csv faylında, “plyr” paketindəki müvafiq əmirlərdən istifadə edərək, siyasi (political) və yaş (age) dəyişənləri üçün tezlik cədvəlləri (frequency tables) yaradın.
require(plyr)

newspapers_csv = read.csv("newspapers.csv")

func_frequency_tables_with_plyr = function(x) {
  
  mytable = count(newspapers_csv, x)
  
  perc = mytable$freq / nrow(newspapers_csv)
  
  cumul = cumsum(mytable$freq)
  
  cumul_perc = cumsum(mytable$freq) / nrow(demo)
  
  table_last = cbind(mytable, cumul, perc, cumul_perc)
  
  table_last
}

political = func_frequency_tables_with_plyr('political')
print("Table Name: Political")
print(political)

age = func_frequency_tables_with_plyr('age')
print("Table Name: Age")
print(age)



#Tapşırıq 3.
#vitamin3.csv faylında, “xtabs” əmri ilə, aşağıdakı dəyişən cütlərindən istifadə edərək çarpaz cədvəllər (cross-tables) qurun:
#a. “dose” və “gender”
#b. “dose” və “type”
#c. “gender” və “type

vitamin = read.csv('vitamin3.csv')

xtab_a = xtabs(~dose+gender, data=vitamin)
ftable(xtab_a)


xtab_b = xtabs(~dose+type, data=vitamin)
ftable(xtab_b)


xtab_c = xtabs(~gender+type, data=vitamin)
ftable(xtab_c)



#Tapşırıq 4.
#Tapşırıq 3-də olan cütlər ilə “CrossTable” funksiyasını istifadə etməklə çarpaz cədvəllər (cross-tables) qurun.

#vitamin = read.csv('vitamin3.csv')
ct_a = CrossTable(vitamin$dose, vitamin$gender)
ct_a_version_2 = CrossTable(vitamin$dose, vitamin$gender,digits = 3,
                            expected = F, prop.r = F, prop.c = F,
                            prop.t = F, prop.chisq = F, chisq = F,
                            fisher = F, mcnemar = F, missing.include = F)


ct_b = CrossTable(vitamin$dose, vitamin$type)
ct_b_version_2 = CrossTable(vitamin$dose, vitamin$type,digits = 3,
                            expected = F, prop.r = F, prop.c = F,
                            prop.t = F, prop.chisq = F, chisq = F,
                            fisher = F, mcnemar = F, missing.include = F)


ct_c = CrossTable(vitamin$gender, vitamin$type)
ct_c_version_2 = CrossTable(vitamin$gender, vitamin$type,digits = 3,
                            expected = F, prop.r = F, prop.c = F,
                            prop.t = F, prop.chisq = F, chisq = F,
                            fisher = F, mcnemar = F, missing.include = F)



