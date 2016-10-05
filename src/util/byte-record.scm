#!r7rs
(define-library (util byte-record)
  (export define-byte-record define-byte-record-collect)
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
            (rec-fs ...)
            (def-fs ...)
            (init-fs ...)
            ((field field-type default getter setter) in-fs ...))
         (define-byte-record-collect
           type
           create
           predicate
           private-create-result
           (+ offset 1)
           (rec-fs ... (field private-getter private-setter))
           (def-fs ...
             (define (getter rec)
               (private-getter rec))
             (define (setter rec value)
               (display "set ")
               (display value)
               (display " at offset ")
               (display offset)
               (newline)
               (private-setter rec value)))
           (init-fs ... (setter private-create-result default))
           (in-fs ...)))
        
        ((_ type
            create
            predicate
            private-create-result
            offset
            (rec-fs ...)
            (def-fs ...)
            (init-fs ...)
            ())
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
