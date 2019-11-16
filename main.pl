:- dynamic(game/1).

:- include('utils.pl').
:- include('player.pl').
:- include('command.pl').
:- include('messages.pl').
:- include('map.pl').
:- include('battle2.pl').
% :- include('battle.pl').
:- include('tokemon.pl').
:- include('test.pl').

setGame(Game) :-
    retract((game(_))),
    assertz(game(Game)), !.
    
    