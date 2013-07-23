;-----------------------------------------------------------------------------
; | Exercise 1.31
;
; a. The sum procedure is only the simplest of a vast number of similar ab-
;    stractions that can be captured as higher-order procedures. Write an ana-
;    logous procedure called product that returns the product of the values of
;    a function at points over a given range. Show how to define factorial in
;    terms of product. Also use product to compute approximations to pi using
;    the formula
;        
;        pi    2*4*4*6*6*8...
;        -- =  -------------- .
;        4     3*3*5*5*7*7...
;
; b. If your product procedure generates a recursive process, write one that
;    generates an iterative process. If it generates an iterative process,
;    write one that generates a recursive process.

(define id
  (lambda (x) x))
  
(define 1+
  (lambda (x) (+ x 1)))

(define (product-iter term a next b)
  (define (iter x acc)
    (if (> x b)
        acc
        (iter (next x) (* (term x) acc))))
  (iter a 1))
  
(define factorial
  (lambda (n)
    (cond ((= 0 n) 0)
          ((= 1 n) 1)
          (else (product-iter id 2 1+ n)))))
          
(define approx-pi
  (lambda (n)
    (define (term n)
      (if (odd? n)
          (/ (1+ n) (+ n 2))
          (/ (+ n 2) (1+ n))))
    (* (product-iter term 1 1+ n) 4)))
    
(define (product-rec term a next b)
  (if (> a b)
      1
      (* (term a) (product-rec term (next a) next b))))
