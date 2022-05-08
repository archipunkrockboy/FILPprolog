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
%1.38 ��� ������������� ������ � ������� a..b. ���������� ����� ����-
%������ ���������, �������� ������� ����������� ����� �������.

count_on_ab(List, A, B, Result):-count_on_ab(List, A, B, 0, Result).
count_on_ab([], _, _, Result, Result):-!.
count_on_ab([H|T], A, B, Count, Result):-H>=A, H=<B, Count1 is Count+1, count_on_ab(T, A, B, Count1, Result); count_on_ab(T, A, B, Count, Result).

f138:- read(Count), read(A), read(B), read_list(Count, List), count_on_ab(List, A, B, Result), write(Result).

%��� ������ �����. ���������� ���������, ���������� �� � ��� ��-
%��� � ������������ �����.

a:-A is 100.0 / 10.0, write(A).


%1.56. ��� ���������� ������ ��������� ������� �������������� ���������
%���������, ������� ������, ��� ������� �������������� �������.

%�������� �� ��������
is_prime(1):-!, fail.
is_prime(X):-is_prime(X, 2).
is_prime(X, X):-!.
is_prime(X, CurDel):-Ost is X mod CurDel, Ost is 0, !, fail;CurDel1 is CurDel + 1, is_prime(X, CurDel1).

sum_count_prime(List, Sum, Count):-sum_count_prime(List, 0, 0, Sum, Count).
sum_count_prime([], Sum, Count, Sum, Count):-!.
sum_count_prime([H|T], CurSum, CurCount, Sum, Count):- is_prime(H), CurSum1 is CurSum+H, CurCount1 is CurCount+1, sum_count_prime(T, CurSum1, CurCount1, Sum, Count),!;sum_count_prime(T, CurSum, CurCount, Sum, Count).


sum_count_nprime(List, Sum, Count):-sum_count_prime(List, SumPrime, CountPrime),CountPrime\=0, AverPrime is SumPrime/CountPrime, sum_count_nprime(List, 0, 0, AverPrime, Sum, Count),!;sum_count_nprime(List, 0, 0, 0, Sum, Count).
sum_count_nprime([], ResultSum, ResultCount, _, ResultSum, ResultCount):-!.
sum_count_nprime([H|T], CurSum, CurCount, AverPrime, Sum, Count):-H>AverPrime, not(is_prime(H)), CurSum1 is CurSum+H, CurCount1 is CurCount+1, sum_count_nprime(T, CurSum1, CurCount1, AverPrime, Sum, Count),!;sum_count_nprime(T, CurSum, CurCount, AverPrime, Sum, Count).

f156:-read(Count), read_list(Count, List), sum_count_nprime(List, Sum, Count1), Count1\=0, Average is Sum/Count1, write(Average),!; write(0).

%14 �������� ���� ������: ���������, �����, ������. ������
%������ ����������: ����������, ��� ���� �� ��� �������, ������ ������,
% ������ - �����, �� �� � ���� ���� ����� �� ������������� �������.
% �����
%���� ����� � ������� �� ������?

inlist([],_):-fail.
inlist([X|_],X).
inlist([_|T],X):-inlist(T,X).

task14:-Hair=[_, _,_],
    inlist(Hair,[blond,_]),
    inlist(Hair,[black,_]),
    inlist(Hair,[red, _]),
    inlist(Hair,[_, belokurov]),
    inlist(Hair,[_, chernov]),
    inlist(Hair,[_, ryzhov]),
    not(in_list(Hair,[blond,belokurov])),
    not(in_list(Hair,[black,chernov])),
    not(in_list(Hair,[red,ryzhov])),
    write(Hair).


%15 ��� ������� ����� � �����, ������� � ����� ������� � ���-
% ���. ��������, ��� ������ � ��� ����� ������ � ������ ���������. ��
% �����,
%�� ������ ���� �� ���� ������. ������ ���� � ������� ������. ����������
%����� ������ � ������ �� ������ �� ������.
task15:-Fashion=[_, _, _],
    inlist(Fashion, [anya,_,_]),
    inlist(Fashion, [valya,_,_]),
    inlist(Fashion, [natasha,_,_]),
    inlist(Fashion, [_, white,_]),
    inlist(Fashion, [_, green, _]),
    inlist(Fashion, [_, blue, _]),
    inlist(Fashion, [_, _, white]),
    inlist(Fashion, [_, _, green]),
    inlist(Fashion, [_, _, blue]),
    inlist(Fashion, [natasha,_,green]),
    not(inlist(Fashion, [natasha,green,_])),
    not(inlist(Fashion, [valya,white,white])),
    write(Fashion),!.

%16 �� ������ �������� ��� �����: �������, ������ � �������. ��
% ������� �������, ������ � �������. � ������� ��� �� �������, �� ������.
% ��
% ����� ������� �� ������. �������, ������� �� ������ ��������, ������
% ������. ������� ������� �������, ������ � ��������.

%[���������, �������, �������, �������� ���������, ������/�����]
task16:- Zavod=[_, _, _],
    inlist(Zavod, [slesar, _, mladshiy, _, 0]),
    inlist(Zavod, [tokar, _,sredniy, _, _]),
    inlist(Zavod, [svarshik, _, _, _, _]),
    inlist(Zavod, [_, borisov,_,_, 1]),
    inlist(Zavod, [_, ivanov,_, _, _]),
    inlist(Zavod, [_, semenov,starshiy,zhenat_na_sestre_borisova,_]),
    inlist(Zavod, [slesar, Who1, _, _, _]),
    inlist(Zavod, [tokar, Who2, _, _, _]),
    inlist(Zavod, [svarshik, Who3, _, _, _]),
    write(Zavod),nl,write('slesar = '),write(Who1),nl,write('tokar = '),write(Who2),nl,write('svarshick = '),write(Who3),!.



%17 � �������, �������, ������� � ����� ��������� ������, ��-
% �����, ���� � ����. ��������, ��� ���� � ������ �� � �������, ����� � ������-
% ��� ��������� ����� �������� � ������� � ������, � ����� - �� ������� �
% �� ����. ������ ��������� ����� ����� � ������ � �������. ���
% ������������ ��� �������� �� �������.

%A ����� �� B
left(_, _, [_]):-fail.
left(A, B, [A|[B|_]]).
left(A, B, [_|T]):-left(A, B, T).

%� ������ �� �
right(_, _, [_]):-fail.
right(A, B, [B|[A|_]]).
right(A, B, [_|T]):-right(A, B, T).

%�����
before(A, B, List):-left(A, B, List).
before(A, B, List):-right(A, B, List).

%[��������, �������]
task17:- Drinks = [_, _, _, _],
    inlist(Drinks,[water, _]),
    inlist(Drinks,[milk, _]),
    inlist(Drinks,[lemonade, _]),
    inlist(Drinks,[kvas, _]),
    inlist(Drinks,[_, bottle]),
    inlist(Drinks,[_, kuvshin]),
    inlist(Drinks,[_, banka]),
    inlist(Drinks,[_, glass]),
    not(inlist(Drinks,[water, bottle])),
    not(inlist(Drinks,[milk, bottle])),
    not(inlist(Drinks,[water, banka])),
    not(inlist(Drinks,[lemonade, banka])),
    left([_, kuvshin],[lemonade,_], Drinks),
    right([kvas, _], [lemonade,_], Drinks),
    before([_, banka], [_, glass], Drinks),
    before([milk,_], [_, glass], Drinks),
    write(Drinks).


