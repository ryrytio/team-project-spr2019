# Loads the necessary package and sources the appropriate files
library(shiny)
source("team_ui.R")
source("team_server.R")

# Runs the application
shinyApp(ui = shinyUI, server = shiny_server)