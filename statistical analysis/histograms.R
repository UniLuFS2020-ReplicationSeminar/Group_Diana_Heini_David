# Average Depression per Land
depression_by_country <- data_depression %>%
  group_by(country) %>%
  summarise(avg_depression = mean(depression, na.rm = TRUE))

View(depression_by_country)

# Bar Chart for average Depression
ggplot(depression_by_country, aes(x = reorder(country, -avg_depression), y = avg_depression)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Land", y = "Durchschnittliche Depression", title = "Durchschnittliche Depression nach Ländern") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Average Depression per gender
depression_by_gender <- data_depression %>%
  group_by(gender) %>%
  summarise(avg_depression = mean(depression, na.rm = TRUE))

View(depression_by_gender)

#Bar chart for average Depression by gender

ggplot(depression_by_gender, aes(x = reorder(gender, -avg_depression), y = avg_depression)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "gender", y = "Durchschnittliche Depression", title = "Durchschnittliche Depression nach Geschlecht") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Based on this there seems to be a difference in depression between the genders and countries

#Note; only 2 data points for gender = no answer -> should be left out from the analysis?

#Calculating means in depression per gender & country

gender_by_country <- data_depression %>%
  group_by(country, gender) %>%
  summarise(mean_variable = mean(depression))

print(gender_by_country)

#creating a data frame of the grouping

result <- data.frame(gender_by_country)

View(result)

#creating a bar chart to visually compare the grouping

library(haven)
library(dplyr)
library(magrittr)
library(ggplot2)

ggplot(gender_by_country, aes(x = country, y = mean_variable, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Mean Variable by Country and Gender",
       x = "Country",
       y = "Mean Variable") +
  theme_minimal()

#looks like females have higher depression scores in all countries except Island and Italy
                            