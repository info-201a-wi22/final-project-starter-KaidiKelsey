
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
  return(summary_info)
}
