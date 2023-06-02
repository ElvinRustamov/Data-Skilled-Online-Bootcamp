#MƏLUMATLARIN QRAFİK TƏSVİRİ. Tapşırıq 4.
# --------------------------------------



#Tapşırıq 1.
#height.csv faylında, çəki (weight) və boy (height) dəyişənləri üçün histoqramlar qurun. Hər histoqrama normal əyri (normal curve) də əlavə edin.
require(ggplot2)
require(plyr)

data = read.csv('hw.csv')

#weight_plot = ggplot()+geom_histogram(
#  data = data,
#  aes(x = weight),
#  fill = 'red',
#  color = 'black'
#)
#print(weight_plot)


#height_plot = ggplot()+geom_histogram(
#  data = data,
#  aes(x = height),
#  fill = 'blue',
#  color = 'black'
#)
#print(height_plot)


weight_plot = ggplot(data,aes(weight))+
  geom_histogram(binwidth = 1.1, fill = 'white', color = 'red')+
  geom_density(aes(y = 1.1*..count..), color = 'black')
print(weight_plot)


height_plot = ggplot(data,aes(height))+
  geom_histogram(binwidth = 1.1, fill='white', color='blue')+
  geom_density(aes(y = 1.1*..count..), color = 'black')
print(height_plot)



#Tapşırıq 2:
#math.csv faylında, “grade1” və “grade2” dəyişənləri üçün kumulativ tezlik xətt qrafikləri (cumulative frequency line charts) yaradın.

math = read.csv('math.csv')

grade1 = count(math, 'grade1')
csum_grade1 = cumsum(grade1$freq)
csum_grade1_percentage = csum_grade1 / nrow(math)
grade1_table = cbind(grade1, csum_grade1_percentage)
grade_1_plot = ggplot() + geom_line(
  data = grade1, 
  aes(x = grade1, 
      y = csum_grade1_percentage),
  color = 'blue'
    )
print(grade_1_plot)


grade2 = count(math, 'grade2')
csum_grade2 = cumsum(grade2$freq)
csum_grade2_percentage = csum_grade2 / nrow(math)
grade2_table = cbind(grade2, csum_grade2_percentage)
grade_2_plot = ggplot() + geom_step(
  data=grade2, 
  aes(x=grade2, 
      y=csum_grade2_percentage), 
  color='red'
    )
print(grade_2_plot)



#Tapşırıq 3.
#Aşağıdakı dəyişənlər üçün sütun diaqramları (column charts) yaradın:
#a. “gender”  və “educ”,  directmail.csv faylında
#b. “continent” toyota.csv faylında 

c
toyota_csv = read.csv("toyota.csv")

gender = ggplot(data = directmail_csv) + geom_bar(mapping = aes(x = gender), fill='blue')
print(gender)
educ = ggplot(data = directmail_csv) + geom_bar(mapping = aes(x = educ), fill='red')
print(educ)
continent = ggplot(data = toyota_csv) + geom_bar(mapping = aes(x = continent), fill='green')
print(continent)



#Tapşırıq 4.
#Aşağıdakıları göstərmək üçün “mean plot charts” yaradın:
#a. hər bir təhsil səviyyəsi (education level) üzrə, yaş (age) dəyişəninin ortalaması (means). (directmail.csv)
#b. hər bir cins (gender) üzrə,  çəki (weight) dəyişəninin ortalaması (means). (hw.csv)


#data = read.csv('hw.csv')
#directmail_csv = read.csv("directmail.csv")

#a
agg_data_directmail = aggregate(directmail_csv$age, by = list(directmail_csv$educ), FUN = mean)
ggplot() + geom_line(data = agg_data_directmail, aes(x = (1:5), y = x)) +
  scale_x_discrete(name = 'Education Level', labels = c('College', 'High school', 'Post-graduate', 'Some college', 'Some high school or less')) + 
  scale_y_continuous(name = 'Age')

#b
agg_data_hw = aggregate(data$weight, by = list(data$gender), FUN = mean)
ggplot() + geom_line(data = agg_data_hw, aes(x = (1:2), y = x)) +
  scale_x_discrete(name = 'Gender', labels = c("Female", "Male")) + 
  scale_y_continuous(name = 'Average Weight')



#Tapşırıq 5.
#math.csv faylında, “grade1” və “grade2” dəyişənləri arasında əlaqəni göstərmək üçün “scatterplot” qrafiki yaradın. “Scatterplot” qrafikinə bir trend xətti əlavə edin və nöqtələrin xətt ətrafında toplanmağa meylli olub-olmadığını şərh edin

#math = read.csv('math.csv')

model = lm(grade2~grade1, data = math)
grade1_min = min(math$grade1)
grade1_max = max(math$grade1)


grade_1 = c(grade1_min, grade1_max)
new_data = data.frame(grade1 = c(grade1_min, grade1_max))
grade_2 = predict(model, newdata = new_data)
new_grades = data.frame(grade_1, grade_2)

ggplot(math, aes(x = grade1, y = grade2)) + geom_point() +
  geom_line(data = new_grades, aes(x = grade_1, y = grade_2), color = 'red')

#Plot-dan göründüyü kimi, nöqtələr (dəyərlər) trend xətti ətrafında toplanmağa meyilli deyil.



#Tapşırıq 6.
#gym.csv faylında, “romania” və “unitedstates” dəyişənləri arasında əlaqəni göstərmək üçün “scatterplot” qrafiki yaradın. “Scatterplot” qrafikinə bir trend xətti əlavə edin və nöqtələrin xətt ətrafında toplanmağa meylli olub-olmadığını şərh edin.

gym = read.csv("gym.csv")

model = lm(romania~unitedstates, data = gym)
unitedstates_min = min(gym$unitedstates)
unitedstates_max = max(gym$unitedstates)


unitedstates = c(unitedstates_min, unitedstates_max)
new_data = data.frame(unitedstates = c(unitedstates_min, unitedstates_max))
romania = predict(model, newdata = new_data)
new_scores = data.frame(unitedstates, romania)

ggplot(gym, aes(x = unitedstates, y = romania)) + geom_point() +
  geom_line(data = new_scores, aes(x = unitedstates_1, y = romania), color = 'red')

#Plot-dan göründüyü kimi, nöqtələr (dəyərlər) trend xətti ətrafında toplanmağa meyillidir.



#Tapşırıq 7.
#directmail.csv faylında, yaş (age) və balans (balance) dəyişəni üçün boxplot qrafiki qurun.

#directmail_csv = read.csv("directmail.csv")
ggplot() + geom_boxplot(data = directmail_csv, aes(x = age, y = income))



#Tapşırıq 8.
#Tapşırıq 7-də olan dəyişənləri istifadə etməklə, qruplaşdırılmış (clustered) boxplot qurun. Qruplaşdırmaq üçün “gender” və “education” dəyişənlərini istifadə edin.
lgd = directmail_csv$educ
ggplot() + geom_boxplot(data = directmail_csv, aes(x = age, y = income, fill = lgd))+
  scale_x_discrete(labels = c("Female", 'Male'))
