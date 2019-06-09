(defun cobol-program ()
  (interactive)
  (erase-buffer)
  (insert (format "       %s" "IDENTIFICATION DIVISION."))
  (newline)
  (insert (format "       %s" "PROGRAM-ID. UNTITLED."))
  (newline)
  (insert (format "       %s" "DATA DIVISION."))
  (newline)
  (insert (format "       %s" "WORKING-STORAGE SECTION."))
  (newline)
  (insert (format "       %s" "PROCEDURE DIVISION."))
  (newline)
  (insert (format "       %s" "DISPLAY \"HELLO\"."))
  (newline))



