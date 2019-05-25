# Summary Information

# Loads the needed packages
library(dplyr)
library(knitr)

# List will include the following pieces of informatiom
# 1. The total number of species that are endangered
# 2. The total number of species that are threatened
# 3. The percentage of species in the dataset that are endangered
# 4. The number of mammals documented as endangered or threatened
# 5. The percentage of endangered/threatened species that are mammals
# 6. The total number of regions in the US

# Makes a function that returns a list with summary information
summary_information <- function(dataset) {
  list <- list()
  endangered <- filter(dataset, FWS.Listing.Status == "Endangered") %>%
    nrow()
  total_rows <- nrow(dataset)
  threatened <- total_rows - endangered
  endangered_percentage <- (endangered / total_rows) * 100
  mammals <- filter(dataset, Species.Group == "Mammals") %>%
    nrow()
  mammals_percentage <- (mammals / total_rows) * 100
  total_regions <- dataset %>%
    group_by(dataset[["FWS.Lead.Region"]]) %>%
    tally() %>%
    nrow()
  list$endangered <- endangered
  list$threatened <- threatened
  list$endangered_percentage <- round(endangered_percentage, 2)
  list$mammals <- mammals
  list$mammal_percentage <- round(mammals_percentage, 2)
  list$regions <- total_regions
  return(list)
}