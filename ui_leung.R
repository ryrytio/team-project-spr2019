#ui.R - Ryan's portion
source("../scripts/chart3_leung.R")
library(shiny)
library(ggplot2)

shinyUI(navbarPage(
  "Endandgered/Threatened Species by Region",
  tabPanel(
    "Counts by Region",
    sidebarPanel(
      selectInput(
        "Region",
        label = "Select a Region",
        choices = list(
          "East Coast",
          "Midwest",
          "The South",
          "West Coast"
        )
      ),
  mainPanel(
    plotOutput("p_leung"))  
    ))))