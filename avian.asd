(asdf:defsystem "avian"
  :description "A simple tool to help organize photos"
  :author "v0sem"
  :license ""
  :version "0.1.0"
  :depends-on ("alexandria" "sha3" "deploy" "clingon" "str")
  :components ((:module "src" :components ((:file "main"))))
  :defsystem-depends-on (:deploy)
  :build-operation "deploy-op"
  :build-pathname "avian"
  :entry-point "avian::entry")

;; ASDF wants to update itself and fails.
;; Yeah, it does that even when running the binary on my VPS O_o
;; Please, don't.
(deploy:define-hook (:deploy asdf) (directory)
  #+asdf (asdf:clear-source-registry)
  #+asdf (defun asdf:upgrade-asdf () NIL))
