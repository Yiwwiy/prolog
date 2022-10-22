% task2
%Условие задачи:
%Пять студентов должны посещать лекции всю неделю, но по определённым ими уста-
%новленным правилам, а именно:
%1) если пришли Андрей и Дмитрий, то Бориса быть не должно;
%2) если Андрей присутствует, а Дмитрий не пришёл, то Борис должен быть, а Виктор%
%быть не должен;
%3) Андрей и Виктор должны присутствовать или отсутствовать одновременно;
%4) если Дмитрий пришёл, то Григория быть не должно;
%5) если нет Бориса и Виктора, то Дмитрий должен быть;
%6) если нет Бориса и есть Виктор, Дмитрия быть не должно, но должен быть Григорий;
%7) если есть Борис, то есть и Андрей.
%В каких сочетаниях студенты могут присутствовать на лекции?

attend(yes).
attend(no).

condition(A, B) :- call(A) -> call(B) ; true.

start :-
    %сопоставлям с attend студенитов
	attend(Andrey), attend(Dmitriy), attend(Boris), attend(Victor), attend(Grigoriy),

    %прописываем условия посещений пар студентами
	condition((Andrey = yes, Dmitriy = yes), (Boris = no)),
	condition((Andrey = yes, Dmitriy = no), (Boris = yes, Victor = no)),
	(Andrey = yes, Victor = yes 
     ; 
     Andrey = no, Victor = no),
	condition((Dmitriy = yes), (Grigoriy = no)),
	condition((Boris = no, Victor = no), (Dmitriy = yes)),
	condition((Boris = no, Victor = yes), (Dmitriy = no, Grigoriy = yes)),
	condition((Boris = yes), (Andrey = yes)),
    
    
	write(andrey), write(':'), write(Andrey), nl,
	write(dmitriy), write(':'), write(Dmitriy), nl,
	write(boris), write(':'), write(Boris), nl,
	write(victor), write(':'), write(Victor), nl,
	write(grigoriy), write(':'), write(Grigoriy), nl.