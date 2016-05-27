(load "./eval.scm")

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((unbind? exp) (eval-unbind exp env))
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


(define (unbind? exp) (tagged-list? exp `unbind))

(define (eval-unbind exp env)
   (unbind-variable! (cadr exp) env)
 )

;vars (x, y, z) vals (1, 2, 3)について考える
(define (unbind-variable! var env)
  (let ((frame (first-frame env)))
    (define (scan var vars vals)
      (cond ((eq? var (car vars))
             (set-car! vars (cdr vars))   ; vars (y, y, z)
             (set-cdr! vars (caddr vars)) ; vars (y, z)
             (set-car! vals (cdr vals))   ; vals (2, 2, 3)
             (set-cdr! vals (caddr vals)) ; vals (2, 3)
             )
            (else (scan var (cdr vars) (cdr vals)))
            ))
    (scan var (car frame) (cdr frame))
    )
  )

(load "./evaluator.scm")
