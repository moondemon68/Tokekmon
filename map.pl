:- dynamic(position/3).
% X, Y, symbol
:- dynamic(mapItem/3).
% X, Y, item

% Map printing
% Valid locations for items: 2 <= X, Y <= 11.
printMap(13, 12) :- newline, !.
printMap(13, Y) :-
    Y2 is Y + 1,
    newline,
    printMap(1, Y2).
printMap(X, Y) :-
    X2 is X + 1, 
    printItem(X, Y), 
    !, 
    printMap(X2, Y).

% Item printing
printItem(X, Y) :- 
    player(X, Y, _, _),
    printPlayer.
printItem(X, Y) :-
    mapItem(X, Y, fence),
    printFence.
printItem(X, Y) :-
    mapItem(X, Y, gym),
    printGym.
printItem(X, Y) :-
    mapItem(X, Y, grass),
    printGrass.
printPlayer :- write('P').
printFence :- write('X').
printGym :- write('G').
printGrass :- write('-').

% Update map item
updateMap(X, Y, Item) :- call(position(X, Y, A)), retract(position(X, Y, A)), assertz(position(X, Y, Item)), !.

% Item definitions (including boundaries)
initMap :-
    asserta(mapItem(_, _, grass)),
    asserta(mapItem(1, 1, fence)),
    asserta(mapItem(1, 2, fence)),
    asserta(mapItem(1, 3, fence)),
    asserta(mapItem(1, 4, fence)),
    asserta(mapItem(1, 5, fence)),
    asserta(mapItem(1, 6, fence)),
    asserta(mapItem(1, 7, fence)),
    asserta(mapItem(1, 8, fence)),
    asserta(mapItem(1, 9, fence)),
    asserta(mapItem(1, 10, fence)),
    asserta(mapItem(1, 11, fence)),
    asserta(mapItem(1, 12, fence)),
    asserta(mapItem(12, 1, fence)),
    asserta(mapItem(12, 2, fence)),
    asserta(mapItem(12, 3, fence)),
    asserta(mapItem(12, 4, fence)),
    asserta(mapItem(12, 5, fence)),
    asserta(mapItem(12, 6, fence)),
    asserta(mapItem(12, 7, fence)),
    asserta(mapItem(12, 8, fence)),
    asserta(mapItem(12, 9, fence)),
    asserta(mapItem(12, 10, fence)),
    asserta(mapItem(12, 11, fence)),
    asserta(mapItem(12, 12, fence)),
    asserta(mapItem(1, 1, fence)),
    asserta(mapItem(2, 1, fence)),
    asserta(mapItem(3, 1, fence)),
    asserta(mapItem(4, 1, fence)),
    asserta(mapItem(5, 1, fence)),
    asserta(mapItem(6, 1, fence)),
    asserta(mapItem(7, 1, fence)),
    asserta(mapItem(8, 1, fence)),
    asserta(mapItem(9, 1, fence)),
    asserta(mapItem(10, 1, fence)),
    asserta(mapItem(11, 1, fence)),
    asserta(mapItem(12, 1, fence)),
    asserta(mapItem(1, 12, fence)),
    asserta(mapItem(2, 12, fence)),
    asserta(mapItem(3, 12, fence)),
    asserta(mapItem(4, 12, fence)),
    asserta(mapItem(5, 12, fence)),
    asserta(mapItem(6, 12, fence)),
    asserta(mapItem(7, 12, fence)),
    asserta(mapItem(8, 12, fence)),
    asserta(mapItem(9, 12, fence)),
    asserta(mapItem(10, 12, fence)),
    asserta(mapItem(11, 12, fence)),
    asserta(mapItem(12, 12, fence)),
    randomPosition(X1, Y1),
    asserta(mapItem(X1, Y1, fence)),
    randomPosition(X2, Y2),
    asserta(mapItem(X2, Y2, fence)),
    randomPosition(X3, Y3),
    asserta(mapItem(X3, Y3, fence)),
    randomPosition(X4, Y4),
    asserta(mapItem(X4, Y4, fence)),
    randomPosition(X5, Y5),
    asserta(mapItem(X5, Y5, fence)),
    randomPosition(X6, Y6),
    asserta(mapItem(X6, Y6, fence)),
    randomPosition(X7, Y7),
    asserta(mapItem(X7, Y7, fence)),
    randomPosition(X8, Y8),
    asserta(mapItem(X8, Y8, fence)),
    randomPosition(X9, Y9),
    asserta(mapItem(X9, Y9, fence)),
    randomPosition(X10, Y10),
    asserta(mapItem(X10, Y10, fence)),
    randomPosition(X11, Y11),
    asserta(mapItem(X11, Y11, fence)),
    randomPosition(X12, Y12),
    asserta(mapItem(X12, Y12, fence)),
    randomPosition(X13, Y13),
    asserta(mapItem(X13, Y13, fence)),
    randomPosition(X14, Y14),
    asserta(mapItem(X14, Y14, fence)),
    randomPosition(X15, Y15),
    asserta(mapItem(X15, Y15, fence)),
    randomPosition(XG, YG),
    asserta(mapItem(XG, YG, gym)),
    !.
