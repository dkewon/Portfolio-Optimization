# -*- coding: utf-8 -*-
"""
Created on Mon Mar  4 16:30:13 2019

@author: eviriyakovithya
"""
import os
os.chdir(r"C:\Users\eviriyakovithya\Downloads")
import urllib
import urllib.parse
import json
import time
import requests
import pandas as pd
import logging
from datetime import datetime
import pandas as pd


url_page = 'https://api.iextrading.com/1.0/ref-data/symbols'
json_page = urllib.request.urlopen(url_page)
json_data = json.loads(json_page.read().decode())
json_df = pd.DataFrame(json_data)

symbol_list = json_df[['symbol']]

sample500 = symbol_list.sample(frac=1, random_state = 0).reset_index()
sample500.to_csv('sample500.csv', header=True, sep=',')



#stock_url ='https://api.iextrading.com/1.0/stock/'+str(sample500.iloc[0,1])+'/chart/5y?format=csv'
#
#stock_json_page = urllib.request.urlopen(stock_url)
#stock_json_data = json.loads(stock_json_page.read().decode())
#stock_json_df = pd.DataFrame(stock_json_data)
#
#
#c=pd.read_csv(stock_url)
#cc = c[['date','close']]
#
#stock_url_list = []
#for i in range(len(sample500)):
#    stock_url = 'https://api.iextrading.com/1.0/stock/'+str(sample500.iloc[i,1])+'/chart/5y?format=csv'
#    stock_url_list.append(stock_url)
#
#pd.DataFrame(stock_url_list).to_csv('stock_url_list.csv', header=True, sep=',')

df_list=[]
count = 1
for i in range(892,len(sample500)):
    print(i)
    if(count <= 500):
        stock_url = 'https://api.iextrading.com/1.0/stock/'+str(sample500.iloc[i,1])+'/chart/5y?format=csv'
        df = pd.read_csv(stock_url)
        df = df[['date','close']]
        df['symbol']=str(sample500.iloc[i,1])
        if(len(df)==1258):
#            df_list.append(df)
            df.to_csv('./stock_csv/'+str(sample500.iloc[i,1])+'.csv', header=True, sep=',')
            count=count+1
            print(count)
            

#find all csv files in the folder
#use glob pattern matching -> extension = 'csv'
#save result in list -> all_filenames
            
#import os
#import glob
#import pandas as pd
#os.chdir(r"C:\Users\eviriyakovithya\Downloads\stock_csv")
#   
#extension = 'csv'
#all_filenames = [i for i in glob.glob('*.{}'.format(extension))]
#
##combine all files in the list
#combined_csv = pd.merge([pd.read_csv(f) for f in all_filenames ])
##export to csv
#combined_csv.to_csv( "combined_csv.csv", index=False, encoding='utf-8-sig')