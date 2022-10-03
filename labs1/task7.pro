% 7 задание
numOfDays(jan, 31).
numOfDays(feb, 29).
numOfDays(mar, 31).
numOfDays(apr, 31).
numOfDays(may, 31).
numOfDays(jun, 30).
numOfDays(jul, 31).
numOfDays(aug, 31).
numOfDays(sep, 30).
numOfDays(oct, 31).
numOfDays(nov, 30).
numOfDays(dec, 31).

nextMonth(jan, feb).
nextMonth(feb, mar).
nextMonth(mar, apr).
nextMonth(apr, may).
nextMonth(may, jun).
nextMonth(jun, jul).
nextMonth(jul, aug).
nextMonth(aug, sep).
nextMonth(sep, oct).
nextMonth(oct, nov).
nextMonth(nov, dec).
nextMonth(dec, jan).

date(M,N) :- N>0, numOfDays(M,N1), N=<N1.	
nextDate(date(M1,N1), date(M2,N2)) :- 
                                 date(M1,N1),
								 (
								  N2 is N1+1, M2 = M1,
								  date(M2,N2) -> true
								  ;
								  numOfDays(M1,N1),
								  nextMonth(M1,M2),
								  N2 is 1
								  ).
								  