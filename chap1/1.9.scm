;pattern 1
(define (+ a b)
  (if (= a 0)
    b
    (inc (+ (dec a) b))))

;pattern 2
(define (+ a b)
  (if (= a 0)
    b
    (+ (dec (+ a 3)) (inc b))))


;(+ 4 5)
;pattern 1の場合
;=> (inc (+ (dec 4) 5))
;=> (inc (+ 3 5)) ->loop
;再帰的プロセス(線形再帰的プロセス)
;incの計算ができずにどんどんネストしていく中身を解決していく必要がある

;(+ 4 5)
;pattern 2の場合
;(+ (dec 4) (inc 5))
;=> (+ 3 6) -> loop
;反復的プロセス (線形反復的プロセス)

