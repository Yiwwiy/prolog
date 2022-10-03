% 2 задание из 2 лабы
inNumber(N,D) :- abs(N) =:= D.


inNumber(N,D) :-
    abs(N) > 9,
    N1 is abs(N) mod 10,
    (   
	N1 == D -> true 
    ;   
	N2 is abs(N) div 10,
    inNumber(N2, D)
    ).

qntDigit(A, B, D, N) :- iter(A, B, D, N, 0).

iter(C, B, D, N, Count) :-
    C == B,
    (inNumber(C, D),
    Count1 is Count + 1 -> N is Count1
    ;   
    N is Count
    ).

iter(C, B, D, N, Count) :-
    C < B,
    C1 is C + 1,
    (  
	inNumber(C, D) -> Count1 is Count + 1,
    iter(C1, B, D, N, Count1)
    ;   
	iter(C1, B, D, N, Count)
    ).