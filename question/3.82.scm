(use srfi-27)
(load "./utils/streams.scm")

;問題3.5をstreamを使ってかきかえよ

(define (random x)
  ; (random-integer x))
  (* (random-real) x))
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))


(define (random-in-range-stream low high)
  (stream-map
    (lambda (x) (random-in-range low high))
    ones))


(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
      (/ passed (+ passed failed))
      (monte-carlo
        (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
    (next (+ passed 1) failed)
    (next passed (+ failed 1))
    )
  )

(define (estimate-integral pred x1 x2 y1 y2)
  (define x-stream (random-in-range-stream x1 x2))
  (define y-stream (random-in-range-stream y1 y2))
  (stream-map
    (lambda (p)
      (* (* (- x2 x1) (- y2 y1)) p))
    (monte-carlo
      (stream-map pred x-stream y-stream) 0 0)))

(define (point-in-circle? x y cx cy r)
   (<= (+ (square (- x cx)) (square (- y cy))) (square r)))

(define (test-check x y)
   (point-in-circle? x y 5.0 7.0 3.0))

(stream-head (estimate-integral test-check 2.0 8.0 4.0 10.0) 1000)
