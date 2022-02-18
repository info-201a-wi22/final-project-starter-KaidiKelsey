library(dplyr)

chart3 <- function(data){
  map_data <- data %>% 
    filter(Subject.Descriptor == "GDP U.S. Dollars")%>%   
    group_by(Country)%>%      #Group the data by country
    select(Country, X2000:X2021)%>%  #Keep only the numeric data from year of 2000 to 2021
    rowwise() %>%
    mutate(Average_GDP =  mean(c(X2000,X2001,X2002, X2003, X2004,
                                 X2005,X2006, X2007,X2008, X2009, X2010, X2011, X2012,X2013,X2014,
                                 X2015,X2016, X2017,X2018,X2019,X2020, X2021), na.rm=TRUE)) %>%
    select(Country, Average_GDP)
  world <- map_data("world")
  names(world)[names(world) == "region"] <- "Country"
  world$Country[which(world$Country == "USA")] = "United States"
  world <- left_join(world, map_data, by = "Country")
  map <- ggplot(world, aes(x = long, y = lat, group = group)) + 
    geom_polygon(aes(fill = Average_GDP),color = "black")
  print(map)
}
