% 6 задание
sirakuz(1,A) :- write(A).
sirakuz(N,AN) :- 
                N>1, N1 is N-1,
				(
				  AN mod 2 =:= 0 -> AM is AN div 2
				  ;
				  AM is 3 * AN + 1
                ),
				write(AN),nl,sirakuz(N1,AM).