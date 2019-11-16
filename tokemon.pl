% ADT Tokemon

% Nama, Tipe, HP, Damage Normal, Damage Skill, IsLegendary
% :- dynamic(tokemon/6).
:- dynamic(hp/2).
:- dynamic(position/3).
:- dynamic(allTokemon/1).
:- dynamic(allTokemon/1).

tokemon(budi).
tokemon(rali).
tokemon(carimender).
tokemon(harlele).
tokemon(camcam).
tokemon(abuy).
tokemon(ibunyabudi).
tokemon(engi).
tokemon(poontoon).
attribute(budi,fire).
attribute(rali, leaf).
attribute(carimender, fire).
attribute(harlele,water).
attribute(camcam, leaf).
attribute(abuy, water).
attribute(ibunyabudi, fire).
attribute(engi, water).
attribute(poontoon, leaf).
normalDamage(budi,25).
normalDamage(rali, 20).
normalDamage(carimender, 6).
normalDamage(harlele,1).
normalDamage(camcam, 18).
normalDamage(abuy, 35).
normalDamage(ibunyabudi, 81).
normalDamage(engi, 100).
normalDamage(poontoon, 500).
skillDamage(budi, 3000).
skillDamage(rali, 50).
skillDamage(carimender, 52).
skillDamage(harlele,35).
skillDamage(camcam, 36).
skillDamage(abuy, 80).
skillDamage(ibunyabudi, 470).
skillDamage(engi, 225).
skillDamage(poontoon, 1250).
isLegendary(budi, 0).
isLegendary(rali, 0).
isLegendary(harlele, 0).
isLegendary(carimender, 0).
isLegendary(harlele, 0).
isLegendary(camcam, 0).
isLegendary(abuy, 0).
isLegendary(ibunyabudi, 1).
isLegendary(engi, 1).
isLegendary(poontoon, 1).
starthp(budi,1200).
starthp(rali, 100).
starthp(carimender, 123).
starthp(harlele,10).
starthp(camcam, 135).
starthp(abuy, 180).
starthp(ibunyabudi, 1351).
starthp(engi, 3500).
starthp(poontoon, 5300).

randomPositionTokemon(X, Y) :-
    randomPosition(X, Y),
    \+(position(_, X, Y)).

initTokemonPosition :-
    forall(tokemon(Tokemon), (tokemon \== budi, randomPosition(X, Y), asserta(position(Tokemon, X, Y)))).
    
initTokemon :-
    initTokemonPosition,
    asserta(allTokemon([rali, carimender, harlele, camcam, abuy, ibunyabudi, engi, poontoon])),
    asserta(hp(budi,1200)),
    asserta(hp(rali, 100)),
    asserta(hp(carimender, 123)),
    asserta(hp(harlele,10)),
    asserta(hp(camcam, 135)),
    asserta(hp(abuy, 180)),
    asserta(hp(ibunyabudi, 1351)),
    asserta(hp(engi, 3500)),
    asserta(hp(poontoon, 5300)).

% primitif
setHp(Name, NewHp) :-
    retract(hp(Name, _)) ->
    assertz(hp(Name, NewHp)), !.

tokemonStatus(Tokemon) :-
    attribute(Tokemon, Att),
    hp(Tokemon, Hp),
    normalDamage(Tokemon, NormalDmg),
    skillDamage(Tokemon, SkillDmg),
    isLegendary(Tokemon, IsLegendary),
    divider,
    write(' Name\t\t: '), write(Tokemon), nl,
    write(' Attribut\t: '), write(Att), nl,
    write(' HP\t\t: '), write(Hp), nl, 
    write(' Normal Damage\t: '), write(NormalDmg), nl, 
    write(' Skill Damage\t: '), write(SkillDmg), nl,
    write(' Legendary\t: '), (IsLegendary == 1 -> write('yes'); write('no')), nl,
    divider,
    !.

tokemonPost :-
    tokemon(T),
    position(T, X, Y),
    write(T), write(' '), write(X), write(' '), write(Y), nl.

moveTokemon :- forall(tokemon(Tokemon), tmove(Tokemon)).

tmove(Tokemon) :-
    random(1, 101, Rand),
    (Rand >= 51 -> tmoveD(Tokemon);
    Rand =< 50 -> tmoveA(Tokemon);
    Rand >= 51 -> tmoveS(Tokemon);
    Rand =< 50 -> tmoveW(Tokemon)).
tmove(_).

tmoveW(Tokemon) :-
    position(Tokemon, X, CurY),
    CurY > 2,
    Y is CurY - 1,
    mapItem(X, Y, Item),!,
    Item \== fence,
    \+position(_, X, Y),
    retract(position(Tokemon, X, CurY)),
    asserta(position(Tokemon, X, Y)).

tmoveS(Tokemon) :-
    position(Tokemon, X, CurY),
    CurY < 11,
    Y is CurY - 1,
    mapItem(X, Y, Item),!,
    Item \== fence,
    \+position(_, X, Y),
    retract(position(Tokemon, X, CurY)),
    asserta(position(Tokemon, X, Y)).

tmoveA(Tokemon) :-
    position(Tokemon, CurX, Y),
    CurX > 2,
    X is CurX - 1,
    mapItem(X, Y, Item),!,
    Item \== fence,
    \+position(_, X, Y),
    retract(position(Tokemon, CurX, Y)),
    asserta(position(Tokemon, X, Y)).

tmoveD(Tokemon) :-
    position(Tokemon, CurX, Y),
    CurX < 11,
    X is CurX + 1,
    mapItem(X, Y, Item),!,
    Item \== fence,
    \+position(_, X, Y),
    retract(position(Tokemon, CurX, Y)),
    asserta(position(Tokemon, X, Y)).