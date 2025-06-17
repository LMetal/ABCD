Il file tspbasic.lp, da utilizzare insieme a data1.lp o data2.lp, contiene
una soluzione di una versione del problema del commesso viaggiatore in cui:

- ci sono dei nodi da visitare (togo) a partire da un nodo iniziale (start)

- sono date le distanze per ogni coppia di nodi

- si deve trovare una soluzione per visitare tutti i nodi, minimizzando la distanza percorsa

L'esercizio consiste in quanto segue.

A) scrivere in un file check.lp regole per verificare che in un file di dati:

- per ogni coppia di nodi "togo" sia fornita una distanza

- le distanze rispettino la disuguaglianza triangolare, che, espressa indicando con d(X,Y) la distanza tra X e Y, è: d(X,Y) <= d(X,Z) + d(Z,Y)

In output devono risultare le eventuali violazioni.

B) scrivere in un file tspmv.lp una soluzione che tenga conto di dati quali quelli in data1add.lp o data2add.lp, che indicano:

1. quali sono i diversi veicoli a disposizione
2. per ciascuno, il costo complessivo (acquisto o noleggio, manutenzione, energia) per unità di distanza (km) 
3. che e' richiesto di visitare alcuni nodi con uno specifico veicolo (es furgone per trasporto materiale, veicolo per trasporto disabili)

e' necessario, utilizzando uno o più veicoli, trovare dei percorsi per visitare tutti i nodi, partendo e tornando al nodo di partenza per ciascun veicolo utilizzato, rispettando gli eventuali requisiti del punto 3, e minimizzando il costo complessivo

Per verificare i risultati: nel caso di data1-data1add il costo della soluzione migliore e' 920; per data2-data2add, il costo è 1535.
Le soluzioni migliori per data1-data1add prevedono che v1 faccia a-b-a e v2 faccia a-d-c-e-a o viceversa.
