;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Set the % key to goto matched parenthesis.
;;; Posted to the NTEmacs mailing list by
;;; Chris McMahan
;;; sachachua.com/notebook/emacs/small-functions.el
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	  ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	  (t (self-insert-command (or arg 1)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;I like this better
(defun forward-or-backward-sexp (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ;; Now, try to succeed from inside of a bracket
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))
;
;http://www.emacswiki.org/emacs/NavigatingParentheses
;emacs has these built in that I have not taken advantage of
;C-M-n
;C-M-p
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-rainbow-delimiters")
(when load-rainbow-delimiters
  (add-to-list 'load-path "~/.emacs.d/rainbow-delimiters/")
  (require 'rainbow-delimiters)
  ; new package does not implement this!!
  ;(global-rainbow-delimiters-mode))
;
(defun my-extra-colors ()
  ;changes colors to be less bright
  ;reference
  ;yoo2080.wordpress.com/2013/09/08/living-with-rainbow-delimiters-mode/
  (require 'color)
  (require 'cl-lib)
  (cl-loop
   for index from 2 to 12
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-desaturate-name (face-foreground face) 25))))
;
(defun my-set-unmatced-rainbow-face ()
  "do what it says, use a strike-thru face for the unmatched face"
  (interactive)
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil
                      :foreground 'unspecified
                      :inherit 'error
                      :strike-through t))
;
;NOTE HAVE SEEN SOME INCORRECT HIGHTLIGHTING, where unmatched is shown in
;cases where no mismatch is present MTF 9-23-2013.  Seems to happen when
;unexpected stuff is in column 0.
;if this get's too irritating lets try
;http://nschum.de/src/emacs/highlight-parentheses/ 
;instead
  ;(require 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  ;
;
  (message "reached before modify-rainbow-colors")
(when modify-rainbow-colors
;
  (eval-after-load 'rainbow-delimiters '(my-extra-colors))
  (eval-after-load 'rainbow-delimiters '(my-set-unmatced-rainbow-face))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;the function where the beginning of a defun was is shown in the echo area
;; ;when it's offscreen did not work automaticly.  This turn that feature on.
;; ;stackoverflow.com/questions/5983387/
;; ; emacs-evaluate-blink-matching-open-when-cursor-highlights-a-parenthesis
;; ;Trey Jackson mentions another paren package than sounds interesting.
;; (defadvice   show-paren-function (after blink activate)
;;   (when (= ?\) (char-before (point)))
;;     (blink-matching-open)))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if load-mic-paren
  (message "Reached before mic-paren.el")
  (add-to-list 'load-path "~/.emacs.d/mic-paren/")
  (require 'mic-paren)  ; loading
  (paren-activate))     ; activating
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this does not seem to work with emacs 24.4, use micparen instead
;
;the function where the beginning of a defun was is shown in the echo area
;when it's offscreen did not work automaticly.  This turn that feature on.
;stackoverflow.com/questions/5983387/
; emacs-evaluate-blink-matching-open-when-cursor-highlights-a-parenthesis
;Trey Jackson mentions another paren package than sounds interesting.
(if load-advise-show-paren-fn
  (defadvice show-paren-function (after blink activate)
    (when (= ?\) (char-before (point)))
      (blink-matching-open))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached end of my-paren-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(provide 'my-paren-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



