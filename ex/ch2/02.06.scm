;-----------------------------------------------------------------------------
; | Exercise 2.6
;
; In case representing pairs as procedures wasn't mind-boggling enough,
; consider that, in a language that can manipulate procedures, we can get by
; without numbers (at least insofar as nonnegative integers are concerned)
; by implementing 0 and the operation of adding 1 as

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
    (lambda (f) (lambda (x) (f ((n f) x)))))


; This representation is known as Church numerals, after its inventor,
; Alonzo Church, the logician who invented the lambda calculus.
;
; Define one and two directly (not in terms of zero and add-1). (Hint: Use
; substitution to evaluate (add-1 zero)). Give a direct definition of the
; addition procedure + (not in terms of repeated application of add-1).


;-----------------------------------------------------------------------------
; | one is a procedure that takes a procedure and applies it once.
(define one
  (lambda (f) 
    (lambda (x)
      (f x))))


;-----------------------------------------------------------------------------
; | two is a procedure that takes a procedure and applies it twice.
(define two
  (lambda (f)
    (lambda (x)
      (f (f x)))))


;-----------------------------------------------------------------------------
; | church+ takes two church numbers and makes a procedure that takes a
; procedure and applies it x times and then takes the procedure generated by
; applying x times and applies it y times.
(define (church+ x y)
  (lambda (f)
    (lambda (x.)
      ((x f) ((y f) x.)))))


;-----------------------------------------------------------------------------
; | Test procedure to pass to Church numerals.
(define (1+ x)
  (+ x 1))