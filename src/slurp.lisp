;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; slurp.lisp
;;;;;    fast io
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; I can't think about that.  It doesn't go with HEDGES in the shape of
;;;;; LITTLE LULU -- or ROBOTS making BRICKS...
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-29 12:51:01 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-28
;;;;; 
;;;;; Keywords: lisp common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11847M  (DarwinX8664)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  begin source code  .....................................................

(in-package :yow)

(defun slurp-file (pathname)
  ""
  (with-open-file (stream pathname :direction :input)
    (let ((string-buffer (make-string (file-length stream))))
      (read-sequence string-buffer stream)
      string-buffer)))

(defun slurp-stream (stream)
  ""
  (with-output-to-string (string-buffer)
    (do
      ((x (next-char stream) (next-char stream)))
      ((eq x stream))
      (write-char x string-buffer))))

(defun test-slurp-stream (pathname)
  ""
  (with-open-file (stream pathname :direction :input :element-type '(unsigned byte 8))
    (slurp-stream stream)))

(defun slurp2-file (pathname)
  ""
  (with-open-file (stream pathname :direction :input)
    (let ((seq (make-string (file-length stream))))
      (read-sequence seq stream)
      seq)))

;;;;  end source code  .......................................................
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Local Variables:
;;  tab-width: 8
;;  fill-column: 78
;;  indent-tabs-mode: nil
;;  comment-column: 50
;;  comment-start: ";; "
;; End:
