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
   (interleave
       (stream-map (lambda (x) (list (stream-car s) x))
                       t)
          (pairs (stream-cdr s) (stream-cdr t))))

;(stream-head (pairs integers integers) 1)
;interleavenの中のpairsが即時評価されて無限ループ
;cons-streamでdelayかけないとだめっぽい
