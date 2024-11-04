(asdf:defsystem "avian"
  :description "A simple tool to help organize photos"
  :author "v0sem"
  :license ""
  :version "0.1.0"
  :depends-on ("deploy" "clingon" "str")
  :components ((:module "src" :components ((:file "main"))))
  :defsystem-depends-on (:deploy)
  :build-operation "deploy-op"
  :build-pathname "avian"
  :entry-point "avian::entry")


