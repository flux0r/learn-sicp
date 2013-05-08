(define (1+ x) (+ 1 x))

(define (2+ x) (+ 2 x))

(define (1- x) (- x 1))

(define (square x) (* x x))

(define (cube x) (* x x x))

(define (avg x y)
  (/ (+ x y) 2))

(define (id x) x)

(define (divides? x y)
  (= (remainder y x) 0))

(define (smallest-divisor n)
  (define (find-divisor n x)
    (cond ((> (square x) n) n)
          ((divides? x n) x)
          (else (find-divisor n (2+ x)))))
  (if (divides? 2 n)
      2
      (find-divisor n 3)))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (gcd-of x y)
  (if (= y 0)
      x
      (gcd-of y (remainder x y))))

(define (relatively-prime? i n)
  (= (gcd-of i n) 1))

(define tolerance-ratio 0.0000001)

(define (done? x y)
  (display "x: ")
  (display x)
  (display "; y: ")
  (display y)
  (newline)
  (< (abs (/ (- y x) (max x y))) tolerance-ratio))
  

; Generate a recursive sum process.
(define (sum-recursive term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum-recursive term (next a) next b))))

; Generate an iterative sum process.
(define (sum-iterative term a next b)
  (define (iter a r)
    (if (> a b)
        r
        (iter (next a) (+ (term a) r))))
  (iter a 0))

; Integrate using a fixed step size.
(define (integrate-fixed-dx f a b dx)
  (define (add-dx x) (+ x dx))
  (* dx (sum f (+ a (/ dx 2.0)) add-dx b)))

; Integrate using Simpson's Rule.
(define (integrate-simpson f a b n)
  (define h (/ (- b a) n))
  (define (y k) (f (+ a (* k h))))
  (define (term k)
    (* (cond ((odd? k) 4)
             ((or (= k 0) (= k n)) 1)
             ((even? k) 2))
       (y k)))
  (* (/ h 3)
     (sum term 0 1+ n)))

; Generate a recursive product process.
(define (product-recursive term a next b)
  (if (> a b)
    1.0
    (* (term a)
       (product-recursive term (next a) next b))))

; Generate an iterative product process.
(define (product-iterative term a next b)
  (define (iter x r)
    (if (> x b)
        r
        (iter (next x) (* (term x) r))))
  (iter a 1.0))

; Use product to define factorial.
(define (factorial n)
  (product id 1 1+ n))

; Use product to define an approximation to pi.
(define (approx-pi n)
  (define (term x)
    (if (odd? x)
        (/ (1+ x) (2+ x))
        (/ (2+ x) (1+ x))))
  (* 4.0 (product term 1 1+ n)))

; Generate a recursive accumulate process.
(define (accumulate-recursive combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate-recursive combiner null-value term (next a)
                                      next b))))

; Define sum in terms of accumulate.
(define (sum-accumulate term a next b)
  (accumulate + 0.0 term a next b))

; Define product in terms of accumulate.
(define (product-accumulate term a next b)
  (accumulate * 1.0 term a next b))

; Generate an iterative process to accumulate.
(define (accumulate-iterative combiner null-value term a next b)
  (define (iter x r)
    (if (> x b)
        r
        (iter (next x) (combiner (term x) r))))
  (iter a null-value))

; Generate an iterative process to accumulate with a filter.
(define (filtered-accumulate-iterative filter-predicate combiner null-value
                                       term a next b)
  (define (iter x r)
    (if (> x b)
      r
      (if (filter-predicate x)
          (iter (next x) (combiner (term x) r))
          (iter (next x) r))))
  (iter a null-value))

; Define accumulate in terms of filtered-accumulate.
(define (accumulate-filtered-accumulate combiner null-value term a next b)
  (filtered-accumulate (lambda (x) #t) combiner null-value term a next b))

; Find the sum of the squares of the prime numbers in a given range.
(define (sum-squares-primes a b)
  (filtered-accumulate prime? + 0 square a 1+ b))

; Find the product of all the positive numbers less than a given number n
; that are relatively prime to n.
(define (product-relative-primes n)
  (filtered-accumulate (lambda (x) (relatively-prime? x n))
                       * 1 id 1 1+ (1- n)))

; THE HALF-INTERVAL METHOD
; Use this method to find roots of an equation f(x) = 0, where f is a
; continuous function.
(define (half-interval-method f a b)
  (define (search neg pos)
    (let ((mid (avg neg pos)))
      (if (done? neg pos)
          mid
          (let ((x (f mid)))
            (cond ((positive? x) (search neg mid))
                  ((negative? x) (search mid pos))
                  (else mid))))))
  (let ((f-of-a (f a))
        (f-of-b (f b)))
    (cond ((and (negative? f-of-a) (positive? f-of-b)) (search a b))
          ((and (negative? f-of-b) (positive? f-of-a)) (search b a))
          (else (error "Values are not of opposite sign." a b)))))

; FIND FIXED POINTS
; A point x is called a fixed point of a function f if f(x) = x.
(define (fixed-point f x)
  (define (try x)
    (let ((y (f x)))
      (if (done? x y)
        y
        (try y))))
  (try x))

(define (square-root x)
  (fixed-point (lambda (y) (avg y (/ x y))) 1.0))

(define approx-phi
  (lambda ()
    (fixed-point (lambda (x) (1+ (/ 1 x))) 1.0)))

(define approx-x-raised-to-x
  (lambda ()
    (fixed-point (lambda (x) (/ (log 1000) (log x)))
                 (1+ tolerance-ratio))))

;---------------------------------------------------------------------------
; Which implementation?
(define sum sum-accumulate)
(define product product-accumulate)
(define accumulate accumulate-filtered-accumulate)
(define filtered-accumulate filtered-accumulate-iterative)
