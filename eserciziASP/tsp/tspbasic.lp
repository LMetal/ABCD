% assume distance dist(X,Y,D) given for every pair
% but not twice for X,Y and Y,X, so:

dist(X,Y,N) :- dist(Y,X,N).

% one outgoing, one ingoing for each "togo" node

1 { go(X,Y) : togo(Y), X!=Y } 1 :-  togo(X). 
1 { go(X,Y) : togo(X), X!=Y } 1 :-  togo(Y). 

% all reachable from start node

reach(Y) :- go(X,Y),start(X).
reach(Y) :- go(X,Y),reach(X).

:- togo(X), not reach(X).

#minimize { D,X : go(X,Y),dist(X,Y,D) }.

#show go/2.
