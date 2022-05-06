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

%13.1 Является ли X внуком Y?
grand_son(X, Y):-parent(Y, Z), parent(Z, X).
%13.2 Вывести всех внуков X
grand_sons(X):-parent(X, Y), man(Y), parent(Y, Z), write(Z), nl ,fail.
