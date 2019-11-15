% Move with random direction (FIX)
initRandom :-
   real_time(TS),
   set_seed(TS),
   !.

randomDirection(X, Y) :-
    random(0, 4, Dir),
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
    random(2, 12, TX),
    random(2, 12, TY),
    mapItem(TX, TY, Item),
    Item \== fence,
    X is TX,
    Y is TY.

% Generate random number (for chance percentage)
chance(X) :-
    random(0, 101, Rand),
    write(Rand),
    Rand =< X.

% Delete one item from list
deleteList(_, [], []).
deleteList(I, [I|T], T) :- !.
deleteList(I, [H|T], [H|R]) :- 
    deleteList(I, T, R).

% Print list element following by number
% <number>. <List element>
% ...................
% ...................
printList([],_).
printList(List, N) :-
    List = [H|T],
    write(N),
    write('. '),
    write(H),nl,
    N2 is N+1,
    printList(T,N2). 

% Count list element
countList([], 0).
countList([_|T], N) :- 
    countList(T, N1),
    N is N1+1.

% get element list by index
elByIndex([El|_], 1, El).
elByIndex(List, Idx, El) :-
    List = [_|T],
    Idx2 is Idx-1,
    elByIndex(T, Idx2, El).
