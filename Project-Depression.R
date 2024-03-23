install.packages("haven")
install.packages("dplyr")
install.packages("ggplot2")
library(haven)
library(dplyr)
library(ggplot2)

# Read the SPSS data file into a dataframe
subset_data <- read.csv("subset_data.csv")
View(subset_data)

# Average Depression per Land
depression_by_country <- subset_data %>%
  group_by(cntry) %>%
  summarise(avg_depression = mean(w4q47, na.rm = TRUE))

# Bar Chart for average Depression
ggplot(depression_by_country, aes(x = reorder(cntry, -avg_depression), y = avg_depression)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Land", y = "Durchschnittliche Depression", title = "Durchschnittliche Depression nach Ländern") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Average household income per country
hincome_by_country <- subset_data %>%
  group_by(cntry) %>%
  summarise(avg_hincome = mean(hinctnta, na.rm = TRUE))

# Bar chart for average household income
ggplot(hincome_by_country, aes(x = reorder(cntry, -avg_hincome), y = avg_hincome)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Land", y = "Durchschnittliches Haushaltseinkommen", title = "Durchschnittliches Haushaltseinkommen nach Ländern") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
