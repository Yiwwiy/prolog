%task5_а) 
%Пример ввода: king_path1([h-8],N).

% Пусть король не может бить пешки. 
%То есть не может проходить и через поля, занятые чёрными пешками.
%За какое минимальное количество ходов он сможет дойти до поля h-8?

%численно сопоставляет порядок столбца 
position(a-_, 1).
position(b-_, 2).
position(c-_, 3).
position(d-_, 4).
position(e-_, 5).
position(f-_, 6).
position(g-_, 7).
position(h-_, 8).

%находит достижумую позицию из исходной
achievablePosition(Init_pos, Pos) :- 
		Init_pos \= Pos, 
		Init_pos = _-Y0, Pos = _-Y,
		Y0 >= 1, Y0 =< 8,
		Y  >= 1, Y  =< 8,
		position(Init_pos, N0), position(Pos, N),
		abs(Y0 - Y) =< 1,
		abs(N0 - N) =< 1.
	
%перебор всех вариантов перемещений, который достижимы из исходного положения
moving(Init_pos,Goal) :- 
		ChessBoard = 
		         [[a-1, a-2, a-3, a-4, a-5, a-6, a-7, a-8],
			  	  [b-1, b-2, b-3, b-4, b-5, b-6, b-7, b-8],
			  	  [c-1, c-2, c-3, c-4, c-5, c-6, c-7, c-8],
			  	  [d-1, d-2, d-3, d-4, d-5, d-6, d-7, d-8],
			  	  [e-1, e-2, e-3, e-4, e-5, e-6, e-7, e-8],
			  	  [f-1, f-2, f-3, f-4, f-5, f-6, f-7, f-8],
			  	  [g-1, g-2, g-3, g-4, g-5, g-6, g-7, g-8],
			      [h-1, h-2, h-3, h-4, h-5, h-6, h-7, h-8]],
	findall(Position, (member(Column,ChessBoard), member(Position, Column), achievablePosition(Init_pos,Position)), Goal).
    
% сопоставляет список позиций с списком списков вида [позиция, номер фронта] 
incFront([], _, []).
incFront([H | T], K, [[H, K] | T1]) :- incFront(T, K, T1).

% добавляет элемент в конец списка
addToEnd([], X, [X]).
addToEnd([H | T], X, [H | T1]) :- addToEnd(T, X, T1).

% удаляет позиции, которые нельзя посещать
deleted([], _, []).
deleted([H | T], FalsePositions, Res) :-  % FalsePositions - список позиций, в которые ход запрещен
	memberchk(H, FalsePositions) -> deleted(T, FalsePositions, Res) % проверяем, что ход запрещен, если да, то выкидываем его
	; 
	Res = [H | T1], % иначе оставляем
	deleted(T, FalsePositions, T1). 

% создаёт список позиций, которые нельзя посещать
falseLst(ListOfPawns, Res) :- falseLst_help(ListOfPawns, [], Res).
falseLst_help([], Res, Res). 
falseLst_help([H | T], Lst, Res) :-
	H = Column-Row,
	position(Column-Row, ColumnNum),
	RowNew is Row - 1,
	(ColumnNum < 8, ColumnNum > 1 -> % пешки бьют два поля
		ColumnNumLeft is ColumnNum - 1,
		ColumnNumRight is ColumnNum + 1,
		position(P1-_, ColumnNumLeft),
		position(P2-_, ColumnNumRight),
		falseLst_help(T, [H, P1-RowNew, P2-RowNew | Lst], Res); % бьют по одно поле
			(ColumnNum =:= 8 -> ColumnNumLeft is ColumnNum - 1, position(P1-_, ColumnNumLeft), falseLst_help(T, [H, P1-RowNew | Lst], Res);
				(ColumnNum =:= 1 -> ColumnNumRight is ColumnNum + 1, position(P2-_, ColumnNumRight), falseLst_help(T, [H, P2-RowNew | Lst], Res)))).

% поиск в ширину - ищет кратчайший путь от данной позиции в целевую
bfs([[Goal, Res] | _], _ , _, [Goal, Res]). % если находим целевую позицию, то останавливаемся
bfs(Lst, Visited, FalsePositions, [Goal, Res]) :- 
	Lst \= [], % закончились рассматриваемые позиции
	Lst = [[Current, N] | Tail], Current \= Goal,
	% если мы попали в посещенную ранее вершину, то пропускаем её
	(memberchk(Current, Visited) -> bfs(Tail, Visited, FalsePositions, [Goal, Res]);
		% иначе
		(moving(Current, NewWays), % NewWays - все позиции, в которые можно попасть из текущей
		deleted(NewWays, FalsePositions, WaysWithoutPawns), % удаляем  пробитые или занятые позиции
		deleted(WaysWithoutPawns, Visited, TrueWays), % удаляем посещённые позиции
		N1 is N + 1, % для нашего нового фронта + увеличиваем его значение
		incFront(TrueWays, N1, NewFront), 
		addToEnd(Visited, Current, NewVisited), % добавляем в список посещённых позиций текущую
		append(Tail, NewFront, NewLst), % дополняем в нашу очередь новый фронт 
		bfs(NewLst, NewVisited, FalsePositions, [Goal, Res]))).

king_path1(ListOfPawns, NumberOfMoves) :-
	Init_pos = a-8, %начальная позиция короля
	Goal = h-1,   %цель
	falseLst(ListOfPawns, FalsePositions), % дополняем к пешкам позиции, которые они бьют
	bfs([[Init_pos, 0]], [], FalsePositions, [Goal, NumberOfMoves]).