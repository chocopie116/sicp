;kaijo
(define 10-kaijo ((lambda (n)
   ((lambda (fact)
      (fact fact n))
    (lambda (ft k)
      (if (= k 1)
          1
          (* k (ft ft (- k 1))))
      )
  ))
 10)
)
(print 10-kaijo)

;fibonacci
(print
  ((lambda (n)
     ((lambda (fib)
        (fib fib n))
      (lambda (fb k)
        (cond ((= k 0) 0)
              ((= k 1) 1)
              (else
                (+ (fb fb (- k 1))
                   (fb fb (- k 2))))))))
   10))


;与えられた数値が偶数かどうかをdefineを使わずにlambdaを使った表現
(define (f x)
  ((lambda (even? odd?)
           (even? even? odd? x))
   (lambda (ev? od? n)
           (if (= n 0) #t (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
           (if (= n 0) #f (ev? ev? od? (- n 1))))))


