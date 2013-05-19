;-----------------------------------------------------------------------------
; | Exercise 1.21
;
; Use the smallest-divisor procedure to find the smallest divisor of each of
; the following numbers: 199, 1999, 19999.

; Find the smallest integral divisor (greater than 1) of a given number n.
; Do this in a straightforward way, by testing n for divisibility by
; successive integers starting with 2.
;
; The end test for find-divisor is based on the fact that if n is not prime
; it must have a divisor less than or equal to sqrt(n). If d is a divisor of n,
; then so is n/d. But d and n/d cannot both be greater than sqrt(n). This means
; that the algorithm need only test divisors between 1 and sqrt(n). Consequently,
; the number of steps required to identify n as prime will have order of
; growth O(sqrt(n)).
(define (smallest-divisor n)
    (define (find-divisor n test-divisor)
      (cond ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))
    (find-divisor n 2))

(define (divides? a b)
    (= (remainder b a) 0))

; The smallest divisor of 199 is (smallest-divisor n) = 199. For 1999, it's
; 1999. For 19999, it's 7.
