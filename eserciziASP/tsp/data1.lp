
% nodi da visitare 

togo(a;b;c;d;e).

start(a).

dist(a,b,10).
dist(a,c,20).
dist(a,d,10).
dist(a,e,10).

dist(b,c,10).
dist(b,d,15).
dist(b,e,18).

dist(c,d,12).
dist(c,e,16).

dist(d,e,12).

% veicoli disponibili

vehicle(v1).
vehicle(v2).

% costo unitario (es al km) del veicolo 

cost(v1,10).
cost(v2,15).

% nec(N,V): è necessario visitare N con il veicolo V

nec(b,v1).
nec(c,v2).




