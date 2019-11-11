/* 
Kelompok : 8
1. Arief Darmawan Tantriady (13518015).
2. Muh.Muslim Al Mujahid (13518054).
3. Morgen Sudyanto (13518093).
4. Moch. Nafkhan Alzamzami (13518132).
*/

:- use_module(library(random)).

% 0 = north, 1 = east, 2 = south, 3 = west
randomDir(D) :- random_between(0, 3, D).

% ADT Tokemon
% Nama, Tipe, HP, Damage Normal, Damage Skill, IsLegendary, LocX, LocY
:- dynamic(tokemon/8).
tokemon(buda, fire, 35, 10, 25, 0, -1, -1).
tokemon(rali, leaf, 100, 20, 75, 0, 3, 4).
tokemon(carimender, fire, 123, 6, 52, 0, 5, 6).
tokemon(harlele, water, 65, 1, 35, 0, 6, 7).
tokemon(camcam, leaf, 135, 18, 36, 0, 6, 8).
tokemon(abuy, water, 180, 35, 80, 0, 3, 6).
tokemon(ibunyabudi, fire, 1351, 81, 470, 1, 5, 2).
tokemon(engi, water, 3500, 100, 225, 1, 8, 1).
tokemon(poontoon, leaf, 5300, 500, 1250, 1, 1, 9).
    
% ADT Pemain
% ListTokemon, LocX, LocY, SudahGym
:- dynamic(pemain/4).
pemain([buda], 0, 0, 0).

% ADT Peta
:- dynamic(peta/1).
peta([['X','X','X','X','X','X','X','X','X','X','X','X'],
['X',-,-,-,-,-,-,-,-,-,-,'X'],['X',-,-,-,-,-,-,-,-,-,-,'X'],['X',-,-,-,-,-,-,-,-,-,-,'X'],
['X',-,-,-,-,-,-,-,-,-,-,'X'],['X',-,-,-,-,-,-,-,-,-,-,'X'],['X',-,-,-,-,-,-,-,-,-,-,'X'],
['X',-,-,-,-,-,-,-,-,-,-,'X'],['X',-,-,-,-,-,-,-,-,-,-,'X'],['X',-,-,-,-,-,-,-,-,-,-,'X'],
['X',-,-,-,-,-,-,-,-,-,-,'X'],
['X','X','X','X','X','X','X','X','X','X','X','X']]).

% Menghitung Legendary
:- dynamic(count_legendary/1).
count_legendary(3).

% Save/Load Game
% TODO
