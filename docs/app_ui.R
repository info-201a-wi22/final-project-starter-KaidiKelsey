library(shiny)
library(ggplot2)
library(dplyr)
library(maps)
library(plotly)
library(utils)
library(tidyr)
library(htmlTable)
data <- read.table("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-KaidiKelsey/main/docs/WE0_data_cleaned.txt"
                   ,header = TRUE, stringsAsFactors = FALSE)
#data for chart1
data1 <- data %>%
  gather(key=year, value=value, X2000:X2021) %>%
  mutate(year=gsub("X", "", year),
         Year=as.integer(year)) %>%
  filter(Country == "United States")%>%
  filter(Subject.Descriptor %in% c("Population",
                                   "Unemployment",
                                   "Inflation, average consumer prices",
                                   "GDP U.S. Dollars"))%>%
  subset(Units != "Percent change")%>%
  na.exclude()%>%
  select(Subject.Descriptor,year, value)
select_values1 <- unique(data1$Subject.Descriptor)[-1]
#data for chart2
data2 <- data %>% gather(key=Year, value=value, X2000:X2021) %>%
  mutate(Year=gsub("X", "", Year), 
         Year=as.integer(Year)) %>% filter(Subject.Descriptor=="GDP U.S. Dollars") %>%
  na.omit()
countries <- unique(data2$Country)
countries <- countries[countries!="United States"]
#data for chart3
select_values <- unique(data$Subject.Descriptor)
select_values <- select_values[c(3,14,16,18,20,28)]
year_range <- range(as.numeric(sub("X","",colnames(data)[5:26])))

#chart1
chart1_content <- sidebarPanel(
  selectInput(inputId = "subject_desc",
              label = "Select a Comparison with GDP:",
              choices = select_values1,
              selected = "Population")
)
chart1_main_content <- mainPanel(
  plotlyOutput(outputId = "chart1"),
  p("These plots were created to compare the overall impact of population, 
    unemployment, inflation and end-of-period consumer prices on GDP in the US.
    The scatter plot regression data analysis provides a plot of the distribution
    of data points in the plane for population, unemployment, inflation and end-of-
    period consumer prices to determine the general trend of GDP with respect to 
    these independent variables.")
)
chart1_panel <- tabPanel(
  "Chart1",
  titlePanel("Interactive Visualization 1: Relationships with GDP"),
  sidebarLayout(
    
    # Display your `scatter_sidebar_content`
    chart1_content,
    
    # Display your `scatter_main_content`
    chart1_main_content
  )
  
)
#chart2
chart2_content <- sidebarPanel(
  sliderInput(inputId = "year",
              label = "Year:",
              min = min(data2$Year),
              max = max(data2$Year),
              step=1, 
              value = c(min(data2$Year), max(data2$Year))),
  selectInput("country", label="Country",
              choices=countries, selected = "China", multiple = T)
)
chart2_main_content <- mainPanel(
  plotlyOutput(outputId = "chart2"),
  p("It was created to compare the GDP trends for the three countries. Because line graphs show the trend of continuous average GDP data since the year of 2000 in Canada, Germany and the United States with an upward trend in overall GDP for different countries.")
)
chart2_panel <- tabPanel(
  "Chart2",
  titlePanel("Interactive Visualization 2: GDP Trends of Countries"),
  sidebarLayout(
    
    # Display your `scatter_sidebar_content`
    chart2_content,
    
    # Display your `scatter_main_content`
    chart2_main_content
  )
)
#chart3
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
  plotlyOutput(outputId = "chart3"),
  p("A choropleth map was created to show a comparison of the average GDP values for each country from 2000 to 2021. The different average GDP values are indicated by the shades of color. It is more intuitive to apply the map to analyze and present the average GDP data for each country around the world in relation to its geographical location.")
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
#introduction
intro_main_content <- mainPanel(
  htmlOutput(outputId = "intro")
)
intro_panel <- tabPanel(
  "Introduction",
  
  # Add a titlePanel to your tab
  titlePanel("Introduction"),
  
  intro_main_content,
  
  mainPanel(
    img(src = "GDP_image.png", height = 314, width = 600)
  )
)
#summary page
summary_main_content <- mainPanel(
  htmlOutput(outputId = "summary")
)
summary_panel <- tabPanel(
  "Summary",
  
  # Add a titlePanel to your tab
  titlePanel("Summary Takeaways"),
  
  summary_main_content
)
#report page
repo_main_content <- mainPanel(
  htmlOutput(outputId = "report")
)
repo_panel <- tabPanel(
  "Report",
  
  # Add a titlePanel to your tab
  titlePanel("Report"),
  
  repo_main_content
)
ui <- navbarPage(
  "GDP analysis and trends",
  intro_panel,
  chart1_panel,
  chart2_panel,
  chart3_panel,
  summary_panel,
  repo_panel
)

