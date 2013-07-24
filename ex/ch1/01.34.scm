;-----------------------------------------------------------------------------
; | Exercise 1.34
;
; Suppose we define the procedure
; 
;       (define (f g)
;         (g 2))
; 
; Then we have
; 
;       (f square)
;       4
; 
;       (f (lambda (z) (* z (+ z 1))))
;       6
; 
; What happens if we (perversely) ask the interpreter to evaluate the
; combination (f f)? Explain. 

; The procedure f takes a procedure g and applies 2 to it. If I feed f to
; itself, it will try to apply 2 to 2 and will fail because 2 is not a
; procedure.
;
; (f f) == (f 2)
;       == (2 2)
