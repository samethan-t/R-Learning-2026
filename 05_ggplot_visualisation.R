library(tidyverse)

install.packages("palmerpenguins")
library(palmerpenguins)
data()
penguins
view(penguins)

penguins %>%
  drop_na(sex) %>%
  filter(species %in% c("Adelie", "Gentoo", "Chinstrap")) %>%
  ggplot(aes(bill_depth_mm, bill_length_mm,
            color = species))+
  geom_point()+
  geom_smooth(method = lm, se = F)+
  facet_wrap(~island)+
  labs(title = "Does Bill Depth influence Bill Length",
       x = "Bill Depth",
       y = "Bill Length")+
  theme_bw()+
  #theme(panel.grid = element_blank())+ #remove lines in back
  theme(panel.grid.major = element_blank())

ggsave(
  "figures/bill_depth_vs_bill_length.png",
  width = 8,
  height = 6,
  dpi = 300
)


