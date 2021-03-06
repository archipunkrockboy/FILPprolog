read_str(A, N):-get0(X), r_str(X, A, [], 0, N).
r_str(10, A, A, N, N):-!.
r_str(X, A, B, K, N):-K1 is K+1, append(B,[X],B1),get0(X1), r_str(X1,A,B1,K1,N).


%put - символ по соответствующему номеру
write_str([]):-!.
write_str([H|T]):-put(H), write_str(T).


%1.1Дана строка. Вывести ее три раза через запятую и показать количе-
%ство символов в ней.

pr1_1:-read_str(S, N), write_str(S), write(', '), write_str(S), write(', '), write_str(S), nl,write('length - '), write(N).


%1.2 Дана строка. Найти количество слов.

pr1_2:-read_str(A,_), countwords(A, K),nl,write(K).

countwords(A,C):-countwords(A,0,C).
countwords([],K,K):-!.
countwords(Str,I,K):-skipspace(Str,Snew),getword(Snew,Word,Snew1),Word \=[],I1 is I+1,countwords(Snew1,I1,K),!.
countwords(_,K,K).

skipspace([32|T],A1):-skipspace(T,A1),!.
skipspace(A1,A1).

getword([],[],[]):-!.
getword(A,Word,A2):-getword(A,[],Word,A2).
getword([],Word,Word,[]).
getword([32|T],Word,Word,T):-!.
getword([H|T],W,Word,A2):-append(W,[H],W1),getword(T,W1,Word,A2).


%1.3 Дана строка, определить самое частое слово
inlist([],_):-fail.
inlist([X|_],X).
inlist([_|T],X):-inlist(T,X).


%сколько раз слово встречается в строке
frequency_str(S, Str, Count):-frequency_str(S, Str, 0, Count).
frequency_str(_, [], Count, Count):-!.
frequency_str(S, Str, CurCount, Count):-getword(Str, W, NewStr), (S = W, CurCount1 is CurCount+1, frequency_str(S, NewStr, CurCount1, Count),!;frequency_str(S, NewStr, CurCount, Count)).

%поиск наиболее встречаемого слова в строке
max_frequency_str(Str, Result):-max_frequency_str(Str, [], 0, Result).
max_frequency_str([], Result, _, Result):-!.
max_frequency_str(Str, CurMax, CurMaxCount, Result):- getword(Str, W, NewStr), frequency_str(W, Str, Count),(Count>CurMaxCount, max_frequency_str(NewStr, W, Count, Result),!;max_frequency_str(NewStr, CurMax, CurMaxCount, Result)).

pr1_3:-read_str(S, _), max_frequency_str(S, Result), write_str(Result).


%1.4 Дана строка. Вывести первые три символа и последний три символа,
%если длина строки больше 5 Иначе вывести первый символ столько
%раз, какова длина строки.

write1(S, N):-write1(S, 0, N).
write1(_, N, N):-!.
write1([H|T], I, N):- I1 is I+1, ((I<3, put(H),write1(T, I1, N)),!;(I+3>=N, put(H),write1(T, I1, N)),!;write1(T, I1, N)).

write2(S, N):-write2(S, 0, N).
write2(_, N, N):-!.
write2([H|_], I, N):-put(H), I1 is I+1, write2([H|_], I1, N).

pr1_4:-read_str(S, N), (N>5, write1(S, N),!; write2(S, N)).


%1.5 Дана строка. Показать номера символов, совпадающих с последним
%символом строки.

sym_by_num(Str, N, Result):-sym_by_num(Str, 0, N, Result).
sym_by_num([Result|_], N, N, Result):-!.
sym_by_num([_|T], I, N, Result):-I1 is I+1,sym_by_num(T, I1, N, Result).

str_length(S, Result):-str_length(S, 0, Result).
str_length([], Result, Result):-!.
str_length([_|T], C, Result):-C1 is C+1, str_length(T, C1, Result).

matchwithlast(S):- str_length(S, N),N1 is N-1, sym_by_num(S, N1, Last), matchwithlast(S, 0, Last).
matchwithlast([],_,_):-!.
matchwithlast([H|T], I, Last):-I1 is I+1, (H = Last, write(I), write(' '), matchwithlast(T,I1, Last);matchwithlast(T,I1, Last)).


pr1_5:-read_str(S, _), matchwithlast(S).




write_list_str([]):-!.
write_list_str([H|T]):-write_str(H),nl,write_list_str(T).

read_str_f(A,N,Flag):-get0(X),r_str_f(X,A,[],N,0,Flag).
r_str_f(-1,A,A,N,N,0):-!.
r_str_f(10,A,A,N,N,1):-!.
r_str_f(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),r_str_f(X1,A,B1,N,K1,Flag).


read_list_str(List,List_len):-read_str_f(A,N,Flag),r_l_s(List,List_len,[A],[N],Flag).
r_l_s(List,List_len,List,List_len,0):-!.
r_l_s(List,List_len,Cur_list,Cur_list_len,_):-
	read_str_f(A,N,Flag),append(Cur_list,[A],C_l),append(Cur_list_len,[N],C_l_l),
	r_l_s(List,List_len,C_l,C_l_l,Flag).

list_length(List, Result):-list_length(List, 0, Result).
list_length([], Result, Result):-!.
list_length([_|T], CurLength, Result):- CurLength1 is CurLength+1, list_length(T, CurLength1, Result).

%2.1Дан файл. Прочитать из файла строки и вывести длину наибольшей
%строки.

%самая длинная строка в списке
max_list_length(List_Str, Result):-max_list_length(List_Str, 0, Result).
max_list_length([], Result, Result):-!.
max_list_length([H|T], CurMax, Result):-list_length(H, CurLength), (CurLength>CurMax, max_list_length(T, CurLength, Result),!;max_list_length(T, CurMax, Result)).


pr2_1:-	see('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14InputFiles/2.1.txt'),read_list_str(List,_),seen,
		tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/2.1.txt'),max_list_length(List, Result), write(Result), told.

%2.2Дан файл. Определить, сколько в файле строк, не содержащих
%пробелы.

count_symbols(List, S, Result):-count_symbols(List, S, 0, Result).
count_symbols([], _, Result, Result):-!.
count_symbols([H|T], S, CurCount, Result):- H = S,Count1 is CurCount+1, count_symbols(T, S, Count1, Result),!;count_symbols(T, S, CurCount, Result).

count_str_hasn_sym(List, S, Result):-count_str_hasn_sym(List, S, 0, Result).
count_str_hasn_sym([], _, Result, Result):-!.
count_str_hasn_sym([H|T], S, CurCount, Result):-count_symbols(H, S, CS), CS is 0, Count is CurCount+1, count_str_hasn_sym(T, S, Count, Result),!;count_str_hasn_sym(T, S, CurCount, Result).

%32-пробел
pr2_2:-see('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14InputFiles/2.2.txt'), read_list_str(List, _), seen, tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/2.2.txt'), count_str_hasn_sym(List, 32, Result), write(Result), told.

%2.3Дан файл, найти и вывести на экран только те строки, в которых букв
%А больше, чем в среднем на строку.

%количество заданного символа в листе строк
count_symbols_list_str(List, S, Result):-count_symbols_list_str(List, S, 0, Result).
count_symbols_list_str([], _, Result, Result):-!.
count_symbols_list_str([H|T], S, CurCount, Result):-count_symbols(H, S, Count), CurCount1 is CurCount+Count, count_symbols_list_str(T, S, CurCount1, Result).

%65-A

write3_3([], _):-!.
write3_3([H|T], AverageA):- count_symbols(H, 65, CountA), CountA > AverageA, write_str(H), nl, write3_3(T, AverageA),!;write3_3(T, AverageA).

pr2_3:-see('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14InputFiles/2.3.txt'), read_list_str(List, CountStr), seen, tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/2.3.txt'), count_symbols_list_str(List, 65, CountA), list_length(CountStr, Length),AverageA is CountA/Length, write3_3(List, AverageA), told.

%2.4 Дан файл, вывести самое частое слово.

%Соединить два листа
join([], List, List).
join([H1|T1], List2, [H1|T2]) :- join(T1, List2, T2).

make_str(List, Result):-make_str(List, [], Result).
make_str([], Result, Result):-!.
make_str([H], [], H):-!.
make_str([H|T], [], Result):- join(H, [], Str1), make_str(T, Str1, Result),!.
make_str([H|T], CurStr, Result):-join(CurStr, [32], Str1), join(Str1, H, Str2), make_str(T, Str2, Result).



pr2_4:-see('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14InputFiles/2.4.txt'), read_list_str(List, _), seen, tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/2.4.txt'), make_str(List, Str), max_frequency_str(Str, Result), write_str(Result), told.


%2.5Дан файл, вывести в отдельный файл строки, состоящие из слов, не
%повторяющихся в исходном файле

%выполняется ли условие: слова строки не повторяются в файле
check2_5([], _):-!.
check2_5(SubStr, Str):- getword(SubStr, W, SubStr1), frequency_str(W, Str, Count), (Count is 1, check2_5(SubStr1, Str),!;fail).

write2_5([], _):-!.
write2_5([H|T], Str):-check2_5(H, Str), write_str(H), nl, write2_5(T, Str),!;write2_5(T, Str).

pr2_5:-see('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14InputFiles/2.5.txt'), read_list_str(List, _), seen, tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/2.5.txt'),make_str(List, Str), write2_5(List, Str), told.


%3Дана строка, состоящая из символов латиницы. Необходимо проверить,
%упорядочены ли строчные символы этой строки по возрастанию.

islow(S):-(S<97;S>122),!,fail.
islow(_).

check3([_]):-!.
check3([S1, S2|T]):-
       (not(islow(S1)), not(islow(S2)), check3(T)),!;
       ((islow(S1)), not(islow(S2)), check3([S1|T])),!;
       (not(islow(S1)), (islow(S2)), check3([S2|T])),!;
       S2>S1, check3([S2|T]),!;
       fail.

pr3:-see('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14InputFiles/3.txt'), read_list_str(List, _), seen, tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/3.txt'),make_str(List, Str), (check3(Str), write('Строчные символы упорядочены'),!;write('Строчные НЕ символы упорядочены')), told.

%4Дана строка. Необходимо подсчитать количество букв "А" в этой
%строке.
pr4:-read_str(S, _), count_symbols(S, 65, Count), write('Count A - '), write(Count).


%5 Дана строка в которой записан путь к файлу. Необходимо найти имя
%файла без расширения.

del_by_num(List, N, Result):-del_by_num(List, N, 0, Result).
del_by_num([_|T], N, N, T):-!.
del_by_num([H|T], N, I, [H|NewT]):- I1 is I+1, del_by_num(T, N, I1, NewT).

%поиск индекса по значению, причем последнего
index_by_elem_back(List, Elem, Result):- index_by_elem_back(List,0, 0, Elem, Result).
index_by_elem_back([],  _, Result, _, Result):-!.
index_by_elem_back([Elem|T], CurIndex, _, Elem, Result):-CurIndex1 is CurIndex+1, index_by_elem_back(T, CurIndex1, CurIndex, Elem, Result),!.
index_by_elem_back([_|T], CurIndex, I, Elem, Result):-CurIndex1 is CurIndex+1, index_by_elem_back(T, CurIndex1, I, Elem, Result).

%срез от N до M
cut(List, N, M, Result):-M1 is M+1,cut(List, N, M1, 0, Result).
cut(List, N, M, N, Result):-list_length(List, Length),M1 is M-N,cut(List, N, M1, M1, Length,Result),!.
cut([_|T], N, M, CurIndex, Result):-CurIndex1 is CurIndex+1, cut(T, N, M, CurIndex1, Result).
cut(Result, _, _, M, M, Result):-!.
cut(List, N, M, DelIndex, Length, Result):-Length1 is Length-1, del_by_num(List, DelIndex, DelList), cut(DelList, N, M, DelIndex, Length1, Result),!.

% C:\Users\Артур\Documents\Prolog\FILPprolog\Lab14\Lab14InputFiles\file.txt
% 46 - . \ - 92
pr5:-read_str(Str, _),index_by_elem_back(Str, 92, I1), I3 is I1+1,index_by_elem_back(Str, 46, I2), I4 is I2-1,cut(Str, I3, I4, Result), write_str(Result).





%К О М Б И Н А Т О Р И К А

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

in_list_exclude([El|T],El,T).
in_list_exclude([H|T],El,[H|Tail]):-in_list_exclude(T,El,Tail).


%размещения с повторениями по К
razm_p(_, 0, Result, Result) :- !.
razm_p(List, K, CurList, Result) :- in_list(List, X), K1 is K - 1, razm_p(List, K1, [X|CurList], Result).
razm_p(List, K, Result) :- razm_p(List, K, [], Result).
razm_p(List, K) :- razm_p(List, K, Perm), write_str(Perm), nl, fail.
razm_p:-read(N),read_list(Str,N), read(K), razm_p(Str, K).

%перестановки
permutations:-read_str(A,_), permutations(A,[]).
permutations(Str):-permutations(Str, []).
permutations([], Perm):- write_str(Perm), nl, !,fail.
permutations(A, Perm):- in_list_exclude(A,El,A1), permutations(A1,[El|Perm]).

%размещения без повторений
razm(_, 0, Result, Result):-!.
razm(List, K, Cur, Result):-in_list_exclude(List, X, Tail),K1 is K-1, razm(Tail, K1, [X|Cur], Result).
razm(List, K, Result):-razm(List, K, [], Result).
razm(List, K):-razm(List, K, Perm), write_str(Perm), nl, fail.


read_list(A,N):-read_list(A,N,0,[]).
read_list(A,N,N,A):-!.
read_list(A,N,K,B):-read(X),append(B,[X],B1),K1 is K+1,read_list(A,N,K1,B1).

%подмножества
sub_set:- read(N),read_list(A,N),sub_set(B,A),write(B),nl,fail.
sub_set([],[]).
sub_set([H|Sub_set],[H|Set]):-sub_set(Sub_set,Set).
sub_set(Sub_set,[_|Set]):-sub_set(Sub_set,Set).


%сочетания по k без повторений
sochet([], _, 0) :- !.
sochet([H|Sub_set], [H|SetTail], K) :- K1 is K-1, sochet(Sub_set, SetTail, K1).
sochet(Sub_set, [_|SetTail], K) :- sochet(Sub_set, SetTail, K).
sochet(Set, K) :- sochet(A, Set, K), write_str(A), nl, fail.
sochet:- read_str(A, _), read(K), sochet(A, K).

%сочетания по k с повторениями
sochet_p([], _, 0) :- !.
sochet_p([H|Sub_set], [H|SetTail], K):- K1 is K-1, sochet_p(Sub_set, [H|SetTail], K1).
sochet_p(Sub_set, [_|SetTail], K) :- sochet_p(Sub_set, SetTail, K).
sochet_p(Set, K) :- sochet_p(A, Set, K), write_str(A), nl, fail.
sochet_p:-read_str(A, _), read(K), sochet_p(A, K).

%все размещения с повторениями, запись в файл
pr6_1:-tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/razm_p.txt'),read_str(Str, _), read(K), not(razm_p(Str, K)), told.

%все размещения с повторениями, запись в файл
pr6_2:- tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/permutations.txt'), read_str(Str,_), not(permutations(Str)), told.

%все размещения с повторениями, запись в файл
pr6_3:-tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/razm.txt'), read_str(Str, _), read(K), not(razm(Str, K)), told.

%все размещения с повторениями, запись в файл
pr6_4:-tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/subset.txt'), not(sub_set), told.

%все сочетания, запись в файл
pr6_5:-tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/sochet.txt'), not(sochet), told.

%все сочетания с повторениями, запись в файл
pr6_6:-tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/sochet_p.txt'), not(sochet_p), told.

%Дано множество {a,b,c,d,e,f}. Построить все слова длины 5, в
%которых ровно две буквы a. Вывод в файл.
%

pr7_write:-Word=[_, _, _, _, _],
	sochet([Position_A1, Position_A2],[0, 1, 2, 3, 4], 2),
	sym_by_num(Word, Position_A1, a), sym_by_num(Word, Position_A2, a),
	in_list_exclude([0, 1, 2, 3, 4], Position_A1, List1), in_list_exclude(List1, Position_A2, [OtherPosition1, OtherPosition2, OtherPosition3]),
	razm_p([b, c, d, e, f], 3, [OtherSymbol1, OtherSymbol2, OtherSymbol3]),
	sym_by_num(Word, OtherPosition1, OtherSymbol1), sym_by_num(Word, OtherPosition2, OtherSymbol2), sym_by_num(Word, OtherPosition3, OtherSymbol3),
	write(Word), nl, fail.

pr7:-tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/7.txt'), pr7_write;told.





pr8_write:-Word=[_, _, _, _, _],
	sochet([Position_A1, Position_A2],[0, 1, 2, 3, 4], 2),
	sym_by_num(Word, Position_A1, a), sym_by_num(Word, Position_A2, a),
	in_list_exclude([0, 1, 2, 3, 4], Position_A1, List1), in_list_exclude(List1, Position_A2, [OtherPosition1, OtherPosition2, OtherPosition3]),
	razm([b, c, d, e, f], 3, [OtherSymbol1, OtherSymbol2, OtherSymbol3]),
	sym_by_num(Word, OtherPosition1, OtherSymbol1), sym_by_num(Word, OtherPosition2, OtherSymbol2), sym_by_num(Word, OtherPosition3, OtherSymbol3),
	write(Word), nl, fail.

pr8:-tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/8.txt'), pr8_write;told.


pr9_write:-Word=[_, _, _, _, _],
	sochet([Position_1, Position_2],[0, 1, 2, 3, 4], 2),
	in_list([a,b,c,d,e], El),
	sym_by_num(Word, Position_1, El), sym_by_num(Word, Position_2, El),
	in_list_exclude([0, 1, 2, 3, 4], Position_1, List1), in_list_exclude(List1, Position_2, [OtherPosition1, OtherPosition2, OtherPosition3]),
	in_list_exclude([a, b, c, d, e, f], El, NewList),
	razm(NewList, 3, [OtherSymbol1, OtherSymbol2, OtherSymbol3]),
	sym_by_num(Word, OtherPosition1, OtherSymbol1), sym_by_num(Word, OtherPosition2, OtherSymbol2), sym_by_num(Word, OtherPosition3, OtherSymbol3),
	write(Word), nl, fail.

pr9:-tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/9.txt'), pr9_write;told.



pr10_write:-Word=[_, _, _, _, _, _],
	sochet([El1, El2], [a, b, c, d, e, f], 2),
	in_list_exclude([a,b,c,d,e,f], El1, List1), in_list_exclude(List1, El2, OtherSymbols),
	sochet([Pos1, Pos2], [0, 1, 2, 3, 4, 5], 2), in_list_exclude([0, 1, 2, 3, 4, 5], Pos1, List2), in_list_exclude(List2, Pos2, OtherPositions),
	sochet([Pos3, Pos4], OtherPositions, 2), in_list_exclude(OtherPositions, Pos3, OtherPositions1), in_list_exclude(OtherPositions1, Pos4, [OtherPos1, OtherPos2]),
	sym_by_num(Word, Pos1, El1), sym_by_num(Word, Pos2, El1), sym_by_num(Word, Pos3, El2), sym_by_num(Word, Pos4, El2),
	razm(OtherSymbols, 2, [OtherSymbol1, OtherSymbol2]),
	sym_by_num(Word, OtherPos1, OtherSymbol1), sym_by_num(Word, OtherPos2, OtherSymbol2),
	write(Word), nl, fail.


pr10:-tell('C:/Users/Артур/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/10.txt'), pr10_write;told.
