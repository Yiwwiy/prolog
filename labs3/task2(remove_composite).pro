% главная функция
remove_composite([],[]).
remove_composite([H|T],Lst) :-
    (
    0 >= H ; isprime(H,2),isprime(H,3)) -> remove_composite(T,Res),
    Lst = [H|Res]
    ;
    remove_composite(T,Lst).
    
is_prime(N,D) :-
    (
    D * D > N -> true 
    ;   
    N mod D =\= 0, 
    N1 is D + 2, 
    is_prime(N, N1)
    ).

