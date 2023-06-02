
install.packages("psych")
library("psych")
#Read csv
demo = read.csv("demographics.csv")

mean_income = mean(demo$income)

std_income = sd(demo$income)

variance_income = var(demo$income)

min_income = min(demo$income)

max_income = max(demo$income)

range_income = range(demo$income)
#range_income[1] -> 9
#range_income[2] -> 1116

median_income = median(demo$income)

quantile_income = quantile(demo$income) 




# Create a matrix
demo2 = cbind(demo$age, demo$income, demo$carpr)
# Change column names
colnames(demo2) = c('age', 'income', 'price')

require(psych)


describe(demo2)
describe(demo2, na.rm=T, trim=0.1, check=T)

# ----------------------------.

install.packages("pastecs")
library("pastecs")

options(scipen=100)
options(digits=2)

stat.desc(demo2)
stat.desc(demo2, basic=T)
stat.desc(demo2, basic=F)

stat.desc(demo2, desc=F)


# skewness and kurtosis ------------------------
install.packages("e1071")
library("e1071")

# output is positive. (right skewed). output is negative (left skewed)
skewness(demo$income)

kurtosis(demo$income)


# quantiles --------------
quantile(demo$income)

quantile(demo$income, probs = c(0.23, 0.46, 0.96))


# mode -------------
install.packages("modeest")
library("modeest")

mlv(demo$income, method="mfv") #mfv means: most frequent values

# -------------------
install.packages("doBy")
library("doBy")

func = function(x) {descStat(x, na.rm=T)}

summaryBy(income~gender, data=demo, FUN=func)

summaryBy(income+age~gender, data=demo, FUN=func)

#--------------------
describeBy(demo$income, demo$educ)

#--------------------
aggregate(demo$age, by=list(demo$marital), FUN=mean)


### TEZLİK VƏ ÇARPAZ CƏDVƏLLƏR
my_table = table(demo$educ, exclude=NULL)

cumsum(my_table)
prop.table(my_table)

n = nrow(demo)
cfreq = cumsum(my_table) / n 

table2 = cbind(Freq=my_table, cumul=cumsum(my_table), relative = prop.table(my_table), cfreq = cfreq)

# ---------------------
install.packages("plyr")
library("plyr")

mytable = count(demo, 'educ')

perc = mytable$freq / nrow(demo)

cumul = cumsum(mytable$freq)

cumul_perc = cumsum(mytable$freq) / nrow(demo)

table3 = cbind(Freq=mytable, cumul=cumul, relative = perc, cfreq = cumul_perc)

# ---------------------
ct = xtabs(~gender+carcat, data=demo)
ftable(ct)

# ---------------------
install.packages("gmodels")
library("gmodels")

CrossTable(demo$gender, demo$carcat, prop.chisq = F)



