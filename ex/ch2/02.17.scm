;-----------------------------------------------------------------------------
; | Exercise 2.17
; 
; Define a procedure last-pair that returns the list that contains only the
; last element of a given (nonempty) list.
;
; (last-pair (list 23 72 149 34))
; (34)

(define (last-pair xs)
  (let ((h (car xs))
        (t (cdr xs)))
    (if (null? t)
        (list h)
        (last-pair t))))
