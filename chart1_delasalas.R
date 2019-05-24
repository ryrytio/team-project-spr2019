# Chart 1

# Loads the necessary packages
library(ggplot2)
library(dplyr)
library(knitr)

# Reads in the data
species_data <- read.csv("data/us_endangered_species.csv",
                         stringsAsFactors = FALSE)

# Filters the dataset to narrow down species groups and make acres data more accessible
acre_data <- species_data %>%
  mutate(Acres = gsub("[^0-9]", "", Acres.and.Miles)) %>%
  mutate(Acres = as.double(Acres)) %>%
  filter(Acres != "", Species.Group %in% c("Amphibians", "Crustaceans",
                                           "Insects", "Mammals", "Reptiles"))

# Makes a function that returns a boxplot
boxplot <- function(dataset) {
  plot <- ggplot(dataset, aes(x = dataset[["Species.Group"]],
                              y = dataset[["Acres"]])) +
    geom_boxplot(fill = "turquoise", color = "turquoise4") +
    scale_y_continuous(limits = c(0, 12000)) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    ggtitle("Distribution of Acres of Critical Habitats For
            Different Species Groups") +
    xlab("Species Group") +
    ylab("Acres")
  return(plot)
}
