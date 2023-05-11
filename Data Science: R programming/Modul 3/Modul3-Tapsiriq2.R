library(tidyverse)
library(plotly)
library(patchwork)
library(highcharter)
#1. "data <- ggplot2::midwest" kodunu icra et. "poptotal" və "popdensity" dəyişənlərinin "scatterplot"unu qur. "category" dəyişəninə görə rənglə, "area" dəyişəninə görə ölçüləndir. "labs" və "scale" əlavə et. "state" dəyişəninə görə plotları ayır. Plotları ayırarkən x və y oxlarını ayarla.

require(ggplot2)
data = ggplot2::midwest

visual = data %>% 
  ggplot(aes(poptotal, popdensity, colour=category)) + 
  geom_point(aes(size = area)) + 
  labs(x = "Total Population", y = "Population Density", title = "Information about popualtion", subtitle = "Scatterplot") + 
  scale_x_log10() +
  facet_grid(state ~ ., scales = 'free')

visual 

#2. "percollege" dəyişəninin "histogram"ını qur. "category" dəyişəninə görə rənglə. "labs" və "scale" əlavə et. "ggplotly" ilə vizuallaşdır.
visual_ggplotly = data %>% 
  ggplot(aes(percollege)) + 
  geom_histogram(aes(fill = category), colour = 'black') +
  labs(x = "Per College", y = "Count", title = "Count of per college", subtitle = "Scatterplot") + 
  scale_x_continuous(breaks = seq(5, 65, 15))

visual_ggplotly %>% ggplotly()


#3. "poptotal" dəyişəninin "boxplot"unu qur. "state" dəyişəninə görə rənglə. "labs" əlavə et. "ggplotly" ilə vizuallaşdır.

visual_ggplotly_2 = data %>% 
  ggplot(aes(poptotal, colour = state)) +
  geom_boxplot() +
  labs(x = "Total population", title = "Total population", subtitle = "Boxplot") +
  scale_x_log10()
visual_ggplotly_2
visual_ggplotly_2 %>% ggplotly()
# Boxplot ggplotly etdidke gorsenmir


#4. Yuxarıdakı plotları "dashboard"a səliqəli şəkildə yığ. (Yəni bir qrafikə yığ).

dahsboard <- (visual + visual_ggplotly + visual_ggplotly_2 + plot_layout(nrow = 1, byrow = 3))
dahsboard

#visual + visual_ggplotly + visual_ggplotly_2 + plot_layout(nrow = 1, byrow = 3) -> 3 dene plot oldugu ucun yaxsi gorsenmir ama deyerler daha aydin sekilde oxuna biler.


#5. "poptotal" və "popdensity" dəyişənlərinin "scatterplot"unu "highcharter" ilə qur. "category" dəyişəninə görə qruplaşdır.
data %>% 
  hchart("scatter", hcaes(x = poptotal, y = popdensity, color = category))
