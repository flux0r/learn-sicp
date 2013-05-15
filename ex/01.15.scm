; The sine of an angle (specified in radians) can be computed by making use
; of the fact that sin(x) is approximately equal to x if x is small enough,
; and the identity
;           sin(r) = 3*(sin(r/3)) - (4*sin)^3*(r/3)
; to reduce the size of the argument of sin. (For purposes of this exercise,
; an angle is considered ``sufficiently small'' if its magnitude is not
; greater than 0.1 radians.) These ideas are incorporated in the following
; procedures:

(define (cube x) (* x x x))

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
 (if (not (> (abs angle) 0.1))
      angle
     (p (sine (/ angle 3.0)))))

; a. How many times is the procedure p applied when (sine 12.15) is
;    evaluated?
; b. What is the order of growth in space and number of steps (as a function
;    of a) used by the process generated by the sine procedure when (sine a)
;    is evaluated?
;
; a. 
; (sine 12.15)
; (p (sine 4.05))
; (p (p (sine 1.345)))
; (p (p (p (sine 0.448))))
; (p (p (p (p (sine 0.149)))))
; (p (p (p (p (p (sine 0.05))))))
; (p (p (p (p (p 0.05)))))
; (p (p (p (p 0.1495))))                    ; 1
; (p (p (p 0.43513)))                       ; 2
; (p (p 0.975843))                          ; 3
; (p -0.789533)                             ; 4
; -0.3999                                   ; 5
;
; b. The p procedure is only called once for every tripling of the argument
;    to sine. The procedure p is clearly linear in its argument and calls
;    to p are the only thunks generated. So sine is logarithmic in time and
;    space.
