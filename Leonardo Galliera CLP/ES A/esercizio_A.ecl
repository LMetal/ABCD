%Leonardo Galliera 20045207

:-lib(clpr).

%predicato mortage -> calcolo rata mensile
% Principal: ammontare iniziale del prestito
% Rate: tasso di interesse mensile (0.005, 0.001)
% Term: mesi durata del prestito
% MonthlyPayment: rata mensile calcolata
% FinalBalance: saldo finale (0 per fine)
mortgage(Principal, Rate, Term, MonthlyPayment, FinalBalance) :-
    %vincoli, prestito positivo, rata positiva, almeno un mese...
    Principal $>= 0,
    Rate $>= 0,
    Term $>= 1,
    MonthlyPayment $>= 0,
    FinalBalance $>= 0,
    
    %Rate = 0 -> niente interessi
    (Rate =:= 0 ->
        MonthlyPayment $= Principal / Term,
        FinalBalance $= 0
    ;
        %formula per prestiti
        PowTerm $= (1 + Rate) ^ Term,
        MonthlyPayment $= Principal * Rate * PowTerm / (PowTerm - 1),
        
        %saldo finale = 0, prestito ripagato
        FinalBalance $= 0
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