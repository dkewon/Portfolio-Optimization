reset;
option solver minos;

param N;
param c {1..N, 1..N};
param r {1..N};
# required return that we want
param alpha; 

var w {1..N} >= 0;

minimize variance:
sum{i in 1..N, j in 1..N} c[i,j]*w[i]*w[j];

subject to RequiredReturn:
sum{i in 1..N} r[i]*w[i] >= alpha;


subject to Budget:
sum{i in 1..N} w[i] = 1;



