se 2.13
;
; Show that under the assumption of small percentage tolerances there is a
; simple formula for the approximate perentage tolerance of the product of
; two intervals in terms of the tolerances of the factors. You many simplify
; the problem by assuming that all numbers are positive.

; (define i1 (mk-center-percent 2.34 0.005))
; (define i2 (mk-center-percent 6.54 0.01))
; (define i3 (mul-interval i1 i2))
; (+ (percent i1) (percent i2))
; => 0.0149999999975
; (percent i3)
; => 0.01499925
; (define i4 (mk-center-percent 34.12 0.0075))
; (define i5 (mul-interval i2 i4))
; (percent i5)
; => 0.01749869
; (+ (percent i2) (percent i4))
; => 0.017499999996
;
; So it looks like the tolerance of the product of two intervals is roughly
; equal to the sum of the tolerances of the two intervals if the tolerances
; are small.

(define mk-center-width
  (lambda (c w)
    (mk-interval (- c w) (+ c w))))
    
(define center
  (lambda (i)
    (/ (+ (lower-bound i) (upper-bound i)) 2)))
    
(define width
  (lambda (i)
    (/ (- (upper-bound i) (lower-bound i)) 2)))
    
(define (mk-interval x y)
  (if (> x y)
      (cons y x)
      (cons x y)))
      
(define (upper-bound i)
  (cdr i))
  
(define (lower-bound i)
  (car i))
  
(define (mk-center-percent c tol)
   (mk-interval (- c (* c tol)) (+ c (* c tol))))
   
(define (percent i)
  (/ (width i) (center i)))
  
(define (mul-interval x y)
  (let ((pt1 (* (lower-bound x) (lower-bound y)))
        (pt2 (* (lower-bound x) (upper-bound y)))
        (pt3 (* (upper-bound x) (lower-bound y)))
        (pt4 (* (upper-bound x) (upper-bound y))))
    (mk-interval (min pt1 pt2 pt3 pt4)
                 (max pt1 pt2 pt3 pt4))))
