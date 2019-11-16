saveGame(FileName) :-
    (game(GameState), GameState == 1,
    player(X, Y, DoneGym, TokemonList),
    open(FileName, write, Stream),
    % donegym, coor player, status tokemon player, tokemon on field

    % [x] [y]
    % [doneGym]
    % [tokemonCount]
    % [namaTokemon] [hpTokemon]
    % [namaTokemon] [hpTokemon]
    % ...
    % [namaTokemon] [hpTokemon]
    % [tokemonFieldCount]
    % [namaTokemonField]
    % [namaTokemonField]
    % ...
    % [namaTokemonField]

    write(Stream, X), write(Stream, '.'), write(Stream, Y), write(Stream, '.'), nl(Stream),
    write(Stream, DoneGym), write(Stream, '.'), nl(Stream),

    countList(TokemonList, N),
    write(Stream, N), write(Stream, '.'), nl(Stream),
    saveTokemonList(Stream, TokemonList),

    allTokemon(ListField),
    countList(ListField, N2),
    write(Stream, N2), nl(Stream),
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
    write(Stream, H), write(Stream, '.'), hp(H, Hp), write(Stream, Hp), write(Stream, '.'), nl(Stream),
    saveTokemonList(Stream, T).

loadGame(FileName) :-
    ((\+game(_); game(GameState), GameState == 0),
    file_exists(FileName),
    open(FileName, read, Stream),

    % start,

    read(Stream, X), read(Stream, Y),
    player(CurX, CurY, DoneGym, TokemonList),
    retract(player(CurX, CurY, DoneGym, TokemonList)),
    asserta(player(X, Y, DoneGym, TokemonList)), !.

    read(Stream, ListCount),

    !, close(Stream))
    ;
    write('File '), write(FileName), write(' does not exist!').