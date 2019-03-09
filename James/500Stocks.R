# Set work directory
setwd("~/Documents/GitHub/Portfolio-Optimization/stock_csv")

# Listing files name in wd
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
#saveRDS(stocks_df, "stocks.rds")

# Restoring data
# my_data <- readRDS("stocks.rds")



