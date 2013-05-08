;; 
;; THE ELEMENTS OF PROGRAMMING
;;
;; The general form of a procedure definition is
;;      (define (<name> <formal parameters>)
;;          <body>) .
;;
;; The general form of a conditional expression is
;;      (cond   (<p1> <e1>)
;;              (<p2> <e2>)
;;              ...
;;              (<pn> <en>)) 
;;  where the groups (<p> <e>) are called clauses. The p in each clause is a
;;  predicate and the e is aconsequent expression.
;;
;;  The general form of an if expression is
;;      (if <predicate> <consequent> <alternative>) .
;;  Some primitive predicates are <, =, and >. There are also logical
;;  composition operations. Three are
;;      (and <e1> ... <en>) ,
;;      (or <e1> ... <en>) ,
;;      (not <e>) .

;; Helpers.
(define (square x) (* x x))
(define (cube x) (* (square x) x))
(define (average x y)
  (/ (+ x y) 2))
(define (abs x)
  (if   (> x 0)
        x
        (- x)))
(define (double x) (+ x x))
(define (one-third x) (/ x 3))

;; This implementation uses a fixed error to determine when to stop running
;; the algorithm. This won't work well for very large or small numbers.
(define (sqrt1 x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))

;; This version uses a fixed relative error based on the difference between
;; the old and new guess in each iteration.
(define (sqrt2 x)
  (define (good-enough? new-guess old-guess)
    (< (abs (/ (- new-guess old-guess) old-guess)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (define new-guess (improve guess))
    (if (good-enough? new-guess guess)
        new-guess
        (sqrt-iter new-guess)))
  (sqrt-iter 1.0))

;; This cube root implementation is similar to sqrt2.
(define (cbrt1 x)
  (define (good-enough? new-guess old-guess)
    (< (abs (/ (- new-guess old-guess) old-guess)) 0.001))
  (define (improve guess)
    (one-third (+ (/ x (square guess)) (double guess))))
  (define (cbrt-iter guess)
    (define new-guess (improve guess))
    (if (good-enough? new-guess guess)
        new-guess
        (cbrt-iter new-guess)))
  (cbrt-iter 1.0))

;; Define which implementation to use.
(define sqrt sqrt2)
(define cbrt cbrt1)
