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


(define (letrec? exp)
 (tagged-list? exp `letrec)
  )



(define (letrec->let exp)
  (let ((vars (map car (cadr exp)))
        (exps (map cdr (cadr exp)))
        (body (cddr exp)))
       (cons 'let
             (cons (map (lambda (x) (list x ''*unassigned*)) vars)
                   (append (map (lambda (x y) (cons 'set! (cons x y))) vars exps) body)
            )
        )
   )
)

(load "./evaluator.scm")
