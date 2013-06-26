;-----------------------------------------------------------------------------
; | Exercise 2.11
;
;  In passing, Ben also cryptically comments: ``By testing the signs of the
;  endpoints of the intervals, it is possible to break mul-interval into
;  nine cases, only one of which requires more than two multiplications.''
;  Rewrite this procedure using Ben's suggestion.

(define (pos? x)
  (>= x 0))

(define (neg? x)
  (<= x 0))

(define (mul-interval x y)
  (let ((xl (lower-bound x))
        (xu (upper-bound x))
        (yl (lower-bound y))
        (yu (upper-bound y)))
    (cond ((or  (and (pos? xl) (pos? xu) (pos? yl) (pos? yu))
                (and (neg? xl) (neg? xu) (neg? yl) (neg? yu)))
            (mk-interval (* xl yl) (* xu yu)))
          ((and (pos? xl) (pos? xu) (neg? yl) (pos? yu))
            (mk-interval (* xu yl) (* xu yu)))
          ((and (neg? xl) (pos? xu) (neg? yl) (pos? yu))
            (mk-interval (min (* xl yu) (* xu yu))
                         (max (* xl yl) (* xu yu))))
          ((or  (and (pos? xl) (pos? xu) (neg? yl) (neg? yu))
                (and (neg? xl) (neg? xu) (pos? yl) (pos? yu)))
            (mk-interval (* xu yl) (* xl yu)))
          ((and (neg? xl) (pos? xu) (pos? yl) (pos? yu))
            (mk-interval (* xl yu) (* xu yu)))
          ((and (neg? xl) (pos? xu) (neg? yl) (neg? yu))
            (mk-interval (* xu yl) (* xl yl)))
          ((and (neg? xl) (neg? xu) (neg? yl) (pos? yu))
            (newline)
            (display "Yay!")
            (mk-interval (* xl yu) (* xl yl))))))


;-----------------------------------------------------------------------------
; | Interval constructor, selectors, and show method.

(define (mk-interval x y)
  (if (> x y)
      (cons y x)
      (cons x y)))

(define (upper-bound interval)
  (cdr interval))

(define (lower-bound interval)
  (car interval))

(define (show-interval x)
  (display "[")
  (display (lower-bound x))
  (display ", ")
  (display (upper-bound x))
  (display "]")
  (newline))


;-----------------------------------------------------------------------------
; | Test cases.

(define t1 (mk-interval -10 -4))
(define t2 (mk-interval -10 4))
(define t3 (mk-interval 10 -4))
