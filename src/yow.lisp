;;;;; -*-    mode: lisp; syntax: common-lisp; coding: utf-8; base: 10;      -*-
;;;;;
;;;;; yow.lisp
;;;;;    yow!
;;;;;
;;;;; Copyright 2009 Dan Lentz, Lentz Intergalactic Softworks
;;;;; Yow!  Legally-imposed CULTURE-reduction is CABBAGE-BRAINED!
;;;;;
;;;;; Updated:Dan Lentz 2009-Mar-20 11:31:00 EDT
;;;;; Created: Dan Lentz <dan@lentz.com> 2009-03-19
;;;;; 
;;;;; Keywords: lisp common-lisp i386-apple-darwin9.6.0
;;;;; Platform: Clozure Common Lisp Version 1.3-RC1-r11820M  (DarwinX8664)
;;;;;
;;;;;
;;;;  begin source code  .....................................................


(in-package :yow)

(defvar *all-yow-dbs* (make-hash-table :test #'equal))

(defclass yow-db ()
  ((name :accessor get-name :initarg :name :initform nil))
  (:documentation "protocol class"))

(defclass textfile-db (yow-db)
  ((path :accessor get-path :initarg :path
     :initform nil)
    (data :accessor get-data :initarg :data
      :initform '()))
  (:documentation "newline delimited, one line per cookie, Hash (#) comments"))


(defgeneric populate (db name &key &allow-other-keys))


(defmethod populate ((db yow-db) name &key &allow-other-keys)
  (setf (get-name db) name)
  (setf (gethash name *all-yow-dbs*) db))


(defmethod populate ((db textfile-db) name &key
                      (path (make-pathname :name "fortunes" :type "txt")))
  (setf (get-name db) name)
  (setf (get-data db)
    (iterate
      (for line :in-file path :using #'read-line)
      (unless (char= (aref line 0) #\#)
        (collect line))))
  (setf (gethash name *all-yow-dbs*) db))


(defmethod initialize-instance :after ((db textfile-db) &rest initargs
                                        &key &allow-other-keys)
  (let ((p (get-path db)))
    (when p
      (populate db (if (get-name db)
                     (get-name db)
                   (pathname-name p)) :path p))))
;;;;;
;; Local Variables:
;;  tab-width: 8
;;  fill-column: 78
;;  indent-tabs-mode: nil
;;  comment-column: 50
;;  comment-start: ";; "
;; End:
;;;;;