; Draw the tree illustrating the process generated by the count-change
; procedure of section 1.2.2 in making change for 11 cents. What are the
; orders of growth of the space and number of steps used by this process as
; the amount to be changed increases?

(define (count-change amount)
 (cc amount 5))

(define (cc amount kinds-of-coins)
 (cond ((= amount 0) 1)
       ((or (< amount 0) (= kinds-of-coins 0)) 0)
       (else (+ (cc amount
                 (- kinds-of-coins 1))
                (cc (- amount
                       (first-denomination kinds-of-coins))
                    kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
 (cond ((= kinds-of-coins 1) 1)
       ((= kinds-of-coins 2) 5)
       ((= kinds-of-coins 3) 10)
       ((= kinds-of-coins 4) 25)
       ((= kinds-of-coins 5) 50)))

; (count-change 11)
; (cc 11 5)
; (+ (cc 11 4) (cc -39 5))
; (+ (+ (cc 11 3) (cc -14 4) 0))
; (+ (+ (+ (cc 11 2) (cc 1 3)) 0))
; (+ (+ (+ (+ (cc 11 1) (cc 6 2) (+ (cc 1 2) (cc -9 3)))) 0))
; (+ (+ (+ (+ (   ...
; .     .
; .     .
; .     .
;
; This procedure takes a linear amount of space as the amount increases
; because it generates a recursive process and from the text, we know that
; space for such a process is proportional to the depth of the tree
; generated by the procedure.
;
; For every type of coin in first-denomination, the procedure will generate
; a number of operations that is proportional to the amount. Since there is
; no memoization, the tree generated by the kth coin will also generate the
; tree generated by the (k - 1)th coin, making the procedure run in
; amount^c time, where c is the number of coins. In this case, amount^5.
