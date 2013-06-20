;-----------------------------------------------------------------------------
; | Exercise 2.9
;
; The width of an interval is half of the difference between its upper and
; lower bounds. The width is a measure of the uncertainty of the number
; specified by the interval. For some arithmetic operations the width of the
; result of combining two intervals is a function only of the widths of the
; argument intervals, whereas for others the width of the combination is not
; a function of the widths of the argument intervals. Show that the width of
; the sum (or difference) of two intervals is a function only of the widths
; of the intervals being added (or subtracted). Give examples to show that
; this is not true for multiplication or division.


; If I have two intervals,
;       i1 = [l1, u1]
; and
;       i2 = [l2, u2],
; then
;       i1 + i2 = [l1 + l2, u1 + u2]
; and the widths of the intervals are
;       w1 = (u1 - l1)/2
; and
;       w2 = (u2 - l2)/2.
;
; The width of i1 + i2 is
;       w3 = (u1 + u2 - l1 - l2)/2.
;
; So I have
;       w1 + w2 = (u1 - l1)/2 + (u2 - l2)/2
;               = (u1 + u2 - l1 - l2)/2
;               = w3.
;
; Also,
;       i1 - i2 = [l1 - u2, u1 - l2]
; And the width of i1 - i2 is
;       w4  = (u1 - l2 - l1 + u2)/2
;           = (u1 + u2 - l1 - l2)/2
;           = w3.
;
; So the width of the interval formed by adding or subtracting two intervals
; is the sum of the width of the two intervals.
;
; Multiplication and division don't admit a function describing the
; relationship between the operands and the result. For example, assume I
; have four intervals,
;       i1 = [5, 9],
;       i2 = [2, 6],
;       i3 = [-3, 1],
; and
;       i4 = [12, 16].
; They all have the same width, namely 2, but the width of i1*i2 is 22, of
; i3*i4 is 71.5, of i2/i1 is 0.49, and of i4/i3 is 10.21. Clearly, the
; resulting interval width of multiplication or division is not a function
; only of the widths of the operands, since operands of width 2 give
; different answers depending on the particular operands.


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
; | Interval addition.

(define (add-interval x y)
  (mk-interval (+ (lower-bound x) (lower-bound y))
               (+ (upper-bound x) (upper-bound y))))


;-----------------------------------------------------------------------------
; | Interval subtraction.

(define (sub-interval x y)
  (mk-interval (- (lower-bound x) (upper-bound y))
               (- (upper-bound x) (lower-bound y))))


;-----------------------------------------------------------------------------
; | Interval multiplication.

(define (mul-interval x y)
  (let ((pt1 (* (lower-bound x) (lower-bound y)))
        (pt2 (* (lower-bound x) (upper-bound y)))
        (pt3 (* (upper-bound x) (lower-bound y)))
        (pt4 (* (upper-bound x) (upper-bound y))))
    (mk-interval (min pt1 pt2 pt3 pt4)
                 (max pt1 pt2 pt3 pt4))))


;-----------------------------------------------------------------------------
; | Interval division.

(define (div-interval x y)
  (mul-interval x (mk-interval (recip (upper-bound y))
                               (recip (lower-bound y)))))


;-----------------------------------------------------------------------------
; | Example intervals for testing.

(define i0 (mk-interval 5 9))
(define i1 (mk-interval 6 2))
(define i2 (mk-interval 1 -3))
(define i3 (mk-interval 16 12))
