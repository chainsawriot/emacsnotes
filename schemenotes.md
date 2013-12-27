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

* _when_ is _if_ without else statement. _unless_ is opposite of
  _when_

