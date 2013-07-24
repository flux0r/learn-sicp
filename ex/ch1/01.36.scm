;-----------------------------------------------------------------------------
; | Exercise 1.36
;
; Modify fixed-point so that it prints the sequence of approximations it
; generates, using the newline and display primitives shown in
; exerciseÂ1.22.  Then find a solution to x^x = 1000 by finding a fixed
; point of x -> log(1000)/log(x). (Use Scheme's primitive log procedure, which
; computes natural logarithms.) Compare the number of steps this takes with
; and without average damping. (Note that you cannot start fixed-point with
; a guess of 1, as this would cause division by log(1) = 0.)

(define (fixed-point f first-guess)
  (let ((tol 0.00001))
    (define (good-enough? x y)
      (< (abs (- x y)) tol))
    (define (try guess counter)
      (let ((next-counter (+ counter 1)))
        (display guess)
        (display " count: ")
        (display counter)
        (newline)
        (let ((next-guess (f guess)))
          (if (good-enough? guess next-guess)
              next-guess
              (try next-guess next-counter)))))
    (try first-guess 0)))

(define x-to-x-no-damp
  (fixed-point (lambda (x) (/ (log 1000) (log x))) 1.1))

(define (average x y)
  (/ (+ x y) 2))

(define x-to-x-damp
  (fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 1.1))

; The solution with no average damping takes 36 steps to terminate and the
; one with average damping takes 12.
