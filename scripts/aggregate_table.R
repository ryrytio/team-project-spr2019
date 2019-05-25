library(dplyr)
library(knitr)

endangered_animals <- read.csv("data/us_endangered_species.csv")
#creating summary table function
summary_table <- function(df) {
  aggr <- df %>%
    group_by(FWS.Lead.Region) %>%
    distinct(Common.Name) %>%
    summarize(num_species = n())
  aggr$FWS.Lead.Region <- c("Water (Any Region)", "Pacific", "Southwest",
                            "Midwest", "Southeast", "Northeast",
                            "Mountain-Prairie", "Alaska Region",
                            "Pacific Southwest")
  names(aggr) <- c("US Region", "Number of Endangered/Threatened Species")
  aggr
}