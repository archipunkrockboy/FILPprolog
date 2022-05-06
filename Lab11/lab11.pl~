man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).

%11.1 Является ли Х сыном Y.
son(X,Y):- man(X), parent(Y, X).
%11.2 Вывести сына Х
son(X):- man(Y), parent(X, Y), write(Y),nl, fail.

%12.1 Является ли Х сестрой Y.
sister(X, Y):- woman(X), parent(Z, X), parent(Z, Y).
%12.2 Вывести всех сестёр Х.
sisters(X):-woman(Y), woman(Z), parent(Z, X), parent(Z, Y), write(Y), nl, fail.

%13.1 Является ли Х внуком Y.
grand_son(X, Y):-parent(Y, Z), parent(Z, X).
%13.2 Вывести всех внуков X
grand_sons(X):-parent(X, Y), man(Y), parent(Y, Z), write(Z), nl ,fail.

%14 Являются ли X и Y внучкой и дедушкой или дедушкой и внучкой
grand_pa_and_da(X, Y):- parent(X, Z), parent(Z, Y); parent(Y, Z), parent(Z, X).

%15 Максимальная цифра числа(рекурсия вверх).
max_cifra_up(0,0).
max_cifra_up(X, M):- X1 is X div 10, max_cifra_up(X1, M1), M2 is X mod 10, (M1>M2,M is M1; M is M2),!.

%16 Максимальная цифра числа(рекурсия вниз)
max_cifra_down(X, M):- max_cifra_down(X, 0, M).
max_cifra_down(0, M ,M):-!.
max_cifra_down(X, Y, M):- Y1 is X mod 10, X1 is X div 10, Y1>Y, max_cifra_down(X1, Y1, M),!;
X2 is X div 10, max_cifra_down(X2, Y, M).

%17 Сумма цифр числа, делящихся на 3
sum_cifr3_up(0, 0).
sum_cifr3_up(X, S):- X1 is X div 10, sum_cifr3_up(X1, S1), Dig is X mod 10, (0 is Dig mod 3, S is S1 + Dig; S is S1), !.

%18 Сумма цифр числа, делящихся на 3(рекурсия вниз).
sum_cifr3_down(X, S):-sum_cifr3_down(X, 0, S).
sum_cifr3_down(0, S, S):-!.
sum_cifr3_down(X, CurS, S):- Dig is X mod 10, 0 is Dig mod 3, CurS1 is CurS + Dig, X1 is X div 10, sum_cifr3_down(X1, CurS1, S),!; X2 is X div 10, sum_cifr3_down(X2, CurS, S),!.

%19 Число Фибонначи с номером N(рекурсия вверх).
fib_up(1, 1):-!.
fib_up(2, 1):-!.
fib_up(N ,X):- N1 is N-1, N2 is N-2, fib_up(N1, X1), fib_up(N2, X2), X is X1+X2.
