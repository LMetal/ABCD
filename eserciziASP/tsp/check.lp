%distanze simmetriche
dist(X,Y,N) :- dist(Y,X,N).

%per ogni coppia di nodi "togo" sia fornita una distanza
missing_distance(X,Y) :- togo(X), togo(Y), X != Y, not dist(X,Y,_).

%le distanze rispettino la disuguaglianza triangolare -> d(X,Y) <= d(X,Z) + d(Z,Y)
triangle_violation(X,Y,Z) :- 
    togo(X), togo(Y), togo(Z),
    X != Y, Y != Z, X != Z, % 3 nodi diversi
    dist(X,Y,DXY), dist(X,Z,DXZ), dist(Z,Y,DZY),
    DXY > DXZ + DZY.

#show missing_distance/2.
#show triangle_violation/3.