start :- 
	write('Prolog : Tokemon ! Gotta catch \'em all'),nl,
	write('Hello There! Welcome to Tugas Besar Logkom! '),nl,
	write('My name is SHiNY and today you are lucky meeting me here.'),nl,
	write('This world is now dijajah by Tokemon, especially the legendary one.'),nl,
	write('You got one job, which is to capture those Legendary Tokemon to rescue the world like the avenger!!.'),nl,
	write(''),nl,
	help,
	nl,write('Legends:'),nl,
	write('  X = Pagar'),nl,
	write('  P = Player'),nl,
	write('  G = Gym'),nl,
	initRandom,
	initMap,
	initPlayer,
	initTokemon,
	!.

help :-
	nl,write('List of commands:'),nl,
	write('  start.\t\t-- Meet us! (Start a new game).'),nl,
	write('  help.\t\t\t-- Show list of commands.'),nl,
	write('  quit.\t\t\t-- Quit'),nl,
	write('  map.\t\t\t-- Print Map'),nl,
	write('  w. a. s. d.\t\t-- Move (Like In Point Blank)'),nl,
	write('  heal.\t\t\t-- Heal Tokemon if you are in gym center'),nl,
	write('  status.\t\t-- Status'),nl,
	write('  save(Filename).\t-- Save game'),nl,
	write('  load(Filename).\t-- Load game'),nl. 

quit :- write('Bye-bye!'),nl,halt.

%heal :- 
	%startDoneGym(DoneGym),
	%(DoneGym == 0 ->  write('Tengtengtengtengteng'), healT;
	%DoneGym == 1 -> write('You already visited Gym! Cannot heal! ULULULU')).

%healT :- asserta(player(X, Y, 1, TokemonList)),

status :- 
	write('Your Tokemon:'),nl,
	player(_,_,_,TokemonList),
	printTokemon(TokemonList),!.

printTokemon([]):-!.
printTokemon([H|T]):-
	write(H),nl,printTokemon(T),!.

map :- printMap(1, 1), !.

w :-
    moveW,
    msgW,
    !.
s :-
    moveS,
    msgS,
    !.
a :-
    moveA,
    msgA,
    !.
d :-
    moveD,
    msgD,
    !.
