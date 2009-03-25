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
  (:export #:doc-op #:yow-relative-pathname))

(in-package :yow.system)

;;;;;
;;;;; System Definitions
;;;;;

(defsystem :yow
  :name "#'yow (a.k.a. fortune) for common lisp"
  :version "0.0.1"
  :maintainer "Dan Lentz <danlentz@gmail.com>"
  :description "a common lisp facility for generating texty bogons"
  :author "Dan Lentz <danlentz@gmail.com>"
  :licence "LGPL"
  :depends-on ( :iterate :cl-ppcre )
  :serial t :components
  ((:module "src" :serial t :components
     ((:file "packages") (:file "yow")))))

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
  (funcall (intern (string :run-tests) (string :lift))) ;; :yow)
  (lift:handle-config-preference :report-property
    '(:title "Yow! Unit Testing Report"))
  (lift:handle-config-preference :report-property '(:relative-to "yow"))
  (lift:handle-config-preference :report-property '(:unique-name nil))
  (lift:handle-config-preference :report-property '(:style-sheet "style.css"))
  (lift:handle-config-preference :report-property '(:if-exists :supersede))
  (lift:handle-config-preference :report-property '(:format :html))
  (lift:handle-config-preference :report-property '(:name "test-report"))
  (lift:handle-config-preference :build-report ())

  )

(defmethod operation-done-p
  ((op asdf:test-op) (system (eql (find-system :yow))))
  nil)

;;; Documentation 

(defclass doc-op (asdf:operation) ())

(defmethod perform ((op doc-op)
                    (system (eql (find-system :yow))))
  "Generate automated documentation for yow system.

Lazily loads yow system and CLDOC framework as needed."
  (asdf:operate 'asdf:load-op :yow)
  (asdf:operate 'asdf:load-op :cldoc)

  (ignore-errors
    (makunbound 'cldoc:+DEFAULT-SECTION-NAMES+))
  
  (defconstant cldoc::+DEFAULT-SECTION-NAMES+
      (list "Overview:" "See Also:" "Examples:" "Notes:" "History:"
        "Status:" "Affected By:" "Side Effects:" "Arguments and Values:"
        "Exceptional Situations:" "Requirements:" "Specification:"))
  
  (defun cldoc::make-footer ()
    "Appends locally specified footer to cldoc:html driven output"
    (cldoc::with-tag (:div (:class "cludg-footer"))
      (cldoc::html-write "Generated with ~A - ~A "
        (lisp-implementation-type)
        (cldoc::get-iso-date-time))))
  
  (cldoc:extract-documentation 'cldoc:html
    (namestring (yow-relative-pathname #P";doc;html;"))
    (asdf:find-system :yow) :table-of-contents-title "Yow! for Common-Lisp")

    (cldoc:extract-documentation 'cldoc:text
    (namestring (yow-relative-pathname #P";doc;text;"))
    (asdf:find-system :yow))

  )

(defmethod operation-done-p
  ((op doc-op) (system (eql (find-system :yow))))
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
