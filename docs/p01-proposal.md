# GDP analysis and trends: Project Proposal

**Code name** : GDP

**Project title** :	GDP analysis and trends

**Authors** :
- Ziliang Huang: zlhuang@uw.edu
- Kaidi Chen: kaidic@uw.edu
- Weixiao Sun: wsun9@uw.edu.


**Affiliation** : INFO-201: Technical Foundations of Informatics - The Information School - University of Washington

**Date** : Winter 2022

**Abstract** : Our main research topic is to **predict the trend of the global or a country’s GDP in 2022 through various factors**. This topic is important because GDP is one of the important criteria to reflect the global or a country’s economic strength. Therefore, having financial-related majors, we are very concerned about this topic and are eager to know what factors affect GDP and how they might affect GDP in 2022.

**Keywords** : _Economic, Development, Society, Macroscopic_

**1.0 Introduction** :
  We will be focusing a research project on the topic of globalized Gross Domestic Product, which is a core indicator of national economic statistics and a common measurement of a region’s economic situation and overall level of development. In general, a country’s GDP could be divided into three categories: value, income, and product. In value terms, it is the difference between the value of all goods and services produced by all resident units in a given period and the value of all non-fixed assets, goods, and services invested in the same period. In income terms, it is the sum of all resident units’ income directly generated in a given period. And in product terms, it is the end-use of goods and services minus imports of goods. GDP is a measure of the total value added by all sectors of the national economy. To be more specific, we will study the impact and relationship of population, inflation, and unemployment on GDP. Meanwhile, through the data from 2000 to 2021, we will predict the GDP trend of the world or a certain country and region in 2022 or even in the future.

**2.0 Design Situation** :

  Nowadays, it cannot be denied that GDP is important because it gives information about the size of the economy and how an economy is performing. Besides, as [experts in International Monetary Fund](https://www.imf.org/external/pubs/ft/fandd/basics/gdp.htm#:~:text=GDP%20is%20important%20because%20it,the%20economy%20is%20doing%20well.) defined, the growth rate of GDP is often used as an indicator of the general health of the economy. Besides, if there will be an increase in a certain country’s or region’s GDP, it will be an important sign for such country or region that the economy might be doing well, which can help the governments come up with some policies in advance.

  About our project framing, we will first study the impact of inflation, unemployment, and population on GDP and whether they may have a linear relationship. Then, we will predict the future trend of GDP according to the relationship and the future trend of the influencing factors.

  “GDP is a lousy measure of economic welfare,” says [Alan Krupnick](https://www.wired.com/story/how-much-is-human-life-worth-in-dollars/), an economist at Resources for the Future. “Economists tend to look at aggregate economic indicators like unemployment rates and GDP, as opposed to getting into the distributional issues—who’s being affected, who’s losing income, where is this GDP growth actually coming from, does it increase the equity in society?” Thus, in our project, we will mainly focus on taking research on where GDP growth is actually coming from and analyze how such economic indicators that economists mainly focus on relate to the GDP.

  Our project is mainly to serve the government, politicians, and economists to plan the future economy of countries or the world. As [BBC News](https://www.bbc.com/news/business-13200758) mentioned, “GDP helps government decide how much it can spend on public services and how much it needs to raise in taxes.” Thus, our project will allow policies to be developed well. Also, our project can also allow scholars interested in the economic field or data analysis to conduct further researches.

  The benefits of our project are obvious, it can help the countries to develop better and formulate better economic policies. However, the harm of our project is that the GDP impact factors we study are very limited, so it might mislead people who are concerned about our project to only focus on inflation, unemployment, and population as the main factors. In fact, there may be more and more important factors.

**3.0 Research questions** :
The United States has the world's third-largest nominal GDP and is one of the world's fastest-growing economies. In addition, the US dollar is the world's reserve currency, accounting for more than two-thirds of all worldwide reserves. As a result, the US GDP reflects the global economy to some extent. Many additional factors, such as the inflation rate, population, and unemployment rate, can all have an impact on GDP. People seldom pay attention to these aspects, despite the fact that they are inextricably linked to our lives.

* **How the population, the unemployment rate, and the inflation and end of period consumer prices affect the GDP in the USA?**

  We will perform data visualization to draw three distributions and find the correlation coefficient to judge the relationship between population and GDP.

* **What are the comparative GDP trends for these three countries (China, Germany, United States) from 2000 to 2021?**

  We will perform data visualization to draw line charts and find the trend of GDP from 2000 to 2021 in China, Germany, and the United States, predicting the GDP for each country in 2022.

* **How does the average GDP compare across different countries around the world?**

  We use data visualization to draw a world map to see the average GDP distribution of various countries from 2000 to 2021.


**4.0 The Dataset**: The origin of our data is from the International Monetary Fund (IMF), an organization working to foster global monetary cooperation, secure financial stability, facilitate international trade, promote high employment and sustainable economic growth and reduce poverty around the world. The dataset we are going to use for this project is 8823 rows and 57 rows, and covers all economic data (e.g. Unemployment, Inflation, GDP, Population) for 190 countries in the world from 1980 to 2021. However, we will probably use only two types of data from the whole set, the population, and GDP of the United States from 2000 to 2021 to complete our research question. We only chose these two sets of data because the United States has changed dramatically in the last 20 years. I think the difficulty with this dataset is whether we can extract the right economic data we need correctly and efficiently. Since there are certain data that are missing in this dataset, which input as "n/a". Moreover, these data are printed into different types of units, including index, number of people, US dollars, and national currency. Hence, we may end up with different numbers of X and Y arguments when we plot them into our graph. Additionally, the class of all the values in this dataset is actually characters, which will let us make mistakes when calculating and graphing this dataset. Thus, we have to convert all the data that we need to calculate into numerical class. As we mentioned above, since we only need two types of data, population, and GDP, which are presented horizontally, their classification is written in a "subject descriptor" column and even the GDP data has several different classifications for each country. Besides, the values in the “subject descriptor” column are complex and are difficult for us to extract corresponding columns for our analysis. This may lead to additional difficulties in the process of data extraction, depending on whether we can find consistent patterns in them. What’s more, we discover that the “Country” and the “Region” columns are not factors, thus making our analysis difficult to proceed. In addition, there are too many features in this database and many of them are not related to our project’s topic, so we have to reorganize this dataset to make it cleaner.

**5.0 Expected Implications**: Technologists need to use R for data visualization. For example, the GDP trend can be displayed in the form of a line chart. At the same time, regarding the relationship between GDP and its related factors, we hope to calculate the correlation coefficient, r value, and p value to study whether there is a linear relationship, which will help us predict. Designers are expected to use R markdown to make a dynamic report to better display our analyzing result, which can allow our analysis to be understood by more people than just those in such a professional field. Policymakers are expected to keep our results of data analysis safe and ensure the clarity of our data resources.

**6.0 Limitations**: As with any statistical indicator, GDP has a defined range of applicability. However, it also has limitations. Our research will be focused primarily on the effects of population, inflation, and unemployment on GDP, and due to the GDP being influenced by numerous factors and data limitations the results of the research project may not obtain the expected trends. The unemployment rate and GDP growth tend to follow each other in a fairly stable relationship . By Okun’s law, the unemployment rate falls by approximately one percentage point for every two percent increase in GDP. In other words, if output goes up by 1% but employment doesn't, then employment remains unchanged. This may be due to workers working overtime rather than an increase in employment, or because society increases the number of people in second jobs, consequently making employment smaller than the percentage increase in output. In any case, this relationship is not very strict and should be evaluated according to the country or region’s situations.

**Acknowledgements**: We would like to say thank you to my TA, the instructor and everyone on my team. Beside, we appreciate that International Monetary Fund collected the  World Economic Outlook Database for our project.


**References**:

  - Tim Callen, International Monetary Fund(2020).Gross Domestic Product: An Economy’s All. https://www.imf.org/external/pubs/ft/fandd/basics/gdp.htm#:~:text=GDP%20is%20important%20because%20it,the%20economy%20is%20doing%20well.

  - Adam Rogers, the WIRED (2020). How Much Is a Human Life Actually Worth? https://www.wired.com/story/how-much-is-human-life-worth-in-dollars/

  - BBC News(2021). What is GDP and how is it measured? https://www.bbc.com/news/business-13200758

  - International Monetary Fund(2021). World Economic Outlook Database. https://www.imf.org/en/Publications/WEO/weo-database/2021/October/download-entire-database

**Appendix A**: Do we need to use the full set of the data while we download from online?
