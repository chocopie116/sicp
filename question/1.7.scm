;1つ目の問 平方根の計算で使ったgood-enough?テストは, 非常に小さい数の平方根をとる時には効果的ではない. また, 実際の計算機では, 算術演算は殆んどの場合, 限られた精度で実行される. それでわれわれのテストは非常に大きい数にも不適切である. 小さい数, 大きい数の場合, どのようにテストが失敗するかの例を使ってこのことを説明せよ.

;(define (good-enough? guess x)
;  (< (abs (- (square guess ) x)) 0.001))
;
;(define (square x) (* x x))

;(define (improve guess x)
;  (average guess (/ x guess)))


;good-enoughの実装が abs(X - guess ^ 2) < 0.001 の場合
    ;xが小さい数
        ;小さい数だといきなり#tになる
    ;xが大きい数
        ;大きい数だと相当な桁数を扱わないと0.001以下にならないため場合によっては無限ループ


;2つめの問 good-enough?を実装するもう一つの戦略は, ある繰返しから次へのguessの変化に注目し, 変化が予測値に比べ非常に小さくなった時に止めるのである. こういう終了テストを使う平方根手続きを設計せよ. これは小さい数, 大きい数に対してうまく働くか.




(define (sqrt-iter guess x)
  ;予測値が十分か?
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
               x)))

(define (improve guess x)
  (/ (+ guess (/ x guess)) 2))

(define (good-enough? guess x)
  (< (abs (- x (* guess guess))
       ) 0.001)
  )


;wrapper
(define (sqrt x) (sqrt-iter 1.0 x)) ;1.0は初期値

(print (sqrt 1))
(print (sqrt 0.000000001))

;極端に小さい数
(print (sqrt 1e-1000))

;極端に大きい数
(print (sqrt 1e100)) ;大きい数は無限ループ
