;-----------------------------------------------------------------------------
; | Exercise 1.25
;
; Alyssa P. Hacker complains that we went to a lot of extra work in writing
; expmod. After all, she says, since we already know how to compute
; exponentials, we could have simply written

(define (expmod-simple b e m)
    (remainder (fast-expt b e) m))

; Is she correct? Would this procedure serve as well for our fast prime
; tester? Explain.

; Well, it uses fast-expt, which is:

(define (sq x)
  (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (sq (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

; The original expmod is:

(define (expmod b e m)
  (cond ((= e 0) 1)
        ((even? e)
            (remainder (sq (expmod b (/ e 2) m))
                       m)
        (else
            (remainder (* b (expmod b (- e 1) m))
                       m)))))

; I think expmod-simple should work, but if I look at the Fermat test for
; testing for primes:

(define (fermat-test n)
  (define (check a)
    (= (expmod a n n) a))
  (check (+ 1 (random (- n 1)))))

; ...it looks like when I test for very large primes, say, 9e9, like in the
; previous exercises, expmod-simple will raise some random integer to the
; 9e9th power. This is probably a disaster. The normal expmod procedure
; never actually raises anything to a power (well, except for squaring
; something), so it's probably much more effective at its job, which is
; simply to find a remainder; it doesn't actually need to ever find the
; exponential.
