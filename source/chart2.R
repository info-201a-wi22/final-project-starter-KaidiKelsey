# Research Question: What are the comparative GDP trends for these three countries
#（Canada, Germany, United States）from 2000 to 2020?


chart2 <- function(data){
  Country_data <- data %>%
    filter(Subject.Descriptor == "GDP U.S. Dollars") %>%
    select(Country, X2000:X2021)
  Country <- Country_data %>%
    filter(Country == "Canada"|Country == "Germany"|Country == "United States") 
  chart_data <- data.frame(year = c(2000:2021),Canada_GDP = as.numeric(Country[1,-1]),
                           Germany_GDP = as.numeric(Country[2,-1]), US_GDP = as.numeric(Country[3,-1]))
  chart_1 <- ggplot(chart_data, aes(x=year)) + 
    geom_line(aes(y = Canada_GDP), color = "darkred") + 
    ggtitle("The trend of GDP in Canada from 2000 to 2021")
  print(chart_1)
  chart_2 <- ggplot(chart_data, aes(x=year)) + 
    geom_line(aes(y = Germany_GDP), color="darkred") + 
    ggtitle("The trend of GDP in Germany from 2000 to 2021")
  print(chart_2)
  chart_3 <- ggplot(chart_data, aes(x=year)) + 
    geom_line(aes(y = US_GDP), color="darkred")+ 
    ggtitle("The trend of GDP in United States from 2000 to 2021")
  print(chart_3)
}

