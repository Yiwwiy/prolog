
insert(nil,X,tr(X,nil,nil)).
insert(T1,X,T2) :-
	nonvar(T2),
	tr(N1,L1,R1) = T1,
	tr(N2,L2,R2) = T2,
	N1 =:= N2,
	(
		X > N1,
		L1 = L2,
		(
		R1 = nil,
		R2 = tr(X,nil,nil)
		;
		\+ R1 = nil,
		insert(R1,X,R2)
		)
	 ;
	 X < N1,
		R1 = R2,
		(
		L1 = nil,
		L2 = tr(X,nil,nil)
		;
		\+ L1 = nil,
		insert(L1,X,L2)
		)
	).

insert(tr(N,L,R),N,tr(N,L,R)).

insert(T1,X,T2) :-
	var(T2),
	tr(N1,L1,R1) = T1,
	(
	X > N1,
	(
	R1 = nil,
	T2 = tr(N1,L1,tr(X,nil,nil)
	)
		;
		\+ R1 = nil,
		insert(R1,X,T3),
		T2 = tr(N1,L1,T3)
		)
	;
	X < N1,
		(
			L1 = nil,
		T2 = tr(N1,tr(X,nil,nil),R1)
		;
		\+ L1 = nil,
		insert(L1,X,T3),
		T2 = tr(N1,T3,R1)
		)
	).

