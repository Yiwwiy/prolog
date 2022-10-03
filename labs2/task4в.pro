isSearchTree(tr(N,L,R)) :- bst(tr(N,L,R),-2^59,2^59).

bst(nil,_,_).

bst(tr(N,L,R),Min,Max) :- 
    N > Min,
    N < Max,
    bst(L,Min,N),
    bst(R,N,Max).