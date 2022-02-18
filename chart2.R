# Research Question: What are the comparative GDP trends for these three countries
#（China, Germany, United States）from 2000 to 2021?
library(ggplot2)


chart2 <- function(data){
  Country_data <- data %>%
    filter(Subject.Descriptor == "GDP U.S. Dollars") %>%
    select(Country, X2000:X2021)
  Country <- Country_data %>%
    filter(Country == "China"|Country == "Germany"|Country == "United States") 
  chart_data_china <- data.frame(year = c(2000:2021),GDP_Billion = as.numeric(Country[1,-1]))
  chart_data_german <- data.frame(year = c(2000:2021),GDP_Billion = as.numeric(Country[2,-1]))
  chart_data_us <- data.frame(year = c(2000:2021),GDP_Billion = as.numeric(Country[3,-1]))
  chart_data <- bind_rows(chart_data_china,chart_data_german,chart_data_us)
  chart_data$country <- c(rep("China",22),rep("Germany",22),rep("United States",22))
  chart_1 <- ggplot(chart_data, aes(x=year,y = GDP_Billion, col = country)) + 
    geom_line()
  print(chart_1)
}

