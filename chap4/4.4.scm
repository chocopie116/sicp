(load "./eval.scm")

(define (and? exp)
 (tagged-list? exp `and)
 )

(define (eval-and exp env)
  (define (itr-and exp)
    (cond ((null? exp) #t)
          ((not (car exp)) #f)
          (else (eval-and (cdr exp) env))
          )
    )
  (itr-and exp)
  )

(define (or? exp)
 (tagged-list? exp `or)
 )

 (define (eval-or exp env)
   (define (itr-or exp)
     (cond ((null? exp) #f)
           ((car exp) #t)
           (else (eval-or (cdr exp) env))
           )
     )
   (itr-or exp)
   )


(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((and? exp) (eval-and (cdr exp) env))
        ((or? exp) (eval-or (cdr exp) env))
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))


;assertion
(print (eval (list 'or  (> 1 2) (> 1 2)) (interaction-environment))) ;#f
(print (eval (list 'or  (< 1 2) (> 1 2)) (interaction-environment))) ;#t

(print (eval (list 'and (< 1 2) (< 1 2)) (interaction-environment))) ;#t
(print (eval (list 'and (< 1 2) (> 1 2)) (interaction-environment))) ;#f


