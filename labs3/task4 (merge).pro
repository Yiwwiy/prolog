merge([],L,L).
merge(L,[],L).
merge([H1|T1], [H2|T2], L) :- 
    (   H1 < H2 -> L = [H1|R], merge(T1,[H2|T2],R) ;
        H1 > H2 -> L = [H2|R], merge([H1|T1],T2,R) ;
        L = [H1,H2|R], merge(T1,T2,R)
    ).

