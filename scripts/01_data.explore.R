#Explore
#Clean
#Manipulate
#Describe and Summarise
#Visualise
#Analyse

#EXPLORE
library(tidyverse)
data(starwars)

dim(starwars) #dimensions (rows and variables)
str(starwars) #structure (variable names, type of variable, etc.)
glimpse(starwars) #same sort of thing as str
View(starwars)
head(starwars)
tail(starwars)
starwars$name

names(starwars)
length(starwars)
class(hair_color)
length(hair_color)
unique(hair_color)
View(sort(table(hair_color), decreasing = T))
barplot(sort(table(eye_color), decreasing = T))

starwars %>%
  select(hair_color) %>%
  count(hair_color) %>%
  arrange(desc(n)) %>%
  View()

View(starwars[is.na(hair_color), ])  #[ , ] before means columns you want, after means variables

class(height)
length(height)
summary(height)
boxplot(height)
hist(height)




