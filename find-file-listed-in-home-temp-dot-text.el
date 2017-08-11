(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
(replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))


(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun find-file-listed-in-home-temp-dot-text ()
  "Opens somethintg good"
  (interactive)
  (find-file 
   (trim-string 
    (substring-no-properties (get-string-from-file "~/temp.txt")))))
