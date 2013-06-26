;-----------------------------------------------------------------------------
; | Exercise 2.2
;
; Consider the problem of representing line segments in a plane. Each
; segment is represented as a pair of points: a starting point and an ending
; point. Define a constructor make-segment and selectors start-segment and
; end-segment that define the representation of segments in terms of points.
; Furthermore, a point can be represented as a pair of numbers: the x
; coordinate and the y coordinate. Accordingly, specify a constructor
; make-point and selectors x-point and y-point that define this
; representation. Finally, using your selectors and constructors, define a
; procedure midpoint-segment that takes a line segment as argument and
; returns its midpoint (the point whose coordinates are the average of the
; coordinates of the endpoints). To try your procedures, you'll need a way
; to print points:


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
; | Compute the average of two numbers.
(define (average x y)
  (/ (+ x y) 2))


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

