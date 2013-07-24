;-----------------------------------------------------------------------------
; | Exercise 1.35
;
; Show that the golden ratio, phi, (section 1.2.2) is a fixed point of the
; transformation x -> 1 + 1/x, and use this fact to compute phi by means of
; the fixed-point procedure.

; From section 1.2.2,
;
;       phi^2 = phi + 1,
;
; so
;
;       phi^2     phi + 1
;       -----  =  -------
;        phi        phi
;
;                       1
;        phi   =  1 +  --- .
;                      phi

(define (fixed-point f first-guess)
  (let ((tol 0.00001))
    (define (good-enough? x y)
      (< (abs (- x y)) tol))
    (define (try guess)
      (let ((next-guess (f guess)))
        (if (good-enough? guess next-guess)
            next-guess
            (try next-guess))))
    (try first-guess)))

(define approx-phi
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))
