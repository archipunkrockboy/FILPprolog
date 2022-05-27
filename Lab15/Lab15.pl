in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

in_list_exclude([El|T],El,T).
in_list_exclude([H|T],El,[H|Tail]):-in_list_exclude(T,El,Tail).

read_str(A, N):-get0(X), r_str(X, A, [], 0, N).
r_str(10, A, A, N, N):-!.
r_str(X, A, B, K, N):-K1 is K+1, append(B,[X],B1),get0(X1), r_str(X1,A,B1,K1,N).


%put - символ по соответствующему номеру
write_str([]):-!.
write_str([H|T]):-put(H), write_str(T).

sym_by_num(Str, N, Result):-sym_by_num(Str, 0, N, Result).
sym_by_num([Result|_], N, N, Result):-!.
sym_by_num([_|T], I, N, Result):-I1 is I+1,sym_by_num(T, I1, N, Result).

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
