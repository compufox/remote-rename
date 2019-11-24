;;;; package.lisp

(defpackage #:remote-rename
  (:use #:cl)
  (:import-from :legit
		:git-location-p
		:remotes
		:git-remote
		:init)
  (:import-from :str
		:containsp
		:replace-all)
  (:import-from :cl-fad
		:walk-directory)
  (:import-from :uiop
		:command-line-arguments
		:directory-exists-p
		:directory-pathname-p))



