library(tidyverse)
library(palmerpenguins)

glimpse(penguins)
summary(penguins)

ggplot(
  penguins,
  aes(
    x = bill_length_mm,
    y = body_mass_g,
    colour = species
  )
) +
  geom_point(size = 3)
