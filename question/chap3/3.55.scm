(load "./utils/streams.scm")

(define ones (cons-stream 1 ones))

(define (add-streams s1 s2)
   (stream-map + s1 s2))


;引数としてストリームsをとり, S0, S0+S1, S0+S1+S2, S0+S1+S2+S3 ...となるpartial-sumsを定義せよ
(define (partial-sums s)
 (cons-stream
  (stream-car s)
  (add-streams (partial-sums s) (stream-cdr s))))

;1から1ずつ増えていくストリームの場合
(define integers (cons-stream 1 (add-streams ones integers)))

(print (stream-ref (partial-sums integers) 0));1
(print (stream-ref (partial-sums integers) 1));3
(print (stream-ref (partial-sums integers) 2));6
(print (stream-ref (partial-sums integers) 3));10
(print (stream-ref (partial-sums integers) 4));15
(print (stream-ref (partial-sums integers) 5));21
(print (stream-ref (partial-sums integers) 6));28

;違うストリームSを使うと
