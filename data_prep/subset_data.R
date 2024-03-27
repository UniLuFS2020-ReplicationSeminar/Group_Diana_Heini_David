install.packages("haven")
install.packages("dplyr")
install.packages("ggplot2")
library(haven)
library(dplyr)
library(ggplot2)

#reading the dataset to R

data <- read.csv("CRON2W4e01.csv")

View(data)

#filtering a subset of columns in the data that might be relevant for the analysis: country, age, gender, depression variable, household income, region

data_depression <- data %>% select(cntry, agea, gndr, w4q47, hinctnta, region)

#checking that the new dataset contains the 6 variables

View(data_depression)

#renaming the columns to more meaningful names

data_depression <- data_depression %>% 
  rename(country = cntry) %>% 
  rename(age = agea) %>% 
  rename(gender = gndr) %>%
  rename(depression = w4q47) %>%
  rename(income = hinctnta)

#checking that the columns have been renamed

View(data_depression)

#renaming the labels on variables to more meaningful names

data_depression$gender[data_depression$gender == "1"] <- "Male"
data_depression$gender[data_depression$gender == "2"] <- "Female"
data_depression$gender[data_depression$gender == "9"] <- "No answer"

#checking for missing values in the dataset

# Replace missing values marked with 9999 and 999 with NA and "no answer" in gender with NA
data_depression[data_depression == 99999] <- NA
data_depression[data_depression == 999] <- NA

View(data_depression)

missing_values <- data_depression %>%
  summarise_all(~sum(is.na(.)))

# Print out the missing values
print(missing_values)

#country has 1 missing value, gender has 4

