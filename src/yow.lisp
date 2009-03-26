;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; yow.lisp
;;;;;    yow!
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; Yow!  Legally-imposed CULTURE-reduction is CABBAGE-BRAINED!
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-21 17:34:21 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-19
;;;;; 
;;;;; Keywords: lisp common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11820M  (DarwinX8664)
;;;;;
;;;;;
;;;;  begin source code  .....................................................

(in-package :yow)
(eval-when (:compile-toplevel :load-toplevel :execute)
  (setf common-lisp:*random-state* (make-random-state t)))

;;;
;;; Special Variables
;;;

(defvar *all-yow-dbs* (make-hash-table :test #'equal)
  "dynamic special variable that maps keyword names to references of loaded yow-db instances")

(defvar *default-db-files* `(("last-names"    . #\linefeed)
                              ("male-names"   . #\linefeed)
                              ("female-names" . #\linefeed)
                              ("fortunes"     . #\%)
                              ("fortunes-o"   . #\%)
                              ("fortunes2-o"  . #\%)
                              ("limerick"     . #\%)
                              ("murphy"       . #\%)
                              ("murphy-o"     . #\%)
                              ("trek"         . #\%)
                              ("zippy"        . #\%)
                              ("yow"          . ,(code-char 0))
                              ("spook"        . ,(code-char 0)))
  "Association-lisp ist of automatically populated textfile-db format data sources.

Each member pair is expected to conform to (STRING . CHAR) where STRING represents the
pathabane (sans TYPE) of an existing, legal database file found in the yow installation's
'data' directory, and where CHAR denotes the record-separator used for that file.

N.B.  This distribution contains an assortment of well-known, public, open-source, database
files, some of which may contain material offensive to some and/or not=suitable for children.
Therefore, on initial load of this library, NO databases are loaded.  If desired, please customize this ALIST to remove any unwanted datafiles.  By convention, all questionable content is linited to files named using a filename-o.txt convention --- e.g., fortunes-o.txt.

* See Also:  {defun load-default-dbs}

")

;;;
;;; Class Hierarchy
;;;

(defclass yow-db ()
  ((name :accessor get-name :initarg :name :initform nil
     :documentation "token by which instances of loaded data sources are named

Although it can be defined as any type value that is operable with #'equal
it is strongly recommended to use symbols interned in 'KEYWORD package, such
as :last-names or :spook")
    (data :accessor get-data :initarg :data
      :initform '()
      :documentation "simple list of instance data elements"))
  (:documentation "Base protocol class for yow data sources.

This abstract class is not meant to be instantiated directly."))

(defclass textfile-db (yow-db)
  ((path :accessor get-path :initarg :path
     :initform nil
     :documentation "file system pathname from which this instance loads")
    (eor-char :accessor get-eor-char
      :initarg :eor-char
      :initform #\newline
      :documentation "character denoting END-OF-RECORD

Each distinct element of the input data should be separated by this
character.  Some commonly encountered cases include #\newline and #\%"))
  (:documentation "simple textfile based data source.

This format is newline delimited, one line per cookie, using hash (#)
comments when found as the first character on a logical line."))

;;;
;;; Lower-level Utility Functions
;;;

(defun slurp-stream (stream)
  ""
  (let ((seq (make-string (file-length stream))))
    (read-sequence seq stream)
    seq))

(defun slurp-file (filename)
  ""
  (with-open-file (f filename :direction :input)
    (slurp-stream f)))

;;;
;;; Obect Instantiation and Datafile Parsing
;;;

(defgeneric populate (db name &key &allow-other-keys))

(defmethod populate ((db textfile-db) name &key
                      (path (make-pathname :name "fortunes" :type "txt")))
  (setf (get-name db) (intern (format nil "~:@(~a~)" name)  :keyword))
  (setf (get-data db) (ppcre:split (get-eor-char db) (slurp-file path)))
  (setf (gethash (get-name db) *all-yow-dbs*) db))

(defmethod initialize-instance :after ((db textfile-db) &rest initargs
                                        &key &allow-other-keys)
  (let ((p (get-path db)))
    (when p
      (populate db
        (if (get-name db) (get-name db) (pathname-name p))
        :path p))))

;;;
;;; END USER INTERFACE
;;;

(defun load-textfile-db (path eor-char)
  ""
  (make-instance 'textfile-db :name (pathname-name path) :eor-char char
    :path path))

(defun load-default-dbs ()
  ""
  (iterate
    (for (name . char) :in *default-db-files*)
    (make-instance 'textfile-db :name name :eor-char char
      :path (yow-relative-pathname  (format nil ";data;~A.txt" name)))))

(defun yow (&optional (dbname :yow))
  ""
  (let ((db (gethash dbname *all-yow-dbs*)))
    (when db
      (elt (get-data db) (random
                           (length (get-data db)))))))

                    
;;;;;
;; Local Variables:
;;  tab-width: 8
;;  fill-column: 78
;;  indent-tabs-mode: nil
;;  comment-column: 50
;;  comment-start: ";; "
;; End:
;;;;;