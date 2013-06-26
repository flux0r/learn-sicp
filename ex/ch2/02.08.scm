;-----------------------------------------------------------------------------
; | Exercise 2.8
;
; Using reasoning analogous to Alyssa's, describe how the difference of two
; intervals may be computed. Define a corresponding subtraction procedure,
; called sub-interval.


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
  (newline)


; Subtracting two intervals uses the worst-case scenario for each end of the
; resulting interval. So, the lower bound of the new interval is the lower
; bound of the first input minus the upper bound of the second input. The
; upper bound of the new interval is the upper bound of the first input
; minus the lower bound of the second. For example, [6, 9] - [2, 4] is 
; 
;       [(6 - 4), (9 - 2)] = [2, 7].
;
; It works for overlapping intervals, too: [4.5, 9.3] - [1.7, 4.9] is
;
;       [-0.4, 7.6].


(define (sub-interval x y)
  (mk-interval (- (lower-bound x) (upper-bound y))
               (- (upper-bound x) (lower-bound y))))
