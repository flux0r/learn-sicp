;-----------------------------------------------------------------------------
; | Exercise 2.12
;
; Define a constructor make-center-percent that takes a center and a 
; percentage tolerance and produces the desired interval. You must also define
; a selector percent that produces the percentage tolerance for a given
; interval. The center selector is the same as the one shown above.

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
