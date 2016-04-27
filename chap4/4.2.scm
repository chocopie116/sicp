(load "./eval.scm")
;a)

;louisは手続き作用のapplyをcondの前にもってきている
;(define x 3)では、本来であればdefinition?の節に入るはずが
;application?の節にはいってしまい、関数定義の動きをしてしまい
;結果関数の定義に必要な引数が足りないというエラーがでる
(define (louis-eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((application? exp)                            ;+ louis eval
         (apply (eval (operator exp) env)              ;+ louis eval
                (list-of-values (operands exp) env)))  ;+ louis eval
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ;((application? exp)                           ;- basic eval
        ; (apply (eval (operator exp) env)             ;- basic eval
        ;        (list-of-values (operands exp) env))) ;- basic eval
        (else
          (error "Unknown expression type -- EVAL" exp))))


;b)

(define (call? exp) (tagged-list exp 'call))


