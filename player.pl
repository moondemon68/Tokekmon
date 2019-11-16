:- dynamic(player/4).
% X, Y, DoneGym, TokemonList

% Starting values
startDoneGym(0).
startTokemon([budi]).

% Initialization
initPlayer :- 
    randomPosition(X, Y),
    startDoneGym(DoneGym),
    startTokemon(TokemonList),
    asserta(player(X, Y, DoneGym, TokemonList)),
    !.

% Update tokemons
addTokemon(Tokemon) :-
    retract(player(X, Y, DoneGym, TokemonList)),
    append([Tokemon], TokemonList, NewTokemonList),
    assertz(player(X, Y, DoneGym, NewTokemonList)).

delTokemon(Tokemon) :-
    retract(player(X, Y, DoneGym, TokemonList)),
    deleteList(Tokemon, TokemonList, NewTokemonList),
    assertz(player(X, Y, DoneGym, NewTokemonList)).

delTokemon2(Tokemon) :-
    retract(allTokemon(TokemonList)),
    deleteList(Tokemon, TokemonList, NewTokemonList),
    assertz(allTokemon(NewTokemonList)),
    retract(position(Tokemon, _, _)),
    assertz(position(Tokemon, -1, -1)), !.

drop(Tokemon) :- delTokemon(Tokemon), !.

% Movement (wasd)
moveW :-
    player(X, CurY, DoneGym, TokemonList),
    Y is CurY - 1,
    mapItem(X, Y, Item),!,
    Item \== fence,
    retract(player(X, CurY, DoneGym, TokemonList)),
    asserta(player(X, Y, DoneGym, TokemonList)), !.

moveS :-
    player(X, CurY, DoneGym, TokemonList),
    Y is CurY + 1,
    mapItem(X, Y, Item),!,
    Item \== fence,
    retract(player(X, CurY, DoneGym, TokemonList)),
    asserta(player(X, Y, DoneGym, TokemonList)), !.

moveA :-
    player(CurX, Y, DoneGym, TokemonList),
    X is CurX - 1,
    mapItem(X, Y, Item),!,
    Item \== fence,
    retract(player(CurX, Y, DoneGym, TokemonList)),
    asserta(player(X, Y, DoneGym, TokemonList)), !.

moveD :-
    player(CurX, Y, DoneGym, TokemonList),
    X is CurX + 1,
    mapItem(X, Y, Item),!,
    Item \== fence,
    retract(player(CurX, Y, DoneGym, TokemonList)),
    asserta(player(X, Y, DoneGym, TokemonList)), !.


