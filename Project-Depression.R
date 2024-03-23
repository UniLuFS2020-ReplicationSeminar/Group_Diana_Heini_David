install.packages("haven")
install.packages("dplyr")
install.packages("ggplot2")
library(haven)
library(dplyr)
library(ggplot2)


# Länder im Datensatz extrahieren
unique_countries <- unique(subset_data$cntry)

# Anzahl der Länder zählen
num_countries <- length(unique_countries)

# Anzeigen der Anzahl
print(num_countries)

show(unique_countries)

# Durchschnittliche Depression nach Land
depression_by_country <- subset_data %>%
  group_by(cntry) %>%
  summarise(avg_depression = mean(w4q47, na.rm = TRUE))

# Balkendiagramm für durchschnittliche Depression
ggplot(depression_by_country, aes(x = reorder(cntry, -avg_depression), y = avg_depression)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Land", y = "Durchschnittliche Depression", title = "Durchschnittliche Depression nach Ländern") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  


