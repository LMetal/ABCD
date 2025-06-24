% n partecipanti ad una vacanza devono essere divisi in gruppi per 
% viaggiare in auto


% quanti partecipanti

#const n=10.

p(1..n).

% alcuni partecipanti hanno a disposizione un'auto
% supponiamo che gli stessi possano guidare (anche auto altrui)

ha_auto(1).
ha_auto(3).
ha_auto(5).
ha_auto(7).

guida(P) :- ha_auto(P).

% altri sono disposti a guidare

guida(2).
guida(4).
guida(6).

% qualche partecipante non vuole stare in auto con un altro

nv(6,10).

% qualche partecipante vuole stare in auto con un altro

v(8,3).
v(9,3).
v(10,3).


