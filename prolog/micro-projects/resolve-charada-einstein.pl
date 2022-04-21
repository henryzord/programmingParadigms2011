% Exemplo de programa em Prolog que resolve o seguinte problema
% de lógica:
%
% 1. O inglês vive na casa vermelha. 
% 2. O sueco tem cachorros. 
% 3. O dinamarquês bebe chá. 
% 4. A casa verde fica à esquerda da casa branca. 
% 5. O dono da casa verde bebe café. 
% 6. A pessoa que fuma Pall Mall cria pássaros. 
% 7. O dono da casa amarela fuma Dunhill. 
% 8. O homem que vive na casa do centro bebe leite. 
% 9. O norueguês vive na primeira casa. 
% 10. O homem que fuma Blends vive ao lado do que tem gatos. 
% 11. O homem que cria cavalos vive ao lado do que fuma Dunhill. 
% 12. O homem que fuma Bluemaster bebe cerveja. 
% 13. O alemão fuma Prince. 
% 14. O norueguês vive ao lado da casa azul. 
% 15. O homem que fuma Blends é vizinho do que bebe água.
%
% Pergunta-se: quem cria peixes?

% Regras para determinar se X está ao lado de Y
ao_lado(X, Y, List) :- a_direita(X, Y, List). % X à direita de Y
ao_lado(X, Y, List) :- a_direita(Y, X, List). % Y à direita de X

% Regra para determinar se uma casa está à direita da outra.
% Operação [X | Y]: separa uma lista, sendo que
% X designa o primeiro elemento e Y o restante da lista.
% (semelhante a CAR/CDR em Scheme)

% Condição para fim da recursão:
% X está à direita de Y se Y está na primeira posição e X está na segunda.
a_direita(X, Y, [Y | [X | _]]).
% Condição recursiva:
% X está à direita de Y se estiver à direita de Y no Restante da lista.
a_direita(X, Y, [_ | Restante]) :- a_direita(X, Y, Restante).

% A solução é uma lista de casas, sendo que cada casa tem a forma:
% casa(cor, nacionalidade, animal, bebida, cigarro)
% member(E, List): verdadeiro se E é um dos elementos de List
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

