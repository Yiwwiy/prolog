% task 4

%Условие задачи: 
%Барон Мюнхгаузен говорит правду только один день в неделю. Какой это день, если известно следующее:
%1. Однажды он сказал: Я лгу по понедельникам и вторникам;
%2. На следующий день он сказал: Сегодня - или четверг, или суббота, или воскресенье;
%3. Ещё на следующий день он сказал: Я лгу по средам и пятницам.

days(Days) :- 
    Days = [monday, tuesday, wednesday, thursday, friday, saturday, sunday].

whatDay(Today, Tomorrow, Day_after_tomorrow) :-
	days(Days),
	length(Days, Length),
	member(Day, Days),
	nth(I, Days, Day),
	Today = Day,
	I1 is I + 1, I2 is I + 2,
    % I1 is I mod Length + 1, I2 is I1 mod Length + 1
	(I1 =< Length -> nth(I1, Days, Tomorrow) 
     ; 
     I1n is I1 - Length, nth(I1n, Days, Tomorrow)),
	(I2 =< Length -> nth(I2, Days, Day_after_tomorrow)
     ; 
     I2n is I2 - Length, nth(I2n, Days, Day_after_tomorrow)).

%главная функция
task4(Day, TrueDay) :- 
        days(Days), member(TrueDay, Days), 
        whatDay(Day, Tomorrow, Day_after_tomorrow),
        
        (Day = TrueDay -> TrueDay \= monday, TrueDay \= tuesday ; (TrueDay = monday ; TrueDay = tuesday)), %1 условие
        (Tomorrow = TrueDay -> (Tomorrow = thursday ; Tomorrow = saturday ; Tomorrow = sunday) ; (Tomorrow \= thursday , Tomorrow \= saturday , Tomorrow \= sunday)), %2 условие
        (Day_after_tomorrow = TrueDay -> (TrueDay \= wednesday, TrueDay \= friday) ; (TrueDay = wednesday ; TrueDay = friday)). %3 условие
       