in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

in_list_exclude([El|T],El,T).
in_list_exclude([H|T],El,[H|Tail]):-in_list_exclude(T,El,Tail).

read_str(A, N):-get0(X), r_str(X, A, [], 0, N).
r_str(10, A, A, N, N):-!.
r_str(X, A, B, K, N):-K1 is K+1, append(B,[X],B1),get0(X1), r_str(X1,A,B1,K1,N).


%put - ������ �� ���������������� ������
write_str([]):-!.
write_str([H|T]):-put(H), write_str(T).

sym_by_num(Str, N, Result):-sym_by_num(Str, 0, N, Result).
sym_by_num([Result|_], N, N, Result):-!.
sym_by_num([_|T], I, N, Result):-I1 is I+1,sym_by_num(T, I1, N, Result).

%���������� � ������������ �� �
razm_p(_, 0, Result, Result) :- !.
razm_p(List, K, CurList, Result) :- in_list(List, X), K1 is K - 1, razm_p(List, K1, [X|CurList], Result).
razm_p(List, K, Result) :- razm_p(List, K, [], Result).
razm_p(List, K) :- razm_p(List, K, Perm), write_str(Perm), nl, fail.
razm_p:-read(N),read_list(Str,N), read(K), razm_p(Str, K).

%������������
permutations:-read_str(A,_), permutations(A,[]).
permutations(Str):-permutations(Str, []).
permutations([], Perm):- write_str(Perm), nl, !,fail.
permutations(A, Perm):- in_list_exclude(A,El,A1), permutations(A1,[El|Perm]).

%���������� ��� ����������
razm(_, 0, Result, Result):-!.
razm(List, K, Cur, Result):-in_list_exclude(List, X, Tail),K1 is K-1, razm(Tail, K1, [X|Cur], Result).
razm(List, K, Result):-razm(List, K, [], Result).
razm(List, K):-razm(List, K, Perm), write_str(Perm), nl, fail.


read_list(A,N):-read_list(A,N,0,[]).
read_list(A,N,N,A):-!.
read_list(A,N,K,B):-read(X),append(B,[X],B1),K1 is K+1,read_list(A,N,K1,B1).

%������������
sub_set:- read(N),read_list(A,N),sub_set(B,A),write(B),nl,fail.
sub_set([],[]).
sub_set([H|Sub_set],[H|Set]):-sub_set(Sub_set,Set).
sub_set(Sub_set,[_|Set]):-sub_set(Sub_set,Set).


%��������� �� k ��� ����������
sochet([], _, 0) :- !.
sochet([H|Sub_set], [H|SetTail], K) :- K1 is K-1, sochet(Sub_set, SetTail, K1).
sochet(Sub_set, [_|SetTail], K) :- sochet(Sub_set, SetTail, K).
sochet(Set, K) :- sochet(A, Set, K), write_str(A), nl, fail.
sochet:- read_str(A, _), read(K), sochet(A, K).

%��������� �� k � ������������
sochet_p([], _, 0) :- !.
sochet_p([H|Sub_set], [H|SetTail], K):- K1 is K-1, sochet_p(Sub_set, [H|SetTail], K1).
sochet_p(Sub_set, [_|SetTail], K) :- sochet_p(Sub_set, SetTail, K).
sochet_p(Set, K) :- sochet_p(A, Set, K), write_str(A), nl, fail.
sochet_p:-read_str(A, _), read(K), sochet_p(A, K).

pr10_write:-Word=[_, _, _, _, _, _],
	sochet([El1, El2], [a, b, c, d, e, f], 2),
	in_list_exclude([a,b,c,d,e,f], El1, List1), in_list_exclude(List1, El2, OtherSymbols),
	sochet([Pos1, Pos2], [0, 1, 2, 3, 4, 5], 2), in_list_exclude([0, 1, 2, 3, 4, 5], Pos1, List2), in_list_exclude(List2, Pos2, OtherPositions),
	sochet([Pos3, Pos4], OtherPositions, 2), in_list_exclude(OtherPositions, Pos3, OtherPositions1), in_list_exclude(OtherPositions1, Pos4, [OtherPos1, OtherPos2]),
	sym_by_num(Word, Pos1, El1), sym_by_num(Word, Pos2, El1), sym_by_num(Word, Pos3, El2), sym_by_num(Word, Pos4, El2),
	razm(OtherSymbols, 2, [OtherSymbol1, OtherSymbol2]),
	sym_by_num(Word, OtherPos1, OtherSymbol1), sym_by_num(Word, OtherPos2, OtherSymbol2),
	write(Word), nl, fail.


pr10:-tell('C:/Users/�����/Documents/Prolog/FILPprolog/Lab14/Lab14OutputFiles/10.txt'), pr10_write;told.

%1.���� ��������� {a,b,c,d,e,f}. ��������� ��� ����� ����� 7, �
%������� ����� 1 ����� ����������� 2 ����, ����� ���� ����� �����������
%3 ���� ��������� ����� �� �����������. ����� � ����.
pr1_write:-Word=[_, _, _, _, _, _, _],
    sochet([El1, El2], [a, b, c, d, e ,f], 2), %El1-����������� 2 ���a, El2-3 ����
    in_list_exclude([a,b,c,d,e,f], El1, List1), in_list_exclude(List1, El2, OtherSymbols), %������� El1 � El2 �� ������ ��������
    sochet([Pos1, Pos2], [0, 1, 2, 3, 4, 5, 6], 2), %������� ��� El1
    in_list_exclude([0, 1, 2, 3, 4, 5, 6], Pos1, List2), in_list_exclude(List2, Pos2, OtherPositions), %������� �������, ������� El1
    sochet([Pos3, Pos4, Pos5], OtherPositions, 3), %������� ��� El2
    in_list_exclude(OtherPositions, Pos3, List3), in_list_exclude(List3, Pos4, List4),in_list_exclude(List4, Pos5, [OtherPos1, OtherPos2]),%������� �%������, ������� El2
    sym_by_num(Word, Pos1, El1), sym_by_num(Word, Pos2, El1), %�������� El11
    sym_by_num(Word, Pos3, El2), sym_by_num(Word, Pos4, El2),sym_by_num(Word, Pos5, El2), %�������� El2
    razm(OtherSymbols, 2, [OtherSymbol1, OtherSymbol2]),%������� �������, � ������� ������� �������� �����
    sym_by_num(Word, OtherPos1, OtherSymbol1), sym_by_num(Word, OtherPos2, OtherSymbol2),%�������� ��������� ������� �� ���������� �������
    write(Word), nl, fail.

pr1:-tell('C:/Users/�����/Documents/Prolog/FILPprolog/Lab15/OutputFiles/1.txt'), pr1_write;told.


%2. ���� ��������� {a,b,c,d,e,f}. ��������� ��� ����� ����� 9, �
%������� ����� 2 ����� ����������� 2 ����, ����� ���� ����� �����������
%��� ����, ��������� ����� �� �����������. ����� � ����.


pr2_write:-Word=[_, _, _, _, _, _, _, _, _],
    sochet([El1, El2, El3], [a, b, c, d, e, f], 3), %El1, El2-2 ����, El3- 3 ����
    in_list_exclude([a,b,c,d,e,f], El1, List1), in_list_exclude(List1, El2, List2), in_list_exclude(List2, El3, OtherSymbols), %������� El1, El2, El3
    sochet([Pos1, Pos2], [0, 1, 2, 3, 4, 5, 6, 7, 8], 2), %������� ��� El1
    in_list_exclude([0, 1, 2, 3, 4, 5, 6, 7, 8], Pos1, List3), in_list_exclude(List3, Pos2, List4),%������� ������� El1
    sochet([Pos3, Pos4], List4, 2), %������� ��� El2
    in_list_exclude(List4, Pos3, List5), in_list_exclude(List5, Pos4, List6),%������� ������� El2
    sochet([Pos5 ,Pos6, Pos7], List6, 3), %������� ��� El3
    in_list_exclude(List6, Pos5, List7), in_list_exclude(List7, Pos6, List8), in_list_exclude(List8, Pos7, [OtherPos1, OtherPos2]), %������� ������� El3
    sym_by_num(Word, Pos1, El1), sym_by_num(Word, Pos2, El1), %������� El1
    sym_by_num(Word, Pos3, El2), sym_by_num(Word, Pos4, El2), %������� El2
    sym_by_num(Word, Pos5, El3), sym_by_num(Word, Pos6, El3), sym_by_num(Word, Pos7, El3),%������� El3
    razm(OtherSymbols, 2, [OtherSymbol1, OtherSymbol2]),%������� �������, � ������� ������� �������� �����
    sym_by_num(Word, OtherPos1, OtherSymbol1), sym_by_num(Word, OtherPos2, OtherSymbol2),%�������� ��������� ������� �� ���������� �������
    write(Word), nl, fail.

pr2:-tell('C:/Users/�����/Documents/Prolog/FILPprolog/Lab15/OutputFiles/2.txt'), pr2_write;told.
