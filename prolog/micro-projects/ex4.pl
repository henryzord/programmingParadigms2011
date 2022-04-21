b(2).
b(3).
c(4).
c(5).
regra1(X, Y) :- b(X), c(Y).
regra2(X, Y) :- b(X), !, c(Y).
