; Alyssa P. Hacker doesn't see why if needs to be provided as a special
; form. ``Why can't I just define it as an ordinary procedure in terms of
; cond?'' she asks. Alyssa's friend Eva Lu Ator claims this can indeed be
; done, and she defines a new version of if:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

; Eva demonstrates the program for Alyssa:

(new-if (= 2 3) 0 5) ; 5

(new-if (= 1 1) 0 5) ; 0

; Delighted, Alyssa uses new-if to rewrite the square-root program:

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  (define (sqrt-iter guess)
    (new-if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess))))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (sqrt-iter 1.0))

; What happens when Alyssa attempts to use this to compute square roots?
; Explain.

; This creates the same problem as exercise 1.5. The new-if procedure uses
; applicative-order evaluation and so will never terminate because sqrt-iter
; is one of the parameters passed to new-if inside itself. Regular if must
; use normal-order evaluation.
