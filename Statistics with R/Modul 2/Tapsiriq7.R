#TƏK DƏYİŞƏNİN ANALİZİNİN APARILMASI

#Tapşırıq 1:
  
#  hw.csv data faylında subyektlərin orta çəkisinin 75 kiloqramdan aşağı olub-olmadığını yoxlamaq üçün “one-simple t test” – dən istifadə edin.
hw_data = read.csv('hw.csv')
result_hw <- t.test(hw_data$weight, mu = 75, alternative = "less")
cat("Test statistic:", result_hw$statistic, "\n")
cat("p-value:", result_hw$p.value, "\n") 
#H0 (null hypothesis) = Subyektlərin orta çəkisi 75-dən aşağıdır
#H1 (alternative hypothesis) = Subyektlərin orta çəkisi 75-dən aşağı deyil
#P dəyəri 0.05-dən böyük olduğu üçün H0 rədd edə bilmirik və buna əsasən deyirik ki subyektlərin orta çəkisi 75-dən aşağıdır.


#Tapşırıq 2:
#  mobilenet.csv data faylında internetdə sərf olunan saatların orta miqdarının 9-dan çox olub-olmadığını yoxlamaq üçün “one-simple t test” – dən istifadə edin.
mobilenet = read.csv('mobilenet.csv')
result_mobil <- t.test(mobilenet$hours, mu = 9, alternative = "greater")
cat("Test statistic:", result_mobil$statistic, "\n")
cat("p-value:", result_mobil$p.value, "\n") 
#H0 (null hypothesis) = internetdə sərf olunan saatların orta miqdarını 9-dan çoxdur
#H1 (alternative hypothesis) = internetdə sərf olunan saatların orta miqdarını 9-dan çox deyil
#P dəyəri 0.05-dən kiçik olduğu üçün H0 rədd edirik və  H1 rədd edə bilmirik, buna əsasən deyirik ki internetdə sərf olunan saatların orta miqdarını 9-dan çox deyil.


#Tapşırıq 3:
#  bankloan.csv data faylında krediti olan subyektlərin faizinin 10%-dən çox olub-olmadığını yoxlamaq üçün “binomial test” – dən istifadə edin.
bank = read.csv('bankloan.csv')
loan_table = table(bank$loan)

result_loan <- binom.test(loan_table, p = 0.1, alternative = "greater", conf.level = 0.95)
cat("Test statistic:", result_loan$statistic, "\n")
cat("p-value:", result_loan$p.value, "\n") 
#H0 (null hypothesis) = krediti olan subyektlərin faizinin 10%-dən çox olması
#H1 (alternative hypothesis) = krediti olan subyektlərin faizinin 10%-dən çox olmaması
#P dəyəri 0.05-dən kiçik olduğu üçün H0 rədd edirik və  H1 rədd edə bilmirik, buna əsasən deyirik ki  krediti olan subyektlərin faizinin 10%-dən çox deyil.


#Tapşırıq 4:
#  directmail.csv data faylında educ (education level) dəyişəni ilə bərabər nəzəri ehtimallardan istifadə edərək “Chi-Square Test” –ni yerinə yetirin.
directmail = read.csv('directmail.csv')

#observed <- table(directmail$educ)
#expected <- prop.table(observed)
#result_direct <- chisq.test(observed, p = expected)
#cat("Chi-Square Statistic:", result$statistic, "\n")
#cat("p-value:", result$p.value, "\n")

table_d = table(directmail$educ)
n = length(table_d)
thprop = 1 / n
result_direct = chisq.test(table_d, p = rep(thprop, n))
cat("Test statistic:", result_direct$statistic, "\n")
cat("p-value:", result_direct$p.value, "\n") 
