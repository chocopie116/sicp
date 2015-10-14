(load "./utils/streams.scm")

(define ones (cons-stream 1 ones))

(define (add-streams s1 s2)
   (stream-map + s1 s2))

;mul-streamを定義せよ
(define (mul-streams s1 s2)
   (stream-map * s1 s2))

;n番目の n+1の階乗になるストリームを定義せよ

(define integers (cons-stream 2 (add-streams ones integers)));2からはじまると都合がよさそう

(define factorials (cons-stream 1 (mul-streams factorials integers)))

(print (stream-ref factorials 0)) ;1
(print (stream-ref factorials 1)) ;2
(print (stream-ref factorials 2)) ;6
(print (stream-ref factorials 3)) ;24
(print (stream-ref factorials 4)) ;120
(print (stream-ref factorials 5)) ;720








