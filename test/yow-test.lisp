;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; yow-test.lisp
;;;;;    testy testy
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; Yow!  Legally-imposed CULTURE-reduction is CABBAGE-BRAINED!
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-20 17:24:05 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-20
;;;;; 
;;;;; Keywords: lisp common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11820M  (DarwinX8664)
;;;;;
;;;;;
;;;;  begin source code  .....................................................

(in-package :yow)
(use-package :lift)

(deftestsuite yow-root-testsuite () ()
  (:documentation "top-level executive for regression unit tests"))

(deftestsuite yow-textfile-db-0 (yow-root-testsuite) ()
  (:test
    (asdf-defsystem-file (ensure (probe-file (asdf:system-definition-pathname
                                               (asdf:find-system :yow))))))
  )

;; (defparameter *D* (make-instance 'textfile-db :name :lastnames
;; 			 :path #P"last-names.txt"))

;;;;;
;; Local Variables:
;;  tab-width: 8
;;  fill-column: 78
;;  indent-tabs-mode: nil
;;  comment-column: 50
;;  comment-start: ";; "
;; End:
;;;;;