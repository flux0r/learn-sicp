; Design a procedure that evolves an iterative exponentiation process that
; uses successive squaring and uses a logarithmic number of steps, as does
; fast-expt. (Hint: Using the observation that (bn/2)2 = (b2)n/2, keep,
; along with the exponent n and the base b, an additional state variable a,
; and define the state transformation in such a way that the product a bn is
; unchanged from state to state. At the beginning of the process a is taken
; to be 1, and the answer is given by the value of a at the end of the
; process. In general, the technique of defining an invariant quantity that
; remains unchanged from state to state is a powerful way to think about the
; design of iterative algorithms.)

(define (1- x) (- x 1))
(define (square x) (* x x))
(define (my-expt b n)
  (define (iter base exponent state)
       ; Keep a state variable for the iteration. The invariant
       ; state*(base^exponent) should not change from one iteration to the
       ; next.
       ;
       ; If the exponent is zero, the answer is the state since I can change
       ; the base^exponent part of the term to 1 without changing the
       ; invariant.
       ;
       ; If the exponent is even, I need to square the base and halve the
       ; exponent, leaving the state the same to keep the invariant from
       ; changing.
       ;
       ; If it's not even, I need to decrement the exponent like in
       ; fast-expt1, but I leave the base alone and move the extra base
       ; multiple to the state by multiplying them, which leaves the
       ; invariant unchanged.
    (cond ((= exponent 0)
            state)
          ((even? exponent)
            (iter (square base) (/ exponent 2.0) state))
          (else
            (iter base (1- exponent) (* state base)))))
  (iter b n 1.0))
