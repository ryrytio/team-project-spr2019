# Loads the needed package
library(shiny)


# Define UI for application that draws scatterplots

# Creates first tab of application
tab_one <- tabPanel(
  "Overview",
  
  # Application title
  titlePanel("Project Overview"),
  
  p("Overview."),

  sidebarLayout(
    sidebarPanel(
    ),
    
    mainPanel(
    )
  )
  )

# Creates the second tab of application
tab_two <- tabPanel(
  "Chart One",
  titlePanel("Chart One"),
  p("Two.")
)

tab_three <- tabPanel(
  "Chart Two",
  titlePanel("Chart Two"),
  p("Three")
)

tab_four <- tabPanel(
  "Chart Three",
  titlePanel("Chart Three"),
  p("Four"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "acres",
        label = "Acres",
        min = 0, max = 14000,
        value = c(0, 12000)
      ),
      selectInput(
        "color",
        label = "Fill Color",
        choices = list("Turquoise" = "turquoise", "Black" = "black", "Yellow" = "yellow")
      )
    ),
    
    # Shows a plot of the generated scatterplot
    mainPanel(
      plotOutput("boxplot")
    )
  )
)

tab_five <- tabPanel(
  "Summary",
  titlePanel("Summary and Takeaways"),
  p("Five")
)

# Combines the tabs
shinyUI <- navbarPage(
  "Endangered Animals",
  tab_one,
  tab_two,
  tab_three,
  tab_four,
  tab_five
)