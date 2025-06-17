:- lib(clpr).

% Helper predicates
sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, TailSum),
    Sum is H + TailSum.

max_list([X], X).
max_list([H|T], Max) :-
    max_list(T, TailMax),
    Max is max(H, TailMax).

% Base vacation days
base_vacation_days(22).

% Rule definitions
extra(r1, 5, Age, YearsService) :- Age < 18.
extra(r1, 5, Age, YearsService) :- Age >= 60.
extra(r1, 5, Age, YearsService) :- YearsService >= 30.

extra(r2, 3, Age, YearsService) :- 
    YearsService >= 30, Age >= 60.

extra(r3, 2, Age, YearsService) :- 
    YearsService >= 15, YearsService < 30.
extra(r3, 2, Age, YearsService) :- 
    Age >= 45.

% Rule classification
additive_rule(r2).
mutually_exclusive_rules([r1, r3]).

% Main predicate to calculate vacation days
vacation_days(Age, YearsService, TotalDays) :-
    base_vacation_days(Base),
    findall(DaysToAdd,
            (additive_rule(RuleName), extra(RuleName, DaysToAdd, Age, YearsService)),
            AdditiveDaysList),
    sum_list(AdditiveDaysList, SumAdditiveDays),
    mutually_exclusive_rules(MutexRules),
    findall(DaysFromMutexRule,
            (member(MutexRuleName, MutexRules), extra(MutexRuleName, DaysFromMutexRule, Age, YearsService)),
            MutexDaysList),
    (   MutexDaysList = []
    ->  MaxMutexDays = 0
    ;   max_list(MutexDaysList, MaxMutexDays)
    ),
    TotalDays is Base + SumAdditiveDays + MaxMutexDays.