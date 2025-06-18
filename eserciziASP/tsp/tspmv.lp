%distanza simmetrica
dist(X,Y,D) :- dist(Y,X,D).

%ogni nodo visitato da almeno un veicolo
1 { visit(X,V) : vehicle(V) } :- togo(X).

%visita veicolo richiesta in determinato nodo
visit(X,V) :- nec(X,V).

%veicolo usato = ha visitato almeno un nodo
used(V) :- visit(X,V).

%primo arco in uscita da start
1 { go(S,Y,V) : dist(S,Y,_), visit(Y,V), start(S), S != Y } 1:- used(V).

%ultimo arco entrante in start (torna allo start)
1 { go(X,S,V) : dist(X,S,_), visit(X,V), start(S), X != S } 1:- used(V).

%un nodo ha un solo arco in uscita per ogni veicolo (grafo denso, disuguaglianza triangolare)
1 { go(X,Y,V) : dist(X,Y,_), visit(Y,V), X != Y } 1:- visit(X,V).

%un nodo ha un solo arco in entrata per ogni veicolo (grafo denso, disuguaglianza triangolare)
1 { go(X,Y,V) : dist(X,Y,_), visit(X,V), X != Y } 1:- visit(Y,V).

%nodo raggiungibile da start
reach(Y,V) :- go(S,Y,V), start(S).
reach(Y,V) :- go(X,Y,V), reach(X,V).
:- visit(X,V), not reach(X,V).


%minimizza costo
#minimize { D*C,X,Y,V : go(X,Y,V), dist(X,Y,D), cost(V,C) }.

%output
#show go/3.