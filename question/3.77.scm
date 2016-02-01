(load "./utils/streams.scm")

;元々定義してあったintegral
;(define (integral delayed-integrand initial-value dt)
;  (define int
;    (cons-stream initial-value
;                 (let ((integrand (force delayed-integrand)))
;                   (add-streams (scale-stream integrand dt)
;                                int))))
;  int)

;問題文のintegralがオカシイので修正せよ
;与えられた式
;そのまま実行すると、delayのintegrandが渡されるためそれをforceする必要がある
;(define (integral integrand initial-value dt)
;  (cons-stream initial-value
;               (if (stream-null? integrand)
;                 the-empty-stream
;                 (integral (stream-cdr integrand)
;                           (+ (* dt (stream-car integrand))
;                              initial-value)
;                           dt))))

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

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)



(stream-head(solve (lambda (y) y) 1 0.001) 10)


