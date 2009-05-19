;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; yow.asd
;;;;;    common lisp facility for generating text bogons
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; YOW!  I can see 1987!!  PRESIDENT FORD is doing the REMAKE of "PAGAN
;;;;; LOVE SONG"...he's playing ESTHER WILLIAMS!!
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-20 16:47:24 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-20
;;;;; 
;;;;; Keywords: asd common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11820M  (DarwinX8664)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :common-lisp-user)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (declaim (optimize (debug 3))))

(defpackage :yow.system
  (:use :cl :asdf)
  (:export  #:yow-relative-pathname))

(in-package :yow.system)

;;;;;
;;;;; System Definitions
;;;;;

(defsystem :yow
  :name "#'yow (a.k.a. fortune) for common lisp"
  :version  #.(with-open-file
                 (vers (merge-pathnames "version.lisp" *load-truename*))
               (read vers))
  ;"0.0.1"
  :maintainer "Dan Lentz <danlentz@gmail.com>"
  :description "a common lisp facility for generating texty bogons"
  :author "Dan Lentz <danlentz@gmail.com>"
  :licence "LGPL"
  :depends-on ( :iterate :cl-ppcre )
  :serial t :components
  ((:module "src" :serial t :components
     ((:file "packages") (:file "slurp") (:file "yow") (:file "user-api")))))

(defsystem :yow.test
  :name "yow test suite"
  :version "0.0.1"
  :description "yow test suite system"
  :maintainer "Dan Lentz <danlentz@gmail.com>"
  :author "Dan Lentz <danlentz@gmail.com>"
  :licence "LGPL"
  :depends-on ( :yow :lift )
  :serial t :components
  ((:module "test" :serial t :components
     ((:file "yow-test")))))

;;;;;
;;;;; Localized Operation Methods
;;;;;

(defmacro yow-relative-pathname (p)
 "pathname relative to yow installation"
  `(merge-pathnames (translate-logical-pathname (pathname ,p))
     (directory-namestring
       (truename
         (asdf:system-definition-pathname (asdf:find-system :yow))))))
    
(defmethod perform :after ((o asdf:load-op) (c (eql (find-system :yow))))
  "register provided functionality :after a successful load of this system"
  (provide 'yow)
  (pushnew :yow *FEATURES*))

;;; Unit Tests

(defmethod perform ((op asdf:test-op)
                    (system (eql (find-system :yow))))
  "Perform unit test suite on yow system"
  (asdf:operate 'asdf:load-op :yow)
  (asdf:operate 'asdf:load-op :yow.test)
  (funcall (intern (string :run-tests) (string :yow.test))))

(defmethod operation-done-p
  ((op asdf:test-op) (system (eql (find-system :yow))))
  nil)


;; Local Variables:
;;  tab-width: 8
;;  fill-column: 78
;;  indent-tabs-mode: nil
;;  comment-column: 50
;;  comment-start: ";; "
;; End:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
