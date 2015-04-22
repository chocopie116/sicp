; xの平方根をもとめる手続き
(define (sqrt-iter guess x)
  ;予測値が十分か？
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
               x)
    ))

; 予測値の精度を改善する
(define (improve guess x)
  (average guess (/ x guess)))

;平均を出す
(define (average x y)
  (/ (+ x y) 2))

; abs((平方根の予測値)^2 - x) < 0.001で十分な精度かどうか
(define (good-enough? guess x)
  (< (abs (- (square guess ) x)) 0.001))

; wrapper
(define (sqrt x) (sqrt-iter 1.0 x))


; use
(print (sqrt 9))
(print (sqrt (+ 100 37)))
(print (square (sqrt 1000)))
