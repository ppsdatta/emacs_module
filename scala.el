(defvar ScalaProjectPath nil)


(defun scala-here ()
  (interactive)
  (setq ScalaProjectPath default-directory))

(defun scala-project (project-name)
  (interactive "sProject name: ")
  (make-directory project-name)
  (make-directory (format "%s/src/main/scala" project-name) t)
  (make-directory (format "%s/src/test" project-name) t)
  (make-directory (format "%s/project" project-name) t)
  (write-region "" "" (format "%s/build.sbt" project-name))
  (setq ScalaProjectPath (format "%s%s"
				 default-directory
				 project-name))
  (message ScalaProjectPath))

(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(defun scala-src-package (package-name)
  (interactive "sPackage name: ")
  (make-directory (format "%s/src/main/scala/%s"
			  ScalaProjectPath
			  (replace-in-string "." "/" package-name))
		  t))

(defun scala-test-package (package-name)
  (interactive "sPackage name: ")
  (make-directory (format "%s/src/test/scala/%s"
			  ScalaProjectPath
			  (replace-in-string "." "/" package-name))
		  t))

(defun scala-java-package (package-name)
  (interactive "sPackage name: ")
  (make-directory (format "%s/src/main/java/%s"
			  ScalaProjectPath
			  (replace-in-string "." "/" package-name))
		  t))

(defun scala-test-java-package (package-name)
  (interactive "sPackage name: ")
  (make-directory (format "%s/src/test/java/%s"
			  ScalaProjectPath
			  (replace-in-string "." "/" package-name))
		  t))

(defun scala-file (filename destination)
  (let ((paths (split-string filename "\\."))
	(file-extension "")
	(file-name "")
	(package-name nil)
	(package-name1 nil))
    (cond
     ((null paths) (message "Huh?"))
     ((= (length paths) 1) (progn
			     (setq file-name (car paths))
			     (setq file-extension "scala")))
     ((= (length paths) 2) (progn
			     (setq file-name (car paths))
			     (setq file-extension (cadr paths))))
     (t (let* ((revpath (reverse paths))
	       (revpackage (cddr revpath)))
	  (setq package-name (mapconcat #'identity
					(reverse revpackage)
					"."))
	  (setq file-extension (car revpath))
	  (setq file-name (cadr revpath)))))
    (when package-name
      (if (string= destination "test")
	  (cond	 
	   ((string= file-extension "scala")
	    (scala-test-package package-name))
	   ((string= file-extension "java")
	    (scala-test-java-package package-name)))
	(cond	 
	 ((string= file-extension "scala")
	  (scala-src-package package-name))
	 ((string= file-extension "java")
	  (scala-java-package package-name))))
      (setq package-name1 (replace-in-string "." "/" package-name)))
    (let ((file-path
	   (format "%s/%s/%s%s.%s"
		       ScalaProjectPath
		       (if (string= file-extension "scala")
			   (format "src/%s/scala" destination)
			 (format "src/%s/java" destination))
		       (if package-name1
			   (format "%s/" package-name1) "")
		       file-name
		       file-extension)))
      (write-region "" "" file-path))))

(defun scala-src-file (file-name)
  (interactive "sFile name: ")
  (scala-file file-name "main"))

(defun scala-test-file (file-name)
  (interactive "sFile name: ")
  (scala-file file-name "test"))

(provide 'scala)

		   
