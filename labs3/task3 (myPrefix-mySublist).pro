myPrefix([], []).
myPrefix([], X) :- X \= [], myPrefix([], []).
myPrefix([H1 | T], [H2 | Tn]) :- H1 = H2, myPrefix(T, Tn).

mySublist(Lst1, Lst2) :- 
   (
    myPrefix(Lst1, Lst2)
    ; 
    Lst2 = [_ | T], mySublist(Lst1, T)
   ).
