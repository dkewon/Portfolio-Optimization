# -*- coding: utf-8 -*-
"""
Created on Mon Mar  4 16:30:13 2019

@author: eviriyakovithya
"""
import os
os.chdir(r"C:\Users\eviriyakovithya\Documents\GitHub\Portfolio-Optimization\scripts")
import urllib
import urllib.parse
import json
import time
import requests
import pandas as pd
import logging
from datetime import datetime
import pandas as pd

#setup url and import as json format
#this will retrieve all symbols in US stock market, total 8718 symbols retrieved
url_page = 'https://api.iextrading.com/1.0/ref-data/symbols'
json_page = urllib.request.urlopen(url_page)
json_data = json.loads(json_page.read().decode())
json_df = pd.DataFrame(json_data)

symbol_list = json_df[['symbol']]

#random shuffle the stock list
random_symbols = symbol_list.sample(frac=1, random_state = 0).reset_index()
random_symbols.to_csv('random_symbols.csv', header=True, sep=',')

#retrieve the price history (5 years historical data) for each stock, upto 500 stocks
#we retrieve only 500 stocks due to limited AMPL student version (max 500 vars for linear model)
#reject the share which has less that 1258 days (5 years) historical data
#save it individually in csv format
df_list=[]
count = 1
for i in range(1,len(random_symbols)):
    print(i)
    if(count <= 500):
        stock_url = 'https://api.iextrading.com/1.0/stock/'+str(random_symbols.iloc[i,1])+'/chart/5y?format=csv'
        df = pd.read_csv(stock_url)
        df = df[['date','close']]
        df['symbol']=str(random_symbols.iloc[i,1])
        if(len(df)==1258): # reject the share which has less that 1258 days (5 years) historical data
#            df_list.append(df)
            df.to_csv('./stock_csv/'+str(random_symbols.iloc[i,1])+'.csv', header=True, sep=',')
            count=count+1
            print(count)
            

#find all csv files in the folder and combine all 500 csv into one
#use glob pattern matching -> extension = 'csv'
#save result in list -> combined_csv
            
import os
import glob
import pandas as pd
os.chdir(r"C:\Users\eviriyakovithya\Documents\GitHub\Portfolio-Optimization\stock_csv")

# find all csv in the target folder
extension = 'csv'
all_filenames = [i for i in glob.glob('*.{}'.format(extension))]

# intialize the combine csv df to store all data
f = all_filenames[0]
df = pd.read_csv(f,  parse_dates=['date'])
combined_csv=df[['date']]
#combine all files in the list
for f in all_filenames:
    df = pd.read_csv(f,  parse_dates=['date'])
    # select only two columns
    df = df[['date', 'close']]
    # rename colname 'close' -> 'stock name'
    df= df.rename(columns = {'close':str(f.split('.')[0])})
    # left join with main df using date col
    combined_csv = combined_csv.merge(df, on="date", how="left")
#export to csv
combined_csv.to_csv( "combined_csv.csv", index=False, encoding='utf-8-sig')










