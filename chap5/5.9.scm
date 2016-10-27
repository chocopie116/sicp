(load "./machine")

;before
;(define (make-operation-exp exp machine labels operations)
;  (let ((op (lookup-prim (operation-exp-op exp) operations))
;        (aprocs
;          (map (lambda (e)
;                       (make-primitive-exp e machine labels))
;               (operation-exp-operands exp))))
;       (lambda ()
;               (apply op (map (lambda (p) (p)) aprocs)))))


;after
(define (make-operation-exp exp machine labels operations)
  (let ((op (lookup-prim (operation-exp-op exp) operations))
        (aprocs
          (map (lambda (e)
                       (if (label-exp? e)
                           (error "Operations can be used only with registers and constants -- ASSEMBLE" e)
                           (make-primitive-exp e machine labels)))
               (operation-exp-operands exp))))
       (lambda ()
               (apply op (map (lambda (p) (p)) aprocs)))))


(define some-machine
  (make-machine
   '()
   (list (list '= =))
   '(start
     (test (op =) (label start) (label start)))))

(start some-machine)
