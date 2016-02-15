(load "./utils/streams.scm")

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))
(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams
                 (scale-stream (stream-cdr s2) (stream-car s1))
                 (mul-series s2 (stream-cdr s1))
                 )
               ))

(define (invert-unit-series s1)
  (cons-stream 1 (mul-series (scale-stream (stream-cdr s1) -1)
                             (invert-unit-series s1)
                             )))


(define inverse-ones (invert-unit-series ones))

(stream-head (mul-series ones ones) 10)

(define (div-series s1 s2)
  (mul-series s1 (invert-unit-series s2)))
