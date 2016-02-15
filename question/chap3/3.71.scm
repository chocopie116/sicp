;@see http://www.serendip.ws/archives/1712
(load "./utils/streams.scm")

(define (cube x)
 (* x x x))

(define (merge-weighted pairs1 pairs2 weight)
  (cond ((stream-null? (stream-car pairs1)) pairs2)
        ((stream-null? (stream-car pairs2)) pairs1)
        (else
          (let ((p1car (stream-car pairs1))
                (p2car (stream-car pairs2)))
            (if (< (weight p1car) (weight p2car))
              (cons-stream p1car (merge-weighted pairs2 (stream-cdr pairs1) weight))
              (cons-stream p2car (merge-weighted pairs1 (stream-cdr pairs2) weight)))))))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
      weight)))

;Ramanujan数 A^3 + B^3 = C^3 + D^3
(define (add-cube-pairs-weight pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (cube i) (cube j))))

(define st (weighted-pairs integers integers add-cube-pairs-weight))

(define (ramanujan s)
  (let ((s1car (stream-car s))
        (s2car (stream-car (stream-cdr s))))
    (let ((s1-weight (add-cube-pairs-weight s1car))
          (s2-weight (add-cube-pairs-weight s2car)))
      (if (= s1-weight s2-weight)
        (cons-stream s1-weight
                     (ramanujan (stream-cdr s)))
        (ramanujan (stream-cdr s))))))

(define ramanujan-stream (ramanujan st))

(stream-head ramanujan-stream 6)

