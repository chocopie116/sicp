(load "./utils/streams.scm")

(define (square x)
  (* x x))

(define (merge-weighted pairs1 pairs2 weight)
  (cond ((stream-null? (stream-car pairs1)) pairs2)
        ((stream-null? (stream-car pairs2)) pairs1)
        (else
          (let ((p1car (stream-car pairs1))
                (p2car (stream-car pairs2)))
            (if (< (weight p1car) (weight p2car))
              (cons-stream p1car (merge-weighted pairs2 (stream-cdr pairs1) weight))
              (cons-stream p2car (merge-weighted pairs1 (stream-cdr pairs2) weight)))))))

(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
      weight)))

(define (add-square-pairs-weight pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (square i) (square j))))

;平方数のペアの無限ストリームを作成
(define st (weighted-pairs integers integers add-square-pairs-weight))

;平方数の和が同じペアの3通りあるもの
;a^2+b^2 = c^2 + d^2 = e^2 + f^2
(define (filter-sum-of-squares-stream s)
  (let ((pair1 (stream-car s))
        (pair2 (stream-car (stream-cdr s)))
        (pair3 (stream-car (stream-cdr (stream-cdr s)))))
    (let ((s1-weight (add-square-pairs-weight pair1))
          (s2-weight (add-square-pairs-weight pair2))
          (s3-weight (add-square-pairs-weight pair3)))
      (if (= s1-weight s2-weight s3-weight)
        (cons-stream s1-weight
                     (filter-sum-of-squares-stream (stream-cdr s)))
        (filter-sum-of-squares-stream (stream-cdr s))))))


(define sum-of-squares-stream (filter-sum-of-squares-stream st))

(stream-head sum-of-squares-stream 10)
