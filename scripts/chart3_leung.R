# chart 3; divide data into sub regions "WestCoast", "Midwest", and "EastCoast"
# find out number of threatened/endangered in each region
library(dplyr)
library(knitr)
library(ggplot2)
raw_endangered_df <- read.csv("data/us_endangered_species.csv", stringsAsFactors = FALSE)
#select only the columns needed for analysis
endangered_v2 <- raw_endangered_df %>%
  select(Species.Group, FWS.Lead.Region, FWS.Listing.Status) %>%
  rename(Species = Species.Group, Region = FWS.Lead.Region, Status = FWS.Listing.Status)

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

#TEST. NOT A FUNCTION. My plot; proof of concept 
plot_test <- ggplot(endangered_v4, 
      aes(x = Region, y = n)) +
  geom_point(size = 3) +
  geom_segment(aes(x = Region,
        xend = Region,
        y = 0,
        yend = n)) +
  labs(title = "# of Endangered & Threatened per U.S. Region",
       subtitle = "U.S. Region versus Amount Endangered/Threatened") +
  theme(axis.text.x = element_text(angle = 30, vjust = 0.7))

#FINAL. IS A FUNCTION. Make that into a function
plot_leung <- function(dataframe) {
  ggplot(dataframe, 
         aes(x = Region,
             y = n)) +
    geom_point(size = 3) +
    geom_segment(aes(x = dataframe$Region,
                     xend = dataframe$Region,
                     y = 0,
                     yend = dataframe$n)) +
    labs(title = "Number of Endangered & Threatened per U.S. Region",
         subtitle = "U.S. Region versus Amount Endangered/Threatened") +
    theme(axis.text.x = element_text(angle = 30, vjust = 0.7))
}
#test function w/ param
plot_leung(endangered_v4)
