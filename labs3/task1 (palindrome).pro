%главная функция
palindrome(Lst) :-
    myReverse(Lst,Res),
    checkListEq(Lst,Res).

myReverse(Lst, Res) :- myReverse_help(Lst, Res, []).

myReverse_help([], Res, Res).
myReverse_help([H|T], Res, Curr) :-
    myReverse_help(T, Res, [H|Curr]).


equalChars(X, X).
equalChars('a', 'A').
equalChars('b', 'B').
equalChars('c', 'C').
equalChars('A', 'a').
equalChars('B', 'b').
equalChars('C', 'c').


checkListEq([], []).
checkListEq([H1|T1], [H2|T2]) :-
    equalChars(H1, H2),
    checkListEq(T1, T2).
