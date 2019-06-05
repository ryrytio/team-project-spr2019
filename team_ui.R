# Loads the needed package
library(shiny)

# Define UI for application

# Creates first tab of application
tab_one <- tabPanel(
  "Overview",

  # Application title
  h1("An Investigation of Endangered Species"),
  h5(em("By Ana De Las Alas, Samuel Lee, Ryan Leung and Joshua
        Lansing")),

  # Adds an image
  img(
    src =
      "https://dingo.care2.com/pictures/causes/3228/3227343.large.jpg",
    width = 800, height = 500
  ),

  # Adds paragraph with overview information
  p(
    "In our project, we explore a dataset on endangered species in the U.S.
    We found the dataset from the", a("Environmental Conservation Online
    System", href = "https://ecos.fws.gov/ecp/report/table/critical-habitat.
    html?fbclid=IwAR34iloupBtcBAHfH7t8uU0WqRWJyGDKggJShn-J1mSbNVl_Zf_7qYP8kFI"),
    ". The dataset provides information on a particular species' scientific
    name, species group, region of habitation and critical habitat type. With
    this dataset, we hope to answer which region of the U.S. contains the
    most endangered and threatened species, which region contains the most
    endangered plant species, and which species type has the greatest
    number of acres for its critical habitat. To answer the first two
    questions, we will focus on the columns 'regions' and 'listing status.
    In this dataset, the U.S. Fish and Wildlife Service divides the U.S.
    into eight regions and uses these eight regions to categorize the
    species' habitat locations. For the last question, we will look
    into the columns 'species group' and 'acres and miles' to compare
    areas for critical habitats. This project is important because
    we can identify which parts of the U.S. are more densely populated
    with endangered or threatened species and work to preserve the
    critical habitats that exist in those areas."
  ),

  # Adds an image
  img(src = "https://www.fws.gov/where/NWRS05dotmapR9-140pixelB.jpg",
    width = 800, height = 575
  ),
  p("The photo above displays how the U.S. Fish and Wildlife Service
      divided the country into eight regions to help identify the
      location of different species' habitats.")
)

# Creates the second tab of application
tab_two <- tabPanel(
  "Chart One",
  titlePanel("Number of Endangered/Threatened in Major U.S. Regions"),
  p("The number of endangered and threatened species within each major
    U.S. region is shown in this visualization. From the chart, it
    can be seen that the West Coast has the most number of endangered
    and threatened, whereas the East Coast has the least."),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "pointcolor",
        label = "Color",
        choices = list(
          "Red" = "red",
          "Black" = "black", "Blue" = "blue"
        ),
        selected = "red"
      ),
      sliderInput(
        "size",
        label = "Point Size", min = 1, max = 5, value = 3
      ),
      sliderInput(
        inputId = "count",
        label = "Count Parameters",
        min = 0, max = 700,
        value = c(0, 600)
      )
    ),

    # Shows a plot of the generated lollipop graph
    mainPanel(
      plotOutput("plot_lollipop")
    )
  )
)

# Creates the third tab of application
tab_three <- tabPanel(
  "Chart Two",
  titlePanel("Looking into Endangered Species Count per Region "),
  p("This bar graph shows the number of endangered species in each
    FWS region of the U.S. FWS Regions are the eight regions that
    the Fish and Wildlife Service uses to identify where species
    live. The visualization tells us that Region 1 hosts the
    greatest number of endangered species."),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "barcolor",
        label = "Color",
        choices = list(
          "Gray" = "gray",
          "Black" = "black", "Orange" = "orange"
        ),
        selected = "orange"
      ),
      sliderInput(
        inputId = "yaxis",
        label = "Y Axis Parameters",
        min = 0, max = 600,
        value = c(0, 500)
      )
    ),

    # Shows a plot of the generated bar graph
    mainPanel(
      plotOutput("bargraph")
    )
  )
)

# Creates the fourth tab of application
tab_four <- tabPanel(
  "Chart Three",
  titlePanel("Comparing Acres of Critical Habitats"),
  p("A critical habitat is a geographic area containing resources that
    are crucial to preserve endangered and threatened species. With this
    chart, we can compare the areas of critical habitats belonging
    to different species groups, where the area is measured by acres. This
    visualization helps us investigate which species group has the highest
    average of critical habitat area. The widgets on the left allow users to
    change the parameters of the y-axis to alter the data being shown on
    the boxplot. The other widget changes the color of the boxes."),
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
        choices = list(
          "Turquoise" = "turquoise",
          "Black" = "black", "Yellow" = "yellow"
        )
      )
    ),

    # Shows a plot of the generated boxplot
    mainPanel(
      plotOutput("boxplot")
    )
  )
)

# Creates the fifth tab of application
tab_five <- tabPanel(
  "Summary",
  titlePanel("Summary and Takeaways"),
  img(
    src =
      "https://dbw4iivs1kce3.cloudfront.net/680x/2017/11/timflach9-11-2017.jpg"
  ),
  h4("Chart One: Lollipop Graph"),
  p("As mentioned earlier, the lollipop graph showed that the West Coast
    had the least number of endangered and threatened species. In contrast,
    the East Coast had the most endangered and threatened species. It's good
    to observe these distributions so that policy makers and stakeholders
    pertaining to animal protections can allocate their efforts in areas
    that need more help. It is also good to note that endangered species also
    encompasses plant species as well because those organisms are also equally
    important to the ecosystem."),

  h4("Chart Two: Bar Graph"),
  p("Sam's chart takeaways."),

  h4("Chart Three: Boxplot"),
  p("From the boxplot, we found that when the maximum number of acres
    displayed on the chart was 5,000 acres or more, mammals always
    seemed to have the highest mean. This means that on average,
    the critical habitats of mammals are larger in area than the
    habitats of other species groups. This may be because
    mammals overall are significantly larger in size than the
    animals in other species groups, such as insects or
    amphibians. We also noticed how the whiskers of the box for
    mammals typically were longer than the whiskers of other boxes.
    This indicates that the interquartile range for mammals'
    critical habitat area is much larger than that for other species
    groups. We can infer that critical habitats for mammals that
    exist in the U.S. are more diverse in size, and can either be
    substantially small or large.")
)

# Combines the tabs
shinyUI <- navbarPage(
  "Endangered Species",
  tab_one,
  tab_two,
  tab_three,
  tab_four,
  tab_five,
  includeCSS("style.css")
)
