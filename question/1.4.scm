(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b)
  )

; b > 0の場合
; a + bで
; 12
(print (a-plus-abs-b 2 10))

; b < 0の場合
; a - bで
; 4
(print (a-plus-abs-b 3 -1))
