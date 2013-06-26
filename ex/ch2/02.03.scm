;-----------------------------------------------------------------------------
; | Exercise 2.3
;
;  Implement a representation for rectangles in a plane. (Hint: You may want
;  to make use of exercise 2.2.) In terms of your constructors and
;  selectors, create procedures that compute the perimeter and the area of a
;  given rectangle. Now implement a different representation for rectangles.
;  Can you design your system with suitable abstraction barriers, so that
;  the same perimeter and area procedures will work using either
;  representation?


;-----------------------------------------------------------------------------
; | Make a rectangle from two adjoining sides. This will be the canonical 
; representation.
(define (make-rect side1 side2)
  (if (> (length-segment side1) (length-segment side2))
      (cons side1 side2)
      (cons side2 side1)))

(define (long-rect x)
  (car x))

(define (short-rect x)
  (cdr x))


;-----------------------------------------------------------------------------
; | Make a rectangle from two opposite corners. This representation can use
; the same perimeter and area procedures as make-rect.
(define (make-rect1 pt1 pt2)
  (let ((side1 (make-segment pt1
                             (make-point (x-point pt1) (y-point pt2))))
        (side2 (make-segment (make-point (x-point pt1) (y-point pt2))
                             pt2)))
    (make-rect side1 side2)))


;-----------------------------------------------------------------------------
; | Get the height of a rectangle.
(define (height-rect x)
    (length-segment (short-rect x)))


;-----------------------------------------------------------------------------
; | Get the width of a rectangle.
(define (width-rect x)
  (length-segment (long-rect x)))


;-----------------------------------------------------------------------------
; | Get the perimeter of a rectangle.
(define (perimeter-rect x)
  (* 2 (+ (height-rect x) (width-rect x))))


;-----------------------------------------------------------------------------
; | Get the area of a rectangle.
(define (area-rect x)
  (* (height-rect x) (width-rect x)))


;-----------------------------------------------------------------------------
; | Show a point.
(define (show-point x)
  (newline)
  (display "(")
  (display (x-point x))
  (display ", ")
  (display (y-point x))
  (display ")"))


;-----------------------------------------------------------------------------
; | Compute whether two points are equal.
(define (points-equal? x y)
  (and (= (x-point x) (x-point y))
       (= (y-point x) (y-point y))))


;-----------------------------------------------------------------------------
; | Compute the average of two numbers.
(define (average x y)
  (/ (+ x y) 2))


;-----------------------------------------------------------------------------
; | Compute the square of a number.
(define (sq x)
  (* x x))


;-----------------------------------------------------------------------------
; | Construct a point and define selectors for the x and y values of a
; point.
(define (make-point x y)
  (cons x y))

(define (x-point x)
  (car x))

(define (y-point x)
  (cdr x))


;-----------------------------------------------------------------------------
; | Construct a line segment and define selectors for the start and end
; points of a line segment.
(define (make-segment x y)
  (cons x y))

(define (start-segment x)
  (car x))

(define (end-segment x)
  (cdr x))


;-----------------------------------------------------------------------------
; | Find the midpoint of a line segment.
(define (midpoint-segment x)
  (make-point (average (x-point (start-segment x))
                       (x-point (end-segment x)))
              (average (y-point (start-segment x))
                       (y-point (end-segment x)))))


;-----------------------------------------------------------------------------
; | Compute the length of a line segment.
(define (length-segment x)
  (sqrt (+ (sq (- (x-point (start-segment x))
                  (x-point (end-segment x))))
           (sq (- (y-point (start-segment x))
                  (y-point (end-segment x)))))))
