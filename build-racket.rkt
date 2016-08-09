#lang racket
(require "src/util/byte-record.scm")
(require macro-debugger/expand)

(expand-only #'(define-byte-record <compl>
                 compl
                 compl?
                 (re u8 0 re set-re!)
                 (im u8 3 im set-im!))
             (list #'define-byte-record #'define-byte-record-collect))

(define-byte-record <compl>
  compl
  compl?
  (re u8 0 re set-re!)
  (im u8 3 im set-im!))

(define a (compl))

(display (re a))
(newline)
(display (im a))
(newline)
(set-re! a 5)
(display (re a))
(newline)

