;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; packages.lisp
;;;;;    package goods
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; Yow!  Legally-imposed CULTURE-reduction is CABBAGE-BRAINED!
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-20 11:08:18 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-20
;;;;; 
;;;;; Keywords: lisp common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11820M  (DarwinX8664)
;;;;;
;;;;;
;;;;  begin source code  .....................................................

(in-package :common-lisp-user)

(defpackage :yow
  (:nicknames :cl-yow)
  (:use :common-lisp :iterate :lift)
  (:export #:*all-yow-dbs* #:yow-db #:textfile-db #:populate))


;;;;;
;; Local Variables:
;;  tab-width: 8
;;  fill-column: 78
;;  indent-tabs-mode: nil
;;  comment-column: 50
;;  comment-start: ";; "
;; End:
;;;;;