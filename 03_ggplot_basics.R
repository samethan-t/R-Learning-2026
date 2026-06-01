library(tidyverse)
data()
mpg
?mpg
names(mpg)

mpg %>%
  filter(hwy < 35) %>%
  ggplot(aes(x = displ,
             y = hwy,
             colour = drv)) +
  geom_point()+
  geom_smooth(method = lm,
              se = F) +
  labs(x = "Engine Size",
       y = "MPG on the Highway",
       title = "Fuel Efficiency")+
  theme_minimal()

#ggsave("name.jpg") will save an image



#Single Categorical Data (Box)
msleep
view(msleep)
names(msleep)

msleep %>%
  drop_na(vore) %>%  #will exclude any data that isn't N/A in Vore
  ggplot(aes(x = vore))+
  geom_bar(fill = "#57A3C6")+
  coord_flip()+ #neater for larger datasets
  theme_bw()+
  labs(x = "Vore",
       y = NULL,
       title = "Number of Observations per Order")

#use fct_infreq(vore) to create order (reorders based on size)

#Single Numeric (Hist)
msleep %>%
  ggplot(aes(awake))+
  geom_histogram(binwidth = 2, fill = "#57A3C6")+ #binwidth bands counts together
  theme_bw()+
  labs(x = "Total Sleep",
       y = NULL,
       title = "Histogram of Total Sleep")





