(load "./utils/streams.scm")

;積分関数
(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

;;回路をモデル化する手続きRC
;;コンデンサの部分の抵抗
;
;;回路の定義を返す
(define (make-circuit r c dt)
  (lambda (i v0)
    (add-streams
      (scale-stream i r)
      (integral
        (scale-stream i (/ 1.0 c)) v0 dt))
    )
  )

(define rc1 ((make-circuit 5 1 0.5) integers 1))

(stream-head rc1 10)


