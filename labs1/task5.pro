% 5 задание
prime(2).
prime(3).

prime(N) :-
    N > 3, 
    N mod 2 =\= 0, 
    isPrime(N,3).

isPrime(N,D) :-
    (
	D * D > N -> true 
    ;   
	N mod D =\= 0, 
    N1 is D + 2, 
    isPrime(N, N1)
    ).