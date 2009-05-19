;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; packages.lisp
;;;;;    package goods
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; Thank god!!..  It's HENNY YOUNGMAN!!
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-21 16:11:59 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-20
;;;;; 
;;;;; Keywords: lisp common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11820M  (DarwinX8664)
;;;;;
;;;;;
;;;;  begin source code  .....................................................

(in-package :common-lisp-user)

(defpackage :ebugs.yow
  (:nicknames :yow :cl-yow)
  (:use :common-lisp :yow.system :iterate)
  (:export
    #:*all-yow-dbs* #:*default-db-files*
    #:load-textfile-db
    #:yow-db #:textfile-db #:populate
    #:load-default-dbs
    #:yow-relative-pathname
    #:yow #:fortune #:limerick #:murphys-law #:trek #:spook #:zippy #:tilton
    #:male-name #:female-name #:last-name
    #:full-name #:full-male-name #:full-female-name)
  (:documentation
    "YOW: Common lisp utilities to generate texty bogons
YOW  is a small common-lisp implementation of the well known \"fortune cookie\"
utility, named after the familiar EMACS implementation.  In addition, this
package includes a small collection of cookie databases.

* Examples:

The following will produce a string containing a randomly chosen Last Name
-- see
{defun yow} 
;;; (yow :last-names)
;;; ;; => \"Smith\"

* See Also:

This Package Incorporates the Following Scaffolding and Component Frameworks.

-  LIFT framework for interactive unit testing by Gary King.
{http://common-lisp.net/project/lift/}
-  CLDOC api documentation facility by Iban Hatchondo.
{http://common-lisp.net/project/cldoc/}
-  ASDF system definition framework by Daniel Barlow.
{http://cliki.net/asdf/}
-  CL-PPCRE
-  ITERATE

* Notes:

This package was implemented with a goal of producing a simple, stand-alone
prototype demonstration of various stylistic code and packaging concerns,
such as system definition, code portability, regression testing,
api, and test-result documentation. It does not necessarily attempt to
implement the most efficient algorithmic solution.

Names databases originate:
- From Bob Baldwin's collection from MIT
- Augmented by Matt Bishop and Daniel Klein

Fortune databases brought to you from the FreeBSD 'ports' collection:
- src/games/fortune/datfiles/fortunes,v 1.179.2.8 2006/08/12 20:30:09 yar
- src/games/fortune/datfiles/fortunes-o.real,v 1.19 2004/04/29 04:36:36 smkelly
- src/games/fortune/datfiles/fortunes2-o,v 1.30 2005/02/03 22:48:29 schweikh
- src/games/fortune/datfiles/startrek,v 1.7 2005/04/24 15:31:11 schweikh
- src/games/fortune/datfiles/zippy,v 1.4 2005/02/01 16:34:38 ru
- src/games/fortune/datfiles/murphy,v 1.11 2005/02/01 16:34:38 ru
- src/games/fortune/datfiles/murphy-o,v 1.2 2003/03/19 17:50:59 eivind
- src/games/fortune/datfiles/limerick,v 1.8 2005/05/07 17:56:50 sch

Spook and Zippy the Pinhead databases arrived via GNU EMACS source distribution
(yow.lines, spook.lines).  Zippy database is currently also used by:
- the FORTUNE program on OZ.AI.MIT.EDU
- the m-x yow command in GNU Emacs.
- NIL (MIT Common Lisp)'s debugger
- something Bandy wrote at LLL-CRG.ARPA 
- Henry's Zippy proxy (http://www.metahtml.com/apps/zippy/)

"))


#+:lift
(defpackage :yow-test
  (:use :common-lisp :yow.system :yow :iterate :lift))


;;;;;
;; Local Variables:
;;  tab-width: 8
;;  fill-column: 78
;;  indent-tabs-mode: nil
;;  comment-column: 50
;;  comment-start: ";; "
;; End:
;;;;;