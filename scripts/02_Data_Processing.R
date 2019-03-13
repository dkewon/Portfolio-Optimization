# set working directory
wd = "C:/Users/eviriyakovithya/Documents/GitHub/Portfolio-Optimization/"
setwd(wd)
getwd()

# read in data
if (!require("utf8")) install.packages("utf8");library(utf8)
if (!require("readr")) install.packages("readr");library(readr)
df <- read.csv("C:/Users/eviriyakovithya/Documents/GitHub/Portfolio-Optimization/Processed_Data/_combined_csv.csv")
if (!require("tidyverse")) install.packages("tidyverse");library(tidyverse)
if (!require("dplyr")) install.packages("dplyr");library(dplyr)
if (!require("lubridate")) install.packages("lubridate");library(lubridate)

df<-data.frame(df)
# rename column
names(df)[1]<-"date"
# change to date time type
df$date <- ymd(df$date)


# aggregate monthly, group by mean  
df_month500<- df %>% group_by(month=floor_date(date, "month")) %>% summarise_each(funs(mean))
# sample only 300 columns (due to AMPL student version limitation)
df_month500<-df_month500[3:length(df_month500)]
set.seed(123)
df_month<- df_month500[, sample(ncol(df_month500[1:length(df_month500)]), 300)]

# define function for gain/loss percentages between each month
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

CovMat<- cov(as.matrix(RetMat))
write.csv(CovMat,'CovMat.csv')

# calculate mean of % changes (ExpRet: Expected Return)
ExpRet <- colMeans(RetMat, na.rm = TRUE)
write.csv(ExpRet,'ExpRet.csv')

# calculate standard deviation of % changes (Stdv)
Stdv <- apply(RetMat, 2, sd, na.rm = TRUE)
write.csv(Stdv,'Stdv.csv')

