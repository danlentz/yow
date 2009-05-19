;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; enduser-commands.lisp
;;;;;    simple command API for simple end-users
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; Join the PLUMBER'S UNION!!
;;;;;
;;;;; Updated:Dan Lentz 2009-Apr-21 15:45:51 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-26
;;;;; 
;;;;; Keywords: lisp common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11820M  (DarwinX8664)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  begin source code  .....................................................

(in-package :yow)

;;;
;;; Special Variables
;;;

(defvar *default-db-files*
  `(("last-names.txt"    . #\linefeed)
     ("male-names.txt"   . #\linefeed)
     ("female-names.txt" . #\linefeed)
     ("fortunes.txt"     . #\%)
     ("fortunes-o.txt"   . #\%)
     ("fortunes2-o.txt"  . #\%)
     ("limerick.txt"     . #\%)
     ("murphy.txt"       . #\%)
     ("murphy-o.txt"     . #\%)
     ("trek.txt"         . #\%)
     ("zippy.txt"        . #\%)
     ("yow.txt"          . ,(code-char 0))
     ("spook.txt"        . ,(code-char 0)))
      "Association-list of textfile-db format data sources automatically populated 
    by default.  Each member pair is expected to conform to (STRING . CHAR) where
    STRING represents the pathabane (sans TYPE) of an existing, legal database
    file found in the yow installation's 'data' directory, and where CHAR denotes
    the record-separator used for that file. N.B.  This distribution contains an
    assortment of well-known, public, open-source, database files, some of which
    may contain material offensive to some and/or not=suitable for children.
    Therefore, on initial load of this library, NO databases are loaded.  If
    desired, please customize this ALIST to remove any unwanted datafiles.  By
    convention, all questionable content is linited to files named using a
    filename-o.txt convention --- e.g., fortunes-o.txt.
* See Also:
    {defun load-default-dbs} ")

;;;
;;; TOP-LEVEL USER-API
;;;

(defun load-default-dbs ()
  "Load all fortune cookie databases specified by {defvar *default-db-files*}.
By default, this distribution contains an assortment of
well-known, public, open-source, database files, some of which may contain
material offensive to some humans and/or not=suitable for children.
Therefore, on initial load of this system, NO databases are loaded.  If
desired, please customize {defvar *default-db-files*} ALIST to remove any
unwanted datafiles.  By convention, all questionable content is linited to
files named using a filename-o.txt convention --- e.g., fortunes-o.txt.
* See Also:
   {defun load-textfile-db}
   {defvar *default-db-files*}"
  (iterate
    (for (name . char) :in *default-db-files*)
    (make-instance 'textfile-db
      :name (pathname-name (pathname name))
      :eor-char char
      :path (yow-relative-pathname  (format nil ";data;~A" name)))))

(defun yow (&optional (dbname :yow))
  "Select and return a random cookie (STRING) from cookie-jar with name
specified by optional parameter DBNAME or from :YOW by default if DBNAME is
not specified. Returns NIL if specified cookie-jar does not exist."
  (let ((db (gethash dbname *all-yow-dbs*)))
    (when db
      (elt (yow::get-data db) (random (length (yow::get-data db)))))))

(defun fortune (&key (offensive-p nil))
  "Select and return a random cookie (STRING) from FORTUNES cookie-jar (by default)
or if keyword argument :OFFENSIVE-P is not NIL, an adult-audience, probably politically
incorrect fortune is returned instead. "
  (if offensive-p
    (if (> (random 100 (make-random-state t)) 50)
      (yow :fortunes-o)           ; fortunes2-o is distributed separately from
      (yow :fortunes2-o))         ; fortunes-o however they are both
                                  ; basicially the same and we select from one
                                  ; or the other randomly         
    (yow :fortunes)))

(defun limerick ()
  "Select and return a random cookie (STRING) from LIMERICKS cookie-jar."
  (yow :limerick))

(defun murphys-law (&key (offensive-p nil))
  "Select and return a random cookie (STRING) from MURPHY'S LAW cookie-jar (by default)
or if keyword argument :OFFENSIVE-P is not NIL, an adult-audience, probably politically
incorrect Murphy's Law is returned instead. "
  (if offensive-p
    (yow :murphy-o)
    (yow :murphy)))

(defun trek ()
  "Select and return a random cookie (STRING) from STAR-TREK cookie-jar."
  (yow :trek))

(defun tilton ()
  "Select and return a random cookie (STRING) from Kenny Tilton-isms cookie-jar."
  (yow :tilton))

(defun spook ()
  "Select and return a random cookie (STRING) from SPOOK cookie-jar, which contains words
and phrases thought by conspiriacy theorists to be monitored by the US Government."
  (yow :spook))

(defun zippy ()
  "Select and return a random cookie (STRING) from ZIPPY the PIN-HEAD cookie-jar"
  (if (> (random 100 (make-random-state t)) 50)
    (yow :yow)
    (yow :zippy)))

(defun male-name ()
  "Select and return a random MALE FIRST NAME."
  (format nil "~:(~a~)"  (yow :male-names)))

(defun female-name ()
  "Select and return a random FEMALE FIRST NAME."
  (format nil "~:(~a~)"  (yow :female-names)))

(defun last-name ()
  "Select and return a random LAST NAME."
  (yow :last-names))

(defun full-male-name ()
  "Randomly construct a MALE FULL NAME (first and last)."
  (concatenate 'string (male-name) " " (last-name)))

(defun full-female-name ()
  "Randomly construct a FEMALE FULL NAME (first and last)."
  (concatenate 'string (female-name) " " (last-name)))

(defun full-name ()
  "Randomly construct a FULL NAME (first and last) of randomly selected gender."
  (if (> (random 100 (make-random-state t)) 50)
    (full-male-name)
    (full-female-name)))

;; Local Variables:
;;  tab-width: 8
;;  fill-column: 78
;;  indent-tabs-mode: nil
;;  comment-column: 50
;;  comment-start: ";; "
;; End:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
