
#REQRESSİYA ANALİZİ - REGRESSION ANALYSIS

#Tapşırıq 1:
  
#  vehicles.csv data faylında “engine”, “horsepow”, “wheelbase”, “width”, “length”, weight və “fuelcap” dəyişənlərinin “price” dəyişəninə təsirini ölçmək üçün reqressiya analizi qurun.
data <- read.csv("vehicles.csv")

model <- lm(price ~ engine + horsepow + wheelbas + width + length + weight + fuelcap, data = data)

summary(model)


#Tapşırıq 2:
  
#  Əvvəlki tapşırıqda təsvir olunan dəyişənlərlə ardıcıl reqressiyanı həyata keçirin və onları reqressiya modelinə aşağıdakı kimi daxil edin:
  
#  1-ci blok: engine, horsepow

#  2-ci blok: qalan dəyişənlər

model_block1 <- lm(price ~ engine + horsepow, data = data)

model_block2 <- lm(price ~ engine + horsepow + wheelbas + width + length + weight + fuelcap, data = data)

print(summary(model_block1))
print(summary(model_block2))


#Tapşırıq 3:
  
#  bankloan.csv data faylında müştəri balansının (balance) aşağıdakı dəyişəndən asılı olub olmadığını müəyyən etmək üçün reqressiya təhlili aparın:
  
#  - yaş (age)

#  - onların krediti olub-olmaması (loan)

bank <- read.csv("bankloan.csv")

model <- lm(balance ~ age + loan, data = bank)

summary(model)


#Tapşırıq 4:
  
#  marketingdb.csv data faylında verilənlər çərçivəsində binomial reqressiya yerinə yetirin, burada asılı dəyişən “union” (həmkarlar ittifaqı üzvüdür ya yox) və müstəqil dəyişənlər “ed” (təhsil illəri), “jobsat” (iş məmnunluğu) və “polview” (siyasi baxış).
marketingdb <- read.csv("marketingdb.csv")
marketingdb$union <- ifelse(marketingdb$union == "Yes", 1, 0)
# Run the binomial regression
model_market <- glm(union ~ ed + jobsat + polview, data = marketingdb, family = binomial)

# Print the regression summary
summary(model_market)

#Tapşırıq 5:
  
#  marketingdb.csv data faylında verilənlər çərçivəsində multinomial reqressiya yerinə yetirin, burada asılı dəyişən “card” (kart növü) və müstəqil dəyişənlər “age”, “gender” və “income”.
install.packages("nnet")
library(nnet)

marketingdb <- read.csv("marketingdb.csv")

model <- multinom(card ~ age + gender + income, data = marketingdb)

summary(model)

#Tapşırıq 6:
  
#  marketingdb.csv data faylında verilənlər çərçivəsində ordinal reqressiya yerinə yetirin, burada asılı dəyişən “jobsat” (iş məmnunluğu) və müstəqil dəyişənlər “age”, “gender”, “income” və “ed”
library(MASS)

marketingdb <- read.csv("marketingdb.csv")

unique(marketingdb$jobsat)
marketingdb$jobsat <- factor(marketingdb$jobsat, ordered = TRUE, levels = c("Highly dissatisfied","Somewhat dissatisfied", "Neutral", "Somewhat satisfied", "Highly satisfied"))


model <- polr(jobsat ~ age + gender + income + ed, data = marketingdb)

summary(model)
