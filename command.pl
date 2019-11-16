start :-
	(\+game(_);game(X),X==0),
	animatePikachu1,
	sleep(0.2),
	cls,
	animatePikachu2,
	sleep(0.2),
	cls,
	animatePikachu1,
	sleep(0.2),
	cls,
	animatePikachu2,
	sleep(0.2),
	cls,
	animatePikachu1,
	sleep(0.2),
	cls,
	animatePikachu2,
	sleep(0.2),
	cls,
	write('Prolog : Tokemon ! Gotta catch \'em all'), nl,
	write('Hello There! Welcome to Tugas Besar Logkom! '), nl,
	write('My name is SHiNY and today you are lucky meeting me here.'), nl,
	write('This world is now dijajah by Tokemon, especially the legendary one.'), nl,
	write('You got one job, which is to capture those Legendary Tokemon to rescue the world like the avenger!!.'), nl,
	write(''), nl,
	sleep(0.5),
	help, nl,
	write('Legends:'), nl,
	write('  X = Pagar'), nl,
	write('  P = Player'), nl,
	write('  G = Gym'), nl,
	initRandom,
	initMap,
	initPlayer,
	initTokemon,
	initBattle, 
	(asserta(game(1));setGame(1)),
	!.
start :-
	nl, write('Game is already running'), nl, !.

help :-
	cls,
	nl, write('List of commands:'), nl,
	write('  start.\t\t-- Meet us! (Start a new game).'), nl,
	write('  help.\t\t\t-- Show list of commands.'), nl,
	write('  quit.\t\t\t-- Quit'), nl,
	write('  map.\t\t\t-- Print Map'), nl,
	write('  w. a. s. d.\t\t-- Move (Like In Point Blank)'), nl,
	write('  heal.\t\t\t-- Heal Tokemon if you are in gym center'), nl,
	write('  status.\t\t-- Status'), nl,
	write('  saveGame(Filename).\t-- Save game'), nl,
	write('  loadGame(Filename).\t-- Load game'), nl. 

quit :- 
	cls,
	write('Bye-bye!'), nl,
	halt.

heal :- 
	player(X,Y,DoneGym,_),
	mapItem(X,Y,gym),
	(DoneGym == 0 ->  write('Tengtengtengtengteng! All your tokemons are healthy now!'), healT, retract(player(A,B,_,C)),assertz(player(A,B,1,C));
	DoneGym == 1 -> write('You already visited Gym! Cannot heal! ULULULU')),!.

healT :- 
	forall(tokemon(Tokemon), healT2(Tokemon)).

healT2(Tokemon) :-
	% player(_,_,_,TokemonList),
	% isMember(TokemonList,Tokemon),
	starthp(Tokemon,X),
	setHp(Tokemon,X).
healT2(_).

status :- 
	cls,
	write('Your Tokemon:'), nl,
	player(_, _, _, TokemonList),
    printTokemon(TokemonList).

printTokemon([]):-!.
printTokemon([H|T]):-
	tokemonStatus(H),nl,printTokemon(T).

moveWf :-
	player(X, CurY, _, _),
    Y is CurY - 1,
	mapItem(X, Y, fence),!,
	write('There\'s a fence in front of you!.').

map :- 
	cls,
	printMap(1, 1), !.
isGym :-
	player(X, Y,_,_),
    mapItem(X, Y, Item),!,
	(Item == gym ->
	write('You are in gym now!! If you wanna heal type \'heal\'\n'),
	write('Ignore me if you dont want to')).

w :-
	game(1),
	moveW,
	map,
	msgW,
	checkTokemon,
	isGym,
	write('Good ....'), nl,
    !.

s :-
	game(1),
	moveS,
	map,
	msgS,
	checkTokemon,
	isGym,
    !.

a :-
	game(1),
	moveA,
	map,
	msgA,
	checkTokemon,
	isGym,
    !.

d :-
	game(1),
	moveD,
	map,
	msgD,
	checkTokemon,
	isGym,
    !.
