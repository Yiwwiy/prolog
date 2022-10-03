:- initialization(consult('kinship.pro')).

%task 1
pred(X, Y) :- parent(X, Y).
pred(X, Y) :-
    parent(F, Y), male(F), 
    parent(M, Y), female(M),
    (pred(X, F) ; pred(X, M)).

pred1(X,Y) :- parent(X,Y).
pred1(X,Y) :- setof(P, (pred(P,Y), pred(X,P)), _).    

%task 2
brother(X,Y) :- male(X), male(Y), siblings(X,Y).

%определяет являются ли братьми и сестрами
siblings(X,Y) :-
   parent(F,Y), male(F), 
   parent(M,Y), female(M),
   parent(F,X),parent(M,Y),
   X \= Y.

 %task 3
married(X, Y) :- 
    setof(C, (parent(X, C), parent(Y, C)), _),
    X \= Y.

%task4
husband(X,Y) :- male(X), married(X,Y).

%task 5
cousin(X,Y) :- 
   parent(P1,X),
   parent(P2,Y),
   siblings(P1,P2).



%task 6
num_of_children(X,N) :- 
   setof(Y, parent(X,Y), F), length(F,N).
num_of_children(X, 0) :-
    (male(X); female(X)),
    \+ parent(X, _). 



%task 7 
nephews(X,Y) :- 
    (female(Y); male(Y)),
    findall(Z, (siblings(Y,S), parent(S, Z)), F), sort(F, X).

nephews1(X,Y) :-  siblings(P,Y), setof(C, parent(P,C), X). 
%talk 8  
family(X) :-  
    married(Father, Mother),
    male(Father),
    female(Mother),
    setof(C, (parent(Father, C), parent(Mother, C)), Kids),
    X = [Father, Mother | Kids].