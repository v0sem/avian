(defpackage avian
  (:use :cl)
  (:local-nicknames (:a :alexandria)))

(in-package :avian)

(defparameter *dest-location* "~/media/photos/birds/")

(defun main (command)
  (let ((photo (clingon:getopt command :photo))
        (bird (str:join "_" (str:split " " (clingon:getopt command :bird))))
        (locale (clingon:getopt command :locale)))
    (format t "[+] Moving ~a to ~a~a_~a.jpg" photo *dest-location* locale bird)
    ))

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
