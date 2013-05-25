;-----------------------------------------------------------------------------
; | Exercise 1.27
;
; Demonstrate that the Carmichael numbers listed in footnote 47 really do
; fool the Fermat test. That is, write a procedure that takes an integer n
; and tests whether an is congruent to a modulo n for every a<n, and try
; your procedure on the given Carmichael numbers.


;-----------------------------------------------------------------------------
; | Try the Fermat test on every integer less than n and evaluate whether
; any of the results are false.
(define (fermat-test-all x)
  (define (iter n)
    (cond   ((= n 1) true)
            ((not (fermat-test x n)) false)
            (else (iter (1- n)))))
  (iter (1- x)))


;-----------------------------------------------------------------------------
; | Modify the Fermat test to just take a value and try it instead of using a
; random one less than n.
(define (fermat-test n a)
  (= (expmod a n n) a))


;-----------------------------------------------------------------------------
; | Compute the exponential of a number modulo another number.
(define (expmod b e m)
    (cond   ((= e 0) 1)
            ((even? e)
                (remainder (sq (expmod b (/ e 2) m)) m))
            (else
                (remainder (* b (expmod b (- e 1) m)) m))))


;-----------------------------------------------------------------------------
(define (sq x)
  (* x x))


;-----------------------------------------------------------------------------
(define (1- x)
  (- x 1))


;-----------------------------------------------------------------------------
; | Testing the numbers 561, 1105, 1729, 2465, 2821, and 6601 with
; fermat-test-all result in false-positive answers. So, the Carmichael
; numbers can fool the Fermat test.
