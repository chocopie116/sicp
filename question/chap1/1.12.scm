;n段の左からk列の要素(n, k)を求める
; 数字が1に確定するまで再起をする
; (1, 1) -> 1
; (2, 1) -> 1
; (3, 1) -> 1
; (2, 2) -> 1
; (3, 3) -> 1
(define (pascal-triangle n k)
  (if (or (= k 1) (= k n))
    1
    (+ (pascal-triangle(- n 1) (- k 1))
       (pascal-triangle(- n 1) k)
     )
   )
  )

(print (pascal-triangle 3 2))
(print (pascal-triangle 5 3))
