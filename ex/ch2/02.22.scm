;-----------------------------------------------------------------------------
; | Exercise 2.22
;
; Louis Reasoner tries to rewrite the first square-list procedure of exercise
; 2.21 so that it evolves an iterative process:
; 
; (define (square-list items)
;   (define (iter things answer)
;     (if (null? things)
;         answer
;         (iter (cdr things)
;               (cons (square (car things)) answer))))
;   (iter items '()))
;
;  Unfortunately, defining square-list this way produces the answer list in
;  the reverse order of the one desired. Why?
; 
; Louis then tries to fix his bug by interchanging the arguments to cons:
; 
; (define (square-list items)
;   (define (iter things answer)
;     (if (null? things)
;         answer
;         (iter (cdr things)
;               (cons answer
;                     (square (car things))))))
;   (iter items nil))
; 
; This doesn't work either. Explain.

; The first way doesn't work because it takes each item from the front of the
; input list, squares it, and then conses it onto the front of the answer. The
; last element from the input will be the first element of the answer.
;
; The second way doesn't work because it builds the list up to the left. The
; output will require the caller to use cdr to get a single element and car
; to get the rest of the list, which could cause nasty bugs.
