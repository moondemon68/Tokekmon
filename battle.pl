:- dynamic(haveUsedSkill/2).
:- dynamic(tokemonInBattle/2).
:- dynamic(turn/1).

% battle initialitation
initBattle(EnemyT,PlayerT) :-
    asserta(tokemonInBattle(EnemyT,enemy)),
    asserta(tokemonInBattle(PlayerT,player)),
    asserta(haveUsedSkill(0,player)),
    asserta(haveUsedSkill(0,enemy)),
    asserta(turn(0)).

checkTokemon :-
    player(X, Y, _, _),
    position(Tokemon, X, Y),
    findTokemon(Tokemon).

% trying to escape from battle
escape(EnemyT) :-
    random(0, 101, Rand),
    (Rand > 70 ->
        beginBattle(EnemyT);
    write('You escaped from battle!.'), nl), !.

% chose tokemon
choseTokemon(Tokemon) :-
    player(_, _, _, TokemonList),
    printList(TokemonList,1),
    write('Choose your tokemon : '),
    read(Idx), nl, 
    elByIndex(TokemonList, Idx, Tokemon), !.
changeTokemon :-
    choseTokemon(Tokemon),
    retract(tokemonInBattle(_, player)),
    assertz(tokemonInBattle(Tokemon, player)),
    retract(haveUsedSkill(_, player)),
    assertz(haveUsedSkill(0, player)), !.

% Attack
attack(Attacker, Victim, Attack) :-

    (Attack == 1 ->
        normalDamage(Attacker, Dmg);
    Attack == 2 ->
        skillDamage(Attacker, Dmg)),

    hp(Victim,Hp),
    write(Victim),
    write(' took '),
    write(Dmg),
    write(' damage'), nl, nl,
    NewHp is Hp-Dmg,
    setHp(Victim,NewHp), !.

% Enemy turn
enemyTurn :-
    tokemonInBattle(PlayerT, player),
    tokemonInBattle(EnemyT, enemy),

    % Should be there some process to decide whether using
    % normal attack or skill
    write('Enemy attack'), nl,
    attack(EnemyT, PlayerT, 1), !.  

% Player turn
playerTurn :-
    tokemonInBattle(PlayerT, player),
    tokemonInBattle(EnemyT, enemy),

    % Command for decide to use normal attack or skill
    write('1. Attack'), nl,
    write('2. Skill'), nl,
    write('What to use? : '),
    read(Command), nl,
    attack(PlayerT, EnemyT, Command), !.

gameOver :-
    write('Game Over'), nl, !.

winBattle :-
    write('You won the battle'), nl,

    tokemonInBattle(EnemyT, enemy),
    write('Do you want to capture '), write(EnemyT), write(' ? (y/n) :'),
    read(Command), nl,
    
    (Command == y ->
        addTokemon(EnemyT),
        write('You captured '), write(EnemyT), nl;
    Command == n ->
        map).

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
% battle plot turn -> checkStatus -> nextTurn(if stop condition unsatisfied)
nexTurn :-
    turn(Turn),
    NextTurn is abs(Turn-1),

    % update turn
    retract(turn(_)),
    assertz(turn(NextTurn)),

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
    cls,
    tokemonInBattle(PlayerT, player),
    tokemonInBattle(EnemyT, enemy),
    hp(PlayerT, Hp1), hp(EnemyT, Hp2),
    
    write('======================================='), nl,
    write('(HP) '), write(' '),
    write(PlayerT), write(' : '), write(Hp1),
    write('   '),
    write(EnemyT), write(' : '), write(Hp2), nl,
    write('======================================='), nl,

    turn(Turn),
    (Turn == 0 ->
        playerTurn;
    Turn == 1 ->
        enemyTurn),
    checkStatus, !.

% begin battle
beginBattle(EnemyT) :-
    % choose tokemon for battle
    choseTokemon(PlayerT),
    write('You choose '),
    write(PlayerT), nl, nl,

    % battle initialitation 
    initBattle(EnemyT, PlayerT),

    % start battlae
    battle, !.

% find tokemon
findTokemon(EnemyT) :-
    cls,
    isLegendary(EnemyT, Is),
    (Is == 1 -> chance(30);chance(60)),
    write('Wild ' ), % Wild ____ Appear
    write(EnemyT),
    write(' appear!'), nl,
    tokemonStatus(EnemyT),
    write('fight? (y/n) : '), 
    read(Command), nl, % Read command
    cls,
    % choose to fight or escape
    (Command == 'y' -> beginBattle(EnemyT); escape(EnemyT)).