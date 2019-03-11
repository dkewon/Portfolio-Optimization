wd = "C:/Users/eviriyakovithya/Documents/GitHub/Portfolio-Optimization/"
setwd(wd)
getwd()


library(readr)
df <- read_csv("C:/Users/eviriyakovithya/Documents/GitHub/Portfolio-Optimization/stock_csv/_combined_csv.csv")

library(tidyverse)
library(dplyr)
library(lubridate)

# aggregate monthly, group by mean  
df_month500<- df %>% group_by(month=floor_date(date, "month")) %>% summarise_each(funs(mean))
# sample only 300 columns
df_month<- df_month500[, sample(ncol(df_month500[3:length(df_month500)]), 300)]


# define function
pct_chg <- function(x){
  pct_change <- -(x-lead(x))/x # Gets percent change in profit from preceding year
  return(pct_change)
}

# # test the function
# x = df_month$ABB[1:10]
# ahead = df_month(x)
# pct_chg(x)

# apply to the dataframe, remove NAs (last row), (RetMat: Return Matrix)
df_pct <- data.frame(lapply(df_month, pct_chg))
RetMat <- na.omit(df_pct)
write.csv(RetMat,'RetMat.csv')

# calculate mean of % changes (ExpRet: Expected Return)
ExpRet <- colMeans(RetMat, na.rm = TRUE)
write.csv(ExpRet,'ExpRet.csv')

# calculate standard deviation of % changes (Stdv)
Stdv <- apply(RetMat, 2, sd, na.rm = TRUE)
write.csv(Stdv,'Stdv.csv')
