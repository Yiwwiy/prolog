sumCubes(0,0).
sumCubes(N,R) :-
    number(N),
	number(R),
	N > 0,
	N1 is (N - 1),
	R1 is (R - (N ^ 3)),
	sumCubes(N1,R1)
	;
	var(N),
	number(R),
	findN(N,R,0)
	;
    var(N),
	var(R),
	A is 0,
	B is 0,
	findNR(N,R,A,B)
	.

findN(N,0,C) :- N = C.
findN(N,R,C) :-
	R > 0,
	C1 is (C + 1),
	R1 is (R - (C1 ^ 3)),
	findN(N,R1,C1).

findNR(N,R,Q,W) :-
	N is (Q + 1),
	R is (W + (N ^ 3));
	Q1 is (Q + 1),
	W1 is (W + (Q1 ^ 3)),
	findNR(N,R,Q1,W1).
