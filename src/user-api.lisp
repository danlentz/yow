;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; enduser-commands.lisp
;;;;;    simple command API for simple end-users
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; Join the PLUMBER'S UNION!!
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-26 12:32:09 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-26
;;;;; 
;;;;; Keywords: lisp common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11820M  (DarwinX8664)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  begin source code  .....................................................

(in-package :yow)

(defun fortune (&key (offensive-p nil))
  ""
  (if offensive-p
    (if (> (random 100 (make-random-state t)) 50)
      (yow :fortunes-o)
      (yow :fortunes2-o))    
    (yow :fortunes)))

(defun limerick ()
  ""
  (yow :limerick))

(defun murphys-law (&key (offensive-p nil))
  ""
  (if offensive-p
    (yow :murphy-o)
    (yow :murphy)))

(defun trek ()
  ""
  (yow :trek))

(defun spook ()
  ""
  (yow :spook))

(defun zippy ()
  ""
  (if (> (random 100 (make-random-state t)) 50)
    (yow :yow)
    (yow :zippy)))

(defun male-name ()
  ""
  (format nil "~:(~a~)"  (yow :male-names)))

(defun female-name ()
  ""
  (format nil "~:(~a~)"  (yow :female-names)))

(defun last-name ()
  ""
  (yow :last-names))

(defun full-male-name ()
  ""
  (concatenate 'string (male-name) " " (last-name)))

(defun full-female-name ()
  ""
  (concatenate 'string (female-name) " " (last-name)))

(defun full-name ()
  ""
  (if (> (random 100 (make-random-state t)) 50)
    (full-male-name)
    (full-female-name)))



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
