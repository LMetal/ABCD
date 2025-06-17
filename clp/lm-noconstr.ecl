lightmeal(H,M,D,T):-
	horsdoeuvre(H,X),
	maincourse(M,Y),
	dessert(D,Z),
	T is X+Y+Z, T<10.

horsdoeuvre(pate,5.0).
horsdoeuvre(salad,1.0).

maincourse(pork,7.0).
maincourse(lobster,2.0).
maincourse(tuna,4.0).
maincourse(beef,5.0).

dessert(icecream,4.0).
dessert(fruitsalad,2.0).
dessert(cheesecake,5.0).
