(load "./utils/streams.scm")

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

;;;;;;;;;;;;;;;;;;;;;;;;;
; 問題
; 3.74の信号検出がノイズ(last-value value)が多いので、ノイズを除去するように計算する
;;;;;;;;;;;;;;;;;;;;;;;;;

;バグがあるversion
;(define (make-zero-crossings input-stream last-value last-avt)
;  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
;    (cons-stream (sign-change-detector avpt last-value)
;                 (make-zero-crossings (stream-cdr input-stream)
;                                      avpt))))


;バグがないversion
;input-streamの前回の補正値(last-avpt)も渡すようにする
(define (make-zero-crossings input-stream last-value last-avpt)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
    (cons-stream (sign-change-detector avpt last-avpt)
                 (make-zero-crossings (stream-cdr input-stream)
                                      (stream-car input-stream) avpt))))
