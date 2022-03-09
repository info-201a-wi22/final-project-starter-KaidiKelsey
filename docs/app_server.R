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

server <- function(input, output,session) {
  output$chart1 <- renderPlotly({
    
    GDP <- data1%>%filter(Subject.Descriptor == "GDP U.S. Dollars")%>%
      select(value)
    
    y_value <- data1 %>% filter(Subject.Descriptor == input$subject_desc)
    plot_data <- cbind(GDP,y_value)
    colnames(plot_data) <- c("GDP", "Subject.Descriptor","year","y_value")
    p <- ggplot(plot_data, aes(x=y_value, y=GDP),col = "black") + geom_point() +
      labs(x = input$subject_desc, y = "GDP U.S  Dollars(Billions)", title = "GDP Comparison Chart") +
      geom_smooth(method=lm,se=FALSE)
    ggplotly(p)
  })
  output$chart2 <- renderPlotly({
    df <-data2 %>% filter(Year>=input$year[1], Year<=input$year[2]) %>%
      filter(Country %in% c(input$country))
    if(nrow(df)>=1){
      p <- ggplot(df, aes(x=Year, y=value, color=Country)) +
        geom_line() + 
        labs(y="GDP U.S  Dollars(Billions)",
             title=paste("Trend of GDP in", input$country, "from",
                         input$year[1],"to",input$year[2]))
      ggplotly(p)
    }
  })
  output$chart3 <- renderPlotly({
    year_range <- seq(input$year_input[1],input$year_input[2])
    year_range <- paste("X", year_range, sep = "")
    map_data <- data %>% 
      filter(Subject.Descriptor == input$subject_input)%>%   
      group_by(Country)%>%      #Group the data by country
      select(Country, year_range)%>%  #Keep only the numeric data from year of 2000 to 2021
      rowwise()
    map_data$Average <- rowMeans(map_data[,-1],na.rm = FALSE)
    world <- map_data("world")
    names(world)[names(world) == "region"] <- "Country"
    world$Country[which(world$Country == "USA")] = "United States"
    world <- left_join(world, map_data, by = "Country")
    map <- ggplot(world, aes(x = long, y = lat, group = group)) + 
      geom_polygon(aes(fill =Average),color = NA) +
      scale_fill_continuous(name = "Average") + 
      labs(title = paste("Average",input$subject_input, "around the world"))
    ggplotly(map)
  })
  output$summary <- renderUI({
    table <- data %>% 
      filter(Subject.Descriptor == "GDP U.S. Dollars", Scale == "Billions")%>%   #Extract on the GDP data for each country
      group_by(Country)%>%      #Group the data by country
      select(Country, X2000:X2021)%>%  #Keep only the numeric data from year of 2000 to 2021
      rowwise() %>%
      mutate( Average_GDP =  mean(c(X2000,X2001,X2002,X2003,X2004,X2005,X2006,X2007,X2008,X2009,X2010,X2011,X2012,X2013,X2014,X2015,X2016,X2017,X2018,X2019,X2020, X2021), na.rm=TRUE)) %>%
      select(Country, Average_GDP) #select on the Country and Average_GDP column
    
    options("scipen" = 100 , "digits" = 4) #remove scientific exponential
    table <- data.frame(table)%>%arrange(-Average_GDP)%>% slice(1:10) #make it as a dataframe and only displys the top 10 countries with the highest GDP of all nations.
    table$Average_GDP <- round(table$Average_GDP,2)
    names(table)[names(table) == "Average_GDP"] <- "Average GDP"
    text1 <- "<p>For the aggregated table below, it calculates the average GDP in each Country from 2000 to 2021. 
    The table displays only the Top 10 country with the highest GDP in Billions of the past twenty years 
    across all regions.</p>"
    text2 <- "<p>The importance of tracking gross 
    domestic product is that it provides a broad picture of a country's economic health. 
    GDP's main goal is to calculate the total dollar worth of all final goods and services 
    sold in a certain time, which is usually a year. It can also be used for other purposes, 
    such as comparing the economies of two or more countries. In general, when the economy 
    grows, businesses expand, and more employment become available. Furthermore, the United 
    States' GDP has an impact on worldwide financial circumstances. There is a strong link 
    between a society's high GDP growth and the elimination of poverty, particularly extreme 
    poverty; inflation, population, and unemployment are all factors that affect our daily 
    lives.</p><p>In relation to the Gross domestic product, we can get an overview of each 
    country's financial state based on their Gross domestic product. By analyzing and comparing 
    the reference Gross domestic product index of different countries, we can determine which 
    countries' economies are experiencing an upward trend and which ones still need improvement. 
    It is very significant for the economy of every country to have Gross domestic product. We 
    can measure the country's current influence on the global economy by analyzing its economy 
    as a key indicator. Comparing GDP between countries in recent years gives us an idea of the 
    country's recent trends, which is a very meaningful figure. In essence, Gross domestic product
    figures provide each country with a sound judgment of its own economic system and allow it 
    to develop effective strategies to improve the economy for the country's long-term 
    development.</p><p>A choropleth map was created to show a comparison of the different subjects’ 
    values for each country from 2000 to 2021 or during any years you want. By observing the average 
    distribution of each subject in the world, we can directly see the differences in this subject 
    in each country, The different subjects’ values are indicated by the shades of color. It is more
    intuitive to apply the map to analyze and present the data of different subjects for each country
    around the world in relation to its geographical location.</p><p>"
    table_show <- table %>%
      addHtmlTableStyle(spacer.celltype = "double_cell")%>%
      htmlTable()
    HTML(text1,table_show,text2)
    
  })
  output$intro <- renderUI({
    text_1 <- "Welcome to our GDP analysis project. Our study project will be focused on the issue of globalized Gross Domestic Product, 
    which is a key indication of national economic data and a common gauge of a region’s economic 
    status and overall degree of development. In general, the GDP of a country may be split into 
    three categories: value, income, and product. It is the difference in value between the total 
    value of all products and services generated by all resident units in a given period and the 
    total value of all non-fixed assets, goods, and services invested in the same period. "
    text_2 <- "</p>More specifically, we will investigate the influence and link between population, inflation, and 
    unemployment on GDP. Meanwhile, using data from 2000 to 2021, we will analysis the economic 
    environment across all region and for forecast for the future."
    HTML(paste(text_1,text_2,'</p><img src="GDP_image.png/></p>'))
  }) 
  output$report <- renderUI({
    text_1 <- "<p><strong>Project title</strong></p><mark class='red'>GDP analysis and trends</mark><p>"
    text_2 <- "<p><strong>Authors</strong></p> Ziliang Huang: zlhuang@uw.edu <br> Kaidi Chen: kaidic@uw.edu <br> Weixiao Sun: wsun9@uw.edu.<p>"
    text_3 <- "<p><strong>Affiliation	</strong></p> INFO-201: Technical Foundations of Informatics - 
    The Information School - University of Washington <p>"
    text_4 <- "<p><strong>Date</strong></p>Winter 2022<p>"
    text_5 <- "<p><strong>Abstract</strong></p>Our main research focus is to predict a country's 
    or a country's GDP in 2022 by analyzing a collection of factors. GDP is one of the key 
    indicators of the overall economic strength of a country, or even the global economy. 
    Therefore, since we have majors in financial-related fields, we are very interested in 
    this topic and eager to discover what factors affect GDP and how they may affect GDP 
    in the year 2022.<p>"
    text_6 <- "<p><strong>Keywords</strong></p>Economic, Development, Society, Macroscopic<p>"
    text_7 <- "<p><strong>1.0 Introduction</strong></p>Our study project will be focused on 
    the issue of globalized Gross Domestic Product, which is a key indication of national 
    economic data and a common gauge of a region's economic status and overall degree of
    development. In general, the GDP of a country may be split into three categories: value, 
    income, and product. It is the difference in value between the total value of all products 
    and services generated by all resident units in a given period and the total value of all 
    non-fixed assets, goods, and services invested in the same period. More specifically, we 
    will investigate the influence and link between population, inflation, and unemployment 
    on GDP. Meanwhile, using data from 2000 to 2021, we will forecast the global GDP trend
    or the GDP trend of a certain nation or area in 2022 or even in the future.<p>"
    text_8 <- "<p><strong>2.0 Design Situation</strong></p><p>GDP is no longer debatable since it 
    provides information about the size of an economy and how well it is operating. Furthermore,
    as experts in International Monetary Fund put it, the GDP growth rate is frequently employed 
    as an indication of the overall health of the economy. Furthermore, if the GDP of a certain 
    nation or area rises, it will be an essential indicator for that country or region that the 
    economy is doing well, which will allow governments to plan ahead of time particular measures.</p>
    <p>Concerning the scope of our project, we will first investigate the influence of 
    inflation, unemployment, and population on GDP and if they have a linear connection. 
    Then, based on the relationship and the future trend of the influencing elements, we 
    will forecast the future trend of GDP. </p> <p>'GDP is a lousy measure of economic welfare', 
    argues Alan Krupnick, an economist at Resources for the Future.'Economists prefer to look at 
    aggregate economic measures such as unemployment rates and GDP rather than going 
    into distributional concerns such as who is affected, who is losing money, 
    where is this GDP growth truly coming from, and does it enhance societal equity?'
    Thus, in our study, we will primarily focus on doing research to determine where 
    GDP growth is coming from and analyzing how such economic indicators that economists 
    mostly focus on connect to GDP.</p><p>Our project's primary goal is to assist 
    governments, lawmakers, and economists in planning the future economies of 
    nations or the globe. 'GDP helps the government decide how much it can spend 
    on public services and how much it needs to raise in taxes,' according to BBC News. 
    As a result, our initiative will enable effective policy development. Furthermore, 
    our initiative may enable researchers interested in the economic sector or data analysis 
    to undertake additional research.</p><p>The advantages of our idea are evident; it 
    may assist countries in developing and formulating stronger economic strategies. 
    The disadvantage of our research is that the GDP effect elements we investigate 
    are quite restricted, which may mislead those who are worried about our project 
    into focusing solely on inflation, unemployment, and population as the key issues. 
    In reality, there may be an increasing number of essential aspects.<p>"
    text_9 <- "<p><strong>3.0 Research questions</strong></p><p><ul><li>How the population, 
    the unemployment rate, and the inflation and end of period consumer prices affect the 
    GDP in the USA?</li></ul></p><p>We will perform data visualization to draw three distributions 
    and find the correlation coefficient to judge the relationship between population and 
    GDP.</p><p><ul><li>What are the comparative GDP trends for different countries 
    from 2000 to 2021?</li></ul></p><p>We will perform data visualization to draw line charts 
    and find the trend of GDP from 2000 to 2021 in different countries, predicting the GDP for 
    each country in 2022.</p><p><ul><li>How does the different subjects (including average GDP, 
    inflation, volume of imports and exports, unemployment, and population) compare 
    across different countries around the world?</li></ul></p><p>We use data visualization 
    to draw a world map to see the average GDP distribution of various countries from 2000 
    to 2021.</p><p>"
    text_10 <- "<p><strong>4.0 The Dataset</strong></p><p>The origin of our data is from the 
    International Monetary Fund (IMF), an organization working to foster global monetary 
    cooperation, secure financial stability, facilitate international trade, promote high 
    employment and sustainable economic growth and reduce poverty around the world. The 
    dataset we are going to use for this project is 8823 rows and 57 rows, and covers all 
    economic data (e.g. Unemployment, Inflation, GDP, Population) for 190 countries in the 
    world from 1980 to 2021. However, we will probably use only two types of data from the 
    whole set, the population, and GDP of the United States from 2000 to 2021 to complete 
    our research question. We only chose these two sets of data because the United States 
    has changed dramatically in the last 20 years. I think the difficulty with this dataset 
    is whether we can extract the right economic data we need correctly and efficiently. 
    Since there are certain data that are missing in this dataset, which input as 'n/a'. 
    Moreover, these data are printed into different types of units, including index, number 
    of people, US dollars, and national currency. Hence, we may end up with different numbers 
    of X and Y arguments when we plot them into our graph. Additionally, the class of all the 
    values in this dataset is actually characters, which will let us make mistakes when 
    calculating and graphing this dataset. Thus, we have to convert all the data that we 
    need to calculate into numerical class. </p><p>As we mentioned above, since we only need two 
    types of data, population, and GDP, which are presented horizontally, their classification 
    is written in a 'subject descriptor' column and even the GDP data has several different 
    classifications for each country. Besides, the values in the “subject descriptor” column 
    are complex and are difficult for us to extract corresponding columns for our analysis. 
    This may lead to additional difficulties in the process of data extraction, depending on
    whether we can find consistent patterns in them. What’s more, we discover that the “Country” 
    and the “Region” columns are not factors, thus making our analysis difficult to proceed. 
    In addition, there are too many features in this database and many of them are not related 
    to our project’s topic, so we have to reorganize this dataset to make it cleaner. </p><p>"
    text_11 <- "<p><strong>5.0 Findings</strong></p><p><ul><li><strong>How the population, 
    the unemployment rate, and the inflation and end of period consumer prices affect the 
    GDP in the USA?</strong></li></ul></p><p>Since a fall in GDP is mirrored in a decrease in the rate 
    of employment, GDP and unemployment rates are frequently linked. Increased GDP levels 
    produce an increase in consumer demand for goods and services, which leads to an 
    increase in employment levels. And the inflation index usually correlates with the 
    GDP because, in the real world, when inflation rises, people will spend more since 
    they know their money will be worth less in the future. In the near run, this leads 
    to higher GDP, which in turn leads to higher prices. Population changes can have a 
    variety of effects on GDP growth. For starters, slower population increase means less 
    labor input. Second, decreased population growth has an indirect, potentially negative 
    impact on individual labor supply, as higher tax rates limit the motivation to work.</p><p>"
    text_12 <-"<p><ul><li><strong>What are the comparative GDP trends for different countries from 2000 to 
    2021?</strong></li></ul></p><p>For the second research question the main focus is on the numerical 
    comparison with the Gross domestic product between the individual countries. The answer
    to the second research question requires a specific analysis to compare the Gross 
    domestic product values of different countries. For example, the comparison of Gross 
    domestic product values between China and Germany shows that China's Gross domestic 
    product values were lower than Germany's Gross domestic product from 2000 to 2007, 
    and after 2007 China's Gross domestic product values started to exceed Germany's. 
    Both countries have shown an overall upward trend in GDP in recent years. The line 
    graphs allow us to compare the GDP of different countries to see the trend in Gross 
    domestic product for different countries in different years. We can determine the 
    comparison of the economic situation and level of development of different countries 
    over different time periods. This gives us an idea of the development of each 
    nationality. </p><p>"
    text_13 <- "<p><ul><li><strong>How do the different subjects (including average GDP, 
    inflation, volume of imports and exports, unemployment, and population) compare across different 
    countries around the world?</strong></li></ul></p><p>For this research question, we have a slider 
    bar to adjust the year range of our research, and also to select the subjects 
    we are researching including average GDP, inflation, volume of imports and exports, 
    unemployment, and population. To begin with, we can find that basically in the range 
    of our selected years, the countries with high average GDP are mainly concentrated in 
    China and the United States. Second, the countries with high inflation are mainly 
    concentrated in South America. Additionally, countries with high import and export 
    rates are mainly distributed in Asia and Africa such as Brazil. Besides, the populous 
    countries are mainly India and China, while some countries with high unemployment are 
    mainly concentrated in Europe and Africa, but the data on the unemployment rate is 
    slightly missing relative to other subjects.</p>"
    text_14 <- "<p><strong>6.0 Discussion </strong></p><p>The importance of tracking gross 
    domestic product is that it provides a broad picture of a country's economic health. 
    GDP's main goal is to calculate the total dollar worth of all final goods and services 
    sold in a certain time, which is usually a year. It can also be used for other purposes, 
    such as comparing the economies of two or more countries. In general, when the economy 
    grows, businesses expand, and more employment become available. Furthermore, the United 
    States' GDP has an impact on worldwide financial circumstances. There is a strong link 
    between a society's high GDP growth and the elimination of poverty, particularly extreme 
    poverty; inflation, population, and unemployment are all factors that affect our daily 
    lives.</p><p>In relation to the Gross domestic product, we can get an overview of each 
    country's financial state based on their Gross domestic product. By analyzing and comparing 
    the reference Gross domestic product index of different countries, we can determine which 
    countries' economies are experiencing an upward trend and which ones still need improvement. 
    It is very significant for the economy of every country to have Gross domestic product. We 
    can measure the country's current influence on the global economy by analyzing its economy 
    as a key indicator. Comparing GDP between countries in recent years gives us an idea of the 
    country's recent trends, which is a very meaningful figure. In essence, Gross domestic product
    figures provide each country with a sound judgment of its own economic system and allow it 
    to develop effective strategies to improve the economy for the country's long-term 
    development.</p><p>A choropleth map was created to show a comparison of the different subjects’ 
    values for each country from 2000 to 2021 or during any years you want. By observing the average 
    distribution of each subject in the world, we can directly see the differences in this subject 
    in each country, The different subjects’ values are indicated by the shades of color. It is more
    intuitive to apply the map to analyze and present the data of different subjects for each country
    around the world in relation to its geographical location.</p><p>"
    text_15 <- "<p><strong>7.0 Conclusion</strong></p><p>The impact of population on GDP is the most 
    intuitive when comparing inflation, unemployment, and population to the GDP of the United States,
    and the correlation between population and GDP is positive. Besides, maybe exactly because of the
    impact of population, inflation, and unemployment, the U.S. and China dominate the global GDP 
    distribution, and their GDP trends are on the rise from 2000 to 2021.</p><p>"
    text_16 <- "<p><strong>Acknowledgements</strong></p><p>We would like to say thank you to my TA, the 
    instructor and everyone on my team. Beside, we appreciate that International Monetary Fund 
    collected the World Economic Outlook Database for our project.</p><p>"
    text_17 <- "<p><strong>References</strong></p><p>Tim Callen, International Monetary Fund(2020).Gross
    Domestic Product: An Economy’s All.<em><a href='https://www.imf.org/external/pubs/ft/fandd/basics/gdp.
    htm#:~:text=GDP%20is%20important%20because%20it,the%20economy%20is%20doing%20well.'>https://www.
    imf.org/external/pubs/ft/fandd/basics/gdp.htm#:~:text=GDP%20is%20important%20because%20it,the%20
    economy%20is%20doing%20well.</a></em></p><p>"
    text_18 <-"<p>Adam Rogers, the WIRED (2020). How Much Is a Human Life Actually Worth? <em><a href=
    'https://www.wired.com/story/how-much-is-human-life-worth-in-dollars/'>https://www.wired.com/
    story/how-much-is-human-life-worth-in-dollars/</a></em></p><p>"
    text_19 <- "<p>BBC News(2021). What is GDP and how is it measured? <em><a href='https://www.bbc.com
    /news/business-13200758'>https://www.bbc.com/news/business-13200758</a></em></p><p>"
    text_20 <- "<p>International Monetary Fund(2021). World Economic Outlook Database.<em><a href='https:
    //www.imf.org/en/Publications/WEO/weo-database/2021/October/download-entire-database'>https://www
    .imf.org/en/Publications/WEO/weo-database/2021/October/download-entire-database</a></em></p><p>"
    
    
    HTML(paste(text_1,text_2,text_3,text_4,text_5,text_6,text_7,text_8,text_9,text_10,
               text_11,text_12,text_13,text_14,text_15,text_16,text_17,text_18,text_19,text_20))
  }) 
}

