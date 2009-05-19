;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; yow.lisp
;;;;;    Yow! I feel partially hydrogenated!
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; I HAVE a towel.
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
     ("tilton.txt"       . #\%)
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
    filename-o.txt convention --- e.g., fortunes-o.txt.  * See Also: {defun
    load-default-dbs} ")

(defvar *all-yow-dbs* (make-hash-table :test #'equal)
  "dynamic special variable that maps keyword names to references of loaded
  yow-db instances")

;;;
;;; Class Hierarchy
;;;

(defclass yow-db ()
  ((name
     :reader         get-name
     :initarg        :name
     :initform       (error "required")
     :documentation "token by which instances of loaded data sources are named
     Although it can be defined as any type value that is operable with
     #'equal it is strongly recommended to use symbols interned in 'KEYWORD
     package, such as :last-names or :spook")
    (data
      :accessor      get-data
      :initarg       :data
      :initform      nil
      :documentation "simple implementation of list based data structure to
      hold an arbitrary number of strings, each of which is a 'cookie' usually
      accessed by random selection for presentation to (and amusement of) the
      user"))
  (:documentation
    "Base protocol class for yow data sources. This abstract class is not
    meant to be instantiated directly."))

(defclass textfile-db (yow-db)
  ((path
     :reader         get-path
     :initarg        :path
     :initform       (error "required")
     :documentation "file system pathname from which to create a single
     'cookie-jar' instance and to load the associated set of 'cookies'.")
    (eor-char
      :reader        get-eor-char
      :initarg       :eor-char
      :initform      #\newline
      :documentation "character denoting END-OF-RECORD. Each distinct element
      of the input data should be separated by this character.  Some commonly
      encountered cases include #\newline and #\%"))
  (:documentation "simple textfile based data source. This format is newline
  delimited, one line per cookie, using hash (#) comments when found as the
  first character on a logical line."))

(defmethod print-object ((o textfile-db) s)
  "enhance printed representation of textfile-db objects with helpful info"
  (print-unreadable-object (o s :type t)
    (format s ":  ~S Cookies" (length (yow::get-data o)))))

;;;
;;; Obect Instantiation and Datafile Parsing
;;;

(defgeneric populate (db name &key &allow-other-keys)
  (:documentation
  "low-level routines used internally to parse specific cookie-jar db formats
and populate the corresponding in-memory data structures with the resulting
data"))

(defmethod populate ((db textfile-db) name &key
                      (path (make-pathname :name "fortunes" :type "txt")))
  (setf (slot-value db 'name) (intern (format nil "~:@(~a~)" name)  :keyword))
  (setf (yow::get-data db)
    (ppcre:split (yow::get-eor-char db) (yow::slurp-file path)))
  (setf (gethash (yow::get-name db) *all-yow-dbs*) db))

(defmethod initialize-instance :after ((db textfile-db) &rest initargs
                                        &key &allow-other-keys)
  "correctly invoke POPULATE (upon instantiation of a TEXTFILE-DB) when PATH
has been specified by an initarg to MAKE-INSTANCE"
  (declare (ignore initargs))
  (let ((p (yow::get-path db)))
    (when p
      (populate db
        (if (yow::get-name db) (yow::get-name db) (pathname-name p))
        :path p))))

;;;
;;; USER-LEVEL UTILITIES
;;;

(defun load-textfile-db (path eor-char &optional (name nil))
  "Parse an ASCII[-ish] text-file specified by PATH having some number of
records delinieated by occourances of the character EOR-CHAR. Load it's
contents into memory and make available as a cookie-jar for use using the YOW
end-user api as a cookie jar denoted by NAME (if specified) or by a name
derived from PATH (if not specified).  In particular, this should be
compatible with most 'fortune' style cookie files like those found on UNIX
systems or '.lines' style files distributed with EMACS."
  (make-instance 'textfile-db
    :name (or name (pathname-name (pathname path)))
    :eor-char eor-char
    :path path))
                    
;; Local Variables:
;;  tab-width: 8
;;  fill-column: 78
;;  indent-tabs-mode: nil
;;  comment-column: 50
;;  comment-start: ";; "
;; End:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
