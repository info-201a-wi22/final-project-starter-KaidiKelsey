
summary <- function(data){
  summary_info <- list()
  summary_info$num_observations <- nrow(data)
  summary_info$num_variables <- ncol(data)
  summary_info$max_GDP_2021 <- data %>%
    filter(Subject.Descriptor == "GDP U.S. Dollars") %>%
    select(X2021) %>%
    max(na.rm = TRUE)
  summary_info$min_GDP_2021 <- data %>%
    filter(Subject.Descriptor == "GDP U.S. Dollars") %>%
    select(X2021) %>%
    min(na.rm = TRUE)
  summary_info$max_population_2021 <- data %>%
    filter(Subject.Descriptor == "Population") %>%
    select(X2021) %>%
    max(na.rm = TRUE)
  summary_info$min_population_2021 <- data %>%
    filter(Subject.Descriptor == "Population") %>%
    select(X2021) %>%
    min(na.rm = TRUE)
  text <- paste("Our project research focuses on observing and analyzing global 
  GDP statistics by analyzing a variety of corresponding impacts. We have selected 
  six distinct variables from our data that we consider are relevant. Specifically,
  the number of observations, variables, the maximum value of GDP in 2021 (billion), 
  the minimum value of GDP in 2021 (billion), the maximum value of population in 2021 
  (million), and the minimum value of population in 2021 (million). The change in the 
  trend of global GDP is seen by looking at the production in conjunction with the 
  effect of numerous independent variables.According to the data, the number of 
  observations for the total data is ",summary_info$num_observations,". The number 
  of variavbles for the total data is ", summary_info$num_variables,". The maximum 
  value of GDP in 2021 is ",summary_info$max_GDP_2021," billion, and the minimum value 
  is ", summary_info$min_GDP_2021," billion; the maximum value of population in 2021 
  is ",summary_info$max_population_2021," million, and the minimum value of population 
  in 2021 is ",summary_info$min_population_2021," million. The population maximum in 
  2021 and the population minimum in 2021. We may infer the amount and trend of the 
  independent variable's influence on the dependent variable from the data, enabling 
  us to compute the difference caused by that demographic component on GDP. By analyzing 
  this data, we can identify the amount to which various factors influence GDP and, as 
  a result, better formulate efficient strategies for the development of the country's 
  GDP in order to achieve economic development.")
  return(cat(text))
}
