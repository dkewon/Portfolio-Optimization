reset;
# option solver minos;

# parameter definition
param n > 0; # number of shares
param T > 0; # number of months
param W; # budget
param RetMat{1..T, 1..n}; # historic monthly returns for selected shares
param u; # Upper limit for investing in a single share
param G; # target return of the portfolio
param Mp{1..n}; # Portfolio’s minimum returns
param ExpRet{1..n}; # expected returns of shares
param stdv{1..n}; # standard deviation of shares

# variable definition
var w{1..n} >=0;

# objective function
maximize MinimumReturn:
sum {j in 1..n} w[j]*Mp[j];

# constraints

subject to TargetReturn:
sum {j in 1..n} ExpRet[j]*w[j] >= G;

subject to Budget:
sum {j in 1..n} w[j] <= W;

subject to bounds {j in 1..n}:
0 <= w[j] <= u;

