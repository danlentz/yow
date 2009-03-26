;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; yow-test.lisp
;;;;;    testy testy
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; Yow!  Legally-imposed CULTURE-reduction is CABBAGE-BRAINED!
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-25 02:48:14 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-20
;;;;; 
;;;;; Keywords: lisp common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11820M  (DarwinX8664)
;;;;;
;;;;;
;;;;  begin source code  .....................................................

(in-package :yow-test)

(deftestsuite yow-root-testsuite () ()
  (:documentation "top-level executive for regression unit tests"))

(handle-config-preference :if-dribble-exists '(:supersede))
(handle-config-preference :dribble '("test-log.txt"))
(handle-config-preference :print-length '(10))
(handle-config-preference :print-level '(5))
(handle-config-preference :print-test-case-names '(t))
(handle-config-preference :print-testsuite-names '(t))
(handle-config-preference :describe-if-not-successful '(t))
(handle-config-preference :evaluate-when-defined '(nil))
(handle-config-preference :print-when-defined '(t))
(handle-config-preference :show-expected-p '(t))
(handle-config-preference :show-details-p '(t))
(handle-config-preference :show-code-p '(t))
(handle-config-preference :log-pathname '(t))

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