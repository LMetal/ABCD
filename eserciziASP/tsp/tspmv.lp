% --- Input atteso da file dati ---
% start(S).             % nodo di partenza (es. start(a).)
% togo(X).              % nodi da visitare (X ≠ start)
% vehicle(V).           % veicoli disponibili
% cost(V,C).            % costo per unità di distanza per veicolo V
% dist(X,Y,D).          % distanza fra nodi (eventualmente solo metà matrice)
% nec(X,V).             % nodo X deve essere visitato da veicolo V

% --- Rendi la distanza simmetrica ---
dist(X,Y,D) :- dist(Y,X,D).

% --- Ogni nodo deve essere visitato da almeno un veicolo ---
1 { visit(X,V) : vehicle(V) } :- togo(X).

% --- Se è necessario un veicolo specifico per un nodo, forzalo ---
visit(X,V) :- nec(X,V).

% --- Un veicolo è usato se visita almeno un nodo ---
used(V) :- visit(X,V).

% --- Arco in uscita dal nodo di partenza per ogni veicolo usato ---
1 { go(S,Y,V) : togo(Y), visit(Y,V), S != Y, start(S) } 1 :- used(V).

% --- Arco in ingresso al nodo di partenza per ogni veicolo usato ---
1 { go(X,S,V) : togo(X), visit(X,V), X != S, start(S) } 1 :- used(V).

% --- Ogni nodo visitato da un veicolo ha un solo arco in uscita ---
1 { go(X,Y,V) : togo(Y), visit(Y,V), X != Y } 1 :- visit(X,V), togo(X).

% --- Ogni nodo visitato da un veicolo ha un solo arco in ingresso ---
1 { go(X,Y,V) : togo(X), visit(X,V), X != Y } 1 :- visit(Y,V), togo(Y).

% --- Connettività: tutti i nodi visitati devono essere raggiungibili da start ---
reach(Y,V) :- go(S,Y,V), start(S).
reach(Y,V) :- go(X,Y,V), reach(X,V).

:- visit(X,V), togo(X), not reach(X,V).

% --- Coerenza: si può andare da/verso un nodo solo se lo si visita ---
:- go(X,Y,V), togo(X), not visit(X,V).
:- go(X,Y,V), togo(Y), not visit(Y,V).

% --- Non partire o tornare allo start con veicolo non usato ---
:- go(S,Y,V), not used(V), start(S).
:- go(X,S,V), not used(V), start(S).

% --- Minimizzazione del costo totale ---
#minimize { D*C,X,Y,V : go(X,Y,V), dist(X,Y,D), cost(V,C) }.

% --- Output utile ---
#show visit/2.
#show go/3.
#show used/1.