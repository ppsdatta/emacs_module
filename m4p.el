;; M4P

(require 'request)
(require 'cl)
(require 'thingatpt)

(defun m4p-listing ()
  (interactive)
  (request "http://musicforprogramming.net/rss.php"
	   :parser 'buffer-string
	   :success (cl-function
		     (lambda (&key data &allow-other-keys)
		       (let* ((root (with-temp-buffer
				      (insert data)
				      (xml-parse-region (point-min) (point-max))))
			      (rss (car root))
			      (channel (car (xml-get-children rss 'channel)))
			      (items (xml-get-children channel 'item)))
			 (mapcar (lambda (i) (insert (format "%S => %s" (nth 2 (nth 3 i)) (nth 2 (nth 13 i)))) (newline))
				 items))))))

(defun m4p-play ()
  (interactive)
  (let ((cmd-string (format "open %s" (thing-at-point 'url))))
    (message cmd-string)
    (shell-command cmd-string)))

(global-set-key (kbd "C-x C-m C-p C-l") 'm4p-listing)
(global-set-key (kbd "C-x C-m C-p C-p") 'm4p-play)


