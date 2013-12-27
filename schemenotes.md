# Racket

* define a struct also define a predicate (structname?) to check for the struct
```scheme
(struct student (name id# dorm) #:transparent)
(define sophomore3 (student 'David 100234 'PG))
(student? sophomore3)
```
