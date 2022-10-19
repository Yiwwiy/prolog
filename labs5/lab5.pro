
% task1
mapFunc([],[],_,[]).
mapFunc([_|_],[],_,[]).
mapFunc([],[_|_],_,[]).
mapFunc([H1|T1],[H2|T2], Func, [H|T]) :-
    Term =.. [Func,H1,H2,H],
    call(Term),
    mapFunc(T1,T2,Func,T).

 add(A,B,C) :- C is A + B. 

 %task2  
 
 %главная функция
choosePairs(Lst1, Lst2, Func, Lst) :- 
	choosePairs_help(Lst1, Lst2, Func, X),
     (var(Lst) -> sort(X, Lst)
     ; 
     sort(X, Res), sort(Lst, Res) ).

%фильтр программы, работающий по аналогии с map
choosePairs_help([], [], _, []).
choosePairs_help([H1 | T1], [H2 | T2], Func, Lst) :-
	Term =.. [Func, H1, H2],
	(call(Term) -> H = H1-H2, choosePairs_help(T1, T2, Func, T), Lst = [H | T];
		choosePairs_help(T1, T2, Func, Lst)).

%task3
foldl(X0, _, [], X0).
foldl(X0,Func,[H|T],Res) :-
   Term =.. [Func,X0,H,R], call(Term),
   foldl(R,Func,T,Res).

%task4
%вставить элемент в дерево
insert(nil,X,tr(X,nil,nil)).
insert(tr(Root,Ltr,Rtr),X,Tree) :- X < Root, insert(Ltr,X,LTree), Tree = tr(Root,LTree,Rtr)
                                   ;
                                   X > Root, insert(Rtr,X,RTree), Tree = tr(Root,Ltr,RTree).


%главная функция
treeFromList(Lst,Tree) :- foldl(nil,insert,Lst,Tree).       

%task5
addHead(_,[],[]).
addHead(X,[H|T], [[X|H]|Res]) :- addHead(X,T,Res).

%task6  
% превращает в список, в котором голова - исходный, а хвост - списки, голова которых, - X
addHeading(Lst, Elem, R) :- addHead(Elem, Lst, Res), append(Lst, Res, R).

%map, принимающий 1 список
map([],_,[]).
map([H|T],Func,[H1|T1]) :- 
   Term =.. [Func,H,H1], call(Term),
   map(T,Func,T1).

 %главная функция  
subsets(LSet,LSubsets) :- nonvar(LSet),
   foldl([[]],addHeading, LSet, Subs), % составляет список из исходного
   (var(LSubsets) -> LSubsets = Subs
    ;
    map(Subs, msort, Subs_), msort(Subs_,Subs_sorted),
    map(LSubsets,msort,Subs2), msort(Subs2,Subs3)
    ,
    Subs_sorted = Subs3), !.

subsets(LSet,LSubsets) :- var(LSet),
    foldl([],append,LSubsets,Res), %создает список, у которого хвост - исходный подсписок
    sort(Res,LSet),
    subsets(LSet,LSubsets).

subsets(LSet,LSubsets) :- var(LSet), var(LSubsets), false.
 
%task7

%пример 
thing(plate, 1, 1.5).
thing(jar, 3, 5).
thing(silverSpoon, 0.3, 15).
sack(3). 

%функции для счета цены и веса
countPrice([], 0).
countPrice([H | T], Price) :-
   thing(H, _, X), countPrice(T, Sum), Price is Sum + X.

countWeight([], 0).
countWeight([H|T], Weight) :-
   thing(H, X, _), countWeight(T, Sum), Weight is Sum + X.

%главная функция
pack(Things, MaxPrice) :-
   findall(X, thing(X, _, _), Lst),
   subsets(Lst, Lst_subs),
   pack_it(Lst_subs, [], 0, Things, MaxPrice), !.

pack_it([], Things, MaxPrice, Things, MaxPrice).
pack_it([H|T], Things, Price, GoodThings, MaxPrice) :-
   countPrice(H, X),
   countWeight(H, Y),
   sack(W),
   (
      Y =< W, 
      X > Price -> pack_it(T, H, X, GoodThings, MaxPrice)
      ;
      pack_it(T, Things, Price, GoodThings, MaxPrice)).   
 
