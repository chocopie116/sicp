;@see http://www.serendip.ws/archives/1808
(define val 10)
(define expression '((set! val (+ val 2)) (set! val (* val 2))))

(define no-operands? null?)
(define first-operand car)
(define rest-operands cdr)

;; 被演算子を左から右へ評価する list-of-values
;(define (list-of-values exps env)
;  (if (no-operands? exps)
;    '()
;    (let ((first-eval (eval (first-operand exps) env)))
;      (cons first-eval
;            (list-of-values (rest-operands exps) env)))))
;(print (list-of-values expression interaction-environment))
;=> (12 24)


; 被演算子を右から左へ評価する list-of-values
;(define (list-of-values exps env)
;  (if (no-operands? exps)
;    '()
;    (let ((first-eval (list-of-values (rest-operands exps) env)))
;      (cons (eval (first-operand exps) env)
;            first-eval))))
;(print (list-of-values expression interaction-environment))
;=> (22 20)
