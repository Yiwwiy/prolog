contains(Tr,X) :- nonvar(X), whenXisNonvar(Tr,X).
contains(Tr,X) :- var(X), whenXisVar(Tr,X).

whenXisNonvar(tr(X,_,_),X).
whenXisNonvar(tr(N,L,_),X) :- X < N, whenXisNonvar(L,X), !.
whenXisNonvar(tr(_,_,R),X) :- whenXisNonvar(R,X), !.

whenXisVar(tr(N,nil,_),X) :- N = X.
whenXisVar(tr(_,L,_),X) :- \+ L = nil, whenXisVar(L,X).
whenXisVar(tr(N,L,R),X) :- 
        \+ L = nil,
        \+ R = nil,
        N = X.
whenXisVar(tr(_,_,R),X) :- \+ R = nil, whenXisVar(R,X).
