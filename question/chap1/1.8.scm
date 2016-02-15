;呼び出し
(define (cubic-root x)
  (cubic-root-iter 1.0 x)
)

;繰り返し計算
(define (cubic-root-iter guess x)
  (if (good-enough? guess x)
    guess
    (cubic-root-iter (improve guess x) x)
  )
)

;評価
(define (good-enough? guess x)
  (< (abs(- x (* guess guess guess))) 0.001)
)

;改善
;近似値の計算式 guessがxの平方根の近似値ならば
(define (improve guess x)
  (/
    (+ (/ x (* guess guess)) (* 2 guess))
     3
  )
)

(print (cubic-root 8))
(print (cubic-root 27))
(print (cubic-root 64))
(print (cubic-root 125))


