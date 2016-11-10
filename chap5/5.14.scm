(load "./machine")

(define (make-stack)
  (let ((s '())
        (number-pushes 0)
        (max-depth 0)
        (current-depth 0))
    (define (push x)
      (set! s (cons x s))
      (set! number-pushes (+ 1 number-pushes))
      (set! current-depth (+ 1 current-depth))
      (set! max-depth (max current-depth max-depth)))
    (define (pop)
      (if (null? s)
          (error "Empty stack -- POP")
          (let ((top (car s)))
            (set! s (cdr s))
            (set! current-depth (- current-depth 1))
            top)))
    (define (initialize)
      (set! s '())
      (set! number-pushes 0)
      (set! max-depth 0)
      (set! current-depth 0)
      'done)
    (define (print-statistics)
      (newline)
      (display (list 'total-pushes  '= number-pushes
                     'maximum-depth '= max-depth)))
    (define (dispatch message)
      (cond ((eq? message 'push) push)
            ((eq? message 'pop) (pop))
            ((eq? message 'initialize) (initialize))
            ((eq? message 'print-statistics)
             (print-statistics))
            (else
             (error "Unknown request -- STACK" message))))
    dispatch))


(define fact-machine
  (make-machine
    '(continue val n)
    (list (list '= =) (list '- -) (list '* *))
    '(start
       (assign continue (label fact-done))
     fact-loop
       (test (op =) (reg n) (const 1))
       (branch (label base-case))
       ;;nとcontinueを退避し再帰呼出しを設定する.
       ;; 再帰呼出しから戻る時after-fact}から
       ;; 計算が続行するようにcontinueを設定
       (save continue)
       (save n)
       (assign n (op -) (reg n) (const 1))
       (assign continue (label after-fact))
       (goto (label fact-loop))
     after-fact
       (restore n)
       (restore continue)
       (assign val (op *) (reg n) (reg val))   ; valに n(n-1)!がある
       (goto (reg continue))                   ; 呼出し側に戻る
     base-case
       (assign val (const 1))                  ; 基底の場合: 1!=1
       (goto (reg continue))                   ; 呼出し側に戻る
    fact-done))
)

(define (fact n)
  ((fact-machine 'stack) 'initialize)
  (set-register-contents! fact-machine 'n n)
  (start fact-machine)
  (format #t "fact:~2d => ~8d" n (get-register-contents fact-machine 'val))
  ((fact-machine 'stack) 'print-statistics)
  (newline))

(fact 1)
;fact: 1 =>        1
;(total-pushes = 0 maximum-depth = 0)
(fact 2)
;fact: 2 =>        2
;(total-pushes = 2 maximum-depth = 2)
(fact 3)
;fact: 3 =>        6
;(total-pushes = 4 maximum-depth = 4)
(fact 4)
;fact: 4 =>       24
;(total-pushes = 6 maximum-depth = 6)
(fact 5)
;fact: 5 =>      120
;(total-pushes = 8 maximum-depth = 8)

;退避の数も、stackの深さも2n-2っぽい

