:- dynamic(game/1).

:- include('utils.pl').
:- include('player.pl').
:- include('command.pl').
:- include('messages.pl').
:- include('map.pl').
:- include('battle2.pl').
:- include('tokemon.pl').

setGame(Game) :-
    retract((game(_))),
    assertz(game(Game)), !.
    
    
