read_str(A, N):-get0(X), r_str(X, A, [], 0, N).
r_str(10, A, A, N, N):-!.
r_str(X, A, B, K, N):-K1 is K+1, append(B,[X],B1),get0(X1), r_str(X1,A,B1,K1,N).


%put - символ по соответствующему номеру
write_str([]):-!.
write_str([H|T]):-put(H), write_str(T).


%1.1Дана строка. Вывести ее три раза через запятую и показать количе-
%ство символов в ней.

f1_1:-read_str(S, N), write_str(S), write(', '), write_str(S), write(', '), write_str(S), nl,write('length - '), write(N).


%1.2 Дана строка. Найти количество слов.

f1_2:-read_str(A,_), countwords(A, K),nl,write(K).

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
max_frequency_str(Str, CurMax, CurMaxCount, Result):- getword(Str, W, NewStr), frequency_str(W, Str, Count),(Count>CurMaxCount, max_frequency_str(NewStr, W, Count, Result);max_frequency_str(NewStr, CurMax, CurMaxCount, Result)).

f1_3:-read_str(S, _), max_frequency_str(S, Result), write_str(Result).


%1.4 Дана строка. Вывести первые три символа и последний три символа,
%если длина строки больше 5 Иначе вывести первый символ столько
%раз, какова длина строки.

write1(S, N):-write1(S, 0, N).
write1(_, N, N):-!.
write1([H|T], I, N):- I1 is I+1, ((I<3, put(H),write1(T, I1, N)),!;(I+3>=N, put(H),write1(T, I1, N)),!;write1(T, I1, N)).

write2(S, N):-write2(S, 0, N).
write2(_, N, N):-!.
write2([H|_], I, N):-put(H), I1 is I+1, write2([H|_], I1, N).

f1_4:-read_str(S, N), (N>5, write1(S, N); write2(S, N)).
