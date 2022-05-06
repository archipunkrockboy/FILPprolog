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

%11.1 ßâëÿåòñÿ ëè Õ ñûíîì Y.
son(X,Y):- man(X), parent(Y, X).
%11.2 Âûâåñòè ñûíà Õ
son(X):- man(Y), parent(X, Y), write(Y),nl, fail.

%12.1 ßâëÿåòñÿ ëè Õ ñåñòğîé Y.
sister(X, Y):- woman(X), parent(Z, X), parent(Z, Y).
%12.2 Âûâåñòè âñåõ ñåñò¸ğ Õ.
sisters(X):-woman(Y), woman(Z), parent(Z, X), parent(Z, Y), write(Y), nl, fail.

%13.1 ßâëÿåòñÿ ëè X âíóêîì Y?
grand_son(X, Y):-parent(Y, Z), parent(Z, X).
%13.2 Âûâåñòè âñåõ âíóêîâ X
grand_sons(X):-parent(X, Y), man(Y), parent(Y, Z), write(Z), nl ,fail.

%14 ßâëÿşòñÿ ëè X è Y âíó÷êîé è äåäóøêîé èëè äåäóøêîé è âíó÷êîé
%óâèäèòü ğóññêèé êîììåíòàğèé ïæ
grand_pa_and_da(X, Y):- parent(X, Z), parent(Z, Y); parent(Y, Z), parent(Z, X).

%15 Ìàêñèìàëüíàÿ öèôğà ÷èñëà(ğåêóğñèÿ ââåğõ).
max_cifra_up(0,0).
max_cifra_up(X, M):- X1 is X div 10, max_cifra_up(X1, M1), M2 is X mod 10, (M1>M2,M is M1; M is M2),!.
