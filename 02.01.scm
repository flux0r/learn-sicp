(define (rat+ x y)
  (mk-rat (+ (* (numer x) (denom y))
             (* (numer y) (denom x)))
          (* (denom x) (denom x))))

(define (rat- x y)
  (mk-rat (- (* (numer x) (denom y))
             (* (numer y) (denom x)))
          (* (denom x) (denom y))))

(define (rat* x y)
  (mk-rat (* (numer x) (numer y))
          (* (denom x) (denom y))))

(define (rat/ x y)
  (mk-rat (* (numer x) (denom y))
          (* (denom x) (numer y))))

(define (rat=? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (mk-rat x y)
  (let ((divisor (gcd (abs x) (abs y))))
    (if (< y 0)
      (cons (/ (- x) divisor) (/ (- y) divisor))
      (cons (/ x divisor) (/ y divisor)))))

(define (numer x)
  (car x))

(define (denom x)
  (cdr x))

(define (show-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (gcd x y)
  (if (= y 0)
    x
    (gcd y (remainder x y))))


; Exercise 2.2
(define (average x y)
  (/ (+ x y) 2))
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

(define (make-segment p1 p2)
  (cons p1 p2))
(define (start-segment l)
  (car l))
(define (end-segment l)
  (cdr l))

(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

(define (midpoint-segment l)
  (make-point (average (x-point (start-segment l))
                       (x-point (end-segment l)))
              (average (y-point (start-segment l))
                       (y-point (end-segment l)))))


; Exercise 2.3
(define (double n)
  (* 2 n))
; Make a rectangle from two opposite corners.
(define (make-rectangle p1 p2)
  (cons p1 p2))
(define (rectangle-w r)
  (abs (- (x-point (car r)) (x-point (cdr r)))))
(define (rectangle-h r)
  (abs (- (y-point (car r)) (y-point (cdr r)))))

(define (rectangle-perimeter r)
  (double (+ (rectangle-w r) (rectangle-h r))))
(define (rectangle-area r)
  (* (rectangle-w r) (rectangle-h r)))


; It's possible to define cons, car, and cdr without any data structures.
(define (mcons x y)
  (lambda (m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (error "Argument not 0 or 1 -- mcons" m)))))
(define (mcar z) (z 0))
(define (mcdr z) (z 1))

; Another way.
(define (xcons x y)
  (lambda (m)
    (m x y)))
(define (xcar z)
  (z (lambda (p q)
       p)))
(define (xcdr z)
  (z (lambda (p q)
       q)))

(define (1+ x) (+ x 1))
(define (negative x) (- 0 x))

; Exercise 2.5
(define (icons a b) (* (expt 2 a) (expt 3 b)))
(define (num-divides n d)
  (define (iter x r)
    (if (= 0 (remainder x d))
        (iter (/ x d) (1+ r))
        r))
  (iter n 0))
(define (icar x)
  (num-divides x 2))
(define (icdr x)
  (num-divides x 3))

; Exercise 2.6
(define zero
  (lambda (f)
    (lambda (x)
      x)))
(define (add-1 n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))
(define one
  (lambda (f)
    (lambda (x)
      (f x))))
(define two
  (lambda (f)
    (lambda (x)
      (f (f x)))))
(define (add-church x y)
  (lambda (f)
    (lambda (z)
      ((x f) ((y f) z)))))
(define three (add-church one two))
(define four (add-church one three))
(define five (add-church two three))

; Exercise 2.1.4
(define (add-interval x y)
  (make-interval (+ (lo x) (lo y))
                 (+ (hi x) (hi y))))
(define (sub-interval x y)
  (make-interval (- (lo x) (hi y))
                 (- (hi x) (lo y))))
(define (mul-interval x y)
  (let ((p1 (* (lo x) (lo y)))
        (p2 (* (lo x) (hi y)))
        (p3 (* (hi x) (lo x)))
        (p4 (* (hi x) (hi y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (hi y))
                               (/ 1.0 (lo y)))))
(define (make-interval x y) (cons x y))
(define (hi x) (cdr x))
(define (lo x) (car x))
