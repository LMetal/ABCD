/* alcuni degli esempi ed esercizi del cap. 5 del testo di Marriott e Stuckey

svolgere gli esercizi 5.3 e 5.7 */

:- lib(clpr).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          5.3 Iteration                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
% mortgage program p175.
mortgage(P,T,_I,_R,B)   :-  {T = 0}, {B = P}. 
mortgage(P,T,I,R,B)  :-  {T >= 1, 
   NP = P + P * I - R, 
   NT = T - 1}, 
   mortgage(NP,NT,I,R,B).
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        5.7 Practical Exercises                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Practical Exercise 5.3

/* una molla con costante k esercita una forza kx se compressa o estesa
per una distanza x rispetto alla sua posizione naturale, 
quindi possiamo scrivere la relazione:

spring(F,K,X) :- {F = K*X }.

In un vano di lunghezza L (vedere figura) ci sono 2 molle di lunghezza L1 e L2
con costanti K1 e K2 all'interno delle quali viene inserito un oggetto 
di lunghezza W.
La somma L1+L2+W puo' essere maggiore di L, nel qual caso le molle verranno
compresse, o minore di L, nel qual caso (supponendo di agganciare le molle
alle estremita' dell'oggetto) le molle risulteranno estese.

Definire una relazione:

stable(L,L1,K1,L2,K2,W,X)

che valga quando X e' la distanza dell'oggetto dall'estremita' sinistra
del vano (vedere figura) quando l'oggetto e' inserito fra le molle
ed e' in posizione stabile (suggerimento di fisica: vuol dire che le forze 
esercitate sull'oggetto dalle due molle si compensano) 

Usarla per trovare dove si posiziona un oggetto lungo 10 cm in un vano di 20 cm,
con molle con L1=10 cm, K1=1 N/cm (1 Newton al centimetro), L2=6 cm, K2 = 2 N/cm
(risposta: X=6, cioe' la molla 1 si comprime da 10 a 6 cm)
Trovare dove si posiziona un oggetto lungo 1 cm con le altre condizioni uguali
(risposta: X=12 cioe' la molla 1 si estende di 2 cm)
Trovare la lunghezza dell'oggetto che in posizione stabile comprime la molla 1
a 8 cm
(risposta: W=7) 

*/

% Practical Exercise 5.7 (con qualche variante)

/* la relazione flight(S,E,D) corrisponde all'esistenza di un
volo da S a E con distanza D;
*/

flight(melbourne, sydney,1000.0).
flight(melbourne, perth,4000.0).
flight(perth, singapore,5000.0).
flight(sydney, singapore,8500.0).
flight(melbourne, cairns,4000.0).
flight(sydney, cairns,3200.0).
flight(cairns, singapore,4900.0). 
flight(singapore, london,10000.0). 
flight(perth, bahrain,8000.0). 
flight(bahrain, london,6500.0).


/* definire una relazione 

path(S,E,D,P) 

che corrisponda all'esistenza di un percorso P da S ad E con distanza 
complessiva D, ottenendo ad esempio:

?- path(melbourne, singapore, D, P).
D = 9500.0
P = [melbourne, sydney, singapore]

e altre 3 risposte. 

Usando minimize(G,E) che trova la soluzione di G che minimizza E, definire poi
una relazione

shortest_path(S,E,D,P) 

con significato: P è il percorso minimo da S ad E, di distanza D, ad esempio:

?- shortest_path(melbourne, london, D, P).
D = 18500.0
P = [melbourne, perth, bahrain, london]


*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% stuff for minimization see chapter 9 %%%%%%%%%%%%%%%%%%%

minimize(G, E) :- 
                      get_min_value(G, E, M),
                      {E = M},
                      call(G).
  
get_min_value(G, E, _) :-
        apply_new_bound(E),
        once(G),
	minimize(E), %% additional call to ensure ground result
        record_better_bound(E),
        fail.
get_min_value(_, _, M) :- erase(bestbound,M).
  
apply_new_bound(_).
apply_new_bound(E) :- 
                          erase(currentbound,B),
                          record(bestbound,B),
                          {E < B},
                          apply_new_bound(E).
  
record_better_bound(E) :- 
                         (erase(bestbound,_) -> true ; true),
                         record(currentbound,E).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




