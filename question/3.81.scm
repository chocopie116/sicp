(load "./utils/streams.scm")

;以下を写経
;http://www.serendip.ws/archives/1797

(define (rand-update x)
  (+ x 1))

(define (rand input-stream random-init)
  (define random-stream
    (if (stream-null? input-stream)
      the-empty-stream
      (let ((request (stream-car input-stream)))
        (cons-stream
          (cond ((eq? request 'generate) (rand-update random-init))
                ((number? request) (rand-update request))
                (else (error "Unknown request --- RAND" request)))
          (rand (stream-cdr input-stream) (stream-car random-stream))))))
  random-stream)

;数字はresetを示している
(define request-stream
  (cons-stream 100
               (cons-stream 'generate
                            (cons-stream 'generate
                                         (cons-stream 100
                                                      (cons-stream 'generate
                                                                   (cons-stream 'generate
                                                                                the-empty-stream)))))))

(stream-head (rand request-stream 0) 6)
