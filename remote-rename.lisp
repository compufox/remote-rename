;;;; git-migrate.lisp

(in-package #:remote-rename)

(defvar *old-acct*)
(defvar *new-acct*)

(defun main ()
  (unless (= (length (command-line-arguments)) 3)
    (quit 1 "not enough arguments" "remote-rename DIRECTORY OLD-ACCOUNT NEW-ACCOUNT"))
  (destructuring-bind (directory old-account new-account) (command-line-arguments)
    (setf *old-acct* old-account)
    (setf *new-acct* new-account)
    (if (directory-exists-p directory)
	(walk-directory directory #'maybe-change-git-remote :directories :breadth-first)
	(quit 1 "directory does not exist"))))

(defun maybe-change-git-remote (item)
  (when (and (directory-pathname-p item) (git-location-p item))
    (let ((repo (init item)))
      (setf (remotes repo)
	    (loop for remote in (remotes repo)
	       collect `(,(car remote) . ,(replace-all *old-acct* *new-acct* (cdr remote))))))))

(defun quit (code &rest messages)
  (format t "~{~a~%~}" messages)
  (uiop:quit code))
