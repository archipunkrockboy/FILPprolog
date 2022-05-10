%11 Количество чисел, взаимнопростых с заданным.
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
write_list([Head|Tail]):-write(Head), write(" "), write_list(Tail).

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

%поиск индекса первого минимального элемента
min_list_index([H|T], Result):-min_list_index([H|T], H, 0, 0, Result).
min_list_index([], _,Result, _,Result):-!.
min_list_index([H|T], Min, MinIndex, CurIndex, Result):-CurIndex1 is CurIndex+1, H < Min, min_list_index(T, H, CurIndex, CurIndex1, Result);CurIndex1 is CurIndex+1, min_list_index(T, Min, MinIndex, CurIndex1, Result).

% 15.8 Дан целочисленный массив. Необходимо найти индексы двух
% наименьших элементов массива.

f158:- read(Count), read_list(Count, List), min_list_index(List, MinIndex1), del_by_num(List, MinIndex1, DelList), min_list_index(DelList, MinIndex2), write(MinIndex1),nl, (MinIndex2<MinIndex1, write(MinIndex2); MinIndex22 is MinIndex2 + 1, write(MinIndex22)).

%15.18 Дан целочисленный массив. Необходимо найти элементы, располо-
%женные перед первым минимальным.



rev(List, Result):-rev(List, [], Result).
rev([], Result, Result):-!.
rev([H|T],List1, Result):-rev(T, [H|List1], Result).

%Срез массива от N до M
cut(List, N, M, Result):-M1 is M+1,cut(List, N, M1, 0, Result).
cut(List, N, M, N, Result):-list_length(List, Length),M1 is M-N,cut(List, N, M1, M1, Length,Result),!.
cut([_|T], N, M, CurIndex, Result):-CurIndex1 is CurIndex+1, cut(T, N, M, CurIndex1, Result).
cut(Result, _, _, M, M, Result):-!.
cut(List, N, M, DelIndex, Length, Result):-Length1 is Length-1, del_by_num(List, DelIndex, DelList), cut(DelList, N, M, DelIndex, Length1, Result),!.



f1518:- read(Count), read_list(Count, List), min_list_index(List, MinIndex), I is MinIndex-1, cut(List, 0, I, Result), write_list(Result).


%15.20 Дан целочисленный массив. Необходимо найти все пропущенные
%числа.
my_min_list([H|T], Result):- my_min_list([H|T],H, Result).
my_min_list([], Result, Result):-!.
my_min_list([H|T], CurMax, Result):-H < CurMax,my_min_list(T, H, Result),!;my_min_list(T, CurMax, Result).

my_max_list([H|T], Result):- my_max_list([H|T],H, Result).
my_max_list([], Result, Result):-!.
my_max_list([H|T], CurMax, Result):-H > CurMax, my_max_list(T, H, Result),!;my_max_list(T, CurMax, Result).

in_list([El|_], El):-!.
in_list([_|T], El):-in_list(T, El).

propuski(List, Result):-my_max_list(List, Max), my_min_list(List, Min), propuski(List, Min, Max, [],Result).
propuski(_,Max, Max, Result, Result):-!.
propuski(List, CurElem, Max, List1, Result):-CurElem1 is CurElem+1,(in_list(List, CurElem), propuski(List, CurElem1, Max, List1, Result), !;propuski(List, CurElem1, Max, [CurElem|List1], Result)).

f1520:- read(Count), read_list(Count, List), propuski(List, Result), write_list(Result).

%15.32Дан целочисленный массив. Найти количество его локальных мак-
%симумов.
count_local_max1([H|T], Result):-count_local_max(T, H, 0, Result).
count_local_max1([], _, _, Result, Result):-!.
count_local_max1([H|T], A, Count, Result):-count_local_max(T, A, H, Count, Result).
count_local_max1([H|T], A, B, Count, Result):- (B>A, B>H, Count1 is Count+1, count_local_max(T, B, H, Count1, Result),!);count_local_max(T, B, H, Count, Result).


count_local_max(List, Result):-count_local_max(List, 0, Result).
count_local_max([], Result, Result):-!.
count_local_max([A|[B|[C|T]]], Count, Result):- B>A, B>C, Count1 is Count+1, count_local_max([B|[C|T]], Count1, Result),!; count_local_max([B|[C|T]], Count,Result).
count_local_max([_|[_]], Result, Result):-!.
count_local_max([_], Result, Result):-!.

f1532:- read(Count), read_list(Count, List), count_local_max(List, Result), write(Result).

closest_elem([H|T], Elem, Result):- MinDifference is abs(H-Elem), closest_elem(T, Elem, H, MinDifference, Result).
closest_elem([], _, Result, _, Result):-!.
closest_elem([H|T], Elem, CurElem, MinDifference ,Result):- Difference is abs(H-Elem),Difference<MinDifference, closest_elem(T, Elem, H, Difference, Result),!;closest_elem(T, Elem, CurElem, MinDifference, Result).

%15.35 Дано вещественное число R и массив вещественных чисел. Найти
%элемент массива, который наиболее близок к данному числу.
f1535:- read(Count), read(Elem), read_list(Count, List), closest_elem(List, Elem, Result), write(Result).


%13 Найдите сумму простых чисел, меньших 1000000 которые можно обрезать
%слева направо и справа налево.



is_prime(1):-!, fail.
is_prime(X):-is_prime(X, 2).
is_prime(X, X):-!.
is_prime(X, CurDel):-Ost is X mod CurDel, Ost is 0, !, fail;CurDel1 is CurDel + 1, is_prime(X, CurDel1).



is_prime_left_right(X):-is_prime_left_right(X, X, X).
is_prime_left_right(_, 0, 0):-!.
is_prime_left_right(X, XL, XR):- is_prime(XL), is_prime(XR), XR1 is XR div 10, del_first_digit(XL, XL1), is_prime_left_right(X, XL1, XR1);!, fail.


del_first_digit(X, Result):-del_first_digit(X, X, 1,_, Result).
del_first_digit(_, 0, _, Result, Result):-!.
del_first_digit(X, CurX, MOD, _, Result):- CurX1 is CurX div 10, MOD1 is MOD*10, A is X mod MOD, del_first_digit(X, CurX1, MOD1, A, Result).


f13(Sum, List):-f13(23, 0, [],Sum, List).
f13(1000000, Sum,List, Sum, List):-!.
f13(1000, CurSum, CurList, Sum, List):-f13(2000, CurSum, CurList, Sum, List).
f13(10000, CurSum, CurList, Sum, List):-f13(20000, CurSum, CurList, Sum, List).
f13(100000, CurSum, CurList, Sum, List):-f13(200000, CurSum, CurList, Sum, List).
f13(Cur, CurSum,List1, Sum, List):- write(Cur),nl,Cur1 is Cur+1, (is_prime_left_right(Cur), write("------"),write(Cur),nl,write("------"),nl, CurSum1 is CurSum+Cur, f13(Cur1,CurSum1,[Cur|List1], Sum, List); f13(Cur1, CurSum,List1, Sum,List)).
