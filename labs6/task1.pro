% task 1
opposite(left, right).
opposite(right, left).

%условия на невозможные перемещения
unsafe(state(_, P, A, family(Dad, Mom, S1, S2, D1, D2))) :-
	Lst = [Dad, Mom, S1, S2, D1, D2],
	opposite(P, A), memberchk(A, Lst).
unsafe(state(_, _, _, family(Dad, Mom, S1, S2, _, _))) :- opposite(Dad, Mom), (Mom = S1; Mom = S2).
unsafe(state(_, _, _, family(Dad, Mom, _, _, D1, D2))) :- opposite(Dad, Mom), (Dad = D1; Dad = D2).

% changeMove изменяет один элемент в списке по индексу N 
changeMove(Lst, N, Res) :- changeMove_help(Lst, N, 1, [], Res).

changeMove_help([], _, _, Lst, Res) :- reverse(Lst, Res).
changeMove_help([H | T], N, K, Lst, Res) :- 
	K = N -> opposite(H, X), K1 is K + 1, changeMove_help(T, N, K1, [X | Lst], Res); K1 is K + 1, changeMove_help(T, N, K1, [H | Lst], Res).

% находит все возможные перемещения одного человека
trueMoves1(Lst, Res) :- trueMoves1_help(Lst, 1, [], Res).

trueMoves1_help(Lst, K, Res, Res) :- K1 is K - 1, length(Lst, K1), !.
trueMoves1_help(Lst, K, X, Res) :-
	K1 is K + 1, changeMove(Lst, K, R), trueMoves1_help(Lst, K1, [R | X], Res).

% находит все возможные перемещения двух человек
trueMoves2(Lst, Res) :- trueMoves2_help(Lst, 1, 2, [], Res).

trueMoves2_help(Lst, _, I, Res, Res) :- I1 is I - 1, length(Lst, I1), !.
trueMoves2_help(Lst, K, I, X, Res) :-
	K =:= 2, K < I -> K1 is K + 1, 
    trueMoves2_help(Lst, K1, I, X, Res)
    ;
	(K < I -> K1 is K + 1, changeMove(Lst, K, Y), changeMove(Y, I, Y1), trueMoves2_help(Lst, K1, I, [Y1 | X], Res);
		K1 = 1, I1 is I + 1, trueMoves2_help(Lst, K1, I1, X, Res)).

% генерирует возможные перемещения
allMove(state(Boat, P, A, family(Dad, Mom, S1, S2, D1, D2)), state(Boat1, P1, A1, family(Dad1, Mom1, S1n, S2n, D1n, D2n))) :-
	opposite(Boat, Boat1),
	Lst1 = [P, A, Dad, Mom], 
    Lst2 = [P1, A1, Dad1, Mom1],
	Lst3 = [S1, S2, D1, D2], 
    Lst4 = [S1n, S2n, D1n, D2n],
	Lst1withoutA = [P, Dad, Mom], 
    Lst2withoutA = [P1, Dad1, Mom1],
	trueMoves1(Lst1withoutA, X),
	trueMoves2(Lst1, Y),
	trueMovesFor1(Lst3, Z),
	(member(Lst2withoutA, X), Lst4 = Lst3, A = A1; 
	member(Lst2, Y), Lst4 = Lst3; 
	member(Lst2withoutA, X), member(Lst4, Z), A = A1).

%поиск в глубину
dfs(Target, Target, Result_Path, Result_Path).
dfs(Current, Target, Cur_Path, Result_Path) :-
	Current \= Target,
	allMove(Current, NewState),
	\+ unsafe(NewState),
	\+ memberchk(NewState, Cur_Path),
	dfs(NewState, Target, [NewState | Cur_Path], Result_Path).

% printPath - предикат, красиво выводящий результат
printPath([]).
printPath([H | T]) :- H = state(B, P, A, family(X1, X2, X3, X4, X5, X6)), write('B-P-A-fam-[X1-X2-X3-X4-X5-X6]'), nl, printPath(T).
