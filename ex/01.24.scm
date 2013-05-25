;-----------------------------------------------------------------------------
; | Exercise 1.24
;
; Modify the timed-prime-test procedure of exercise 1.22 to use fast-prime?
; (the Fermat method), and test each of the 12 primes you found in that
; exercise. Since the Fermat test has (log n) growth, how would you expect
; the time to test primes near 1,000,000 to compare with the time needed to
; test primes near 1000? Do your data bear this out? Can you explain any
; discrepancy you find?


;-----------------------------------------------------------------------------
(define (timed-prime-test n)
  
  (define (start-prime-test n start-time)
    (if (fast-prime? n 1000)
        (report-prime (- (runtime) start-time))))
  
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

  (newline)
  (display n)
  (start-prime-test n (runtime)))


;-----------------------------------------------------------------------------
(define (sq x)
  (* x x))


;-----------------------------------------------------------------------------
; | Compute the exponential of a number modulo another number.
(define (expmod b e m)
    (cond   ((= e 0) 1)
            ((even? e)
                (remainder (sq (expmod b (/ e 2) m)) m))
            (else
                (remainder (* b (expmod b (- e 1) m)) m))))


;-----------------------------------------------------------------------------
; | Fermat test for primality. Choose a random number a between 1 and n - 1
; inclusive and check whether the remainder modulo n of the nth power of a
; is equal to a.
(define (fermat-test n)
    (define (check a)
        (= (expmod a n n) a))
    (check (+ (random (- n 1)) 1)))


;-----------------------------------------------------------------------------
; | Run the Fermat test a given number of times. If the test succeeds every
; time, the result is #t; otherwise, it's #f.
(define (fast-prime? x n)
    (cond   ((= n 0) true)
            ((fermat-test x) (fast-prime? x (- n 1)))
            (else false)))


;-----------------------------------------------------------------------------
(define (search-for-primes x y)
  (cond ((even? x) (search-for-primes (+ x 1) y))
        ((<= x y) (timed-prime-test x)
                  (search-for-primes (+ x 2) y))))


;-----------------------------------------------------------------------------
; The average time taken to test the three lowest primes greater than 9e9 is
; 0.10, 9e10 is 0.11, 9e11 is 0.12, 9e12 is 0.14, and 9e13 is 0.14.
