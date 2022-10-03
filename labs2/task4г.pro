searchDeleted(tr(X, nil, nil), X).

searchDeleted(tr(N, L, _), X) :- L \= nil -> searchDeleted(L, X)
; 
N = X.

removeDeleted(tr(X, nil, nil), X, nil). 
removeDeleted(tr(X, nil, R), X, R). 
removeDeleted(tr(X, L, nil), X, L). 
removeDeleted(tr(N, _, _), X, T) :- X < N, T = tr(N, T1, _), 
removeDeleted(_, X, T1). 

myRemove(nil, _, nil).
myRemove(tr(X, nil, nil), X, nil) :- !.
myRemove(tr(X, L, nil), X, T) :- T = L, !.
myRemove(tr(X, nil, R), X, T) :- T = R, !.
myRemove(tr(X, L, R), X, T) :- 
            searchDeleted(R, T1), 
            write(T1), 
            removeDeleted(R, T1, R1), 
            write(R1), 
            T = tr(T1, L, R1), 
            !.
myRemove(tr(N, L, R), X, T) :- 
	X < N -> myRemove(L, X, T1), 
	T = tr(N, T1, R)
	; 
	myRemove(R, X, T1), T = tr(N, L, T1).