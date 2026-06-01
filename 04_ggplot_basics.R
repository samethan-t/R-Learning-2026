library(tidyverse)
msleep
view(msleep)
names(msleep)

#two or more numerics (on from hist)
msleep %>%
  filter(bodywt < 2) %>%
  ggplot(aes(x = bodywt,
             y = brainwt)) +
  geom_point(aes(color = sleep_total,
                 size = awake))+
  geom_smooth(method = lm,
              se = F)+
  labs(x = "Body Weight",
       y = "Brain Weight",
       title = "Brain and Body Weight")+
  theme_minimal()


#Line Graph (2 numeric and 1 categorical)
view(Orange)

Orange %>%
  filter(Tree != "2") %>%
  ggplot(aes(age, circumference))+
  geom_point()+
  geom_smooth()+
  facet_wrap(~Tree)+
  theme_bw()+
  labs(title = "Tree age and circumference")

Orange %>%
  filter(Tree != "1" &
         Tree != "2") %>%
  ggplot(aes(age, circumference, color = Tree))+
  geom_point(size = 3, alpha = 0.5)+
  #geom_line(size = 0.8)+ #joins lines
  #geom_smooth(method = lm,
              se = F)+
  theme_minimal()+
  labs(title = "Tree age and circumference")








