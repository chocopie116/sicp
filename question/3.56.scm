(load "./utils/streams.scm")


(define (add-streams s1 s2)
   (stream-map + s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream s2car (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream s1car
                               (merge (stream-cdr s1)
                                      (stream-cdr s2)))))))))
;--------------------
;mergeの動作テスト
;--------------------
;2こ飛ばす
(define step-by-two (cons-stream 2 step-by-two))
;奇数の無限ストリーム
(define even (cons-stream 1 (add-streams step-by-two even)))
;偶数の無限ストリーム
(define odd (cons-stream 2 (add-streams step-by-two odd)))

;奇数と偶数をmergeした無限ストリーム
(define merged-odd-even (merge even odd))

;(stream-print merged)
;1,2,3,4,5,6,7,8,
(print (stream-ref merged-odd-even 0));1
(print (stream-ref merged-odd-even 2));3
(print (stream-ref merged-odd-even 3));4
;--------------------
;mergeの動作テスト
;--------------------

