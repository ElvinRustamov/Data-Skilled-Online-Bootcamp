#ƏLƏQALƏRİN YOXLANILMASI – TEST ASSOCIATION

#Tapşırıq 1:
  
#  mobilenet.csv data faylında Pearson, Spearman və Kendall korrelyasiyasından istifadə edərək internetdə sərf olunan saatların sayı ilə gəlir arasında əlaqənin olub olmadığını müəyyənləşdirin.
mobilenet = read.csv('mobilenet.csv')

pearson_corr <- cor(mobilenet$hours, mobilenet$income, method = "pearson")

spearman_corr <- cor(mobilenet$hours, mobilenet$income, method = "spearman")

kendall_corr <- cor(mobilenet$hours, mobilenet$income, method = "kendall")

cat("Pearson correlation:", pearson_corr, "\n")
cat("Spearman correlation:", spearman_corr, "\n")
cat("Kendall correlation:", kendall_corr, "\n")


#Tapşırıq 2:
  
#  countries.csv data faylında Pearson, Spearman və Kendall korrelyasiyasından istifadə edərək şəhərlərdə (urban) yaşayan insanların faizi ilə ümumi daxili məhsul (gdp) arasında əlaqənin olub-olmadığını müəyyənləşdirin.
data <- read.csv("countries.csv")
urban <- data$urban
gdp <- data$gdp

pearson_corr_countries <- cor.test(urban, gdp, method = "pearson")

spearman_corr_countries <- cor.test(urban, gdp, method = "spearman")

kendall_corr_countries <- cor.test(urban, gdp, method = "kendall")

pearson_corr_countries
spearman_corr_countries
kendall_corr_countries


#Tapşırıq 3:
  
#  countries.csv data faylında şəhərlərdə (urban) yaşayan insanların faizi ilə ümumi daxili məhsul (gdp) arasındakı əlaqəni hesablayın və oxuyan insanların faizinin təsirini (literacy) “control variable” olaraq istifadə edin.
install.packages('ppcor')
install.packages('MASS')
library(MASS)
library(ppcor)

df <- data.frame(urban, gdp, literacy)
df <- na.omit(df)

partial_corr <- pcor.test(df$urban, df$gdp, df$literacy)

cat("Partial correlation coefficient:", partial_corr$estimate, "\n")
cat("p-value:", partial_corr$p.value, "\n")


#Tapşırıq 4:
  
#  directmail.csv data faylında gəlir və educ (education level) dəyişəni arasında əlaqənin olub-olmadığını müəyyən etmək üçün “Chi-Square Test” –ni yerinə yetirin.
direcmail = read.csv('directmail.csv')
cross_table <- table(direcmail$income, direcmail$educ)

# Perform the Chi-Square Test
chi_square <- chisq.test(cross_table)

# Print the test result
cat("Chi-Square Test result:\n")
cat("Chi-Square statistic:", chi_square$statistic, "\n")
cat("p-value:", chi_square$p.value, "\n")
cat("Degrees of freedom:", chi_square$parameter, "\n")