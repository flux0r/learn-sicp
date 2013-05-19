;-----------------------------------------------------------------------------
; | Exercise 1.22
;
;  Most Lisp implementations include a primitive called runtime that returns
;  an integer that specifies the amount of time the system has been running
;  (measured, for example, in microseconds). The following timed-prime-test
;  procedure, when called with an integer n, prints n and checks to see if n
;  is prime. If n is prime, the procedure prints three asterisks followed by
;  the amount of time used in performing the test.

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

; Using this procedure, write a procedure search-for-primes that checks the
; primality of consecutive odd integers in a specified range. Use your
; procedure to find the three smallest primes larger than 1000; larger than
; 10,000; larger than 100,000; larger than 1,000,000. Note the time needed
; to test each prime. Since the testing algorithm has order of growth of
; O(sqrt(n)), you should expect that testing for primes around 10,000 should
; take about sqrt(10) times as long as testing for primes around 1000. Do
; your timing data bear this out? How well do the data for 100,000 and
; 1,000,000 support the sqrt(n) prediction? Is your result compatible with
; the notion that programs on your machine run in time proportional to the
; number of steps required for the computation?

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
    (define (find-divisor n test-divisor)
      (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))
    (find-divisor n 2))

(define (divides? a b)
    (= (remainder b a) 0))

(define (search-for-primes x y)
  (cond ((even? x) (search-for-primes (+ x 1) y))
        ((<= x y) (timed-prime-test x)
                  (search-for-primes (+ x 2) y))))

; The three smallest primes larger than 1000 are 1009, 1013, and 1019.
; Larger than 10,000: 10,007; 10,009; and 10,037. Larger than 100,000:
; 100,003; 100019; and 100043. Larger than 1,000,000: 1,000,003; 1,000,033;
; 1,000,037.
;
; I can't see the time required for each one since the time is too small for
; a difference between the start and end times. However, the average time
; taken for the three smallest primes larger than 9e9 is 0.38, for 9e10 is
; 1.21, for 9e11 is 3.83, for 9e12 is 12.13, and for 9e13 is 38.87. Since
; these are all 10 times the previous one, the change in time taken should
; be about sqrt(10), or 3.16, times the previous one. The actual changes are
; 3.18, 3.17, 3.17, and 3.20. So O(sqrt(n)) seems like a reasonable growth
; rate for the prime? procedure.
