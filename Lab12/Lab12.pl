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
