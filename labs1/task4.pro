% 4 задание
doubleFact(0,1).
doubleFact(1,1).
doubleFact(N,F) :- N>1, N1 is N-2, doubleFact(N1,F1), F is N*F1.