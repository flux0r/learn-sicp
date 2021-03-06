;-----------------------------------------------------------------------------
; | Exercise 1.33
;
; You can obtain an even more general version of accumulate (exercise 1.32) by
; introducing the notion of a filter on the terms to be combined. That is,
; combine only those terms derived from values in the range that satisfy a
; specified condition. The resulting filtered-accumulate abstraction takes the
; same arguments as accumulate, together with an additional predicate of one
; argument that specifies the filter. Write filtered-accumulate as a
; procedure. Show how to express the following using filtered-accumulate:
;
; a. the sum of the squares of the prime numbers in the interval a to b
;    (assuming that you have a prime? predicate already written)
;
; b. the product of all the positive integers less than n that are relatively
;    prime to n (i.e., all positive integers i < n such that GCD(i,n) = 1).

(define (filtered-accumulate pred combiner null-value term a next b)
  (define (iter x acc)
    (cond ((> x b) acc)
          ((pred x) (iter (next x) (combiner (term x) acc)))
          (else (iter (next x) acc))))
  (iter a null-value))

(define (summ-squares-primes a b)
  (filtered-accumulate prime? + 0 square a 1+ b))

(define (prod-relative-primes n)
  (define (pred x)
    (relatively-prime? x n))
  (filtered-accumulate pred * 1 id 2 1+ n))


;-----------------------------------------------------------------------------
  
(define (relatively-prime? x y)
  (= (gcd x y) 1))

(define (id x)
  x)

(define (1+ x)
  (+ x 1))

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
    
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (remainder n d)
  (- n (* (floor (/ n d)) d)))
  
(define (square x)
  (* x x))
