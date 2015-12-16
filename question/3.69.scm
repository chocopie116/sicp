(load "./utils/streams.scm")

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define (stream-append s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (stream-append (stream-cdr s1) s2))))

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

(define (triples s t u)
  (cons-stream
    (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
      (stream-map (lambda (x) (cons (stream-car s) x))
                  (pairs t (stream-cdr u)))
      (triples (stream-cdr s) (stream-cdr t) (stream-cdr u))
      )
    )
  )

(define (square x)
  (* x x)
  )

(define pythagoras (stream-filter (lambda (x)
                                    (= (+ (square (car x)) (square (cadr x))) (square (caddr x)))
                                    )
                                  (triples integers integers integers))
  )

(stream-head (triples integers integers integers) 10)
(stream-head pythagoras 3)
