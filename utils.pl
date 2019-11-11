% :- include('map.pl').
% :- include('utils.pl').
% :- include('player.pl').

% Move with random direction (FIX)
randomDirection(X, Y) :-
    random_between(0, 3, Dir),
    (Dir == 0 -> 
        Y2 is Y + 1, mapItem(X, Y2, Item), Item \== fence, Y is Y2; 
    Dir == 1 -> 
        X2 is X + 1, mapItem(X2, Y, Item), Item \== fence, X is X2; 
    Dir == 2 -> 
        Y2 is Y - 1, mapItem(X, Y2, Item), Item \== fence, Y is Y2; 
    Dir == 3 -> 
        X2 is X - 1, mapItem(X2, Y, Item), Item \== fence, X is X2).

% Generate random position
randomPosition(X, Y) :-
    random_between(2, 11, TX),
    random_between(2, 11, TY),
    mapItem(TX, TY, Item),
    Item \== fence,
    X is TX,
    Y is TY.

% Generate random number (for chance percentage)
chance(X) :-
    random_between(0, 100, Rand),
    Rand =< X.

% Delete one item from list
deleteList(_, [], []).
deleteList(I, [I|T], T) :- !.
deleteList(I, [H|T], [H|R]) :- 
    deleteList(I, T, R).

