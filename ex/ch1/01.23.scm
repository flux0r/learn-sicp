;-----------------------------------------------------------------------------
; | Exercise 1.23
;
; The smallest-divisor procedure shown at the start of this section does
; lots of needless testing: After it checks to see if the number is
; divisible by 2 there is no point in checking to see if it is divisible by
; any larger even numbers. This suggests that the values used for
; test-divisor should not be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9,
; .... To implement this change, define a procedure next that returns 3 if
; its input is equal to 2 and otherwise returns its input plus 2. Modify the
; smallest-divisor procedure to use (next test-divisor) instead of (+
; test-divisor 1). With timed-prime-test incorporating this modified version
; of smallest-divisor, run the test for each of the 12 primes found in
; exercise 1.22. Since this modification halves the number of test steps,
; you should expect it to run about twice as fast. Is this expectation
; confirmed? If not, what is the observed ratio of the speeds of the two
; algorithms, and how do you explain the fact that it is different from 2?


;-----------------------------------------------------------------------------
(define (smallest-divisor n)
    (define (next x)
      (if (= x 2) 3 (+ x 2)))
    (define (find-divisor n test-divisor)
      (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (next test-divisor)))))
    (find-divisor n 2))


;-----------------------------------------------------------------------------
(define (divides? a b)
    (= (remainder b a) 0))


;-----------------------------------------------------------------------------
(define (prime? n)
  (= n (smallest-divisor n)))


;-----------------------------------------------------------------------------
(define (timed-prime-test n)
  
  (define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (runtime) start-time))))
  
  (define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

  (newline)
  (display n)
  (start-prime-test n (runtime)))


;-----------------------------------------------------------------------------
(define (search-for-primes x y)
  (cond ((even? x) (search-for-primes (+ x 1) y))
        ((<= x y) (timed-prime-test x)
                  (search-for-primes (+ x 2) y))))


;-----------------------------------------------------------------------------
; The average time for the three smallest primes larger than 9e9 is 0.21,
; for 9e10 is 0.66, for 9e11 is 2.04, for 9e12 is 6.46, and for 9e13 is
; 20.48. The same figures for the other implementation are 0.38, 1.21, 3.83,
; 12.13, and 38.87. This gives ratios of 0.55, 0.59, 0.59, 0.53, and 0.53.
; So, it's not quite a doubling in performance. It's probably because even
; though it cuts the number of tests to run in half, it adds another
; procedure call and an ``if'' statement evaluation to each number.
