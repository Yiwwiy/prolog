% 1 задание из 2 лабы
toSquares(A,B,N) :- squares(A,B,N,1).
squares(A,A,N,N).
squares(A,B,N,C) :- 
                   (
				    A > B , C1 is C + 1,
                    A1 is A - B,
                    squares(A1,B,N,C1)
                    ;
                    A < B, C1 is C + 1,
                    B1 is B - A,
                    squares(A,B1,N,C1)
                    ).  					