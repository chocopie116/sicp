(load "./utils/streams.scm")

(define the-empty-stream '())

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

;1-20までaccumしたものをseqとする
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
;(display-stream seq)
; 1 3 6 10 15...

;偶数のみfilterしたものをyとする
(define y (stream-filter even? seq))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))

;---------
(print (stream-ref y 7))
;---------

;with memo-proc
;136

;without memo-proc (utils/streamsをコメントアウト)
;162

;---------
(display-stream z)
;---------

;with memo-proc
;10
;15
;45
;55
;105
;120
;190
;210

;without memo-proc (utils/streamsをコメントアウト)
;15
;180
;230
;305
