%главная функция
myReverse(Lst, Res) :- myReverse_help(Lst, Res, []).

myReverse_help([], Res, Res).
myReverse_help([H|T], Res, Curr) :-
    myReverse_help(T, Res, [H|Curr]).



