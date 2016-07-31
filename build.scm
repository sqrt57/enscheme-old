(cond-expand
  (r7rs)
  (chicken (require-extension r7rs))
  (else (display "Unsupported Scheme implementation\n")
        (exit 1)))
(import (scheme base))
(import (scheme write))
(write-string "Hello, world!\n")
(display "Hello!\n")

