;-----------------------------------------------------------------------------
; | Exercise 1.19
;
; There is a clever algorithm for computing the Fibonacci numbers in a
; logarithmic number of steps. Recall the transformation of the state
; variables a and b in the fib-iter process of section 1.2.2: a <- a + b and
; b <- a. Call this transformation T, and observe that applying T over and
; over again n times, starting with 1 and 0, produces the pair Fib(n + 1)
; and Fib(n). In other words, the Fibonacci numbers are produced by applying
; T^n, the nth power of the transformation T, starting with the pair (1,0).
;
; Now consider T to be the special case of p = 0 and q = 1 in a family of
; transformations T_pq, where T_pq transforms the pair (a,b) according to a
; <- bq + aq + ap and b <- bp + aq.
;
; Show that if we apply such a transformation T_pq twice, the effect is the
; same as using a single transformation T_p'q' of the same form, and compute
; p' and q' in terms of p and q. This gives us an explicit way to square
; these transformations, and thus we can compute T^n using successive
; squaring, as in the fast-expt procedure.

; a1    = bq + aq + ap
; b1    = bp + aq .
;
; b2    = b1*p + a1*q
;       = p(bp + aq) + q(bq + aq + ap)
;       = bp^2 + aqp + bq^2 + aq^2 + aqp
;       = b(p^2 + q^2) + a(2qp + q^2) .
;
; p'    = p^2 + q^2 .
; q'    = 2qp + q^2 .
; 
; a2    = b1*q + a1*q + a1*p
;       = q(bp + aq) + q(bq + aq + ap) + p(bq + aq + ap)
;       = bpq + aq^2 + bq^2 + aq^2 + apq + bpq + apq + ap^2
;       = b(pq + q^2 + pq) + a(q^2 + pq + pq) + a(q^2 + p^2)
;       = b(q^2 + 2pq) + a(q^2 + 2pq) + a(q^2 + p^2)
;       = bq' + aq' + ap' .

; Put this all together to complete the following procedure, which runs in a
; logarithmic number of steps:
(define (fast-fib x)
  (define (iter a b p q counter)
    (cond ((= counter 0) b)
          ((even? counter)
            (iter a
                  b
                  (+ (square p) (square q))
                  (+ (double (* p q)) (square q))
                  (half counter)))
          (else (iter (+ (* b q) (* a q) (* a p))
                      (+ (* b p) (* a q))
                      p
                      q
                      (1- counter)))))
  (iter 1 0 0 1 x))
