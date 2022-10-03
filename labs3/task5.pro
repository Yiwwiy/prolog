%Главный предикат
numlst(0,[0]).
numlst(N,Lst) :- 
   nonvar(N), N>0,
   forNonvar(N,Lst,[]).

numlst(N,Lst) :-
   var(N),nonvar(Lst),
   nonvarLst(N,Lst,0).
numlst(N,Lst) :-
   var(N),var(Lst),
   forVars(N,Lst,0,[0]).

%5(a)
forNonvar(0,[],0).
forNonvar(0,R,R).
forNonvar(N,Lst,R) :- 
    N > 0,
    N1 is N // 10, 
    D is N mod 10,
forNonvar(N1,Lst,[D|R]).

%5(б)
forVars(N, Lst, N, Lst) :- 
    N \= 0, 
    numlst(N, Lst).
forVars(N, Lst, K, Res) :- 
    K1 is K + 1, 
    numlst(K, Res), 
    forVars(N, Lst, K1, _).

nonvarLst(N, [], N).
nonvarLst(N, [H | T], K) :-
    K1 is K*10 + H, 
    nonvarLst(N, T, K1).

