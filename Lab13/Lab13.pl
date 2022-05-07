list_length([H|T], N):-list_length([H|T], 0, N).
list_length([], N, N):-!.
list_length([_|T], CurN, N):- CurN1 is CurN+1, list_length(T, CurN1, N).

write_list([]):-!.
write_list([Head|Tail]):-write(Head), nl, write_list(Tail).

read_list(0, []):-!.
read_list(N, [X|T]):- read(X), N1 is N-1, read_list(N1, T).

rev(List, Result):-rev(List, [], Result).
rev([], Result, Result):-!.
rev([H|T],List1, Result):-rev(T, [H|List1], Result).

cut(List, N, M, Result):-M1 is M+1,cut(List, N, M1, 0, Result).
cut(List, N, M, N, Result):-list_length(List, Length),M1 is M-N,cut(List, N, M1, M1, Length,Result),!.
cut([_|T], N, M, CurIndex, Result):-CurIndex1 is CurIndex+1, cut(T, N, M, CurIndex1, Result).
cut(Result, _, _, M, M, Result):-!.
cut(List, N, M, DelIndex, Length, Result):-Length1 is Length-1, del_by_num(List, DelIndex, DelList), cut(DelList, N, M, DelIndex, Length1, Result),!.

my_min_list([H|T], Result):- my_min_list([H|T],H, Result).
my_min_list([], Result, Result):-!.
my_min_list([H|T], CurMax, Result):-H < CurMax,my_min_list(T, H, Result),!;my_min_list(T, CurMax, Result).

my_max_list([H|T], Result):- my_max_list([H|T],H, Result).
my_max_list([], Result, Result):-!.
my_max_list([H|T], CurMax, Result):-H > CurMax, my_max_list(T, H, Result),!;my_max_list(T, CurMax, Result).

in_list([El|_], El):-!.
in_list([_|T], El):-in_list(T, El).
%1.38 Дан целочисленный массив и отрезок a..b. Необходимо найти коли-
%чество элементов, значение которых принадлежит этому отрезку.

count_on_ab(List, A, B, Result):-count_on_ab(List, A, B, 0, Result).
count_on_ab([], _, _, Result, Result):-!.
count_on_ab([H|T], A, B, Count, Result):-H>=A, H=<B, Count1 is Count+1, count_on_ab(T, A, B, Count1, Result); count_on_ab(T, A, B, Count, Result).

f138:- read(Count), read(A), read(B), read_list(Count, List), count_on_ab(List, A, B, Result), write(Result).

