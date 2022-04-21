% Exemplo de programa em Prolog que define
% fatos e regras sobre pessoas e localizacoes geograficas.

localizado_em(santa_maria, rio_grande_do_sul).
localizado_em(porto_alegre, rio_grande_do_sul).
localizado_em(salvador, bahia).
localizado_em(rio_grande_do_sul, brasil).
localizado_em(bahia, brasil).
localizado_em(grenoble, franca).
localizado_em(paris, franca).
localizado_em(franca, europa).

nasceu_em(andre, santa_maria).
nasceu_em(jose, salvador).
nasceu_em(marc, grenoble).
nasceu_em(maria, porto_alegre).
nasceu_em(joana, salvador). %added
nasceu_em(michel, paris). %added
nasceu_em(X, Y) :- localizado_em(Z, Y), nasceu_em(X, Z).

mora_em(andre, paris).
mora_em(jose, grenoble).
mora_em(marc, porto_alegre).
mora_em(maria, salvador).
mora_em(X, Y) :- localizado_em(Z, Y), mora_em(X, Z).

idade(andre, 25).
idade(jose, 30).
idade(marc, 28).
idade(maria, 32).
idade(joana, 22). %added
idade(michel, 40). %added

gaucho(X) :- nasceu_em(X, rio_grande_do_sul).
brasileiro(X) :- nasceu_em(X, brasil).
europeu(X) :- nasceu_em(X, europa).

year(A) :- get_time(X), stamp_date_time(X,D,0), date_time_value(year,D,A).

ano_nascimento(Pessoa, AnoAprox) :- idade(Pessoa, Idade), year(Esteano), AnoAprox is Esteano - Idade.


