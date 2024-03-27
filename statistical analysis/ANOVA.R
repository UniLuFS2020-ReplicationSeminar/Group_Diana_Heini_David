#Creating a new column that groups the nordic countries and other countries to 2 categories; North and South

data_depression$area <- ifelse(data_depression$country %in% c("FI", "SE", "IS"), "North", "South")

#checking how the depression scores look like in the 2 areas

gender2_by_area <- data_depression %>%
  group_by(area, gender2) %>%
  summarise(mean_variable = mean(depression), .groups = 'drop') %>%
  na.omit()

ggplot(gender2_by_area, aes(x = area, y = mean_variable, fill = gender2)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Average depression in the two areas",
       x = "Country",
       y = "Mean depression") +
  theme_minimal()

#visually seems that there is a difference that matches with our hypothesis; differences are bigger in south category

#testing it with a ANOVA test

model <- aov(depression ~ area + gender2 + area:gender2, data = data_depression)

summary(model)

#area and gender are separately significant (p<.001), the interaction term slightly less (p=.05)

#post-hoc test to see where the differences are

TukeyHSD(model)

#all differences are significant (p<.001) except for the difference between North:Male-North:Female; hypothesis supported :)
