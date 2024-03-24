install.packages("haven")
install.packages("dplyr")
install.packages("ggplot2")
library(haven)
library(dplyr)
library(ggplot2)

# Read the SPSS data file into a dataframe
subset_data <- read.csv("subset_data.csv")
View(subset_data)

# Cleaning Data Filter out rows with missing values in any column
cleaned_data <- subset_data[complete.cases(subset_data), ]
View(cleaned_data)

# Average Depression per Land
depression_by_country <- cleaned_data %>%
  group_by(cntry) %>%
  summarise(avg_depression = mean(w4q47, na.rm = TRUE))

# Bar Chart for average Depression
ggplot(depression_by_country, aes(x = reorder(cntry, -avg_depression), y = avg_depression)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Land", y = "Durchschnittliche Depression", title = "Durchschnittliche Depression nach Ländern") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Average household income per country
hincome_by_country <- cleaned_data %>%
  group_by(cntry) %>%
  summarise(avg_hincome = mean(hinctnta, na.rm = TRUE))

# Bar chart for average household income
ggplot(hincome_by_country, aes(x = reorder(cntry, -avg_hincome), y = avg_hincome)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Land", y = "Durchschnittliches Haushaltseinkommen", title = "Durchschnittliches Haushaltseinkommen nach Ländern") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Scatterplot between average depression and average household income
ggplot(data = merge(depression_by_country, hincome_by_country, by = "cntry"), aes(x = avg_hincome, y = avg_depression)) +
  geom_point() +
  labs(x = "Durchschnittliches Haushaltseinkommen", y = "Durchschnittliche Depression", title = "Depression and Income")

# Group by age + depression and household income
depression_by_age <- cleaned_data %>%
  group_by(age_group = cut(agea, breaks = c(0, 20, 30, 40, 50, 60, Inf))) %>%
  summarise(avg_depression = mean(w4q47, na.rm = TRUE))

hincome_by_age <- cleaned_data %>%
  group_by(age_group = cut(agea, breaks = c(0, 20, 30, 40, 50, 60, Inf))) %>%
  summarise(avg_hincome = mean(hinctnta, na.rm = TRUE))

# Visualization: Bar chart for average depression by age group
ggplot(depression_by_age, aes(x = age_group, y = avg_depression)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Age Group", y = "Average Depression", title = "Average Depression by Age Group") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Visualization: Bar chart for average household income by age group
ggplot(hincome_by_age, aes(x = age_group, y = avg_hincome)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Age Group", y = "Average Household Income", title = "Average Household Income by Age Group") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Daten für Tschechien filtern
czech_data <- cleaned_data %>%
  filter(cntry == "CZ")

# Durchschnittliche Depressionen für jede Region in Tschechien berechnen
average_depression <- czech_data %>%
  group_by(region) %>%
  summarise(avg_depression = mean(w4q47, na.rm = TRUE))

# Durchschnittseinkommen für jede Region in Tschechien berechnen
average_income <- czech_data %>%
  group_by(region) %>%
  summarise(avg_income = mean(hinctnta, na.rm = TRUE))

# Zusammenführen der durchschnittlichen Depressionen und des Durchschnittseinkommens nach Region
merged_data <- merge(average_depression, average_income, by = "region")

# Punktdiagramm für Durchschnittseinkommen und durchschnittliche Depressionen nach Region
ggplot(merged_data, aes(x = avg_income, y = avg_depression, color = region)) +
  geom_point(size = 3) +
  labs(x = "Haushaltseinkommen", y = "Durchschnittliche Depressionen", 
       title = "Vergleich von Einkommen und Depressionen nach Regionen in Tschechien") +
  theme_minimal()

# Ordinale Regressionsanalyse
install.packages("ordinal")
library(ordinal)

# Konvertieren der abhängigen Variable in einen Faktor
cleaned_data$w4q47 <- factor(cleaned_data$w4q47)

# Ordinale Regression durchführen
ord_model <- clm(w4q47 ~ gndr + agea + eduyrs + hinctnta, data = cleaned_data)

# Zusammenfassung des Modells anzeigen
summary(ord_model)




#Delete environment
rm(list = ls())
