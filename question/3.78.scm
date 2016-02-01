(load "./utils/streams.scm")

;3.77を元にすすめてみる

;回路のストリームyを図中のyとdyとdyyについて、それぞれ以下のように定義する

(define (solve-2nd a b y0 dy0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (add-streams (scale-stream dy a) (scale-stream y b)))
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

(stream-head(solve-2nd  1 0 1 1 0.001) 10)
