; The following pattern of numbers is called Pascal's triangle.
; 
; 
; The numbers at the edge of the triangle are all 1, and each number inside
; the triangle is the sum of the two numbers above it.35 Write a procedure
; that computes elements of Pascal's triangle by means of a recursive
; process.


;-----------------------------------------------------------------------------
; | pascal

(define (pascal m n)
  (if (or (= 1 n) (= m n))
    1
    (+ (pascal (1- m) (1- n))
       (pascal (1- m) n))))


; (pascal 3 2)
; (+ (pascal 2 1)
;    (pascal 2 2))
; (+ 1
;    (+ (pascal 1 1)
;       1))
; (+ 1 (+ 1 1))
; (+ 1 2)
; 3
