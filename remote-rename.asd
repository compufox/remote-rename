;;;; git-migrate.asd

(asdf:defsystem #:remote-rename
  :description "migrate a local git repo to a new username"
  :author "ava fox"
  :license  "NPLv1+"
  :version "0.1"
  :serial t
  :depends-on (#:cl-cwd #:legit #:unix-opts #:cl-fad #:str)
  :components ((:file "package")
               (:file "remote-rename"))
  
  :build-operation "program-op"
  :build-pathname "bin/remote-rename"
  :entry-point "remote-rename::main")

#+sb-core-compression
(defmethod asdf:perform ((o asdf:image-op) (c asdf:system))
  (uiop:dump-image (asdf:output-file o c) :executable t :compression t))
