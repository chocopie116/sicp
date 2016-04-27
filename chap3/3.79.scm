(load "./utils/streams.scm")

;3.78で

;回路のストリームyを図中のyとdyとdyyについて、それぞれ以下のように定義する

(define (solve-2nd f y0 dy0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (stream-map f dy y))
  y)

(define (integral delayed-integrand initial-value dt)
  (cons-stream initial-value
               (let ((integrand (force delayed-integrand)))
                 (if (stream-null? integrand)
                   the-empty-stream
                   (integral (delay (stream-cdr integrand))
                             (+ (* dt (stream-car integrand))
                                initial-value)
                             dt)))
               ))


(define (func dy y)
  (+ (* dy 1) (* y 2))
  )

(stream-head (solve-2nd func 1 1 0.001) 10)

