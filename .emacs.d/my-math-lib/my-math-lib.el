

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-inc-2 ()
  "Increment the number forward from point by 2
   Does not move point, only does the first number on a line"
  (interactive)
  (re-search-forward "[0-9]+" nil t)
  (my-increment-number-decimal 2))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(global-set-key (kbd "<f9>") 'my-inc-2)
; 3 aoeu 4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg
   Does not move point, only does the first number on a line"
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;taken from http://www.emacswiki.org/emacs/IncrementNumber
(defun my-increment-number-decimal-forward-line ()
  "Does not move point, only does the first number on a line"
  (interactive)
  (let ((col (current-column)))
    (my-increment-number-decimal)
    (forward-line 1)
    (move-to-column col)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;taken from http://www.emacswiki.org/emacs/IncrementNumber
(defun my-increment-numbers-region (p1 p2)
  "Does not move point, only does the first number on a line"
  (interactive "r")
  (setq tempp1 p1)
  (setq tempp2 p2)
  (goto-char p1)
  (let 
    ((col (current-column)))
  (while (< (point) p2 )
    (my-increment-number-decimal)
    (forward-line 1)
    (move-to-column col))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; eoeu 000271 023 htns
; eoeu 000271 023 htns
; eoeu 000271 023 htns
; eoeu 000271 023 htns
; eoeu 000271 023 htns
; eoeu 000271 023 htns


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;interesting Math
(message "reached before load-macro-math")
(when  load-macro-math 
  (add-to-list 'load-path "~/.emacs.d/macro-math/")
  (require 'macro-math)
;
  (defun my-macro-math-eval-region (beg end &optional copy-to-kill-ring digits)
    "MTF changed the behavior to not delete the region and to pun in an = sign.
  Evaluate the marked mathematical expression and replace it with the result.
  With arg COPY-TO-KILL-RING or prefix arg, don't replace region, but save the
  result to the kill-ring.  When DIGITS is non-nil, or a numeric prefix arg is
  given, it determines the number of decimal digits to round to."
    (interactive (list (region-beginning)
                       (region-end)
                       (consp current-prefix-arg)
                       (when (numberp current-prefix-arg) current-prefix-arg)))
    (let* ((calc-multiplication-has-precedence nil)
           (result (macro-math-eval (buffer-substring-no-properties beg end)))
           (rounded (if digits
                        (macro-math-round result digits)
                      (number-to-string result))))
      (if (or buffer-read-only copy-to-kill-ring)
          (progn (deactivate-mark)
                 (kill-new rounded)
                 (message "Saved %s in kill-ring" rounded))
        ;(delete-region beg end)
        (insert " = " rounded))))
  )
;
; 1.0/1.1
; 1.1+1 = 2.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://www.emacswiki.org/emacs/IncrementNumber
;incrementors probably don't belong in the .emacs, but no where to put them now
(defun my-increment-number-hexadecimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer hex-format)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789abcdefABCDEF")
        (when (re-search-forward "[0-9a-fA-F]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 16) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 16 field-width) answer)))
          (if (equal (match-string 0) (upcase (match-string 0)))
              (setq hex-format "X")
            (setq hex-format "x"))
          (replace-match (format (concat "%0" (int-to-string field-width)
                                         hex-format)
                                 answer)))))))
;
;
(defun my-inc ()
  "Call to my-increment-number-hexadecimal."
  (interactive)
  (my-increment-number-hexadecimal 4))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;https://www.emacswiki.org/emacs/RectangleAdd
(defun rectangle-add (start end)
  "Add all the lines in the region-rectangle and put the result in the 
   kill ring."
  (interactive "r")
  (let ((sum 0))
    (mapc (lambda (line)
            (setq sum (+ sum (rectangle-add-make-number line))))
          (extract-rectangle start end))
    (kill-new (number-to-string sum))
    (message "%s" sum)))

(defun rectangle-add-make-number (n)
  "Turn a string into a number, being tolerant of commas and even other 'junk'.
  When I started programming, my numeric input routines translated l 
  (lowercase ell) into 'one', as many users had learnt their
  keyboarding on manual typewriters which typically lacked 
  a separate key for the digit 1. Am I old, or what?"
  (while (string-match "[^0-9.]" n)
  (setq n (replace-match "" nil nil n)))
  (string-to-number n))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun inline-calc (arg)
  "Evaluate a region as an algebraic expression via Calc.  If a
region is active, it will evaluate it and either replace it with
or append to it (if given a prefix argument) the result.  If the
is no active region, it prompts for an expression via the
minibuffer."
  (interactive "P")
  (require 'calc)
  (let ((calc-multiplication-has-precedence nil))
    (if (use-region-p)
        (let ((result (calc-eval (buffer-substring (region-beginning)
                                                   (region-end)))))
          (if (not arg)
              (delete-region (region-beginning) (region-end))
            (goto-char (region-end))
            (insert " = "))
          (insert result))
      (message "Result: %s" (calc-eval (read-string "Expression: "))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(provide 'my-math-lib)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
