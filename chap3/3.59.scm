(load "./utils/streams.scm")

(define ones (cons-stream 1 ones))

(define (add-streams s1 s2)
   (stream-map + s1 s2))

(define (devide-streams s1 s2)
  (stream-map / s1 s2))

(define (devide-streams s1 s2)
  (stream-map / s1 s2))


(define natural_number (cons-stream 1 (add-streams ones natural_number)))

(define twos (cons-stream 2 twos))

(define integrate-series(devide-streams ones natural_number))
(stream-head integrate-series 5)


;(define integrate-series(devide-streams twos natural_number))
;(stream-head integrate-series 5)

