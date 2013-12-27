# Racket's special forms

1. define
2. if


# Racket's conditionals

* define a struct also define a predicate (structname?) to check for
  the struct type

```scheme
(struct student (name id# dorm) #:transparent)
(define sophomore3 (student 'David 100234 'PG))
(student? sophomore3)
```

* equality predicates (such as _boolean=?_, _string=?_) can generally be
  replaced by _equal?_ Use type-specific predicates just to specify the
  type of argument required for a function.

```scheme
(boolean=? #f #f)
(equal? #f #f)
```

* The difference between _equal?_ and _eq?_ for struct is: equal? check for the
  structural equality but eq? check for the equality in memory
  location / same call of the constructor function. (instance
  equality) Structural equality for opaque struct is only mereinstance identity
  Ref: Racket Guide 5.5

```scheme
(struct point (x y) #:transparent)
(define pt1 (point 1 2))
(define pt2 (point 1 2))
(equal? pt1 pt2)
(eq? pt1 pt2)
(define pt3 pt1)
(eq? pt3 pt1)

(struct point-opaque (x y)) ; opaque struct
(define pt4 (point-opaque 1 2))
(define pt5 (point-opaque 1 2))
(equal? pt4 pt5) ; same function as eq?
```

* For _if_ , 0 and empty are also counted as #t. The only thing
  that is counted as #f is #f only.

```scheme
(if '(0) 'yes 'no)
(if empty 'yes 'no)
(if (member 4 (list 3 4 1 5)) '4-is-in 'not-in) ; member is not a predicate
```

* Racket's _cond_ use square bracket

```scheme
(define x 10)
(cond [(= x 13) 'unlucky]
	  [(odd? x) 'odd]
	  [else 'even])
```

* _when_ is _if_ without else statement. _unless_ is the opposite of
  _when_


