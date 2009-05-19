;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; yow-doc.asd
;;;;;    document publishing machinery
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; I always have fun because I'm out of my mind!!!
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-27 10:21:43 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-27
;;;;; 
;;;;; Keywords: asd common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11847M  (DarwinX8664)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  begin source code  .....................................................

(in-package :common-lisp-user)
(eval-when (:compile-toplevel :load-toplevel :execute)
  (declaim (optimize (debug 3))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defpackage :yow-doc.system
    (:use :cl :asdf :yow :docudown)
    (:export  #:yow-relative-pathname)))

(in-package :yow-doc.system)
  (import 'markdown::included-document)

(defsystem :yow-doc
  :name "yow documentation plumbing"
  :version "0.0.1"
  :description "yow documentation system"
  :maintainer "Dan Lentz <danlentz@gmail.com>"
  :author "Dan Lentz <danlentz@gmail.com>"
  :licence "LGPL"
  :depends-on ( :yow :lift  :cl-markdown :docudown :metatilities-base
                :metatilities)
  :serial t :components
  ((:module "doc" :serial t :components
     ((:file "setup")
       (:docudown-source "yow.md")))))


#|

;; (defmethod perform ((op doc-op)
;;                     (system (eql (find-system :yow))))
;;   "Generate automated documentation for yow system.

;; Lazily loads yow system and CLDOC framework as needed."

;;   (asdf:operate 'asdf:load-op :yow)
;;   (asdf:operate 'asdf:load-op :cldoc)
(defun make-cldocs ()
  (makunbound 'cldoc:+DEFAULT-SECTION-NAMES+)
  (defconstant cldoc:+DEFAULT-SECTION-NAMES+
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

;; (defmethod operation-done-p
;;   ((op doc-op) (system (eql (find-system :yow))))
;;   nil)

|#
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