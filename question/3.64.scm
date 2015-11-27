(load "./utils/streams.scm")

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)


;問題
(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

;答え
(define (stream-limit s tolerance)
  (if
    (<
      (abs
        (- (stream-car s) (stream-car (stream-cdr s)))
        )
      tolerance)
    (stream-car (stream-cdr s))
    (stream-limit (stream-cdr s) tolerance)
    )
  )

(print (sqrt 3 0.01))
;1.7320508100147274
