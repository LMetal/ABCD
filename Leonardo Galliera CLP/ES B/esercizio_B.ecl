:- lib(clpr).

%ritorna la somma degli elementi nella lista
sum_list([], 0).
sum_list([H|T], Sum) :-
	sum_list(T, Temp),
	Sum is H + Temp.

max_list([], 0).
max_list([X], X).
max_list([H|T], Max) :-
	max_list(T, MaxCoda),
	Max is max(H, MaxCoda).

%giorni base
base_vacation_days(22).

%regole con vincoli
% extra(Nome, GiorniAggiuntivi, Eta, AnniServizio)

% r1: 5 giorni per specifiche condizioni, altrimenti 0
extra(r1, 5, Age, YearsService) :- {Age < 18}, !.
extra(r1, 5, Age, YearsService) :- {Age >= 60}, !.
extra(r1, 5, Age, YearsService) :- {YearsService >= 30}, !.
extra(r1, 0, Age, YearsService).

% r2: 3 giorni per specifiche condizioni, altrimenti 0
extra(r2, 3, Age, YearsService) :- {YearsService >= 30}, !.
extra(r2, 3, Age, YearsService) :- {Age >= 60}, !.
extra(r2, 0, Age, YearsService).

% r3: 2 giorni per specifiche condizioni, altrimenti 0
extra(r3, 2, Age, YearsService) :- {YearsService >= 15, YearsService < 30}, !.
extra(r3, 2, Age, YearsService) :- {Age >= 45}, !.
extra(r3, 0, Age, YearsService).

%inizializzazione vincoli additivi/mutex
additive_rules([r2]).
mutually_exclusive_rules([r1, r3]).
% per arrivare a 37 giorni di ferie potrebbe essere
% additive_rules([r1, r2, r3]).
% mutually_exclusive_rules([]).


%calcolo vacanze
vacation_days(Age, YearsService, TotalDays) :-
	base_vacation_days(Base),
	% Define Age and YearsService as CLP variables
	{Age >= 0, YearsService >= 0}, % Assuming non-negative age and service years

	%trova regole additive applicabili
	additive_rules(AdditiveRules),
	findall(DaysToAdd,
		(member(Name, AdditiveRules), extra(Name, DaysToAdd, Age, YearsService)),
		AdditiveDaysList),
	sum_list(AdditiveDaysList, SumAdditiveDays),
	
	%trova tutte regole mutex applicabili
	mutually_exclusive_rules(MutexRules),
	findall(DaysMutex,
		(member(Name, MutexRules), extra(Name, DaysMutex, Age, YearsService)),
		MutexDaysList),
	%se mutex vuoto 0, altrimenti il maggiore
	max_list(MutexDaysList, MaxMutexDays),
	
	TotalDays is Base + SumAdditiveDays + MaxMutexDays.