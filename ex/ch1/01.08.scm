; Newton's method for cube roots is based on the fact that if y is an
; approximation to the cube root of x, then a better approximation is given
; by the value
; 
; (x/y^2 + 2y)/3
;
; Use this formula to implement a cube-root procedure analogous to the
; square-root procedure. (In section 1.3.4 we will see how to implement
; Newton's method in general as an abstraction of these square-root and
; cube-root procedures.)

(define (square x)
  (* x x))

(define (cube x)
  (* (square x) x))

(define (cube-rt x)
  (define (good-enough? new old)
    (< (abs (/ (- new old) old)) 0.0001))
  (define (improve y)
    (/ (+ (/ x (square y)) (* 2 y)) 3))
  (define (iter result)
    (define new (improve result))
    (if (good-enough? new result)
        new
        (iter new)))
  (iter 1.0))
