library(dplyr)
library(leaflet)
library(ggplot2)
library(knitr)
library(jsonlite)
library(httr)

endangered_file <- read.csv("data/us_endangered_species.csv",
                        stringsAsFactors = FALSE)
#getting status counts and separating them by certain regions
tally_lead_region <- endangered_file %>%
  select(FWS.Lead.Region, FWS.Listing.Status) %>%
  group_by(FWS.Lead.Region) %>%
  count(FWS.Listing.Status) %>%
  filter(FWS.Listing.Status == "Endangered") %>%
  filter(FWS.Lead.Region == "Region 1" | FWS.Lead.Region == "Region 3" |
         FWS.Lead.Region == "Region 4" | FWS.Lead.Region == "Region 8")

#plotting information into column graph
regions_plot <- function(dataset) {
  ggplot(data = dataset) +
    geom_col(mapping = aes(x = dataset[["FWS.Lead.Region"]], y = n)) +
    labs(
      y = "Number of Endangered Species", x = "Region", title =
        "Endangered Species by Region"
    )
}