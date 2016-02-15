;define
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;use
(print (new-if (= 2 3) 0 5))
(print (new-if (= 1 1) 2 3))

(print "---load---")
(load "../memo/1.1.7.scm")
(print "---load---")


;question/1.5.scmよりgauscheは作用的順序で評価される(operand, operatorを評価した後に、作用させる)
;標準のifのみ正規順序の評価がされる(operatorを先に評価し、operandoは値が必要になるまで評価しない)
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter(improve guess x)
            x)))

; 下記のスクリプトをたたくとレスポンスがない
; (print (sqrt 9))


;解説
;(define (sqrt-iter guess x)
;  (new-if (good-enough? guess x)
;          guess
;          (sqrt-iter(improve guess x) <- 先に引数をsqrt-iterを評価してしまい(無限ループしてしまう)
;            x)))


