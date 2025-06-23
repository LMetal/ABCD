:- lib(clpr).

sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, TailSum),
    Sum is H + TailSum.

max_list([X], X).
max_list([H|T], Max) :-
    max_list(T, TailMax),
    Max is max(H, TailMax).

%giorni base
base_vacation_days(22).

%regole
extra(r1, 5, Age, YearsService) :- Age < 18.
extra(r1, 5, Age, YearsService) :- Age >= 60.
extra(r1, 5, Age, YearsService) :- YearsService >= 30.

extra(r2, 3, Age, YearsService) :- 
    YearsService >= 30, Age >= 60.

extra(r3, 2, Age, YearsService) :- 
    YearsService >= 15, YearsService < 30.
extra(r3, 2, Age, YearsService) :- 
    Age >= 45.

%inizializzazione vincoli additivi/mutex
additive_rule(r2).
mutually_exclusive_rules([r1, r3]).

%calcolo vacanze
vacation_days(Age, YearsService, TotalDays) :-
    base_vacation_days(Base),
	%trova regole additive applicabili
    findall(DaysToAdd,
            (additive_rule(RuleName), extra(RuleName, DaysToAdd, Age, YearsService)),
            AdditiveDaysList),
    sum_list(AdditiveDaysList, SumAdditiveDays),
    
	%trova tutte regole mutex applicabili
	mutually_exclusive_rules(MutexRules),
    findall(DaysMutex,
            (member(Name, MutexRules), extra(Name, DaysMutex, Age, YearsService)),
            MutexDaysList),
	%se mutex vuoto 0, altrimenti il maggiore
    (
	MutexDaysList = [] ->  MaxMutexDays = 0;
	max_list(MutexDaysList, MaxMutexDays)
    ),
    TotalDays is Base + SumAdditiveDays + MaxMutexDays.