﻿%11 Количество чисел, взаимнопростых с заданным.
nod(A, 0, A) :- !.
nod(A, B, X) :- C is A mod B, nod(B, C, X).

count_vzaim_pr_up(X, Count):- count_vzaim_pr_up(X, X, Count).
count_vzaim_pr_up(_, 1, 1):-!.
count_vzaim_pr_up(X, CurDel, Count):-
    CurDel1 is CurDel-1,
    count_vzaim_pr_up(X, CurDel1, Count1),
    nod(X, CurDel, NOD),
   (    NOD is 1,
    Count is Count1+1, !;
    Count is Count1).

count_vzaim_pr_down(X, Count):-count_vzaim_pr_down(X, 1, X, Count).
count_vzaim_pr_down(_, Count, 1, Count):-!.
count_vzaim_pr_down(X, C, CurDel, Count):-CurDel1 is CurDel-1, nod(X, CurDel, NOD), (NOD is 1, C1 is C+1, count_vzaim_pr_down(X, C1, CurDel1, Count),!;count_vzaim_pr_down(X, C, CurDel1, Count)).

%12 Найти делитель числа, который является вазимнопростым с наибольшим
% количеством цифр данного числа.

%рассматривается один делитель
f(X, Del, Count):-f(X, Del, 0, Count).
f(0, _, Count, Count):-!.
f(X, Del, C, Count):-
    X1 is X div 10, Dig is X mod 10,
    (nod(Dig, Del, NOD), NOD is 1, C1 is C+1, f(X1, Del, C1, Count);
    f(X1, Del, C, Count)).


%проход по всем делителям и поиск необходимого
f12(X, Result):-f12(X, X, 0, 0, Result).
f12(_, 1, Result, _, Result):-!.
f12(X, CurDel, MaxDel, MaxCount, Result):-
    CurDel1 is CurDel-1, Ost is X mod CurDel,
    (Ost is 0, f(X, CurDel, Count), Count>MaxCount, f12(X, CurDel1, CurDel, Count, Result),!;
    f12(X, CurDel1, MaxDel, MaxCount, Result)).

%14 Длина списка
list_length([H|T], N):-list_length([H|T], 0, N).
list_length([], N, N):-!.
list_length([_|T], CurN, N):- CurN1 is CurN+1, list_length(T, CurN1, N).

write_list([]):-!.
write_list([Head|Tail]):-write(Head), nl, write_list(Tail).

read_list(0, []):-!.
read_list(N, [X|T]):- read(X), N1 is N-1, read_list(N1, T).

%удалить элемент с указанным номером
del_by_num(List, N, Result):-del_by_num(List, N, 0, Result).
del_by_num([_|T], N, N, T):-!.
del_by_num([H|T], N, I, [H|NewT]):- I1 is I+1, del_by_num(T, N, I1, NewT).

%Получить значение по индексу
get_elem_index([H|T], Index, Result):- get_elem_index([H|T], Index, 0, Result).
get_elem_index([H|_], Index, Index, H):-!.
get_elem_index([_|T], Index, CurIndex, Result):- CurIndex1 is CurIndex+1, get_elem_index(T, Index, CurIndex1, Result).

%Соединить два листа
join([], List, List).
join([H1|T1], List2, [H1|T2]) :- join(T1, List2, T2).

shift_right(List, N, Result):-list_length(List, Count), shift_right(List, N, 0,Count, Result).
shift_right(Result, N, N,_, Result):-!.
shift_right(List, N, I, Count, Result):-I1 is I+1, Count1 is Count-1, get_elem_index(List, Count1, GetElem), del_by_num(List, Count1, DelList), shift_right([GetElem|DelList],N, I1, Count, Result).

%15.7 Циклический сдвиг массива вправо на 2 позиции
f157:- read(Count), read_list(Count, List), shift_right(List, 2, Result), write_list(Result).
