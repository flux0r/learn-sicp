;-----------------------------------------------------------------------------
; | Exercise 2.16
;
; Explain, in general, why equivalent algebraic expressions may lead to diff-
; erent answers. Can you devise an interval-arithmetic package that does not
; have this shortcoming, or is this task impossible.

; This interval system does not actually represent an algebraic structure,
; since it has no neutral element. It is close and so will typically produce
; reasonable answers, but to get something that is exact would require symbol-
; ic manipulation of some sort rather than direct manipulation of inexact num-
; erical representations by machine.
