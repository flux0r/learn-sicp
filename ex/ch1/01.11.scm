;-----------------------------------------------------------------------------
; | A function f is defined by the rule that f(n) = n if n<3 and f(n) = f(n -
; 1) + 2f(n - 2) + 3f(n - 3) if n> 3. Write a procedure that computes f by
; means of a recursive process. Write a procedure that computes f by means
; of an iterative process.


;-----------------------------------------------------------------------------
; | Recursive process

(define (1- x) (- x 1))
(define (2- x) (- x 2))
(define (3- x) (- x 3))

(define (fr n)
  (if (< n 3)
    n
    (+ (fr (1- n))
       (* 2 (fr (2- n)))
       (* 3 (fr (3- n))))))

; (fr 4)
; (+ (fr 3) (* 2 (fr 2)) (* 3 (fr 1)))
; (+ (+ (fr 2) (* 2 (fr 1)) (* 3 (fr 0)))
;    (* 2 2)
;    (* 3 1))
; (+ (+ 2 2) 4 3)
; (+ 4 4 3)
; 11


;-----------------------------------------------------------------------------
; | Iterative process

(define (fi n)
  (define (iter n. r1 r2 r3)
    (if (< n. 3)
      r1
      (iter (1- n.)
            (+ r1 (* 2 r2) (* 3 r3))
            r1
            r2)))
  (if (< n 3)
    n
    (iter n 2 1 0)))

; (fr 4)
; (iter 4 2 1 0)
; (iter 3 4 2 1)
; (iter 2 11 4 2)
; 11
