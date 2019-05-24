library(dplyr)
library(leaflet)
library(ggplot2)
library(knitr)
library(jsonlite)
library(httr)

endangered_file <- read.csv("data/us_endangered_species.csv",
                        stringsAsFactors = FALSE)

tally_lead_region <- endangered_file %>% 
  select(FWS.Lead.Region, FWS.Listing.Status) %>%
  group_by(FWS.Lead.Region) %>% 
  count(FWS.Listing.Status) %>% 
  filter(FWS.Listing.Status == "Endangered") %>% 
  filter(FWS.Lead.Region == "Region 1" | FWS.Lead.Region == "Region 3"|
         FWS.Lead.Region == "Region 4" | FWS.Lead.Region == "Region 8")

region_plot <- function(tally_lead_region) {
  ggplot(data = tally_lead_region) +
  geom_col(mapping = aes(x = FWS.Lead.Region, y = n)) +
  labs(
    y = "# of Endangered Species", x = "Region", title =
      "Endangered Species by Region"
  )
}