# Load libraries
library(tidyverse)
library(janitor)

# Set seed for reproducibility
set.seed(42)

# Generate messy raw data
raw_data <- tibble(
  `Insect ID` = 1:120,
  `Species Type` = rep(c("Species_A", "Species_B"), each = 60),
  `Life-Stage` = rep(rep(c("Larva", "Pupa", "Adult"), each = 20), 2),
  `Treatment Group` = rep(rep(c("Control", "Heat Acclimated"), each = 10), 6),
  # Simulated CTmax values with some missing data and typos
  `CTmax Trial 1` = round(c(rnorm(60, mean = 38, sd = 1.5), rnorm(60, mean = 41, sd = 1.2)), 1),
  `CTmax Trial 2` = round(c(rnorm(60, mean = 38.5, sd = 1.4), rnorm(60, mean = 41.2, sd = 1.1)), 1)
)

# Inject messiness: missing data and inconsistent casing
raw_data$`CTmax Trial 1`[c(15, 42, 88)] <- NA
raw_data$`Life-Stage`[c(5, 25)] <- "larva" # lowercase typo
raw_data$`Treatment Group`[c(12, 72)] <- "control" # lowercase typo

print(head(raw_data))


######### START ANALYSIS ##########
dim(raw_data)
glimpse(raw_data)
summary(raw_data)
names(raw_data)

unique(raw_data$`Species Type`)
unique(raw_data$`Life-Stage`)
unique(raw_data$`Treatment Group`)
unique(raw_data$`CTmax Trial 1`)
unique(raw_data$`CTmax Trial 2`)

colSums(is.na(raw_data))

raw_data <- raw_data %>%
  mutate(
    `Life-Stage` = str_to_title(`Life-Stage`),
    `Treatment Group` = str_to_title(`Treatment Group`)
  )

clean_data <- raw_data %>%
  drop_na(`CTmax Trial 1`)


table(clean_data$`Life-Stage`)

clean_data %>%
  count(`Life-Stage`)

clean_data %>%
  count(`Treatment Group`)

clean_data %>%
  group_by(`Species Type`) %>%
  summarise(
    mean_CTmax = mean(`CTmax Trial 1`)
  )



clean_data %>%
  ggplot(aes(`Species Type`, `CTmax Trial 1`,
             colour = `Treatment Group`))+
  geom_jitter()+
  facet_wrap(~`Life-Stage`)+
  labs(title = "Does CTmax differ between species",
       x = "Species",
       y = "CTmax Treatment 1")+
  theme_bw()+
  #theme(panel.grid = element_blank())+ #remove lines in back
  theme(panel.grid.major = element_blank())

clean_data %>%
  group_by(`Species Type`) %>%
  summarise(
    mean_CTmax = mean(`CTmax Trial 1`, na.rm = TRUE),
    sd_CTmax = sd(`CTmax Trial 1`, na.rm = TRUE),
    n = n()
  )


t.test(
  `CTmax Trial 1` ~ `Species Type`,
  data = clean_data
)

aov(
  `CTmax Trial 1` ~ `Species Type`,
  data = clean_data
)

summary(clean_data)




clean_data %>%
  ggplot(
    aes(`CTmax Trial 1`,
        `CTmax Trial 2`)
  ) +
  geom_point() +
  geom_smooth(method = "lm")
