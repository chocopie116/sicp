(define (square x) (* x x))

(print (square 3))

(print (square (+ 3 5)))

(print (square (square 3)))


(define (sum-of-squares x y) (+ (square x) (square y)))

(print (sum-of-squares 3 10))


(define (f a) (sum-of-squares (+ a 1)(* a 2)))

(print (f 5))


