(define (1+ n) (+ n 1))
(define (1- n) (- n 1))

; Exercise 1.11 -- recursive process.
(define (f1 n)
  (if   (< n 3)
        n
        (+  (f1 (1- n))
            (* 2 (f1 (- n 2)))
            (* 3 (f1 (- n 3))))))

; Exercise 1.11 -- iterative process.
(define (f2 n)
  (define (f-iter a b c counter)
    (if (< counter 3)
        a
        (f-iter (+ a (* 2 b) (* 3 c))
                a
                b
                (-1 counter))))
  (if   (< n 3)
        n
        (f-iter 2 1 0 n)))

; Exercise 1.12
(define (pascal row col)
  (cond ((= col 0) 1)
        ((= col row) 1)
        (else (+    (pascal (1- row) (1- col))
                    (pascal (1- row) col)))))

; Exercise 1.15 -- approximating sin
(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine x)
  (if   (not (> (abs x) 0.1))
        x
        (p (sine (/ x 3.0)))))

; Exponentiation
;
; This is linear with the exponent with respect to time and constant with
; respect to space.
(define (expt1 b n)
  (define (expt-iter b product counter)
    (if (= counter 0)
        product
        (expt-iter b (* b product) (1- counter))))
  (expt-iter b 1 n))

; Take advantage of the fact that b^n == (b^(n/2))^2 if n is even to speed
; things up. If it's not even, factor out a base and decrement the exponent.
(define (square x) (* x x))
(define (fast-expt1 b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt1 b (/ n 2))))
        (else (* b (fast-expt1 b (1- n))))))

; Exercise 1.16
;
; Take advantage of successive squaring like in fast-expt1, but generate an
; iterative process instead of a recursive one.
(define (my-expt b n)
  (define (iter base exponent state)
    ; Keep a state variable for the iteration. The invariant
    ; state*(base^exponent) should not change from one iteration to the
    ; next.
    ;
    ; If the exponent is zero, the answer is the state since I can change
    ; the base^exponent part of the term to 1 without changing the
    ; invariant.
    ;
    ; If the exponent is even, I need to square the base and halve the
    ; exponent, leaving the state the same to keep the invariant from
    ; changing.
    ;
    ; If it's not even, I need to decrement the exponent like in fast-expt1,
    ; but I leave the base alone and move the extra base multiple to the
    ; state by multiplying them, which leaves the invariant unchanged.
    (cond ((= exponent 0)
                state)
          ((even? exponent)
                (iter (square base) (/ exponent 2.0) state))
          (else
                (iter base (1- exponent) (* state base)))))
  (iter b n 1.0))


; Exercise 1.17
(define (slow-* x y)
  (if (= y 0)
      0
      (+ x (slow-* x (1- y)))))

(define (double x) (+ x x))
(define (half x) (/ x 2))

; Use doubling to generate a recursive procedure with a logarithmic number
; of steps.
(define (fast-* x y)
  (cond ((= y 0) 0)
        ((even? y) (double (fast-* x (half y))))
        (else (+ x (fast-* x (1- y))))))

; Exercise 1.18
;
; Use doubling to generate an interative procedure with a logarithmic
; number of steps. Invariant is (+ (* x y) a) == (+ (* x1 y1) a1).
(define (iter-* x y)
  (define (iter a b state)
    (cond ((= b 0) state)
          ((even? b) (iter (double a) (half b) state))
          (else (iter a (1- b) (+ state a)))))
  (iter x y 0))


; Exercise 1.19
(define (fast-fib x)
  (define (iter a b u v counter)
    (cond ((= counter 0) b)
          ((even? counter)
            (iter a
                  b
                  (+ (square u) (square v))
                  (+ (double (* u v)) (square v))
                  (half counter)))
          (else (iter (+ (* b v) (* a v) (* a u))
                      (+ (* b u) (* a v))
                      u
                      v
                      (1- counter)))))
  (iter 1 0 0 1 x))



(define (gcd x y)
  (if (= y 0)
    x
    (gcd y (remainder x y))))
