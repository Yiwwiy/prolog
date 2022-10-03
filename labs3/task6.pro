quickSort([],[]).
quickSort([H|T],Res) :-
        partition(H,T,H1,T1), % H1 - список элементов не меньших H
        quickSort(H1,SortH1),
        quickSort(T1,SortT1),
        append(SortT1,[H|SortH1],Res).

partition(_,[],[],[]).
partition(H,[X|T],S,[X|T2]) :- 
        X < H,
        !,
        partition(H,T,S,T2).
partition(H,[X|T],[X|S],T2) :-
       partition(H,T,S,T2).        

