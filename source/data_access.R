# Example: Project Data Access Functions  ----
#----------------------------------------------------------------------------#
# These functions are used to access data sources ... 
#----------------------------------------------------------------------------#
data_access_test <- function () {
  origin_data <- read.csv(file.path("../data", "WEOOct2021all.csv"))
  WE0_data <- select(origin_data, "Country","Subject.Descriptor",	"Units",
           "Scale","X2000","X2001",	"X2002",	"X2003",	"X2004",
           "X2005","X2006",	"X2007",	"X2008",	"X2009",	"X2010",	"X2011",	"X2012","X2013","X2014",
           "X2015","X2016",	"X2017","X2018","X2019","X2020","X2021") 
  #Remove empty rows
  WE0_data <- WE0_data[-which(WE0_data$X2000 == "" & WE0_data$X2001 == ""), ]
  #Replace values in the “Subject Descriptor” column with the shortened names provided above
  WE0_data$Subject.Descriptor[which(WE0_data$Subject.Descriptor == "Gross domestic product, current prices"&
                                      WE0_data$Units == "National currency")] = "GDP Domestic Currency"
  WE0_data$Subject.Descriptor[which(WE0_data$Subject.Descriptor == "Gross domestic product, current prices"&
                                      WE0_data$Units == "U.S. dollars")] = "GDP U.S. Dollars"
  WE0_data$Subject.Descriptor[which(WE0_data$Subject.Descriptor == "Gross domestic product per capita, current prices"&
                                      WE0_data$Units == "U.S. dollars")] = "GDP p.c. U.S. Dollars"
  WE0_data$Subject.Descriptor[which(WE0_data$Subject.Descriptor == "Gross domestic product per capita, current prices"&
                                      WE0_data$Units == "National currency")] = "GDP p.c. Domestic currency"
  WE0_data$Subject.Descriptor[which(WE0_data$Subject.Descriptor == "Inflation, end of period consumer 
                                prices")] = "Inflation"
  WE0_data$Subject.Descriptor[which(WE0_data$Subject.Descriptor == "Unemployment rate")] = "Unemployment"
  WE0_data$Subject.Descriptor[which(WE0_data$Subject.Descriptor == "Population")] = "Population"
  WE0_data$Subject.Descriptor[which(WE0_data$Subject.Descriptor == "Gross domestic product 
                                corresponding to fiscal year, current prices")] = "GDP FY U.S. Dollars"
  #Convert the “Country”column to be a factor
  WE0_data$Country <- as.factor(WE0_data$Country)
  #Ensure that the values in all columns associated with the years 2000 to 2021 are numeric or “NA”
  new <- vector()
  convert <- function(x){
    x <- gsub(",","",x)
    new <- as.numeric(x)
    return(new)
  }
  WE0_data[,(5:26)] <- lapply(WE0_data[,(5:26)], convert)
  write.table(WE0_data, file.path("../data","WE0_data_cleaned.txt"), sep = "\t")
  data <- read.table(file.path("../data","WE0_data_cleaned.txt"))
  return(data)
}
