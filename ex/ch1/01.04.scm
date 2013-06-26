; Observe that our model of evaluation allows for combinations whose
; operators are compound expressions. Use this observation to describe the
; behavior of the following procedure.

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; The if statements returns either + or - depending on the value of b and
; then applies it to the operands a and b.
