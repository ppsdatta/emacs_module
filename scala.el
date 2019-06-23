(defun scala-project (project-name)
  (interactive "sProject name: ")
  (make-directory project-name)
  (make-directory (format "%s/src/main/scala" project-name) t)
  (make-directory (format "%s/src/main/test" project-name) t)
  (make-directory (format "%s/project" project-name) t)
  (write-region "" "" (format "%s/build.sbt" project-name))
  (message "Done"))

(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(defun scala-src-package (package-name)
  (interactive "sPackage name: ")
  (make-directory (format "%s/src/main/scala/%s"
			  default-directory
			  (replace-in-string "." "/" package-name))
		  t))

(defun scala-test-package (package-name)
  (interactive "sPackage name: ")
  (make-directory (format "%s/src/test/scala/%s"
			  default-directory
			  (replace-in-string "." "/" package-name))
		  t))

(defun scala-java-package (package-name)
  (interactive "sPackage name: ")
  (make-directory (format "%s/src/main/java/%s"
			  default-directory
			  (replace-in-string "." "/" package-name))
		  t))

