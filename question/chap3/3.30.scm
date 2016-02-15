(define (full-adder a b c-in sum c-out)
  (let (
        (s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire))
        )
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))



(define (half-adder a b s c)
  (let (
        (d (make-wire))
        (e (make-wire))
        )
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))





;ripple-carry-adderでみたとき、計に追加されるものは、wireのリストのA, B, SとC-in, C-out
(define (ripple-carry-adder list-a list-b list-sum c-out)
  (define (iter list-a list-b list-sum c-in)
    (if (not (null? list-a))
      (let ((c-out (make-wire)))
        (full-adder (car list-a) (car list-b) c-in (car list-sum) c-out)
        (iter (cdr list-a) (cdr list-b) (cdr list-sum) c-out))
      'ok))
  (iter list-a list-b list-sum c-out))

