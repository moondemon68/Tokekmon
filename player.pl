% :- include('map.pl').
% :- include('utils.pl').
% :- include('player.pl').

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
    assert(player(X, Y, DoneGym, TokemonList)),
    !.

% Update tokemons
addTokemon(Tokemon) :-
    retract(player(X, Y, DoneGym, TokemonList)),
    append([Tokemon], TokemonList, NewTokemonList),
    asserta(player(X, Y, DoneGym, NewTokemonList)).

delTokemon(Tokemon) :-
    retract(player(X, Y, DoneGym, TokemonList)),
    delete_one([Tokemon], TokemonList, NewTokemonList),
    asserta(player(X, Y, DoneGym, NewTokemonList)).

% Movement (wasd)
moveW :-
    player(X, CurY, DoneGym, TokemonList),
    CurY > 2,
    Y is CurY - 1,
    mapItem(X, Y, Item),
    Item \== fence,
    retract(player(X, CurY, DoneGym, TokemonList)),
    asserta(player(X, Y, DoneGym, TokemonList)).

moveS :-
    player(X, CurY, DoneGym, TokemonList),
    CurY < 11,
    Y is CurY + 1,
    mapItem(X, Y, Item),
    Item \== fence,
    retract(player(X, CurY, DoneGym, TokemonList)),
    asserta(player(X, Y, DoneGym, TokemonList)).

moveA :-
    player(CurX, Y, DoneGym, TokemonList),
    CurX > 2,
    X is CurX - 1,
    mapItem(X, Y, Item),
    Item \== fence,
    retract(player(CurX, Y, DoneGym, TokemonList)),
    asserta(player(X, Y, DoneGym, TokemonList)).

moveD :-
    player(CurX, Y, DoneGym, TokemonList),
    CurX < 11,
    X is CurX + 1,
    mapItem(X, Y, Item),
    Item \== fence,
    retract(player(CurX, Y, DoneGym, TokemonList)),
    asserta(player(X, Y, DoneGym, TokemonList)).