(load "./utils/streams.scm")

(define (sqrt-improve guess x)
 (average guess (/ x guess)))


(define (sqrt-stream x)
 (define guesses
   (cons-stream 1.0
                (stream-map (lambda (guess)
                                    (sqrt-improve guess x))
                            guesses)))
 guesses)


(define (sqrt-stream2 x)
 (cons-stream 1.0
              (stream-map (lambda (guess)
                                  (sqrt-improve guess x))
                          (sqrt-stream2 x))))


(define (average x y)
(print 'once)
 (/ (+ x y) 2))

;= Answer ===============================================================================

;streamを一度計算しているのでメモ化される
(print 'sqrt-stream-faster)
(stream-head (sqrt-stream 5) 5)

(print '-----------------)
;streamに対して計算するのではなく、sqrt-stream2が呼ばれるだけ
(print 'sqrt-stream-slower)
(stream-head (sqrt-stream2 5) 5)

