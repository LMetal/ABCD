%Leonardo Galliera 20045207

% numero auto necessarie (anche ((n-1)/4)+1 )

autotot(N) :- N=n/4, n\4=0.
autotot(N) :- N=n/4+1, n\4>0.




% in output deve risultare l'assegnazione e le eventuali violazioni dell'ultima
% condizione


% scrivere regole per fare in modo che vengano scelte le auto in numero uguale
% a quelle necessarie
{auto_scelta(A) : ha_auto(A)} = N :- autotot(N).

%ogni persona in esattamente una auto
{in_auto(P, A) : auto_scelta(A)} = 1 :- p(P).

% che ad ogni auto scelta siano assegnate tra 2 e 4 persone, compreso il proprietario,
:- auto_scelta(A), #count{P : in_auto(P, A)} < 2.
:- auto_scelta(A), #count{P : in_auto(P, A)} > 4.

% che ad ogni auto sia assegnato un altro partecipante che guida
:- auto_scelta(A), not #count{P : in_auto(P, A), guida(P), P != A} >= 1.

%il proprietario deve essere nella sua auto se è scelta
:- auto_scelta(A), not in_auto(A, A).

% che due partecipanti non siano assegnati alla stessa auto se uno non vuole l'altro
:- in_auto(P1, A), in_auto(P2, A), nv(P1, P2).
:- in_auto(P1, A), in_auto(P2, A), nv(P2, P1).

% e che possibilmente siano nella stessa auto se uno vuole l'altro
violazione_preferenza(P1, P2) :- v(P1, P2), not same_auto(P1, P2).

%ottimizza numero di violazione_preferenza, ognuna peso 1
#minimize{1@1, P1, P2 : violazione_preferenza(P1, P2)}.


%utils
same_auto(P1, P2) :- in_auto(P1, A), in_auto(P2, A), P1 != P2.

assegnazione(P, A) :- in_auto(P, A).

guidatore_auto(P, A) :- in_auto(P, A), guida(P).

#show assegnazione/2.
#show guidatore_auto/2.
#show violazione_preferenza/2.
#show auto_scelta/1.
