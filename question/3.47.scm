;相互排除器
(define (make-mutex)
  (let ((cell (list 0)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
               (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))

;
(define (clear! cell)
    (set-car! cell (- (car cell) 1)))

(define (test-and-set! cell)
  (if (> (car cell)  3)
    #t
    (begin (set-car! cell (+ (car cell) 1))
           #f)))

(define mutex (make-mutex))

(print (mutex 'acquire))
(print (mutex 'acquire))
(print (mutex 'acquire))
(print (mutex 'acquire))
(print (mutex 'acquire))

;#<undef>
;#<undef>
;#<undef>
;#<undef>
