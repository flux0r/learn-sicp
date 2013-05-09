; The good-enough? test used in computing square roots will not be very
; effective for finding the square roots of very small numbers. Also, in
; real computers, arithmetic operations are almost always performed with
; limited precision. This makes our test inadequate for very large numbers.
; Explain these statements, with examples showing how the test fails for
; small and large numbers. An alternative strategy for implementing
; good-enough? is to watch how guess changes from one iteration to the next
; and to stop when the change is a very small fraction of the guess. Design
; a square-root procedure that uses this kind of end test. Does this work
; better for small and large numbers?

(define (average x y)
  (/ (+ x y ) 2))

(define (square x) (* x x))

(define (crappy-sqrt x)
  (define (sqrt-iter guess)
    (if (good-enough? guess)
      guess
      (sqrt-iter (improve guess))))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (sqrt-iter 1.0))

; If I define a small number, say, .0000000058477, squaring the result of
; crappy-sqrt gives back 9.76566394661905e-4. If I define a large number,
; say, 49838809000038488490, the procedure will enter an infinite loop
; because the precision of the numbers makes it impossible to meet the
; good-enough? exit criteria.

; Here, the procedure stops when the change is a small percentage of the
; previous value. It works better for small and large numbers.
(define (sqrt-better x)
  (define (sqrt-iter guess old)
    (if (good-enough? guess old)
      guess
      (sqrt-iter (improve guess) guess)))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? guess old)
    (< (abs (/ (- guess old) old)) 0.001))
  (sqrt-iter 1.0 0.0))
