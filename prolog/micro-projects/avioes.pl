%O avião do Cel. Milton solta fumaça vermelha.
%O rádio transmissor do Ten. Walter está com problemas.
%O piloto do avião que solta fumaça verde adora pescar.
%O Major Rui joga futebol nos finais de semana.
%O avião que solta fumaça verde está imediatamente à direita do avião que solta fumaça branca.
%O piloto que bebe leite está com o altímetro desregulado.
%O piloto do avião que solta fumaça preta bebe cerveja.
%O praticante de natação pilota o avião que solta fumaça vermelha.
%O Cap. Farfarelli está na ponta esquerda da formação.
%O piloto que bebe café voa ao lado do avião que está com pane no sistema hidráulico.
%O piloto que bebe cerveja voa ao lado do piloto que enfrenta problemas na bússola.
%O homem que pratica equitação gosta de beber chá.
%O Cap. Nascimento bebe somente água.
%O Cap. Farfarelli voa ao lado do avião que solta fumaça azul.
%Na formação, há um avião entre o que tem problema hidráulico e o com pane no altímetro.
%Um dos pilotos joga tênis.
%Há um avião com problema de temperatura.
a_direita(X, Y, [Y | [X | _]]).
a_direita(X, Y, [_ | R]) :- a_direita(X, Y, R).

ao_lado(X, Y, List) :- a_direita(X, Y, List).
ao_lado(X, Y, List) :- a_direita(Y, X, List).

um_entre(X, Y, [X | [_ | [Y |_ ]]]).
um_entre(X, Y, [Y | [_ | [X |_ ]]]).
um_entre(X, Y, [_ | R]) :- um_entre(X, Y, R).
%(pessoa, cor da fumaça, anomalia, hobbie, bebida)

solucao(Avioes) :-
  	Avioes = [_, _, _, _, _], % lista com 5 elementos
	member(aviao(milton, vermelha, _, _, _), Avioes),  	
	member(aviao(walter, _, radio, _, _), Avioes),
	member(aviao(_, verde, _, pescar, _), Avioes),
	member(aviao(rui, _, _, futebol, _), Avioes),
	a_direita(aviao(_, verde, _, _, _), aviao(_, branca, _, _, _), Avioes),
	member(aviao(_, _, altimetro, _, leite), Avioes),
	member(aviao(_, preta, _, _, cerveja), Avioes),
	member(aviao(_, vermelha, _, natacao, _), Avioes),
	[aviao(farfarelli, _, _, _, _) | _] = Avioes,  
	ao_lado(aviao(_, _, _, _, cafe), aviao(_, _, hidraulico, _, _), Avioes), 
	ao_lado(aviao(_, _, _, _, cerveja), aviao(_, _, bussola, _, _), Avioes),
	member(aviao(_, _, _, equitacao, cha), Avioes),
	member(aviao(nascimento, _, _, _, agua), Avioes),
	ao_lado(aviao(farfarelli, _, _, _, _), aviao(_, azul, _, _, _), Avioes),
	um_entre(aviao(_, _, hidraulico, _, _), aviao(_, _, altimetro, _, _), Avioes),
	member(aviao(_, _, _, tenis, _), Avioes),
	member(aviao(_, _, temperatura, _, _), Avioes).

