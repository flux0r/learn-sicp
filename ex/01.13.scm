;-----------------------------------------------------------------------------
; | Prove that Fib(n) is the closest integer to theta^n/5, where
;
;           theta = (1 + sqrt(5))/2.
;
; Hint: Let  upsilon = (1 - sqrt(5))/2. Use induction and the definition of
; the Fibonacci numbers (see section 1.2.2) to prove that
;
;           Fib(n) = (theta^n - upsilon^n)/sqrt(5).


; fib(0) = 0
; fib(1) = 1
; fib(n) = fib(n - 1) + fib(n - 2) for n > 1.
;
; Let phi = (1 + sqrt(5))/2.
; Let psi = (1 - sqrt(5))/2.
;
; fib(0) = 0 = (phi^0 - psi^0)/(sqrt(5))
;            = 0/sqrt(5)
;            = 0.
;
; fib(1) = 1 = phi^1 - psi^1
;              -------------------
;                   sqrt(5)
;
;                 phi - psi
;            = ---------------
;                 sqrt(5)
;
;              1 + sqrt(5) - 1 + sqrt(5)
;            = -------------------------
;                     2*sqrt(5)    
;
;              2*sqrt(5)
;            = ---------
;              2*sqrt(5)
;
;            = 1.
;
; fib(2) = fib(1) + fib(0)
;        = 1 + 0
;        
;               phi^2 - psi^2
;        = 1 = ----------------
;                  sqrt(5)
;
;              ((1 + sqrt(5))/2)^2 - ((1 - sqrt(5))/2)^2
;        =   -------------------------------------------
;                             sqrt(5)
;        
;             (1 + 2*sqrt(5) + 5)/4 - (1 - 2*sqrt(5)) + 5)/4
;        =    ----------------------------------------------
;                             sqrt(5)
;            
;             6 + 2*sqrt(5) - (6 - 2*sqrt(5))
;        =    -------------------------------
;                           4*sqrt(5)
;
;             4*sqrt(5)
;        =    ---------
;             4*sqrt(5)
;
;        = 1.
;
;      
;
;
;
;
; Assume 
;       fib(n)      = (phi^n - psi^n)/sqrt(5)
; and
;       fib(n - 1)  = (phi^(n - 1) - psi^(n - 1))/sqrt(5).
;
; From the definition of fib,
;       fib(n + 1)  = fib(n + 1 - 1) + fib(n + 1 - 2)
;                   = fib(n) + fib(n - 1)
;                   
;                     phi^n - psi^n   phi^(n - 1) - psi^(n - 1)
;                   = ------------- + -------------------------
;                        sqrt(5)             sqrt(5)
;                     
;                     phi^n + phi^(n - 1) - psi^n - psi^(n - 1)
;                   = -----------------------------------------
;                                   sqrt(5)
;
;                     phi^(n + 1)*(phi^(-1) + phi^(-2)) - psi^(n + 1)*(psi^(-1) - psi^(-2))               
;                   = ----------------------------------------------------------------------
;                                                  sqrt(5)
;
;                     phi^(n + 1)*phi^(-1)*(1 + phi^(-1)) - psi^(n + 1)*psi^(-1)*(1 - psi^(-1))
;                   = -------------------------------------------------------------------------
;                                                   sqrt(5)
;
;                     phi^(n + 1)*(1 + phi^(-1))   psi^(n + 1)*(1 - psi^(-1))
;                   = -------------------------- - --------------------------
;                          phi*sqrt(5)                  psi*sqrt(5)
;
;                     phi^(n + 1)*phi         psi^(n + 1)*psi
;                   = ----------------   -   ----------------
;                          phi*sqrt(5)            psi*sqrt(5)
;
;                   = phi^(n + 1)/sqrt(5) - psi^(n + 1)/sqrt(5)
;                   
;                     phi^(n + 1) - psi^(n + 1)
;                   = ------------------------- .
;                            sqrt(5)
;
; If fib(n) - phi^n/sqrt(5) is always less than 0.5, then phi^n/sqrt(5) will
; be within 0.5 of actual fib(n).
;
;           fib(n) - phi^n/sqrt(5)  <= 1/2
;
;           phi^n - psi^n    phi^n
; ======>   ------------- - ------- <= 1/2
;              sqrt(5)      sqrt(5)
;
;
;           -psi^n
; ======>   -------                 <= 1/2
;           sqrt(5)
;
; ======>   psi^n                   <= -sqrt(5)/2 .
;
; Since psi is approximately -0.6180, any value psi^n where n is positive
; will be less than 1. The number -sqrt(5)/2 is approximately 1.118, so
; fib(n) is indeed the closest integer to (phi^n - psi^n)/sqrt(5).
