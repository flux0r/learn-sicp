;-----------------------------------------------------------------------------
; | Exercise 1.29.
;
; Simpson's Rule is a more accurate method of numerical integration than the
; method illustrated above. Using Simpson's Rule, the integral of a function f
; between a and b is approximated as
;
;    h
;    - * (y[0] + 4y[1] + 2y[2] + 4y[3] + 2y[4] + ... + 2y[n - 2] +
;    3                
;                        4y[n - 1] + y[n])
; 
; where h = (b - a)/n, for some even integer n, and y[k] = f(a + kh).
; (Increasing n increases the accuracy of the approximation.) Define a
; procedure that takes as arguments f, a, b, and n and returns the value of
; the integral, computed using Simpson's Rule. Use your procedure to integrate
; cube between 0 and 1 (with n = 100 and n = 1000), and compare the results to
; those of the integral procedure shown above.

(define (cube x) (* x x x))

(define (sum term a next b)
  (define (iter a acc)
    (if (> a b)
        acc
    (iter (next a) (+ (term a) acc))))
  (iter a 0))
  
(define (1+ x) (+ x 1))

(define (simpsons-method f a b n)
  (let ((h (/ (- b a) n)))
    (define (y k) (f (+ a (* k h))))
    (define (term x)
      (* (cond ((or (= x 0) (= x n)) 1.0)
               ((even? x) 2.0)
               (else 4.0))
         (y x)))
    (* (/ h 3.0)
       (sum term 0 1+ n))))
       
; The distance to the right answer for n := 100 is 5.55e-17 for Simpson's meth-
; od and 1.25e-5 for the original method. For n := 1000, I still get
; 5.55e-17 compared with 1.25e-7 for the original. So Simpson's method is
; more accurate.
