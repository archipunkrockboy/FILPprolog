﻿read_str(A, N):-get0(X), r_str(X, A, [], 0, N).
r_str(10, A, A, N, N):-!.
r_str(X, A, B, K, N):-K1 is K+1, append(B,[X],B1),get0(X1), r_str(X1,A,B1,K1,N).


%put - символ по соответствующему номеру
write_str([]):-!.
write_str([H|T]):-put(H), write_str(T).


%1.1Дана строка. Вывести ее три раза через запятую и показать количе-
%ство символов в ней.

f11:-read_str(S, N), write_str(S), write(', '), write_str(S), write(', '), write_str(S), nl,write('length - '), write(N).
