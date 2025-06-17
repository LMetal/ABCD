:-lib(clpr).

%predicato mortage -> calcolo rata mensile
% Principal: ammontare iniziale del prestito
% Rate: tasso di interesse mensile (0.005, 0.001)
% Term: mesi durata del prestito
% MonthlyPayment: rata mensile calcolata
% FinalBalance: saldo finale (0 per fine)
mortgage(Principal, Rate, Term, MonthlyPayment, FinalBalance) :-
    { Rate >= 0,
      Term > 0,
      Principal > 0,
      FinalBalance = 0 },
    (   { Rate =:= 0 } ->
        % Caso senza interessi
        { MonthlyPayment = Principal / Term }
    ;   % Per mantenere la linearità in CLP(R), usiamo un'approssimazione
        % che funziona bene per tassi bassi e durate ragionevoli
        % Approssimazione: MonthlyPayment ˜ Principal/Term * (1 + Rate*Term/2)
        { MonthlyPayment = Principal / Term * (1 + Rate * Term / 2) }
    ).

% incomev -> prima fase
incomev(TotalRepayment, LoanTerm, MonthlyIncome, MonthlyDebt) :-
    { TotalIncome = LoanTerm * MonthlyIncome,
      TotalDebt = LoanTerm * MonthlyDebt,
      AccumulatedDebt = TotalDebt + TotalRepayment,
      TotalIncome > AccumulatedDebt }.

% incomeval -> Seconda fase
% Principal: somma da prendere in prestito
% Rate: tasso di interesse mensile
% LoanTerm: mesi durata del prestito
% MonthlyIncome: reddito mensile
% MonthlyDebt: debito mensile
incomeval(Principal, Rate, LoanTerm, MonthlyIncome, MonthlyDebt) :-
    %calcola rata mensile
    mortgage(Principal, Rate, LoanTerm, MonthlyPayment, 0),
    
    %calcola rimborso totale
    { TotalRepayment = MonthlyPayment * LoanTerm },
    
    %usa incomev
    incomev(TotalRepayment, LoanTerm, MonthlyIncome, MonthlyDebt).