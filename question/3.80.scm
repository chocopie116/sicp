(load "./utils/streams.scm")

;3.78で

;回路のストリームyを図中のyとdyとdyyについて、それぞれ以下のように定義する

;(define (solve-2nd f y0 dy0 dt)
;  (define y (integral (delay dy) y0 dt))
;  (define dy (integral (delay ddy) dy0 dt))
;  (define ddy (stream-map f dy y))
;  y)
(define (solve R L C vc0 il0 dt)
  (define vc (integral (delay dvc) vc0 dt))
  (define il (integral (delay dil) il0 dt))
  (define dvc (scale-stream il (/ -1 C)))
  (define dil (add-streams
                (scale-stream vc (/ 1 L))
                (scale-stream il (/ (* -1 R) L))))
  (cons il vc))


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

;R=1オーム, C=0.2ファラド, L=1ヘンリ, dt=0.1秒, 初期値iL0=0アンペア, vC0=10
(stream-head (car (solve 1 1 0.2 10 0 0.1)) 10)
(newline)
(stream-head (cdr (solve 1 1 0.2 10 0 0.1)) 10)

