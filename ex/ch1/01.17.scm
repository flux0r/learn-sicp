;-----------------------------------------------------------------------------
; | Exercise 1.17
;
; The exponentiation algorithms in this section are based on performing
; exponentiation by means of repeated multiplication. In a similar way, one
; can perform integer multiplication by means of repeated addition. The
; following multiplication procedure (in which it is assumed that our
; language can only add, not multiply) is analogous to the expt procedure:

(define (slow-* x y)
  (if (= y 0)
      0
      (+ x (slow-* x (1- y)))))

; This algorithm takes a number of steps that is linear in b. Now suppose we
; include, together with addition, operations double, which doubles an
; integer, and halve, which divides an (even) integer by 2. Using these,
; design a multiplication procedure analogous to fast-expt that uses a
; logarithmic number of steps.

(define (1- x) (- x 1))
(define (double x) (+ x x))
(define (half x) (/ x 2))

(define (fast-* x y)
  (cond ((= y 0) 0)
        ((even? y) (double (fast-* x (half y))))
        (else (+ x (fast-* x (1- y))))))
