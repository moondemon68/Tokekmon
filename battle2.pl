:- dynamic(haveUsedSkill/2).
:- dynamic(tokemonInBattle/2).
:- dynamic(turn/1).

% battle initialitation
initBattle :-
    asserta(turn(0)), 
    asserta(haveUsedSkill(0, player)),
    asserta(haveUsedSkill(0, enemy)), !.

checkTokemon :-
    % player(X, Y, _, _),
    % position(Tokemon, X, Y),
    % findTokemon(Tokemon), !.
    random(1, 101, Rand),
    (Rand < 26  ->
        random(1, 10, Rand2), 
        allTokemon(TokemonList), 
        elByIndex(TokemonList, Rand2, Tokemon), 
        isLegendary(Tokemon, 0);
    Rand > 94 ->
        random(1, 10, Rand2), 
        allTokemon(TokemonList), 
        elByIndex(TokemonList, Rand2, Tokemon), 
        isLegendary(Tokemon, 1)
    ), 
    write(Rand), nl,
    findTokemon(Tokemon), !.

% trying to escape from battle
escape :-
    game(2),
    random(0, 101, Rand),
    (Rand > 70 ->
        cls,
        write('Failed to escape!'), nl,
        hpBar,
        battle;
    write('You escaped from battle!'), setGame(1)), nl, !.

% chose tokemon
changeTokemon :-
    resetSkill,
    player(_, _, _, TokemonList),
    write('Chose another tokemon!'), nl,
    printList(TokemonList), !.

% Attack
attack :-
    game(4),
    tokemonInBattle(Victim, enemy),
    tokemonInBattle(Attacker, player),
    attribute(Victim,Y),
    attribute(Attacker,X),
    normalDamage(Attacker, Dmg),
    hp(Victim, Hp),
    cls,
    write('Attacking enemy'), nl,
    ((X == fire) -> (Y == water,Y == daemon -> EDmg is floor(0.5*Dmg); Y == leaf,Y == angmud -> EDmg is floor(1.5*Dmg);EDmg is Dmg);
    (X == water) -> (Y == fire, Y == angmud-> EDmg is floor(1.5*Dmg); Y == leaf,Y == daemon -> EDmg is floor(0.5*Dmg);EDmg is Dmg);
    (X == leaf) -> (Y == fire,Y == daemon -> EDmg is floor(0.5*Dmg); Y == water,Y == angmud -> EDmg is floor(1.5*Dmg);EDmg is Dmg);
    (X == daemon) -> (Y == daemon -> EDmg is Dmg; EDmg is floor(1.5*Dmg));
    (X == angmud) -> (Y == angmud -> EDmg is Dmg; EDmg is floor(0.5*Dmg)),
    (X == panitia) -> (Y == angmud -> EDmg is floor(2.0*Dmg),EDmg is Dmg)), 
    write(Victim), write(' took '), write(EDmg), write(' damage'), nl,
    divider,
    NewHp is Hp-EDmg,
    setHp(Victim, NewHp), 
    checkStatus, !.
attack :-
    game(_),
    write('This command can only be used in battle'), nl, !.

skill :-
    game(4),
    haveUsedSkill(0, player),
    retract(haveUsedSkill(_, player)),
    assertz(haveUsedSkill(1, player)),
    tokemonInBattle(Victim, enemy),
    tokemonInBattle(Attacker, player),
    attribute(Attacker,X),
    attribute(Victim,Y),
    skillDamage(Attacker, Dmg),
    hp(Victim, Hp),
    cls,
    write('Attacking enemy'), nl,
    ((X == fire) -> (Y == water,Y == daemon -> EDmg is floor(0.5*Dmg); Y == leaf,Y == angmud -> EDmg is floor(1.5*Dmg);EDmg is Dmg);
    (X == water) -> (Y == fire, Y == angmud-> EDmg is floor(1.5*Dmg); Y == leaf,Y == daemon -> EDmg is floor(0.5*Dmg);EDmg is Dmg);
    (X == leaf) -> (Y == fire,Y == daemon -> EDmg is floor(0.5*Dmg); Y == water,Y == angmud -> EDmg is floor(1.5*Dmg);EDmg is Dmg);
    (X == daemon) -> (Y == daemon -> EDmg is Dmg; EDmg is floor(1.5*Dmg));
    (X == angmud) -> (Y == angmud -> EDmg is Dmg; EDmg is floor(0.5*Dmg)),
    (X == panitia) -> (Y == angmud -> EDmg is floor(2.0*Dmg),EDmg is Dmg)), 
    write(Victim), write(' took '), write(EDmg), write(' damage'), nl, 
    divider,
    NewHp is Hp-EDmg,
    setHp(Victim, NewHp), 
    checkStatus, !.

skill :- 
    game(4),
    haveUsedSkill(1, player),
    write('Skill can only be used once!'), nl, !.

skill :-
    game(_),
    write('This command can only be used in battle'), nl, !.

resetSkill :-
    retract(haveUsedSkill(_, player)),
    assertz(haveUsedSkill(0, player)), !.

enemyAttack :-
    tokemonInBattle(Victim, player),
    tokemonInBattle(Attacker, enemy),
    attribute(Attacker,X),
    attribute(Victim,Y),
    haveUsedSkill(Have, enemy),
    (Have == 0 ->
    skillDamage(Attacker, Dmg), retract(haveUsedSkill(_, enemy)), assertz(haveUsedSkill(1, enemy));
    normalDamage(Attacker, Dmg)),
    ((X == fire) -> (Y == water,Y == daemon -> EDmg is floor(0.5*Dmg); Y == leaf,Y == angmud -> EDmg is floor(1.5*Dmg);EDmg is Dmg);
    (X == water) -> (Y == fire, Y == angmud-> EDmg is floor(1.5*Dmg); Y == leaf,Y == daemon -> EDmg is floor(0.5*Dmg);EDmg is Dmg);
    (X == leaf) -> (Y == fire,Y == daemon -> EDmg is floor(0.5*Dmg); Y == water,Y == angmud -> EDmg is floor(1.5*Dmg);EDmg is Dmg);
    (X == daemon) -> (Y == daemon -> EDmg is Dmg; EDmg is floor(1.5*Dmg));
    (X == angmud) -> (Y == angmud -> EDmg is Dmg; EDmg is floor(0.5*Dmg)),
    (X == panitia) -> (Y == angmud -> EDmg is floor(2.0*Dmg),EDmg is Dmg)), 
    hp(Victim, Hp),
    write(Victim), write(' took '), write(EDmg), write(' damage'), nl,
    divider, nl,
    NewHp is Hp-EDmg,
    setHp(Victim, NewHp), 
    checkStatus, !.

% Enemy turn
enemyTurn :-
    % Should be there some process to decide whether using
    % normal attack or skill
    write('Enemy attack'), nl,
    enemyAttack, !.

% Player turn
playerTurn :-
    setGame(4),
    write('Type "attack" or "skill"'), nl,
    hpBar, 
    !.

gameOver :-
    setGame(0),
    write('Game Over'), nl, !.

winBattle :-
    setGame(5),
    write('You won the battle'), nl,
    
    tokemonInBattle(EnemyT, enemy),
    delTokemon2(EnemyT),
    write('Type "capture" to take '), write(EnemyT), write(' as your tokemon or "eggxecute" !'), nl. 

capture :-
    game(5),
    player(_, _, _, TokemonList),
    countList(TokemonList, N),
    (
        N == 6 -> write('Your inventory is full, "drop" some before you catch more tokemon'), nl
        ;
        setGame(1),
        tokemonInBattle(Tokemon, enemy),
        addTokemon(Tokemon),
        write('You captured '), write(Tokemon), write('!'), nl,
        starthp(Tokemon, StartHP),
        setHp(Tokemon, StartHP)
    ), !.

eggxecute :-
    setGame(1),
    map, !.

loseBattle :-
    tokemonInBattle(PlayerT, player),
    delTokemon(PlayerT),

    % check if there still another tokemon to use
    player(_, _, _, TokemonList),
    countList(TokemonList, N),
    (N >= 1 ->
        changeTokemon, % chose other tokemon
        nexTurn;
    N == 0 -> % no tokemon left
        gameOver), !.

% battle phase
nexTurn :-
    turn(Turn),
    NextTurn is abs(Turn-1),

    % update turn
    retract(turn(_)),
    asserta(turn(NextTurn)),

    % back to battle
    battle, !.

checkStatus :-
    tokemonInBattle(PlayerT, player),
    tokemonInBattle(EnemyT, enemy),
    hp(PlayerT, Hp1),
    hp(EnemyT, Hp2),

    % check player and enemy tokemon HP
    (Hp1 =< 0 ->
        loseBattle;
    Hp2 =< 0 ->
        winBattle; 
    nexTurn), !.

battle :-
    turn(Turn),
    (Turn == 0 ->
        playerTurn;
    Turn == 1 ->
        enemyTurn), !.

% find tokemon
findTokemon(EnemyT) :-
    allTokemon(TokemonList),
    isMember(EnemyT, TokemonList),
    cls,
    write('Wild ' ), write(EnemyT), write(' appear!'), nl,
    tokemonStatus(EnemyT),
    (asserta(tokemonInBattle(EnemyT, enemy));
    retract(tokemonInBattle(EnemyT, enemy)),
    assertz(tokemonInBattle(EnemyT, enemy))),
    setGame(2),
    write('Type "fight" to begin battle or "escape" to run'), nl,
    divider, !.
    
fight :-
    game(2),
    setGame(3),
    cls,
    nl, write('C\'mon, choose your partner!'), nl, 
    divider,
    write('Type "summon(<tokemon>)"'), nl,
    divider,
    write('[Available tokemon] : '), 
    player(_, _, _, TokemonList),
    write(TokemonList), nl,
    divider, !.

summon(Tokemon) :-
    cls,
    player(_, _, _, TokemonList),
    isMember(Tokemon, TokemonList),
    asserta(tokemonInBattle(Tokemon, player)),
    divider,
    write('Summoning '), write(Tokemon), write('.................'), nl,
    divider,
    battle, !.
summon(Tokemon) :-
    player(_, _, _, TokemonList),
    isMember(Tokemon, TokemonList),
    retract(tokemonInBattle(_, player)) ->
    assertz(tokemonInBattle(Tokemon, player)),
    divider,
    write('Summoning '), write(Tokemon), write('.................'), nl,
    divider,
    cls,
    battle, !.
    
hpBar :-
    tokemonInBattle(PlayerT, player),
    tokemonInBattle(EnemyT, enemy),
    hp(PlayerT, Hp1), hp(EnemyT, Hp2),
    
    divider,
    write('(HP) '),
    write(PlayerT), write(' : '), write(Hp1),
    write('   '),
    write(EnemyT), write(' : '), write(Hp2), nl,
    divider, !.

