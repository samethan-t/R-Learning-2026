[1. Project Setup & Paths] ──► [2. Import] ──► [3. Explore] ──► [4. Clean] ──► [5. Transform]

[9. File Export] ◄── [8. Reporting] ◄── [7. Analyze] ◄── [6. Visualize] ◄──┘

#################################################
# MASTER ECOLOGY WORKFLOW
#################################################

# Load packages
library(tidyverse)
library(janitor)
library(performance)
library(see)

#################################################
# 1. IMPORT DATA
#################################################

data <- raw_data

# OR

# data <- read_csv("datasets/my_data.csv")

#################################################
# 2. EXPLORE DATA
#################################################

dim(data)
glimpse(data)
summary(data)
names(data)
head(data)
tail(data)

# Check variable types

class(data$Species)

# Check categories

unique(data$Species)

# Missing values

colSums(is.na(data))

#################################################
# 3. CLEAN DATA
#################################################

clean_data <- data %>%
  mutate(
    Life_Stage = str_to_title(Life_Stage),
    Treatment = str_to_title(Treatment)
  ) %>%
  drop_na()

# Check cleaning worked

unique(clean_data$Life_Stage)
unique(clean_data$Treatment)

# Quick sanity check for outliers or entry errors
if(max(data$CTmax_Trial_1, na.rm = TRUE) > 60) {
  warning("Extreme temperature outlier detected! Check raw data entries.")
}

#################################################
# 4. MANIPULATE DATA
#################################################

clean_data <- clean_data %>%
  mutate(
    CTmax_Mean =
      (CTmax_Trial_1 +
         CTmax_Trial_2) / 2,

    CTmax_Change =
      CTmax_Trial_2 -
      CTmax_Trial_1
  )

#################################################
# 5. DESCRIBE DATA
#################################################

summary(clean_data$CTmax_Mean)
mean(clean_data$CTmax_Mean)
median(clean_data$CTmax_Mean)
sd(clean_data$CTmax_Mean)
range(clean_data$CTmax_Mean)

# Counts

clean_data %>%
  count(Species)

clean_data %>%
  count(Treatment)

#################################################
# 6. SUMMARISE DATA
#################################################

summary_table <- clean_data %>%
  group_by(Species, Treatment, Life_Stage) %>%
  summarise(
    Mean = mean(CTmax_Mean, na.rm = TRUE), # na.rm = TRUE prevents code breaks if NAs slip through
    SD = sd(CTmax_Mean, na.rm = TRUE),
    N = n(),
    SE = SD / sqrt(N),
    .groups = "drop" # Always drop groupings to prevent weird downstream errors
  )

summary_table

#################################################
# 7. VISUALISE DATA
#################################################

# Run this right before plotting to fix alphabetical ordering
clean_data <- clean_data %>%
  mutate(Life_Stage = factor(Life_Stage, levels = c("Larva", "Pupa", "Adult")))

plot1 <- clean_data %>%
  ggplot(aes(x = Life_Stage, y = CTmax_Mean, fill = Treatment)) +
  # Using a boxplot with outlier.shape = NA so points don't double-plot
  geom_boxplot(outlier.shape = NA, alpha = 0.7, position = position_dodge(0.8)) +
  # Overlay individual data points beautifully
  geom_point(aes(colour = Treatment), position = position_jitterdodge(jitter.width = 0.1, dodge.width = 0.8), alpha = 0.5) +
  facet_wrap(~Species) +
  labs(
    title = "Critical Thermal Maximum Across Developmental Stages",
    x = "Life Stage",
    y = expression("Mean " * CT[max] * " (°C)"), # Formats CTmax with subscripts and degree symbols natively
    fill = "Treatment Group",
    colour = "Treatment Group"
  ) +
  theme_classic(base_size = 13) + # theme_classic is the gold standard for Nature/Ecology journals
  scale_fill_viridis_d(option = "viridis", end = 0.8) +
  scale_colour_viridis_d(option = "viridis", end = 0.8) +
  theme(
    strip.background = element_blank(), # Removes unnecessary boxes around facet titles
    strip.text = element_text(face = "bold"),
    legend.position = "bottom"

plot1

#################################################
# 8. ANALYSE DATA
#################################################

# t-test

t.test(
  CTmax_Mean ~ Species,
  data = clean_data
)

# ANOVA

model <- aov(
  CTmax_Mean ~ Species +
    Treatment +
    Life_Stage,
  data = clean_data
)

# Interaction ANOVA
model <- aov(CTmax_Mean ~ Species * Treatment * Life_Stage, data = clean_data)
summary(model)

# Post-Hoc Testing (Essential if your ANOVA p-value is < 0.05)
# This tells you exactly WHICH groups are significantly different from each other
TukeyHSD(model)

summary(model)

# Fit your linear model or ANOVA
insect_model <- lm(CTmax_Mean ~ Species * Treatment * Life_Stage, data = clean_data)

#################################################
# 8.5 MODEL DIAGNOSTICS (Assumptions Check)
#################################################

# Scenario A: Check everything visually at once using ggplot-based output
# This creates a composite grid containing:
# - Posterior predictive check
# - Homogeneity of Variance (Residuals vs Fitted)
# - Normality of Residuals (QQ-Plot)
# - Normality of Residuals (Histogram)

diagnostics_plot <- check_model(insect_model)
plot(diagnostics_plot) # Displays a beautiful 4-panel diagnostic grid

# Scenario B: Quick formal statistical tests for your manuscript text
check_normality(insect_model)   # Tests if residuals are normally distributed (Shapiro-Wilk)
check_heteroscedasticity(insect_model) # Tests for equal variance (Breusch-Pagan / Levene's)

#################################################
# 9. SAVE OUTPUTS
#################################################

ggsave(
  "figures/ctmax_plot.png",
  plot = plot1,
  width = 8,
  height = 6,
  dpi = 300
)

write_csv(
  summary_table,
  "output/summary_table.csv"
)

#################################################
# 10. BIOLOGICAL INTERPRETATION
#################################################

# Question:
# Does CTmax differ between species?

# Result:
# Species_B had higher mean CTmax

# Statistics:
# p-value = ?

# Conclusion:
# Species_B appears more thermally tolerant
