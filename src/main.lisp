(defpackage avian
  (:use :cl)
  (:local-nicknames (:a :alexandria)))

(in-package :avian)

(defparameter *dest-location* "~/media/photos/birds/")

(defun bird-count (locale bird)
  (length (loop for path in (directory (str:concat *dest-location* "*.jpg"))
                when (str:contains? (str:concat locale "_" bird) (namestring path))
                  collect path
                )))

(defun save-file (locale bird og-photo)
  (let ((bcount (bird-count locale bird)))
    (format t "Moving ~a to ~a" og-photo *dest-location*)
    (rename-file
     og-photo
     (str:concat *dest-location* locale "_" bird "_" (format nil "~2,'0D" bcount) "." (pathname-type og-photo)))))

(defun main (command)
  (let ((photo (clingon:getopt command :photo))
        (bird (str:join "_" (str:split " " (clingon:getopt command :bird))))
        (locale (clingon:getopt command :locale)))
    (save-file locale bird photo)))

(defun cli/options ()
  (list
   (clingon:make-option
    :string
    :description "Photo to rename and store"
    :short-name #\p
    :long-name "photo"
    :key :photo)
   (clingon:make-option
    :string
    :description "Name of the bird"
    :short-name #\b
    :long-name "bird"
    :key :bird)
   (clingon:make-option
    :string
    :description "Country where this photo was taken in two letter country code format"
    :short-name #\l
    :long-name "locale"
    :key :locale)))

(defun cli/command ()
  (clingon:make-command
   :name "avian"
   :description "Relocate photo with appropiate name"
   :usage "[-p <PHOTO>] [-b <BIRD>] [-l <LOCALE>]"
   :version "0.1.0"
   :authors '("v0sem <progpabsanch@gmail.com>")
   :options (cli/options)
   :handler #'main))

(defun entry ()
  (handler-case (clingon:run (cli/command))
    (sb-sys:interactive-interrupt ()
      (format t "~%")
      (sb-ext:exit))))
