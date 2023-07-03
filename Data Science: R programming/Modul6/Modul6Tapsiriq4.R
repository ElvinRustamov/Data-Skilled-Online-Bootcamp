#"cluster" paketindən "plantTraits" datasını daxil et.

#datada klasterlərin optimal sayını tap.

#"K-Means" Klasterləşmə modelini qur.

#Nəticəni vizuallaşdır.

library(cluster)
library(ggplot2)

data(plantTraits)

sum(is.na(plantTraits))

plantTraits = plantTraits[complete.cases(plantTraits), ]

wss = sapply(1:10, function(k) {
  kmeans(plantTraits, centers = k, nstart = 10)$tot.withinss
})
plot(1:10, wss, type = "b", xlab = "Number of Clusters", ylab = "Within-cluster Sum of Squares", mar = c(5, 5, 2, 2))


k = 3
kmeans_model = kmeans(plantTraits, centers = k, nstart = 10)


plantTraits_df = as.data.frame(plantTraits)

plantTraits_df$cluster = as.factor(kmeans_model$cluster)

ggplot(plantTraits_df, aes(x = pdias, y = height, color = cluster)) +
  geom_point() +
  labs(x = "height", y = "longindex", title = "K-means Clustering Result")
