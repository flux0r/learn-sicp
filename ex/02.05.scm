;-----------------------------------------------------------------------------
; | Exercise 2.5
;
; Show that we can represent pairs of nonnegative integers using only
; numbers and arithmetic operations if we represent the pair a and b as the
; integer that is the product 2^a*3^b. Give the corresponding definitions of
; the procedures cons, car, and cdr.

(define (cons-N x y)
  (* (expt 2 x) (expt 3 y)))

(define (car-N x)
  (num-of-divisions x 2))

(define (cdr-N x)
  (num-of-divisions x 3))

(define (num-of-divisions x y)
  (define (iter x. r)
    (if (= (remainder x. y) 0)
        (iter (/ x. y) (+ 1 r))
        r))
  (iter x 0))
