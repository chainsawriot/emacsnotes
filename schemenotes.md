# Racket

* define a struct also define a predicate (structname?) to check for the struct

```scheme
(struct student (name id# dorm) #:transparent)
(define sophomore3 (student 'David 100234 'PG))
(student? sophomore3)
```

* equality predicates (such as boolean=?, string=?) can generally be replaced by equal?

```scheme
(boolean=? #f #f)
(equal? #f #f)
```


