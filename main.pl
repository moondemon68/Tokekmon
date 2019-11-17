:- dynamic(game/1).

:- include('utils.pl').
:- include('player.pl').
:- include('command.pl').
:- include('messages.pl').
:- include('map.pl').
:- include('battle.pl').
:- include('tokemon.pl').
:- include('saveload.pl').

setGame(Game) :-
    retract((game(_))),
    assertz(game(Game)), !.

gameFinish :- 
    allTokemon(X),
    noLegendary(X),
    write('COngratulations! YOu win this game!\n'), 
    halt,!.

noLegendary([]).
noLegendary(List) :-
    List = [Tokemon|T],
    isLegendary(Tokemon, 0),
    noLegendary(T), !.

    