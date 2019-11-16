saveGame(FileName) :-
    (game(GameState), GameState == 1,
    player(X, Y, DoneGym, TokemonList),
    open(FileName, write, Stream),
    % donegym, coor player, status tokemon player, tokemon on field

    % [x]
    % [y]
    % [doneGym]
    % [tokemonCount]
    % [namaTokemon]
    % [hpTokemon]
    % [namaTokemon]
    % [hpTokemon]
    % ...
    % [namaTokemon]
    % [hpTokemon]
    % [tokemonFieldCount]
    % [namaTokemonField]
    % [namaTokemonField]
    % ...
    % [namaTokemonField]

    write(Stream, X), write(Stream, '.'), nl(Stream),
    write(Stream, Y), write(Stream, '.'), nl(Stream),
    write(Stream, DoneGym), write(Stream, '.'), nl(Stream),

    countList(TokemonList, N),
    write(Stream, N), write(Stream, '.'), nl(Stream),
    saveTokemonList(Stream, TokemonList),

    allTokemon(ListField),
    countList(ListField, N2),
    write(Stream, N2), write(Stream, '.'), nl(Stream),
    saveTokemonFieldList(Stream, ListField),

    !, close(Stream))
    ;
    write('You can\'t save the game at this time!').

saveTokemonFieldList(_, []).
saveTokemonFieldList(Stream, [H|T]) :-
    write(Stream, H), write(Stream, '.'), nl(Stream),
    saveTokemonFieldList(Stream, T).

saveTokemonList(_, []).
saveTokemonList(Stream, [H|T]) :-
    write(Stream, H), write(Stream, '.'), nl(Stream),
    hp(H, Hp), write(Stream, Hp), write(Stream, '.'), nl(Stream),
    saveTokemonList(Stream, T).

loadGame(FileName) :-
    (file_exists(FileName),
    open(FileName, read, Stream),

    start,

    read(Stream, X), read(Stream, Y), read(Stream, DoneGym),
    player(CurX, CurY, CurDoneGym, CurTokemonList),
    retract(player(CurX, CurY, CurDoneGym, CurTokemonList)),
    assertz(player(X, Y, DoneGym, [])),

    read(Stream, ListCount),
    loadTokemonList(Stream, ListCount),

    retract(allTokemon(_)),
    read(Stream, ListTokemonFieldCount),
    loadTokemonFieldList(Stream, ListTokemonFieldCount, [], Result),
    assertz(allTokemon(Result)),

    !, close(Stream))
    ;
    write('File "'), write(FileName), write('" does not exist or not valid!').

loadTokemonList(_, 0).
loadTokemonList(Stream, ListCount) :-
    NextListCount is ListCount - 1,
    read(Stream, Name), read(Stream, Hp),
    addTokemon(Name), setHp(Name, Hp),
    loadTokemonList(Stream, NextListCount).

loadTokemonFieldList(_, 0, List, Result) :-
    Result = List.
loadTokemonFieldList(Stream, ListCount, List, Result) :-
    NextListCount is ListCount - 1,
    read(Stream, Name), NextList = [Name|List],
    loadTokemonFieldList(Stream, NextListCount, NextList, Result).
