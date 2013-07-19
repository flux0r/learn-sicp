;-----------------------------------------------------------------------------
; | Exercise 2.15
;
; Eva Lu Ator, another user, has also noticed the different intervals computed
; by different but algebraically equivalent expressions. She says that a
; formula to compute with intervals using Alyssa's system will produce tighter
; error bounds if it can be written in such a form that no variable that
; represents an uncertain number is repeated. Thus, she says par2 is a
; "better" program for parallel resistances than par1. Is she right? Why?

; The procedure par1 is represented mathematically by
;
;     R1*R2
;    -------
;    R1 + R2
;
; and par2 is
;
;         1
;    ----------- .
;    1/R1 + 1/R2
;
; To change par2 into par1, I can do
;
;         1                1        R1
;    -----------    = ----------- * --
;    1/R1 + 1/R2      1/R1 + 1/R2   R1
;                   
;                         R1        R2
;                   = ----------- * --
;                      1 + R1/R2    R2
;
;                       R1*R2
;                   = ----------- .
;                      R2 + R1
;
; However, these manipulations depend on the fact that 1 is the neutral
; element of the division operator. For our intervals, we know from exercise
; 2.14 that dividing an interval by itself does not equal the neutral 
; interval (1 . 1), but only an approximation. So Alyssa's right: factoring
; out the extra neutral elements will improve the error bounds of the program.


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
