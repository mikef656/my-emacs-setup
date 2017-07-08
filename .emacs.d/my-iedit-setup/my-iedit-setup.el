(add-to-list 'load-path "~/.emacs.d/iedit/")
(require 'iedit)


(defun iedit-dwim (arg)
  "With no arg edit the entire buffer
   With - arg behavior depends on mode
      -EMACS-LISP mode:defuns
      -NOT EMACS-LISP :paragraphs
   The region (ex defun, para) is not highlighted. during the operation."
  (interactive "P")
     (if iedit-mode
         ;T
         ;iedit Active-> cancel
         (progn
           (iedit-done)
           (message "Finished IEDIT"))
         ;
         ;F
         (progn (let ((mytemp) (mystring4iedit))
            ;save point to a var bc want to restore point after it is
            ;moved by something like "mark-paragraph"
            (setq  mytemp (point))
            (iedit-mode)
               (if (eq major-mode 'emacs-lisp-mode)
                   ;T
                   ;M-- operates on the defun, no arg the para
                   (if (eq arg '-) 
                      (progn (mark-defun) (setq mystring4iedit "For Defun"))
                      ;; (progn (mark-paragraph) (setq mystring4iedit "For Paragraphs"))
                      (progn (mark-whole-buffer) (setq mystring4iedit "For Buffer"))
		      )     
                   ;F
                   (if (eq arg '-) 
                     ;; (progn (set-mark (point)) (end-of-buffer) (setq mystring4iedit "To End Of Buffer"))
		     (progn  (mark-paragraph) (setq mystring4iedit "For Paragraphs") )
                     (progn (mark-whole-buffer) (setq mystring4iedit "To End Of Buffer"))
		     )
               )
            (iedit-mode)
            (goto-char mytemp)
            ;(message "Started IEDIT %s" mystring4iedit)
            ))
     )) 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; grab M-n back from iedit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (add-hook 'iedit-mode-hook
     (lambda ()
      (define-key iedit-mode-occurrence-keymap (kbd "M-n") 'nill)
      (define-key iedit-mode-occurrence-keymap (kbd "M-n") 'my-forward-char)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end of %s" (buffer-name)) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-iedit-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
