isPrime(N,D) :-
    (
	D * D > N -> true 
    ;   
	N mod D =\= 0, 
    N1 is D + 2, 
    isPrime(N, N1)
    ).

remove_composite([],[]).
remove_composite([H|T],Lst) :-
    (
     0 >= H ; isPrime(H,2),isPrime(H,3)) -> remove_composite(T,Res),
    Lst = [H|Res]
    ;
    remove_composite(T,Lst).

