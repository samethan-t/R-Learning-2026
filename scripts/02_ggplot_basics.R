library(tidyverse)

data()
penguins

ggplot(data = penguins,
       mapping = aes(x = sex,
                     y = body_mass_g
                    )) +
  geom_point(size = 5)+
  geom_line(colour = "red")


ggplot(penguins, aes(sex, body_mass_g))+
  geom_point()+
  geom_line()

view(penguins)

penguins %>%
  ggplot(aes(species, body_mass_g,
             colour = island) +
  geom_point(size = 3, alpha = 0.5) +
  geom_smooth(method = lm, se = F) +
  labs(x = "Species of Penguin", y = "Body Mass (g)")
  #facet_wrap(~Type)


#other edits that you can make (i.e. amazing insects or research project)
aes(colour = treatment)
aes(fill = treatment)
aes(shape = sex)
alpha = 0.5
theme_classic()


penguins %>%
  #filter() can remove outliers by using variable >/< x %>%
  ggplot(aes(species, body_mass_g)) +
  geom_boxplot()+
  geom_point(alpha = 0.5,
             aes(size = bill_depth_mm,
                 colour = island))+
  facet_wrap(~sex, nrow = 1)+
  coord_flip()+
  theme_bw()+
  labs(x = "Penguin Species", y = "Body Mass (g)", title = "Body Mass variation in Penguins")


#






