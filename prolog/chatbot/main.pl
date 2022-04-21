%%%%%%%%%%
%database%
%%%%%%%%%%

:- dynamic(get_predicates/1).

saudation(['oi','ola','hello','hi'],['oi, quem fala?', 'oi, quem eh voce?','oi!', 'ola!', 'oi! como vai voce?']).
goodbye(['tchau','adeus','bye'],['adeus!', 'tchau!', 'adorei conversar com voce, ate mais!']).

ask('?').

objeto('bola').
objeto('guarda-chuva').

veiculo('carro').
veiculo('bicicleta').
veiculo('navio').
veiculo('aviao').

local('casa').
local('aqui').

pessoa('eu').
pessoa('tu').
pessoa('ela').
pessoa('ele').
pessoa('nos').
pessoa('vos').
pessoa('elas').
pessoa('eles').
pessoa('voce').
pessoa('Lucy').
pessoa('lucy').

robo('lucy').
robo('Lucy').
robo('voce').

get_predicates([objeto, pessoa, veiculo, local, robo]).
get_keys(['oi','ola','hello','hi','tchau', 'adeus', 'bye', 'goodbye']).

verb_be(['sou', 'es', 'eh', 'somos', 'sois', 'sao']).
articles(['a','o','um','uma','umas','uns']).
modifiers(['sim', 'nao']).
	
%%%%%%%%%%%%%%%%%%%%%%%%%
%predicados fundamentais%
%%%%%%%%%%%%%%%%%%%%%%%%%

%verifica se uma lista de palavras esta contida 
%numa string, e retorna as palavras da lista 
%encontradas
str_list(_,[],[]).
str_list(String, [T|B], X) :-
	sub_str(T, String),
	str_list(String, B, Y),	
	X = [T|Y], ! ;
	str_list(String, B, X), !.
	
%verifica se uma string está contida na outra
sub_str([],[]).
sub_str(Sub, Str) :-
	name(Sub, List1),
	name(Str, List2), 
	sub_list(List1, List2).

%verifica se uma sub lista está contida
%numa lista
sub_list([], _).
sub_list([T|B1], [T|B2]) :- 
	sub_list(B1, B2), !.
sub_list(L1, [_|B2]) :-
	sub_list(L1, B2), !.
	

%compara duas listas e retorna os itens
%comuns à elas
%pega cada item da 1ª lista e vai comparando com
%TODOS da segunda, e aí por diante
list_list([],_,[]).	
list_list([T1|B1],B2,[T1|B3]) :-
	member(T1, B2),
	list_list(B1, B2, B3), !.
list_list([_|B1], B2, B3) :-
	list_list(B1, B2, B3), !.
	
%recebe um predicado de dois argumentos e o aplica à uma lista 
map(_, [], []).
map(Predicate, [T|B], [L1|L2]) :-
	Run =.. [Predicate, T, L1],
	Run,
	map(Predicate, B, L2), !.

build_and_run(Predicate, Arg, Answer) :-
	Run =.. [Predicate, Arg],
	Run,
	Answer = 'sim.' ;
	Answer = 'nao.'.

%recebe uma lista de inteiros e converte
%para o código ASCII que esses inteiros representam,
%e então concatena em um átomo.
list_to_string(IntList, String) :-
	map(char_code, CharList, IntList),
	concat_atom(CharList, String).

%opera com listas.
jump_punctuation([],[],[]) :- !.
jump_punctuation([32|B1],[],B1) :- !. %!
jump_punctuation([33|B1],B2,B3) :-  
	jump_punctuation(B1, B2, B3), !.
jump_punctuation([44|B1],B2,B3) :-  %','
	jump_punctuation(B1, B2, B3), !.
jump_punctuation([46|B1],B2,B3) :-  
	jump_punctuation(B1, B2, B3), !.
jump_punctuation([63|B1],B2,B3) :-  
	jump_punctuation(B1, B2, B3), !.
jump_punctuation([T|B1],[T|B2],B3) :-
	jump_punctuation(B1,B2,B3), !.

%opera com listas. separa todas
%as palavras da frase em uma lista de palavras
split_phrase([],[]).
split_phrase(Str, [T|B]) :-
	jump_punctuation(Str, R, S),
	list_to_string(R, T), 
	split_phrase(S, B), !.
	
%%%%%%%%%%%%%%%%%%%%%
%funções de database%
%%%%%%%%%%%%%%%%%%%%%

quit_session(Phrase) :- 
	Phrase = bye.

search_predicate(Split, Predicate) :-
	articles(Articles),
	list_list(Articles, Split, F1),
	F1 = [T1|_],
	nth0(I1, Split, T1),
	I2 is I1 + 1,
	nth0(I2, Split, Predicate).

non_question(FoundKeys, Answer) :-
	saudation(In1, Out1),
	sub_list(FoundKeys, In1), (
		length(Out1, L1),
		IA is random(L1),
		nth0(IA, Out1, Answer)
	) ;
	goodbye(In2, Out2),
	sub_list(FoundKeys, In2), (
		length(Out2, L2),
		IB is random(L2),
		nth0(IB, Out2, Answer)
	).

question(FoundKeys, Split, Answer) :-
	verb_be(BeList),
	list_list(Split, BeList, F2),
	F2 = [Verb|_],
	nth0(I1, Split, Verb),
	I2 is I1 - 1,
	nth0(I2, Split, Arg),
	FoundKeys = [Predicate|_],
	build_and_run(Predicate, Arg, Answer).

search_base(Phrase, Answer) :-	
	get_keys(Keys),
	name(Phrase, IntPhrase),
	split_phrase(IntPhrase, Split),
	list_list(Split, Keys, FA),
	FA \= [], (
		non_question(FA, Answer), !
	) ;	
	get_predicates(Predicates),
	name(Phrase, IntPhrase),
	split_phrase(IntPhrase, Split),
	list_list(Split, Predicates, F1),
	F1 \= [], (
		question(F1, Split, Answer), !
	) ;
		ask(QuestMark),
		sub_str(QuestMark, Phrase), (
			get_answer(Phrase),
			Answer = 'huuum.', !
	) ;
	Answer = 'talvez.', !.

get_answer(Question) :-
	write('Lucy: '), 
	write('nao sei. o que voce acha?'), nl, nl,
	write('Voce: '),
	read(Answer),
	name(Question, IntPhrase1),
	split_phrase(IntPhrase1, Split1),	
	%acha o predicado
	articles(Articles),	
	list_list(Split1, Articles, F1),
	F1 = [T1|_],
	nth0(I1, Split1, T1),
	I2 is I1 + 1,
	nth0(I2, Split1, Predicate),
	get_predicates(Predicates),
	append(Predicates, [Predicate], NewPredicates),
	retract(get_predicates(Predicates)),
	asserta(get_predicates(NewPredicates)),	
	%acha o sujeito do predicado	
	verb_be(Verbs),
	list_list(Split1, Verbs, F2),
	F2 = [T2|_],
	nth0(I3, Split1, T2),
	I4 is I3 - 1,
	nth0(I4, Split1, Subject),
	%acha o que o usuário acha que é
	name(Answer, IntPhrase2), 
	split_phrase(IntPhrase2, Split2),
	modifiers(Mods),
	list_list(Split2, Mods, F3),
	Run =.. [Predicate, Subject],
	F3 \= [], (
		F3 = [T3|_],
		T3 = 'nao', (
			asserta(Run :- false), !
		) ;
		asserta(Run), !
	) ;
		asserta(Run), !.
	
main :- 
	write('Digite sua frase entre aspas simples (\') e termine a sentenca com um ponto (.)'), nl,
	write('Ex: \'ola\'.'), nl,
	repeat,
	nl, write('Voce: '),
	read(Input),
	search_base(Input, Output),
	write('Lucy: '), 
	write(Output), nl,
	quit_session(Input), !.
