﻿read_str(A, N):-get0(X), r_str(X, A, [], 0, N).
r_str(10, A, A, N, N):-!.
r_str(X, A, B, K, N):-K1 is K+1, append(B,[X],B1),get0(X1), r_str(X1,A,B1,K1,N).


%put - символ по соответствующему номеру
write_str([]):-!.
write_str([H|T]):-put(H), write_str(T).


%1.1Дана строка. Вывести ее три раза через запятую и показать количе-
%ство символов в ней.

f11:-read_str(S, N), write_str(S), write(', '), write_str(S), write(', '), write_str(S), nl,write('length - '), write(N).

%1.2 Дана строка. Найти количество слов.
% 4 аргумент(флаг): 1 - слово началось и ищем конец, 0 - пропускаем
% пробелы.
words_count(S, C):-words_count(S, 0, C, 0).
words_count([],C,C,_):-!.
words_count([32|T], CurC, C, 0):- words_count(T, CurC, C, 0).
words_count([_|T], CurC, C, 0):- CurC1 is CurC+1, words_count(T, CurC1, C, 1).
words_count([_|T], CurC, C, 1):- words_count(T, CurC, C, 0).


%words_count([],C,C):-!.

f12:-read_str(A,_), countwords(A, K),nl,write(K).

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
