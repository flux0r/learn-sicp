; Define a procedure that takes three numbers as arguments and returns the
; sum of the squares of the two larger numbers.

(define (two-larger x y z)
  (define (square x) (* x x))
  (define (sum-squares x y) (+ (square x) (square y)))
  (define (>= x y)
          (or (= x y) (> x y)))
  (if (>= x y)
    (if (>= y z)
      (sum-squares x y)
      (sum-squares x z))
    (if (>= x z)
      (sum-squares x y)
      (sum-squares y z))))
