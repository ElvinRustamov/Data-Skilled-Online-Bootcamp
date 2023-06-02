#TƏSVİRİ STATİSTİKA. Tapşırıq 2.
# -----------------------------

#Tapşırıq 1.
#bankloan.csv faylında, R-də mövcud olan funksiyalardan istifadə edərək balans (balance) dəyişəni üçün əsas statistik göstəriciləri müəyyən edin.

balance_csv = read.csv("bankloan.csv")

balance = balance_csv$balance

mean_balance = mean(balance)
paste("Averega value of balance: ", mean_balance)


std_balance = sd(balance)
paste("Standart Deviation of balance: ", std_balance)


variance_balance = var(balance)
paste("Variation of balance: ", variance_balance)


min_balance = min(balance)
paste("Minimum value of balance: ", min_balance)


max_balance = max(balance)
paste("Maximum value of balance: ", max_balance)


range_balance = range(balance)
#range = maximum value - min value
paste("Range of balance: ", range_balance[2] - range_balance[1])
paste("Range of balance: ", max_balance - min_balance)


median_balance = median(balance)
paste("Median of balance: ", median_balance)


quantile_balance = quantile(balance) 
print("Quantiles of balance: ")
print(quantile_balance)



#Tapşırıq 2.
#directmail.csv faylında, “psych” paketində “describe” funksiyadan istifadə edərək, yaş (age) dəyişəni üçün əsas statistik göstəriciləri müəyyən edin.
require(psych)
directmail_csv = read.csv("directmail.csv")

describe(directmail_csv$age)

#describe(directmail_csv$age, na.rm=T, check=T)



#Tapşırıq 3.
#bankloan.csv faylında, “pastecs” paketində “statdesc” funksiyadan istifadə edərək, yaş (age) dəyişəni üçün əsas statistik göstəriciləri müəyyən edin.
require(pastecs)
#balance_csv = read.csv("bankloan.csv")

options(scipen=100)
options(digits=2)

stat.desc(balance_csv$age, basic=F)



#Tapşırıq 4.
#icecream.csv faylında, dondurma (icecream) dəyişəni üçün “skewness” və “kurtosis” göstəricilərini müəyyən edin. Sonra eyni dəyişən üçün 7%, 38% və 72% faizlikləri hesablayın və “mode” tapın.
require(e1071)
require(modeest)

icecream_csv = read.csv("icecream.csv")

skewness_of_icecream = skewness(icecream_csv$icecream)
paste("Skewness of icecream: ", skewness_of_icecream)

kurtosis_of_icecream = kurtosis(icecream_csv$icecream)
paste("Kurtosis of icecream: ", kurtosis_of_icecream)

quantile_of_icecream = quantile(icecream_csv$icecream, probs = c(0.07, 0.38, 0.72))
print(quantile_of_icecream)

mode_of_icecream = mlv(icecream_csv$icecream, method="mfv")
paste("Mode of icecream: ", list(mode_of_icecream))



#Tapşırıq 5.
#Tapşırıq 4-də olan əməliyyatları math.csv faylında grade1 dəyişəni üçün təkrar edin.
math_csv = read.csv("math.csv")

skewness_of_grade1 = skewness(math_csv$grade1)
paste("Skewness of grade1: ", skewness_of_grade1)

kurtosis_of_grade1 = kurtosis(math_csv$grade1)
paste("Kurtosis of grade1: ", kurtosis_of_grade1)

quantile_of_grade1 = quantile(math_csv$grade1, probs = c(0.07, 0.38, 0.72))
print(quantile_of_grade1)

mode_of_grade1 = mlv(math_csv$grade1, method="mfv")
paste("Mode of grade1: ", mode_of_grade1)



#Tapşırıq 6.
#hw.csv faylında, “DoBy” paketindəki müvafiq funksiyadan istifadə edərək, subyektlərin boyu (height) üçün əsas statistik göstəriciləri ayrı-ayrılıqda kişilər və qadınlar üçün hesablayın.
require(doBy)
hw_csv = read.csv("hw.csv")

func = function(x) {descStat(x, na.rm=T)}
summary = summaryBy(height~gender, data=hw_csv, FUN=func)
print(summary)



#Tapşırıq 7.
#hw.csv faylında, “DescribeBy” funksiyadan istifadə edərək, subyektlərin çəkisi (weight) üçün əsas statistik göstəriciləri ayrı-ayrılıqda kişilər və qadınlar üçün hesablayın.

#hw_csv = read.csv("hw.csv")
describe = describeBy(hw_csv$weight, hw_csv$gender)
print(describe)



#Tapşırıq 8.
#directmail.csv faylında, “Stats” paketindəki “aggregate” funksiyadan istifadə edərək, subyektlərin yaşı (age) üçün əsas statistik göstəriciləri təhsil səviyyələri (education levels) üzrə hesablayın. 

#directmail_csv = read.csv("directmail.csv")
#func = function(x) {descStat(x, na.rm=T)}
aggregation = aggregate(directmail_csv$age, by=list(directmail_csv$educ), FUN=func)
print(aggregation)



