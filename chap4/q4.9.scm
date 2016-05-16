; こんな感じで実装してみる
;; M-Eval input:
;(define i 0)
;
;;;; M-Eval value:
;ok
;;;; M-Eval input:
;(while (< i 10)
;(set! i (+ i 1))
;(display i))

(load "./eval.scm")

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((and? exp) (eval-and exp env))
        ((or? exp) (eval-or exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
          (make-procedure (lambda-parameters exp) (lambda-body exp) env))
        ((begin? exp)
          (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((let? exp) (eval (let->derived exp) env))
        ((let*? exp) (eval (let*->nested-lets exp) env))
        ((while? exp) (eval (while->derived exp) env))
        ((application? exp)
          (apply-new (eval (operator exp) env)
                 (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp)))
  )


(define (while? exp) (tagged-list? exp `while))
(define (while-condition exp) (cadr exp))
(define (while-body exp) (cddr exp))

(define (while->derived exp)
  (let ((condition (while-condition exp))
        (body (while-body exp)))
    (list `let `while-loop `()
          (make-if condition
                   (append (cons `begin body)
                           (list (cons `while-loop `())))
                   `true))
    )
  )

(load "./evaluator.scm")

;実行結果
;;;; M-Eval input:
;(define i 0)
;
;(while (< i 10)
;(set! i (+ i 1))
;(display i))
;
;
;;;; M-Eval value:
;ok
;
;;;; M-Eval input:
;12345678910
;;;; M-Eval value:
;#t
