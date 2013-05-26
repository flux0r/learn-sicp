;-----------------------------------------------------------------------------
; | Exercise 2.1
;
; Define a better version of make-rat that handles both positive and
; negative arguments. Make-rat should normalize the sign so that if the
; rational number is positive, both the numerator and denominator are
; positive, and if the rational number is negative, only the numerator is
; negative.


;-----------------------------------------------------------------------------
; | Find the greatest common divisor of two integers.
(define (gcd x y)
  (if (= y 0)
      x
      (gcd y (remainder x y))))


;-----------------------------------------------------------------------------
; | Construct a rational number represented by a cons pair.
(define (make-rat n d)
  (let ((pos? (or (and (positive? n) (positive? d))
                  (and (negative? n) (negative? d))))
        (abs-n (abs n))
        (abs-d (abs d))
        (g (abs (gcd n d))))
    (cons (/ (if pos?
                 abs-n
                 (* -1 abs-n))
             g)
          (/ abs-d g))))


;-----------------------------------------------------------------------------
; | Get the numerator of a rational number created with make-rat.
(define (numer x)
  (car x))


;-----------------------------------------------------------------------------
; | Get the denominator of a rational number created with make-rat.
(define (denom x)
  (cdr x))


;-----------------------------------------------------------------------------
; | Show a rational number created with make-rat.
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))
