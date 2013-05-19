;-----------------------------------------------------------------------------
; | Exercise 1.18
;
; Using the results of exercises 1.16 and 1.17, devise a procedure that
; generates an iterative process for multiplying two integers in terms of
; adding, doubling, and halving and uses a logarithmic number of steps.

; Invariant is (+ (* x y) a) == (+ (* x1 y1) a1).
(define (iter-* x y)
  (define (iter a b state)
    (cond ((= b 0) state)
          ((even? b) (iter (double a) (half b) state))
          (else (iter a (1- b) (+ state a)))))
  (iter x y 0))
