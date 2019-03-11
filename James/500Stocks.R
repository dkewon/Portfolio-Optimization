
# Libraries
library(lubridate)
library(dplyr)
library(tidyverse)
library(multiplex)
install.packages("multiplex")

###############################################################################
#                               Reading Row Data                              #
###############################################################################

# Set work directory
setwd("~/Documents/GitHub/Portfolio-Optimization/James")

# Listing files name in wd
# MAKE SURE THERE ARE ONLY 500 csv files in WD!!!!
csv_names<-list.files()

# Functions
read_data<-function(csv_file){
  df<-read.delim(csv_file, header = TRUE, sep=",")
  df$date<-as.Date(df$date)
  return(df)
}

colnames_data<-function(csv_file){
  name<-substr(csv_file,1,nchar(csv_file)-4)
  return(name)
}

# Reading data
stocks_list<-lapply(csv_names, read_data)
# Creating a empty dataframe
stocks_df <- data.frame(matrix(ncol = 500, nrow = 1258))

# Filling up a dataframe
for (i in 1:500){
stocks_df[,i]<-stocks_list[[i]]$close
}

# Putting stock names as a column names
stocks_names<-lapply(csv_names,colnames_data)
colnames(stocks_df)<-unlist(stocks_names)

# Adding a Date column
stocks_df$Date<-stocks_list[[1]]$date

# Save dataframe as .rds
saveRDS(stocks_df, "stocks.rds")

###############################################################################
#             Computing c (mean) and r (covariance)                           #
###############################################################################

# Loading data created in the code above
prices <- readRDS("stocks.rds")
hist(year(prices$Date))

# Generate 6 random no-repeated numbers: sample(1:20, 6, replace=F) 
nvar<-500
# colnames(prices[,sample(1:500, nvar, replace=F) ])

# Creating Year and Month column to aggregate
prices$Year<-year(prices$Date)
prices$Month<-month(prices$Date)
names(prices)

# Price %Variation
# Group by year/month
prices_ym<-prices %>%
                group_by(Year,Month) %>%
                summarise_at(vars(colnames(prices)[1:nvar]), funs(mean)) %>%
                arrange(-Year,-Month)

prices_dif<-(prices_ym[1:60,3:(nvar+2)]/prices_ym[2:61,3:(nvar+2)]-1)*100
prices_dif$Year<-prices_ym$Year[1:60]
prices_dif$Month<-prices_ym$Month[1:60]

# AML Model: Param r (mean of each stock price)
prices_dif_mean <-prices_dif %>% summarise_at(vars(colnames(prices_dif)[1:nvar]), funs(mean))
r<-t(prices_dif_mean)
write.dat(r, "r.dat")

# AML Model: Param c (covariance matrix of stock price)
c<-cov(cbind(prices_dif[,1:nvar]))
write.dat(c, "c.dat")
