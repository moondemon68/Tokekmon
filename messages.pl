msgW :-
    write('\nGoing upp 1 block...\n').
msgS :-
    write('\nGoing downn 1 block...\n').
msgA :-
    write('\nGoing left 1 block...\n').
msgD :-
    write('\nGoing right (when nothing goes wrong) 1 block...\n').
msgFence :- 
    write('\nyOu crashed into a fence!!!!!\n'),
    write('You lost your dignity crashing into a fence!\n').
msgGym :-
    write('\nYou are now in the Gym!\n'),
    write('You can only heal once.\n'),
    write('Write "heal" to heal, ignore me if you don\'t want to\n').

