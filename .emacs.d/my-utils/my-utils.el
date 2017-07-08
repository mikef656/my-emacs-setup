;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; list of defuns in this file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; list-print (list)                                     
; my-insert-eval-last-sexp ()                           
; display-prefix (arg)                                  
; display-prefix-numeric (arg)                          
; my-color-message ()                                   
; my-capitalize-at-point-qrr ()                         
; inside-string? ()                                     
; inside-comment? ()                                    
; space-newlines  (&optional num-newlines-arg start end)
; delete-carrage-returns ()                             
; occur-non-ascii ()                                    
; qr-under-dir (start finish)                           
; qr-incdir (start finish)                              
; qr-eol (start finish)                                 
; qr-ks (start finish)                                  
; undo-kill-buffer (arg)                                
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; - Ever struggled with peeking the lists..?
;;; - I have, and printing the contents of auto-mode-alist into
;;;   the buffer is very easy with this.
;;; - Should be default emacs function.
;;;
(defun list-print (list)
  "Insert content of LIST into current point."
  (interactive "XLisp symbol, list name: ")
  (mapcar
   (function
    (lambda (x) (insert (2str x) "\n")))
   list))
;
;
;
;;; ----------------------------------------------------------------------
;;; 1990, Sebastian Kremer, Institute for Theoretical Physics, West Germany
;;; BITNET: ab027@dk0rrzk0.bitnet
;;;
(defsubst 2str (list &optional separator)
  "Convert LIST into string. Optional SEPARATOR defaults to \" \".
Input:
  LIST       '(\"str\" \"str\" ...)
  separator  ' '
Return:
  str"
  (mapconcat
   (function identity)			;returns "as is"
   list
   (or separator " ")
   ))
;
;(setq  A (list "a" "b" "c"))
;(list-print A)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Eval a lisp statement and place the result in the buffer commented at eol
;SO answer by Drew
;/stackoverflow.com/questions/18284497/
;how-to-update-evaluation-result-comments-of-emacs-lisp-forms-easilly
(defun my-insert-eval-last-sexp ()
   (interactive)
   (let ((this-command  'eval-print-last-sexp))
     (save-excursion (eval-last-sexp-1 t)))
   (when (looking-back ")") (insert " ; "))
   (insert "  ")
   (move-end-of-line 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun display-prefix (arg)
  "Display the value of the raw prefix arg."
  (interactive "P")
  (message "%s" arg)
  (when (listp arg)   (message "Arg %s is a list." arg))
  (when (symbolp arg) (message "Arg %s is a symbol." arg))
  (when (numberp arg) (message "Arg %s is a number." arg)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun display-prefix-numeric (arg)
  "Display the value of the raw prefix arg."
  (interactive "p")
  (message "%s" arg)
  (when (listp arg)   (message "Arg %s is a list." arg))
  (when (symbolp arg) (message "Arg %s is a symbol." arg))
  (when (numberp arg) (message "Arg %s is a number." arg)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-color-message ()
  "example shows how to color a mesage"
  (interactive)
  (setq myvar (propertize "foo" 'face '(:foreground "red")))
  (y-or-n-p (message (format "Check out %s"  myvar))))
  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-capitalize-at-point-qrr ()
  "Capitaize symbol at point,then use it as the search regex for qrr
  to and maybe capitaize some occurences of the symbol."
  (interactive)
  (let (temp my-start)
  (setq my-start (car (bounds-of-thing-at-point 'symbol)))
  (query-replace-regexp
    (setq temp (thing-at-point 'symbol))
      (capitalize temp) nil my-start (point-max))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Xah Lee
;ergoemacs.org/emacs/elisp_determine_cursor_inside_string_or_comment.html
(defun inside-string? ()
  "Returns non-nil if inside string, else nil.
This depends on major mode having setup syntax table properly."
  (interactive)
  (let ((result (nth 3 (syntax-ppss))))
    (message "%s" result)
    result))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Xah Lee
;ergoemacs.org/emacs/elisp_determine_cursor_inside_string_or_comment.html
(defun inside-comment? ()
  "Returns non-nil if inside comment, else nil.
This depends on major mode having setup syntax table properly."
  (interactive)
  (let ((result (nth 4 (syntax-ppss))))
    (message "%s" result)
    result))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MTF 8-21-14
; need to handle the case for 2-newlines where the current file has only one
;;
;lower case p is numeric prefix, without a prefex key default is 1
(defun space-newlines  (&optional num-newlines-arg start end)
  "Work on the active region if there is one
   C-u or M- of 1 or 2 are valid, 1 is the default,"
  (interactive "p\nr")
  (let (my-replace-string)
  ;
  (cond
    ((equal num-newlines-arg 1)
    (setq my-replace-string "\n\n")
     (message "one"))
    ;
    ((equal num-newlines-arg 2)
     (setq my-replace-string "\n\n\n")
     (message "two")))
  ;
  (if mark-active
     (progn
       ;first remove any whitespace only lines
       (save-excursion
       (goto-char start)
       (while (re-search-forward "^\\s-+$" end t )
         (replace-match "")))
       ;remove back to back newlines
       (save-excursion
       (goto-char start)
       (while (re-search-forward "\n\n+" end t )
         (replace-match my-replace-string))))
     (progn
       (save-excursion
       ;first remove any whitespace only lines
       (while (re-search-forward "^\\s-+$" (point-max) t )
         (replace-match "")))
       ;remove back to back newlines
       (save-excursion
       (while (re-search-forward "\n\n+" (point-max) t )
         ;; (replace-match "\n\n\n"))))))
         (replace-match my-replace-string)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun delete-carrage-returns ()
  "From stackoverflow.com/questions/23712076/how-to-remove-m-in-emacs"
  (interactive)
  (save-excursion
    (goto-char 0)
    (while (search-forward "\r" nil :noerror)
      (replace-match ""))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://www.emacswiki.org/emacs/FindingNonAsciiCharacters
(defun occur-non-ascii ()
  "Find any non-ascii characters in the current buffer."
  (interactive)
  (occur "[^[:ascii:]]"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun qr-under-dir (start finish)
  "aoeu"
  (interactive "r")
  ;
  (setq target-string "^.*_dir")
  (setq replace-string "\"\.")
  (query-replace-regexp target-string replace-string nil start finish))
  ;
  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun qr-incdir (start finish)
  "aoeu"
  (interactive "r")
  ;
  (setq target-string "./../../../")
  (setq replace-string "./")
  (query-replace target-string replace-string nil start finish))
  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun qr-eol (start finish)
  "aoeu"
  (interactive "r")
  ;
  (setq target-string "\"$")
  (setq replace-string "\" \\\\")
  (query-replace-regexp target-string replace-string nil start finish))
  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun qr-ks (start finish)
  "aoeu"
  (interactive "r")
  ;
  (qr-under-dir start finish)
  (pop-to-mark-command)
  (qr-incdir start finish)
  (pop-to-mark-command)
  (qr-eol start finish)
  (pop-to-mark-command))
  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; from http://www.emacswiki.org/emacs/RecentFiles#toc1
; DOES NOT WORK, NICE IDEA THOUGH 
(defun undo-kill-buffer (arg)
  "Re-open the last buffer killed.  With ARG, re-open the nth buffer."
  (interactive "p")
  (let ((recently-killed-list (copy-sequence recentf-list))
         (buffer-files-list
          (delq nil (mapcar (lambda (buf)
                              (when (buffer-file-name buf)
                                (expand-file-name (buffer-file-name buf)))) (buffer-list)))))
    (mapc
     (lambda (buf-file)
       (setq recently-killed-list
             (delq buf-file recently-killed-list)))
     buffer-files-list)
    (find-file
     (if arg (nth arg recently-killed-list)
       (car recently-killed-list)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end of my-utils.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(provide 'my-utils)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
