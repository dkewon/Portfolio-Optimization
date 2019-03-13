library(readr)
DEMO <- read_csv("C:/Users/eviriyakovithya/Documents/GitHub/Portfolio-Optimization/stock_csv/_combined_csv.csv")
View(DEMO)

library(tidyverse)

profit_pct_change <- function(x) {
  x <- DEMO[order(DEMO$month, decreasing = TRUE), ] # Confirms ordered by decreasing year
  pct_change <- diff(DEMO$ABB)/DEMO$ABB[-1] * 100 # Gets percent change in profit from preceding year
  data.frame(month = DEMO$month[-length(DEMO$month)], pct_change = pct_change) # Returns data frame
}

Percent<-lapply(DEMO, function(x) {
  x <- DEMO[order(DEMO$month, decreasing = TRUE), ] # Confirms ordered by decreasing year
  pct_change <- diff(DEMO$ABB)/DEMO$ABB[-1] * 100 # Gets percent change in profit from preceding year
  data.frame(month = DEMO$month[-length(DEMO$month)], pct_change = pct_change) # Returns data frame
})

# need to loop
#Percentf<-as.data.frame(Percent)
