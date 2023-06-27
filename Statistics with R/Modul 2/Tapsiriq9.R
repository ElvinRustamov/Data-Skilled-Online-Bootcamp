#ORTALAMADAN FƏRQLİLİK TESTLƏRİ - MEAN DİFFERENCE TESTS

#Tapşırıq 1:
  
#  students.csv data faylında “male” və “female” tələbələr arasında orta bal fərqinin olub-olmadığını yoxlayın. (Male=1, Female=0)

students = read.csv('students.csv')

leveneTest(students$score, students$gender)

loan_yes_students <- students[students$gender == 0, "score"]
loan_no_students <- students[students$gender == 1, "score"]

t_test_students <- t.test(loan_yes_students, loan_no_students)

cat("Two-sample t-test result:\n")
cat("t-value:", t_test_students$statistic, "\n")
cat("p-value:", t_test_students$p.value, "\n")


#Tapşırıq 2:
  
#  bankloan.csv data faylında krediti olan (loan=”yes”) və olmayan ((loan=”no”) insanlar arasında ortalama balansda (average balance) fərqin olub-olmadığını müəyyənləşdir
bank = read.csv('bankloan.csv')

loan_yes <- bank[bank$loan == "yes", "balance"]
loan_no <- bank[bank$loan == "no", "balance"]

t_test <- t.test(loan_yes, loan_no)

cat("Two-sample t-test result:\n")
cat("t-value:", t_test$statistic, "\n")
cat("p-value:", t_test$p.value, "\n")
                                                          
#Tapşırıq 3:
                                                                     
#  gym.csv data faylında Rumıniya və ABŞ-dan olan hakimlər tərəfindən verilən orta bal (average score) arasında fərqin olub-olmadığını müəyyənləşdirin.
         
gym = read.csv('gym.csv')     

t.test(gym$romania, gym$unitedstates)

#Tapşırıq 4:
                                                                     
#  incomedata.csv data faylında One-Way analizindən istifadə edərək şəxslərin gəlirlərinə onların təhsil səviyyəsinin (education level) təsir edib-etmədiyini müəyyənləşdirin.
       
data = read.csv('incomedata.csv')

anova_result <- aov(income ~ educ, data = data)

print(summary(anova_result))      

#Tapşırıq 5:
                                                                     
#  incomedata.csv data faylında Two-Way analizindən istifadə edərək şəxslərin gəlirlərinə onların təhsil səviyyəsinin (education level) və yaşının (age) təsir edib-etmədiyini müəyyənləşdirin.

anova_result_two_way <- aov(income ~ educ * agecat, data = data)

print(summary(anova_result_two_way))