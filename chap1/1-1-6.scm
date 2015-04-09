(print 10)
(print (+ 5 3 4))
(print (- 9 1))
(print (/ 6 2))
(print (+ (* 2 4) (- 4 6)))
(print (define a 3))
(print (define b (+ a 1)))
(print (+ a b (* a b)))
(print (= a b))
(print (
        if (
            and (> b a )(< b (* a b))
            )
        b a
        )
)

(print (
        cond ((= a 4) 6)
        ((= b 4) (+ 6 7 a))
        (else 25)
        )
       )


(print (+ 2 (if (> b a) b a)))

(print(* (cond ((> a b) a )
               ((< a b) b)
         (else -1)
         )
         (+ a 1)
  )
)

;question1.2
(print
  (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
    (* 3 (- 6 2)(- 2 7))
  )
)


;question1.3
(define (square x) (* x x))
(define (sum-square x y ) (+ (square x) (square y)))
(define (filter-smallest x y z)(if (> x y)
                                 (sum-square x (if (> y z) y z))
                                 (sum-square y (if (> x z) x z)))
)

(print (filter-smallest 1 2 3))
(print (filter-smallest 3 1 2))
(print (filter-smallest 4 1 2))
(print (filter-smallest 1 2 4))
(print (filter-smallest 2 2 1))
(print (filter-smallest 1 1 1))
(print (filter-smallest 1 2 1))
