chart1 <- function(data){
  #population
  new_data <- filter(data, Country == "United States",
                     Subject.Descriptor == c("Population","GDP Domestic Currency"))
  x <- new_data %>%
    filter(Subject.Descriptor == "Population") %>%
    select("X2000","X2001",	"X2002",	"X2003",	"X2004",
           "X2005","X2006",	"X2007",	"X2008",	"X2009",	"X2010",	"X2011",	"X2012","X2013","X2014",
           "X2015","X2016",	"X2017","X2018","X2019","X2020","X2021") %>%
    as.numeric()
  y <- new_data %>%
    filter(Subject.Descriptor == "GDP Domestic Currency") %>%
    select("X2000","X2001",	"X2002",	"X2003",	"X2004",
           "X2005","X2006",	"X2007",	"X2008",	"X2009",	"X2010",	"X2011",	"X2012","X2013","X2014",
           "X2015","X2016",	"X2017","X2018","X2019","X2020","X2021") %>%
    as.numeric()
  plot(x, y,xlab ="Population", ylab ="GDP",main="GDP vs Population") + 
    abline(lm(y ~ x), col = "blue", lwd = 2)
  print(cor.test(x,y))
  #unemployment rate
  new_data <- filter(data, Country == "United States",
                     Subject.Descriptor == c("Unemployment","GDP Domestic Currency"))
  x <- new_data %>%
    filter(Subject.Descriptor == "Unemployment") %>%
    select("X2000","X2001",	"X2002",	"X2003",	"X2004",
           "X2005","X2006",	"X2007",	"X2008",	"X2009",	"X2010",	"X2011",	"X2012","X2013","X2014",
           "X2015","X2016",	"X2017","X2018","X2019","X2020","X2021") %>%
    as.numeric()
  y <- new_data %>%
    filter(Subject.Descriptor == "GDP Domestic Currency") %>%
    select("X2000","X2001",	"X2002",	"X2003",	"X2004",
           "X2005","X2006",	"X2007",	"X2008",	"X2009",	"X2010",	"X2011",	"X2012","X2013","X2014",
           "X2015","X2016",	"X2017","X2018","X2019","X2020","X2021") %>%
    as.numeric()
  plot(x, y,xlab ="Unemployment rate", ylab ="GDP",main="GDP vs Unemployment rate") + 
    abline(lm(y ~ x), col = "blue", lwd = 2)
  print(cor.test(x,y))
  #inflation
  new_data <- filter(data, Country == "United States",
                     Subject.Descriptor == c("Inflation, average consumer prices","GDP Domestic Currency"))
  x <- new_data %>%
    filter(Subject.Descriptor == "Inflation, average consumer prices") %>%
    select("X2000","X2001",	"X2002",	"X2003",	"X2004",
           "X2005","X2006",	"X2007",	"X2008",	"X2009",	"X2010",	"X2011",	"X2012","X2013","X2014",
           "X2015","X2016",	"X2017","X2018","X2019","X2020","X2021") %>%
    as.numeric()
  y <- new_data %>%
    filter(Subject.Descriptor == "GDP Domestic Currency") %>%
    select("X2000","X2001",	"X2002",	"X2003",	"X2004",
           "X2005","X2006",	"X2007",	"X2008",	"X2009",	"X2010",	"X2011",	"X2012","X2013","X2014",
           "X2015","X2016",	"X2017","X2018","X2019","X2020","X2021") %>%
    as.numeric()
  plot(x, y,xlab ="Inflation, average consumer prices(%)", ylab ="GDP",main="GDP vs Inflation, average consumer prices") + 
    abline(lm(y ~ x), col = "blue", lwd = 2)
  print(cor.test(x,y))
  
}

