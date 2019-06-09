(defun open-shell-v (name)
  (interactive "sShell name: ")
  (let ((buffer (generate-new-buffer-name name)))
    (split-window-right)
    (shell buffer)))

(defun open-shell-h (name)
  (interactive "sShell name: ")
  (let ((buffer (generate-new-buffer-name name)))
    (split-window-below)
    (shell buffer)))

(defun open-shell (name)
  (interactive "sShell name: ")
  (let ((buffer (generate-new-buffer-name name)))
    (shell buffer)))




