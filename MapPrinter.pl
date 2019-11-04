printMap(Map) :- printRows(Map).
printRows([]).
printRows([H|T]) :- printRow(H), nl, printRows(T).
printRow([]).
printRow([H|T]) :- write(H), printRow(T).
