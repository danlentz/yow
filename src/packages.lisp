;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; packages.lisp
;;;;;    package goods
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; Yow!  Legally-imposed CULTURE-reduction is CABBAGE-BRAINED!
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-21 16:06:39 EDT
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
  (:use :common-lisp :yow.system :iterate :lift)
  (:export #:*all-yow-dbs* #:yow-db #:textfile-db #:populate
    #:doc-op #:yow-relative-pathname
    #:yow #:male-name #:female-name #:last-name #:full-name
    #:full-male-name #:full-female-name)
  (:documentation
    "YOW: Common lisp utilities to generate texty bogons

YOW  is a small common-lisp implementation of the well known \"fortune cookie\"
utility, named after the familiar EMACS implementation.  In addition, this
package includes a small collection of cookie databases.

* Examples:

The following will produce a string containing a randomly chosen Last Name
(see {defun yow}):
;;; (yow :last-names)
;;; ;; => \"Smith\"

* Notes:

This package was implemented with a goal of producing a simple, stand-alone
prototype demonstration of various stylistic code and packaging concerns,
such as system definition, code portability, regression testing,
api, and test-result documentation. It does not necessarily attempt to
implement the most efficient algorithmic solution.

* See Also:

This Package Incorporates the Following Scaffolding and Component Frameworks.

-  LIFT framework for interactive unit testing by Gary King.  {http://common-lisp.net/project/lift/}

-  CLDOC api documentation facility by Iban Hatchondo. {http://common-lisp.net/project/cldoc/}

-  ASDF system definition framework by Daniel Barlow.   {http://cliki.net/asdf/}

"))


;;;;;
;; Local Variables:
;;  tab-width: 8
;;  fill-column: 78
;;  indent-tabs-mode: nil
;;  comment-column: 50
;;  comment-start: ";; "
;; End:
;;;;;