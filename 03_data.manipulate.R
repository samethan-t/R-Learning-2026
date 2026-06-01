#MANIPULATING DATA
library(tidyverse)
msleep
glimpse(msleep)
View(msleep)

#rename variable
msleep

msleep %>%
  rename("conserv" = "conservation") # rename to = from

#reorder variables
msleep %>%
  select(vore, name, everything())

# change a variable type
class(msleep$vore)

msleep$vore <- as.factor(msleep$vore)
glimpse(msleep)

msleep %>%
  mutate(vore = as.character(vore)) %>%  #vore = what we overright or replace
  glimpse()

#select variables to work with
names(msleep)

msleep %>%
  select(2:4,   #works within the 2nd to 4th variables
         awake,
         starts_with("sleep"),
         contains("wt")) %>%
  names()

#filter and arrange data
unique(msleep$order)

msleep %>%
  filter((order == "Carnivora" |   # | means OR, ie if the order is either Carnivora OR primates
            order == "Primates") &
           sleep_total > 8) %>%
  select(name, order, sleep_total) %>%
  arrange(-sleep_total) %>%
  View

msleep %>%
  filter(order %in% c("Carnivora", "Primates") &
           sleep_total > 8) %>%
  select(name, order, sleep_total) %>%
  arrange(order) %>%
  View()


#change observations (mutate)
msleep %>%
  mutate(brainwt = brainwt * 1000) %>%
  View

msleep %>%
  mutate(brainwt_in_grams = brainwt * 1000) %>%
  View()


#Conditional Changes (if_else)
## logical vector based on a condition

msleep$brainwt
msleep$brainwt > 0.01

size_of_brain <- msleep %>%
  select(name, brainwt) %>%
  drop_na(brainwt) %>%
  mutate(brain_size = if_else(brainwt > 0.01,
                              "large",
                              "small"))

size_of_brain


#recode data and rename a variable
##change observations of "large" and "small" into numerics

size_of_brain %>%
  mutate(brain_size = recode(brain_size,
                             "large" = 1,
                             "small" = 2))

# reshape the data from wide to long or long to wide
install.packages("gapminder")
library(gapminder)
View(gapminder)

data <- select(gapminder, country, year, lifeExp)

View(data)

wide_data <- data %>%
  pivot_wider(names_from = year, values_from = lifeExp)

View(wide_data)

long_data <- wide_data %>%
  pivot_longer(2:13,
               names_to = "year",
               values_to = "lifeExp")  #columns you want to work with

