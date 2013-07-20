;-----------------------------------------------------------------------------
; | Exercise 2.20
;
; Use dotted-tail notation to write a procedure same-parity that takes one or
; more integers and returns a list of all the arguments that have the same
; even-odd parity as the first argument.
;
; (same-parity 1 2 3 4 5 6 7)
; (1 3 5 7)
; (same-parity 2 3 4 5 6 7)
; (2 4 6)

(define (same-parity x . xs)
  (let ((p? (if (even? x) even? odd?)))
    (define (iter xs acc)
      (cond ((null? xs) (reverse acc))
            ((p? (car xs)) (iter (cdr xs) (cons (car xs) acc)))
            (else (iter (cdr xs) acc))))
    (iter (cons x xs) '())))
