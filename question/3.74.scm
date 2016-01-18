
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

;;確認
;;出力が0
;(print (sign-change-detector 0 0))
;(print (sign-change-detector 1 1))
;(print (sign-change-detector -2 -2))
;
;;出力が1
;(print (sign-change-detector 0 1));koko
;(print (sign-change-detector -1 0))
;(print (sign-change-detector -1 1))
;
;;出力が-1
;(print (sign-change-detector 0 -1));koko
;(print (sign-change-detector 1 0))
;(print (sign-change-detector 1 -1))
