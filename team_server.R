# Loads the needed packages
library(ggplot2)
library(dplyr)

# Reads in the data
species_data <- read.csv("data/us_endangered_species.csv",
  stringsAsFactors = FALSE
)

# Chart 3: Filters the dataset to narrow down species groups and make
# acres data more accessible
acre_data <- species_data %>%
  mutate(Acres = gsub("[^0-9]", "", Acres.and.Miles)) %>%
  mutate(Acres = as.double(Acres)) %>%
  filter(Acres != "", Species.Group %in% c(
    "Amphibians", "Crustaceans",
    "Insects", "Mammals", "Reptiles"
  ))

# Chart 2: Gets status counts and separates them by certain regions
tally_lead_region <- species_data %>%
  select(FWS.Lead.Region, FWS.Listing.Status) %>%
  group_by(FWS.Lead.Region) %>%
  count(FWS.Listing.Status) %>%
  filter(FWS.Listing.Status == "Endangered") %>%
  filter(FWS.Lead.Region != "NOAA")

# Chart 1: divides data into sub regions "WestCoast", "Midwest", and "EastCoast"
# and finds out number of threatened/endangered in each region
# Selects only the columns needed for analysis
endangered_v2 <- species_data %>%
  select(
    Species.Group, FWS.Lead.Region,
    FWS.Listing.Status
  ) %>%
  rename(
    Species = Species.Group, Region = FWS.Lead.Region,
    Status = FWS.Listing.Status
  )

# Convert regions to West Coast, Midwest, South and East Coast. Use only mainland U.S.,
# Exclude Hawaii and Alaska
endangered_v2$Region[endangered_v2$Region == "Region 1"] <- "West Coast"
endangered_v2$Region[endangered_v2$Region == "Region 8"] <- "West Coast"

endangered_v2$Region[endangered_v2$Region == "Region 6"] <- "Midwest"
endangered_v2$Region[endangered_v2$Region == "Region 2"] <- "Midwest"
endangered_v2$Region[endangered_v2$Region == "Region 3"] <- "Midwest"

endangered_v2$Region[endangered_v2$Region == "Region 5"] <- "East Coast"

endangered_v2$Region[endangered_v2$Region == "Region 4"] <- "The South"

# Selects only these regions and their information
endangered_v3 <- endangered_v2 %>%
  filter(Region == "West Coast" | Region == "Midwest" | Region == "East Coast" |
    Region == "The South")

# Calculate number of endangered/threatened by region. Use tally function
endangered_v4 <- endangered_v3 %>%
  group_by(Region) %>%
  tally()

# Renames column to Count
endangered_v5 <- endangered_v4 %>%
  select(Region, n) %>%
  rename(Count = n)


# Define server logic required to draw charts
shiny_server <- (function(input, output) {

  # Renders boxplot
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

  # Renders bar graph
  output$bargraph <- renderPlot({
    g <- ggplot(
      data = tally_lead_region,
      mapping = aes(x = FWS.Lead.Region, y = n)
    ) +
      geom_col(fill = input$barcolor, color = "black") +
      labs(
        x = "FWS Region", y = "Number of Endangered Species", title =
          "Endangered Species by FWS Defined Regions"
      ) +
      scale_y_continuous(limits = input$yaxis)
    g
  })

  # Renders lollipop graph
  output$plot_lollipop <- renderPlot({
    p <- ggplot(
      endangered_v5,
      aes(
        x = Region,
        y = Count
      )
    ) +
      geom_point(size = input$size, color = input$pointcolor) +
      geom_segment(aes(
        x = Region,
        xend = Region,
        y = 0,
        yend = Count
      )) +
      labs(
        title = "Number of Endangered & Threatened Species
           per U.S. Region",
        subtitle = "U.S. Region versus Amount of Endangered/Threatened
           Species"
      ) +
      theme(axis.text.x = element_text(angle = 30, vjust = 0.7)) +
      scale_y_continuous(limits = input$count)
    p
  })
})
