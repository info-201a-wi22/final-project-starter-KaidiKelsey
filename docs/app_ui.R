library(shiny)
library(ggplot2)
library(dplyr)
library(maps)
library(plotly)
library(utils)
data <- read.table("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-KaidiKelsey/main/docs/WE0_data_cleaned.txt"
                   ,header = TRUE, stringsAsFactors = FALSE)
select_values <- unique(data$Subject.Descriptor)
select_values <- select_values[c(3,14,16,18,20,28)]
year_range <- range(as.numeric(sub("X","",colnames(data)[5:26])))
chart3_content <- sidebarPanel(
  subject_input <- selectInput(
    inputId = "subject_input",
    label = "Select the Subject You Want to Make a MAP",
    choices = select_values,
    selected = "GDP U.S. Dollars"
  ),
  year_input <- sliderInput(
    inputId = "year_input",
    label = "Select the Year Range",
    min = year_range[1],
    max = year_range[2],
    value = year_range
  )
)
chart3_main_content <- mainPanel(
  plotlyOutput(outputId = "chart3")
)
chart3_panel <- tabPanel(
  "Chart3",
  
  # Add a titlePanel to your tab
  titlePanel("Interactive Visualization 3: Global Distribution Map"),
  
  # Create a sidebar layout for this tab (page)
  sidebarLayout(
    
    # Display your `scatter_sidebar_content`
    chart3_content,
    
    # Display your `scatter_main_content`
    chart3_main_content
  )
)
intro_main_content <- mainPanel(
  htmlOutput(outputId = "intro")
)
intro_panel <- tabPanel(
  "Introduction",
  
  # Add a titlePanel to your tab
  titlePanel("Introduction"),
  
  # Create a sidebar layout for this tab (page)
  intro_main_content
)
ui <- navbarPage(
  "GDP",
  intro_panel,
  chart3_panel
)

