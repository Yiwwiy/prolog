%главный предикат
max_increasing_sublist([],Seq) :- Seq = [], !.
max_increasing_sublist([H],Seq) :- Seq = [H], !.
max_increasing_sublist(Lst, Seq) :- var(Seq), Lst \= [], max_growed_seq(Lst, [], Seq), take_first(Seq).
max_increasing_sublist(Lst, Seq) :- nonvar(Seq), max_growed_seq(Lst, [], Max), length(Lst,L), length(Max, M), 
    (L = M,  is_max_growed_seq(Lst, M, Seq)
     ;
     take_first(Seq), is_max_growed_seq(Lst, M, Seq)).

%является ли 
is_max_growed_seq(Lst, M, Seq) :- 
    Lst \= [],
    growed_seq(Lst, -2^59, NSeq, HLst),
    length(NSeq, S),
    ((NSeq = Seq, S = M); is_max_growed_seq(HLst, M, Seq)).

%найти максимальную возврастающую подпоследовательность
max_growed_seq([], Max, RSeq) :- RSeq = Max.
max_growed_seq(Lst, Max, RSeq) :-
    Lst \= [],
    growed_seq(Lst, -2^59, Seq, HLst),
    length(Max, M), length(Seq, S),
    (S > M -> max_growed_seq(HLst, Seq, RSeq); max_growed_seq(HLst, Max, RSeq)).

%найти возрастающую подпоследовательность
growed_seq([], _, [], []).
growed_seq([H|T], P, Seq, X) :- 
    H > P, growed_seq(T, H, NSeq, X1), 
    Seq = [H|NSeq], X = X1.
growed_seq([H|T], P, Seq, X) :- 
    H =< P, Seq = [], X = [H|T].

%ищет ближайщую
take_first([_]).
take_first(Lst) :- Lst = [H1 | T], T = [H2 | _], H1 is H2 - 1, take_first(T).

