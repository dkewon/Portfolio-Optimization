wd = "C:/Users/eviriyakovithya/Downloads/AMPL files-20190225/ampl.mswin64/20190228"
setwd(wd)
getwd()

N = 3
sigma1 = 0.1 # variance 1
sigma2 = 0.01 # variance 2
sigma3 = 0.05 # variance 3

T = 1000

R1 = rnorm(T,mean = 0,sigma1) # Stock1
R2 = rnorm(T,mean = 0.5*(1-R1)-0.5,sigma2) # Gold -> negative corr with R1 mean
R3 = rnorm(T,mean = 0.1*R1,sigma3) # Real estate -> positive corr with R1

rbind(mean(R1),mean(R2),mean(R3))

cov(cbind(R1,R2,R3))



plot(1:T, R1, type = 'l', ylim = c(-.5,0.5))
lines(1:T, R2, type = 'l', col = 2)
lines(1:T, R3, type = 'l', col = 3)


gold= read.csv('gold-Current.csv')
silver= read.csv('silver-current.csv')

rbind(mean(gold$Perth.Mint.Spot, na.rm = T),mean(silver$Perth.Mint.Spot, na.rm = T))
cov(cbind(gold$Perth.Mint.Spot,silver$Perth.Mint.Spot))

plot(1:nrow(gold), gold$Perth.Mint.Spot, type = 'l')

plot(1:nrow(gold), silver$Perth.Mint.Spot, type = 'l', col = 2)