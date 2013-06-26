;-----------------------------------------------------------------------------
; | Exercise 2.10.
;
; Ben Bitdiddle, an expert systems programmer, looks over Alyssa's shoulder
; and comments that it is not clear what it means to divide by an interval
; that spans zero. Modify Alyssa's code to check for this condition and to
; signal an error if it occurs.


;-----------------------------------------------------------------------------
; | I actually didn't use Alyssa's exact code for my interval constructor,
; so I don't have the problem Ben noticed. The problem is that if the
; denominator of div-interval spans zero, Alyssa's implementation will
; produce an interval with an upper-bound that is less than its lower-bound.
; I made my constructor compare each argument and put them in the right
; place.

(define (div-interval x y)
  (if (and (<= (lower-bound y) 0)
           (>= (upper-bound y) 0))
      (error "div-interval: The denominator cannot span zero.")
      (mul-interval x (mk-interval (recip (lower-bound y))
                                   (recip (upper-bound y))))))

;-----------------------------------------------------------------------------
; | Interval constructor, selectors, and show method.

(define (mk-interval x y)
  (if (> x y)
      (cons y x)
      (cons x y)))

(define (upper-bound interval)
  (cdr interval))

(define (lower-bound interval)
  (car interval))

(define (show-interval x)
  (display "[")
  (display (lower-bound x))
  (display ", ")
  (display (upper-bound x))
  (display "]")
  (newline))


;-----------------------------------------------------------------------------
; | Calculate half of a given number.
;
(define (half x)
  (/ x 2.0))


;-----------------------------------------------------------------------------
; | Calculate the reciprocal of a number.

(define (recip x)
  (/ 1.0 x))


;-----------------------------------------------------------------------------
; | Calculate the width of an interval.

(define (width-interval x)
  (half (- (upper-bound x) (lower-bound x))))


;-----------------------------------------------------------------------------
; | Interval multiplication.

(define (mul-interval x y)
  (let ((pt1 (* (lower-bound x) (lower-bound y)))
        (pt2 (* (lower-bound x) (upper-bound y)))
        (pt3 (* (upper-bound x) (lower-bound y)))
        (pt4 (* (upper-bound x) (upper-bound y))))
    (mk-interval (min pt1 pt2 pt3 pt4)
                 (max pt1 pt2 pt3 pt4))))
