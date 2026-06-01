#DESCRIBING

#range/spread
#centrality
#variance
#summarising data
#create tables


library(tidyverse)
data()
View(msleep)

#have a quick look
glimpse(msleep)


#describe the spread, centrality and variance
min(msleep$awake)
max(msleep$awake)
range(msleep$awake)
IQR(msleep$awake)
mean(msleep$awake)
median(msleep$awake)
var(msleep$awake)

#summarise selected variables
summary(msleep)
summary(msleep$sleep_total)

msleep %>%
  select(sleep_total, brainwt) %>%
  summary()

# create a summary table
## for each category of "vore"
### show the min, Max, difference
#### and arrange data by average

msleep %>%
  drop_na(vore) %>%
  group_by(vore) %>%
  summarise(Lower = min(sleep_total),
            Average = mean(sleep_total),
            Upper = max(sleep_total),
            Difference =
              max(sleep_total)-min(sleep_total)) %>%
arrange(Average) %>%
  View()


#Creating contingency tables
library(MASS)
attach(Cars93)

glimpse(Cars93)

table(Origin)
table(AirBags, Origin)
addmargins(table(AirBags, Origin), 1)

table(AirBags, Origin)
prop.table(table(AirBags, Origin), 2)* 100
round(prop.table(table(AirBags, Origin), 2))

Cars93 %>%
  group_by(Origin, AirBags) %>%
  summarise(number = n()) %>%
  pivot_wider(names_from = Origin,
              values_from = number)



