;-----------------------------------------------------------------------------
; | Exercise 1.26
;
; Louis Reasoner is having great difficulty doing exercise 1.24. His
; fast-prime? test seems to run more slowly than his prime? test. Louis
; calls his friend Eva Lu Ator over to help. When they examine Louis's code,
; they find that he has rewritten the expmod procedure to use an explicit
; multiplication, rather than calling square:

(define (expmod-slow b e m)
  (cond ((= e 0) 1)
        ((even? e)
            (remainder (* (expmod b (/ e 2) m)
                          (expmod b (/ e 2) m))
                       m))
        (else
            (remainder (* b (expmod b (- e 1) m))
                       m))))

; ``I don't see what difference that could make,'' says Louis. ``I do.''
; says Eva. ``By writing the procedure like that, you have transformed the
; (log n) process into a (n) process.'' Explain.

; The original expmod is:

(define (expmod b e m)
  (define (sq x)
    (* x x))
  (cond ((= e 0) 1)
        ((even? e)
            (remainder (sq (expmod b (/ e 2) m))
                       m)
        (else
            (remainder (* b (expmod b (- e 1) m))
                       m)))))

; Comparing them, in the slow version, everytime the exponent is even,
; expmod will recurse twice instead of once.  Further, the second recursive
; call is redundant, since it is calculating the same result as the first
; one. This means that the n in O(log(n)) is really 2^n, since every even
; case generates two new trees, and the log(2^n) turns into regular old n.
