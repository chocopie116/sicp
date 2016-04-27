;(load "./eval.scm")
;
;(define (cond-allow? clauses)
; (tagged-list? (cadr clause) `=>)
;)
;
;(define (eval-recipient clause)
; (let
;  (ret (eval (car clause)))
;  (if ret (eval (caddr clause) ret))
;  )
; )
;
;(define (cond-predicate clause)
; (if (cond-recipient? clause)
;  (eval-recipient clause)
;  (car clause)))
;
;(define (eval exp env)
;  (print `ok)
;  (cond ((self-evaluating? exp) exp)
;        ((variable? exp) (lookup-variable-value exp env))
;        ((quoted? exp) (text-of-quotation exp))
;        ((assignment? exp) (eval-assignment exp env))
;        ((definition? exp) (eval-definition exp env))
;        ((if? exp) (eval-if exp env))
;        ((lambda? exp)
;         (make-procedure (lambda-parameters exp)
;                         (lambda-body exp)
;                         env))
;        ((begin? exp)
;         (eval-sequence (begin-actions exp) env))
;        ((cond? exp) (eval (cond->if exp) env))
;        ((application? exp)
;         (apply (eval (operator exp) env)
;                (list-of-values (operands exp) env)))
;        (else
;          (error "Unknown expression type -- EVAL" exp))))
;
;
;;exec
;;(print (eval (list 'cond (`#t) (`#f)) interaction-environment)) ;#f
;
;
;(print (eval (list `b 2) interaction-environment))
;;(print (cond ((assoc 'b '((a 1) (b 2))) => cadr) (else false)))
;;(list `cond (list (`assoc 'b '((a 1) (b 2))) `=> `cadr) (else #f))
;
;;(cond ((assoc 'b '((a 1) (b 2))) => cadr) (else false))
;; -> (list `cond ((assoc 'b '((a 1) (b 2))) => cadr) (else #f))
;; ----> (list `cond ((assoc 'b '((a 1) (b 2))) => cadr) (else false))
;
;;(eval (list 'cond (`assoc `b ((`a 1) (`b 2)) => cadr))) ;#f
