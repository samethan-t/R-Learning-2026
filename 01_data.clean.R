
#CLEANING DATA
library(tidyverse)
view(starwars) #view data in table

#Variable Types
glimpse(starwars) #overview of data in console
class(starwars$gender)
unique(starwars$gender)

starwars$gender <- as.factor(starwars$gender) #makes into factor and assigns to starwars$gender (replaces)
class(starwars$gender)

levels(starwars$gender)

starwars$gender <- factor((starwars$gender),
                          levels = c("masculine",
                                     "feminine")) #creates the levels in the order you want

levels(starwars$gender)

#Select variable
names(starwars)

starwars %>%
  select(name, height, ends_with("color")) %>%
  names() #selects specific variables


#Filter observations
unique(starwars$hair_color)

starwars %>%
  select(name, height, ends_with("color")) %>%
  filter(
    hair_color %in% c("blond", "brown"),
    height < 180
  )

#Missing Data
mean(starwars$height, na.rm = T) #na.rm = not available removed is true

starwars %>%
  select(name, gender, hair_color, height)

starwars %>%
  select(name, gender, hair_color, height) %>%
  na.omit()

starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(!complete.cases(.)) #only shows varabbles with missing values

starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(!complete.cases(.)) %>%
  drop_na(height) %>%
  view()

starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(!complete.cases(.)) %>%
  mutate(hair_color = replace_na(hair_color, "none"))


#Duplicates
Names <- c("Peter", "John", "Andrew", "Peter")
Age <- c(22, 33, 44, 22)

friends <- data.frame(Names, Age)

friends[!duplicated(friends), ]

friends %>% distinct()


#Recoding variables
starwars %>% select(name, gender)

starwars %>%
  select(name, gender) %>%
  mutate(gender = recode(gender,
                         "masculine" = 1,
                         "feminine" = 2))





