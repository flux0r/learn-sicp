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

(define (id x) x)

(define (1+ x) (+ x 1))

(define (summ-squares-primes a b)
  (filtered-accumulate prime? + 0 id a 1+ b))

; TODO
