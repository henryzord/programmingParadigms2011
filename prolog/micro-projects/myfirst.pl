a_direita(X, Y, [Y | [X | _]]).
a_direita(X, Y, [_ | Restante]) :- a_direita(X, Y, Restante).

um_entre(X, Y, [X | [_ | [Y |_ ]]]).
um_entre(X, Y, [Y | [_ | [X |_ ]]]).
um_entre(X, Y, [_ | R]) :- um_entre(X, Y, R).

solucao(Pessoas) :- 
	Pessoas = [_, _], 
	member(pessoa(raul, masculino), Pessoas),
	member(pessoa(alessandra, _), Pessoas),
	member(pessoa(_, feminino), Pessoas),
	a_direita(pessoa(_, feminino), pessoa(raul, _), Pessoas).	

contem_valor(Char, [Char | _]).
contem_valor(Char, [_ | List]) :- contem_valor(Char, List).

cont_char(Char, [Top | Bottom]) :- Char == Top + cont_char(Char, Bottom).


deduzame(A, A, [A]).
deduzame(A, B, [A | R]) :- 
	A =< B,
	Num is A + 1,
	deduzame(Num, B, R).

pred([], L, L).
pred([H | T], L, [H | R]) :- pred(T, L, R).

sumlist([], 0).
sumlist([T|B], S) :- 
	sumlist(B, S1),
	S is T + S1.


plusone([], []).
plusone([T|B1], [T1|B2]) :-
	T1 is T + 1,
	plusone(B1,B2).




