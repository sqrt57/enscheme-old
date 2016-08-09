#lang scheme
#;(import (scheme base)
        (scheme file)
        (scheme write))
; (import (util byte-record))
(require "src/util/byte-record.scm")

; ; (define exename "build/a.exe")
; ; (write-pecoff-file exename)

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

