# Loads the needed packages
library(ggplot2)
library(dplyr)
library(shiny)

# Reads in the data
species_data <- read.csv("data/us_endangered_species.csv",
  stringsAsFactors = FALSE
)

# Filters the dataset to narrow down species groups and make 
# acres data more accessible
acre_data <- species_data %>%
  mutate(Acres = gsub("[^0-9]", "", Acres.and.Miles)) %>%
  mutate(Acres = as.double(Acres)) %>%
  filter(Acres != "", Species.Group %in% c(
    "Amphibians", "Crustaceans",
    "Insects", "Mammals", "Reptiles"
  ))

# Define server logic required to draw boxplot
shiny_server <- (function(input, output) {
  output$boxplot <- renderPlot({
    b <- ggplot(
      data = acre_data,
      mapping = aes_string(x = "Species.Group", y = "Acres")
    ) +
      geom_boxplot(fill = input$color, color = "turquoise4") +
      scale_y_continuous(limits = input$acres) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      ggtitle("Distribution of Acres of Critical Habitats For
              Different Species Groups") +
      xlab("Species Group") +
      ylab("Acres")

    b
  })
})
