(define (A x y) (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
             (A x (- y  1))))))


;(A 1 10)の場合
;(else (A (- x 1)
;       (A x (- y 1))))
;-> (else (A (- 1 1)
;       (A 1 (- 10 1))))
;-> (else (A (0) (A 1 9)))
;-> (else (A 0 (A 1 9))) ; (A 1 9) loop
;
;A(1 9)
;else (A (- 1 1)
;       (A 1 (- 9 1)))
;-> else (A (0) (A 1 8)) ; (A 1 8)がloop
;
;A(1 8)
;else (A (- 1 1)
;       (A 1 (7))); (A 1 7)がloop
;
;
;つまり
; A( 1 10)
; -> (A (1 (A 1 9)))
; -> (A (1 (A  (1 (A 1 8)))))
; -> (A (1 (A  (1 (A 1 (A 1 7))))))
; (A 1 x)は繰り返すと2になる
; 2^10に値がなる

(print (A 1 10)) ;1024

(print (A 2 4)) ;65536
; (A 2 4)
; (A 1 (A 2 3))
; (A 1 (A 1 (A 1 2)))
; (A 1 (A 1 (A 1 (A 1 1))))

(print (A 3 3)) ;65536

;(define (f n) (A 0 n))
;(define (g n) (A 1 n))
;(define (h n) (A 2 n))
;(define (k n) (* 5 n n))


(define (f n) (A 0 n)) ;f は2n 
(define (g n) (A 1 n)) ;g は2^n
(define (h n) (A 2 n)) ;h は
(define (k n) (* 5 n n)) ;k は5n^2を計算


