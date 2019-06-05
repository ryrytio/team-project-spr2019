# Loads the needed packages
library(ggplot2)
library(dplyr)
library(shiny)
library(plotly)
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

# chart 3; divide data into sub regions "WestCoast", "Midwest", and "EastCoast"
# find out number of threatened/endangered in each region
raw_endangered_df <- read.csv("data/us_endangered_species.csv",
                              stringsAsFactors = FALSE)
#select only the columns needed for analysis
endangered_v2 <- raw_endangered_df %>%
  select(Species.Group, FWS.Lead.Region,
         FWS.Listing.Status) %>%
  rename(Species = Species.Group, Region = FWS.Lead.Region,
         Status = FWS.Listing.Status)

#convert regions to West Coast, Midwest, South and East Coast. Use only mainland U.S.,
# exclude Hawaii and Alaska
endangered_v2$Region[endangered_v2$Region == "Region 1"] <- "West Coast"
endangered_v2$Region[endangered_v2$Region == "Region 8"] <- "West Coast"

endangered_v2$Region[endangered_v2$Region == "Region 6"] <- "Midwest"
endangered_v2$Region[endangered_v2$Region == "Region 2"] <- "Midwest"
endangered_v2$Region[endangered_v2$Region == "Region 3"] <- "Midwest"

endangered_v2$Region[endangered_v2$Region == "Region 5"] <- "East Coast"

endangered_v2$Region[endangered_v2$Region == "Region 4"] <- "The South"

#selecting only these regions and their information
endangered_v3 <- endangered_v2 %>%
  filter(Region == "West Coast" | Region == "Midwest" | Region == "East Coast" |
           Region == "The South")

# calculate number of endangered/threatened by region. Use tally function
endangered_v4 <- endangered_v3 %>%
  group_by(Region) %>%
  tally()

#rename column to Count
endangered_v5 <- endangered_v4 %>%
  select(Region, n) %>%
  rename(Count = n)

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
  
  output$plot_leung <- renderPlot({
    p <- ggplot(endangered_v5,
                aes(x = Region,
                    y = Count)) +
      geom_point(size = 3) +
      geom_segment(aes(x = Region,
                       xend = Region,
                       y = 0,
                       yend = Count)) +
      labs(title = "# of Endangered & Threatened per U.S. Region",
           subtitle = "U.S. Region versus Amount Endangered/Threatened") +
      theme(axis.text.x = element_text(angle = 30, vjust = 0.7))
    p
  })
})