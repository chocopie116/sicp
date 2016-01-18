(load "./utils/streams.scm")

;3.75のやり方はうまくない(make-zer-crossingの中で値を補正する)ので
;実際に観測データ(input-stream)を補正するsmoothで書き直す


(define (smooth st)
  (cons-stream
    (/ (+ (stream-car st) (stream-car (stream-cdr st))) 2)
    (smooth (stream-cdr st))
    )
  )

;streamの値を取得して、それらを連続する2つの値で平均をとったstreamに変換する処理
;(define test (smooth integers))
;(stream-head test 10)

;3/2, 5/2, 7/2, 9/2, 11/2, 13/2, 15/2, 17/2, 19/2, 21/2,


;last-valueとvalueの2つの引数をとって、0か+1か-1を返す手続き
;これは引数として二つの値をとり, それらの値の符号を比較し, 適切な0, 1または-1を生じる.
(define (sign-change-detector last-value value)
 (cond ((= last-value value) 0)
        ((> last-value 0) -1)
        ((< last-value 0) 1)
        ((< last-value value) 1)
        ((> last-value value) -1)
      )
 )



;Alyssiaさんのを修正
;3.74を
(define sense-data
   (stream-map (lambda (x) (sin x)) integers))

(define (make-zero-crossings input-stream last-value)
   (cons-stream
       (sign-change-detector (stream-car input-stream) last-value)
          (make-zero-crossings (stream-cdr input-stream)
                                   (stream-car input-stream))))

;Alyssa
;sense-dataからnoiseを取得するだけ
(define removed-noise-input-stream (smooth sense-data))

(define zero-crossings
  (stream-map sign-change-detector removed-noise-input-stream (cons-stream 0 removed-noise-input-stream))
  )

(stream-head zero-crossings 10)
