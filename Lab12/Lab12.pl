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
