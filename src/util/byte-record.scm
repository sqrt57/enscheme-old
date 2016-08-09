#!r7rs
(define-library (util byte-record)
(export define-byte-record)
(import (scheme base)
        (scheme write))

(begin
  (define-syntax define-byte-record
    (syntax-rules ()
      ((_ type create predicate in-fields ...)
       (define-byte-record-collect
         type
         create
         predicate
         private-create-result
         0
         ()
         ()
         ()
         (in-fields ...)))))

  (define-syntax define-byte-record-collect
    (syntax-rules ()
      ((_ type
          create
          predicate
          private-create-result
          offset
          (rec-fr ...)
          (def-fr ...)
          (init-fr ...)
          ())
       (define-byte-record-reverse
         type
         create
         predicate
         private-create-result
         offset
         (rec-fr ...)
         (def-fr ...)
         (init-fr ...)
         ()
         ()
         ()))
      ((_ type
          create
          predicate
          private-create-result
          offset
          (rec-fr ...)
          (def-fr ...)
          (init-fr ...)
          ((field field-type default getter setter) in-fs ...))
       (define-byte-record-collect
         type
         create
         predicate
         private-create-result
         (+ offset 1)
         ((field private-getter private-setter) rec-fr ...)
         ((define (getter rec)
            (private-getter rec))
          (define (setter rec value)
            (display "set ")
            (display value)
            (display " at offset ")
            (display offset)
            (newline)
            (private-setter rec value))
          def-fr ...)
         ((setter private-create-result default) init-fr ...)
         (in-fs ...)))
      ))

  (define-syntax define-byte-record-reverse
    (syntax-rules ()
      ((_ type
          create
          predicate
          private-create-result
          offset
          (r rec-fr ...)
          (d1 d2 def-fr ...)
          (i init-fr ...)
          (rec-fs ...)
          (def-fs ...)
          (init-fs ...))
       (define-byte-record-reverse
         type
         create
         predicate
         private-create-result
         offset
         (rec-fr ...)
         (def-fr ...)
         (init-fr ...)
         (r rec-fs ...)
         (d2 d1 def-fs ...)
         (i init-fs ...)))
      ((_ type
          create
          predicate
          private-create-result
          offset
          ()
          ()
          ()
          (rec-fs ...)
          (def-fs ...)
          (init-fs ...))
       (begin
         (define-record-type
           type
           (private-create)
           predicate
           rec-fs ...)
         (define (create)
           (define private-create-result (private-create))
           init-fs ...
           private-create-result)
         def-fs ...))
      ))
  ))
