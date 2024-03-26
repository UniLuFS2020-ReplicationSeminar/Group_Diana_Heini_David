install.packages("haven")
install.packages("dplyr")
install.packages("ggplot2")
library(haven)
library(dplyr)
library(ggplot2)

#reading the dataset to R

data <- read.csv("CRON2W4e01.csv")

View(data)

#filtering a subset of columns in the data needed for the analysis: country, age, gender, depression variable, household income, region

data_depression <- data %>% select(cntry, agea, gndr, w4q47, hinctnta, region)

#checking that the new dataset contains the 6 variables

View(data_depression)





