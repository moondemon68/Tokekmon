% ADT Tokemon

% Nama, Tipe, HP, Damage Normal, Damage Skill, IsLegendary
% :- dynamic(tokemon/6).
:- dynamic(hp/2).

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
normalDamage(budi,10).
normalDamage(harlele,1).
normalDamage(camcam, 18).
skillDamage(budi,25).
skillDamage(harlele,35).
isLegendary(budi,0).
isLegendary(harlele,0).

initTokemon :-
    asserta(hp(budi,10)),
    asserta(hp(harlele,10)).
    
    % asserta(tokemon(name(budi), attribute(fire), hp(1000), normal_damage(10), skill_damage(25), is_legendary(0))),
    % asserta(tokemon(name(rali), attribute(leaf), hp(100), normal_damage(20), skill_damage(5), is_legendary(0))),
    % asserta(tokemon(name(carimender), attribute(fire), hp(123), normal_damage(6), skill_damage(52), is_legendary(0))),
    % asserta(tokemon(name(harlele), attribute(water), hp(1000), normal_damage(1), skill_damage(35), is_legendary(0))),
    % asserta(tokemon(name(camcam), attribute(leaf), hp(135), normal_damage(18), skill_damage(36), is_legendary(0))),
    % asserta(tokemon(name(abuy), attribute(water), hp(180), normal_damage(35), skill_damage(80), is_legendary(0))),
    % asserta(tokemon(name(ibunyabudi), attribute(fire), hp(1351), normal_damage(81), skill_damage(470), is_legendary(1))),
    % asserta(tokemon(name(engi), attribute(water), hp(3500), normal_damage(100), skill_damage(225), is_legendary(1))),
    % asserta(tokemon(name(poontoon), attribute(leaf), hp(5300), normal_damage(500), skill_damage(1250), is_legendary(1))).

% Selektor
% getAtt(Name, Att) :-
%     tokemon(name(Name), attribute(Att), _, _, _ , _),!.

% getHp(Name, Hp) :-
%     tokemon(name(Name), _, hp(Hp), _, _, _),!.

% getNormalDamage(Name, Dmg) :-
%     tokemon(name(Name), _, _, normal_damage(Dmg), _, _),!.

% getSkillDamage(Name, Dmg) :-
%     tokemon(name(Name), _, _, _, skill_damage(Dmg), _),!.

% getIsLegendry(Name, IsTrue) :-
%     tokemon(name(Name), _, _, _, _, is_legendary(IsTrue)),!.

% primitif
setHp(Name, NewHp) :-
    retract(hp(Name, _)) ->
    assertz(hp(Name ,NewHp)),!.
    % retract(tokemon(name(Name), _, _, _, _, _)),
    % assertz(tokemon(name(Name), _, hp(NewHp), _, _, _)).
    