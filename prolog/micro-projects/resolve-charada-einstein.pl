% Exemplo de programa em Prolog que resolve o seguinte problema
% de l�gica:
%
% 1. O ingl�s vive na casa vermelha. 
% 2. O sueco tem cachorros. 
% 3. O dinamarqu�s bebe ch�. 
% 4. A casa verde fica � esquerda da casa branca. 
% 5. O dono da casa verde bebe caf�. 
% 6. A pessoa que fuma Pall Mall cria p�ssaros. 
% 7. O dono da casa amarela fuma Dunhill. 
% 8. O homem que vive na casa do centro bebe leite. 
% 9. O noruegu�s vive na primeira casa. 
% 10. O homem que fuma Blends vive ao lado do que tem gatos. 
% 11. O homem que cria cavalos vive ao lado do que fuma Dunhill. 
% 12. O homem que fuma Bluemaster bebe cerveja. 
% 13. O alem�o fuma Prince. 
% 14. O noruegu�s vive ao lado da casa azul. 
% 15. O homem que fuma Blends � vizinho do que bebe �gua.
%
% Pergunta-se: quem cria peixes?

% Regras para determinar se X est� ao lado de Y
ao_lado(X, Y, List) :- a_direita(X, Y, List). % X � direita de Y
ao_lado(X, Y, List) :- a_direita(Y, X, List). % Y � direita de X

% Regra para determinar se uma casa est� � direita da outra.
% Opera��o [X | Y]: separa uma lista, sendo que
% X designa o primeiro elemento e Y o restante da lista.
% (semelhante a CAR/CDR em Scheme)

% Condi��o para fim da recurs�o:
% X est� � direita de Y se Y est� na primeira posi��o e X est� na segunda.
a_direita(X, Y, [Y | [X | _]]).
% Condi��o recursiva:
% X est� � direita de Y se estiver � direita de Y no Restante da lista.
a_direita(X, Y, [_ | Restante]) :- a_direita(X, Y, Restante).

% A solu��o � uma lista de casas, sendo que cada casa tem a forma:
% casa(cor, nacionalidade, animal, bebida, cigarro)
% member(E, List): verdadeiro se E � um dos elementos de List
% O operador "=" unifica o lado esquerdo com o direito
solucao(Casas, Dono_Peixe) :-
  Casas = [_, _, _, _, _], % lista com 5 elementos
  member(casa(vermelha, ingles, _, _, _), Casas),
  member(casa(_, sueco, cachorro, _, _), Casas),
  member(casa(_, dinamarques, _, cha, _), Casas),
  a_direita(casa(branca,_,_,_,_), casa(verde,_,_,_,_), Casas),
  member(casa(verde, _, _, cafe, _), Casas),
  member(casa(_, _, passaro, _, pallmall), Casas),
  member(casa(amarela, _, _, _, dunhill), Casas),
  [_, _, casa(_, _, _, leite, _), _, _] = Casas,
  [casa(_, noruegues, _, _, _) | _] = Casas,
  ao_lado(casa(_, _, _, _, blends), casa(_, _, gato, _, _), Casas),
  ao_lado(casa(_, _, _, _, dunhill), casa(_, _, cavalo, _, _), Casas),
  member(casa(_, _, _, cerveja, bluemaster), Casas),
  member(casa(_, alemao, _, _, prince), Casas),
  ao_lado(casa(_, noruegues, _, _, _), casa(azul, _, _, _, _), Casas),
  ao_lado(casa(_, _, _, _, blends), casa(_, _, _, agua, _), Casas),
  member(casa(_, Dono_Peixe, peixe, _, _), Casas).

