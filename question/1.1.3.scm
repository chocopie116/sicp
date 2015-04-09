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
