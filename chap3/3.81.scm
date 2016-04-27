(load "./utils/streams.scm")

;以下を写経
;http://www.serendip.ws/archives/1797

(define (rand-update x)
  (+ x 1))

;request-stream 乱数に対する操作の命令のストリーム
;random-init generate(rand-updateの引数)する元の値
(define (rand request-stream random-init)
  (define random-stream
    (if (stream-null? request-stream)
      the-empty-stream
      (let ((request (stream-car request-stream)))
        (cons-stream
          (cond ((eq? request 'generate) (rand-update random-init))
                ((number? request) (rand-update request))
                (else (error "Unknown request --- RAND" request)))
          (rand (stream-cdr request-stream) (stream-car random-stream))))))
  random-stream)

;数字は与えられた数字でリセットせよという意味を示している
(define request-stream
  (cons-stream 20
               (cons-stream 'generate
                            (cons-stream 'generate
                                         (cons-stream 1
                                                      (cons-stream 'generate
                                                                   (cons-stream 'generate
                                                                                the-empty-stream)))))))


(stream-head (rand request-stream 0) 6)
