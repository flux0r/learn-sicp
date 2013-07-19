;-----------------------------------------------------------------------------
; | Exercise 2.14
;
; Demonstrate that Lem is right. Investigate the behavior of the system on a
; variety of arithmetic expressions. Make some intervals A and B, and use them
; in computing the expressions A/A and A/B. You will get the most insight by
; using intervals whose width is a small percentage of the center values.
; Examine the results of the computation in center-percent form.


(define i1 (mk-center-width 10 0.02))
(define i2 (mk-center-width 50 0.015))
(define i3 (div-interval i1 i1))
(define i4 (div-interval i1 i2))
(define i5 (par1 i1 i2))
(define i6 (par2 i1 i2))

; i5
; => (8.309 . 8.357)
; i6
; => (8.319 . 8.348)
; 
; So Lem is right: they do produce different answers.
;
; i3
; => (0.996008 . 1.004008)
; i4
; => (0.1995 . 0.2005)
; 
; So dividing an interval by itself doesn't make the unit interval (1 . 1),
; as expected.

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
                 
(define (recip x)
  (/ 1 x))
                 
(define (div-interval x y)
  (if (and (<= (lower-bound y) 0)
           (>= (upper-bound y) 0))
      (error "div-interval: The denominator cannot span zero.")
      (mul-interval x (mk-interval (recip (lower-bound y))
                                   (recip (upper-bound y))))))
                                   
(define (add-interval x y)
  (mk-interval (+ (lower-bound x) (lower-bound y))
               (+ (upper-bound x) (upper-bound y))))
                                   
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
                
(define (par2 r1 r2)
  (let ((one (mk-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))
