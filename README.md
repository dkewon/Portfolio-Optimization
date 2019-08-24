# Portfolio optimization

by: Ekapope Viriyakovithya , James Ponce, Deborah Kewon, Saeed Mirzaee, Usman Muhammad

## Introduction
In this study, we aimed to create a model using AMPL to help investors effectively
manage their stocks and invest on the most profitable stocks. We collected stock
market data of 500 companies from [IEX Group](https://iextrading.com/developer/docs/) and allocated the assets based on the principle of portfolio optimization.

## Data description
First of all, we randomly extracted 500 stocks from 8,718 stocks in the U.S. market
with the period of 5 years (1258 trading days). Each row is the closing price of a stock for
the designated trading date. However, using student version of AMPL software, we are
allowed to compute only up to 300 variables for a non-linear problem (500 for linear
problem). Therefore, we omitted 200 stocks in the second step. We aggregated stock
prices by mean and grouped by month, and then calculated average percentage changes,
covariance, and used them as inputs for AMPL.

For more detail and findings, please refer to [Portfolio_Optimization_Group_Project.pdf](https://github.com/dkewon/Portfolio-Optimization/blob/master/Portfolio_Optimization_Group_Project.pdf).
