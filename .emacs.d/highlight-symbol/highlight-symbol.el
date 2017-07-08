;;; highlight-symbol.el --- automatic and manual symbol highlighting
;;
;; Copyright (C) 2007-2009 Nikolaj Schumacher
;;
;; Author: Nikolaj Schumacher <bugs * nschum de>
;; Version: 1.1
;; Keywords: faces, matching
;; URL: http://nschum.de/src/emacs/highlight-symbol/
;; Compatibility: GNU Emacs 22.x, GNU Emacs 23.x
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;; Add the following to your .emacs file:
;; (require 'highlight-symbol)
;; (global-set-key [(control f3)] 'highlight-symbol-at-point)
;; (global-set-key [f3] 'highlight-symbol-next)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-prev)))
;; (global-set-key [(control meta f3)] 'highlight-symbol-query-replace)
;;
;; Use `highlight-symbol-at-point' to toggle highlighting of the symbol at
;; point throughout the current buffer.  Use `highlight-symbol-mode' to keep the
;; symbol at point highlighted.
;;
;; The functions `highlight-symbol-next', `highlight-symbol-prev',
;; `highlight-symbol-next-in-defun' and `highlight-symbol-prev-in-defun' allow
;; for cycling through the locations of any symbol at point.
;; When `highlight-symbol-on-navigation-p' is set, highlighting is triggered
;; regardless of `highlight-symbol-idle-delay'.
;;
;; `highlight-symbol-query-replace' can be used to replace the symbol.
;;
;;; Change Log:
;;
;; 2009-04-13 (1.1)
;;    Added `highlight-symbol-query-replace'.
;;
;; 2009-03-19 (1.0.5)
;;    Fixed `highlight-symbol-idle-delay' void variable message.
;;    Fixed color repetition bug.  (thanks to Hugo Schmitt)
;;
;; 2008-05-02 (1.0.4)
;;    Added `highlight-symbol-on-navigation-p' option.
;;
;; 2008-02-26 (1.0.3)
;;    Added `highlight-symbol-remove-all'.
;;
;; 2007-09-06 (1.0.2)
;;    Fixed highlighting with delay set to 0.  (thanks to Stefan Persson)
;;
;; 2007-09-05 (1.0.1)
;;    Fixed completely broken temporary highlighting.
;;
;; 2007-07-30 (1.0)
;;    Keep temp highlight while jumping.
;;    Replaced `highlight-symbol-faces' with `highlight-symbol-colors'.
;;    Fixed dependency and Emacs 21 bug.  (thanks to Gregor Gorjanc)
;;    Prevent calling `highlight-symbol-at-point' on nil.
;;
;; 2007-04-20 (0.9.1)
;;    Fixed bug in `highlight-symbol-jump'.  (thanks to Per Nordlöw)
;;
;; 2007-04-06 (0.9)
;;    Initial release.
;;
;;; Code:

(require 'thingatpt)
(require 'hi-lock)
(eval-when-compile (require 'cl))

(push "^No symbol at point$" debug-ignored-errors)

(defgroup highlight-symbol nil
  "Automatic and manual symbols highlighting"
  :group 'faces
  :group 'matching)

(defface highlight-symbol-face
  '( (((class color) (background dark))
     ;(:background "gray55"))
     (:foreground "Black" :background "yellow"))
    (((class color) (background light))
     (:background "gray90")))
  "*Face used by `highlight-symbol-mode'."
  :group 'highlight-symbol)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; Hi Drew, 
;; Is there a command that runs every time concurrently with each interactive
;; command to decode the current command without the user pressing a key?
;;
;; I want to use something like:
;; ;;made up "current-command" (if (current-command (not eq my-command1) (this-mode
;; 0) ;;
;; but I don't want to call anything from lisp or the keyboard to get the "if"
;; (logically not literally).
;; The general use is to cancel a mode automatically, in the case where the user
;; interactively runs a command that is not in its mode map.  There will be a limit
;; of only a handful of commands in the mode.  So I want to decode everything else
;; and use that event to cancel the minor mode.
;; I seem to remember something like this from a manual but can't find it now.
;; Thanks
;; Mike
;;
;; Hi Mike,
;; Sorry, I don't understand well what you're asking. But it sounds like you should
;; look at variable `pre-command-hook'. You can put a function on that hook that
;; will do whatever you want to do, before the command gets executed.
;; 
;; See (elisp) Command Overview.
;; 
;; Variable: pre-command-hook This normal hook is run by the editor command loop
;;      before it executes each command.  At that time, `this-command' contains the
;;      command that is about to run, and `last-command' describes the previous
;;      command.  *Note Command Loop Info::.
;; 
;; HTH - Drew

(defun my-highlight-symbol-hook ()
   "before every command check if it is one of these two, if it is turn
    hsm on if its not turn it off."
   (interactive)
   ;
   ;don't run this hook defun in the minibuffer
   ;Saw a case where the smex minibuffer got in a wierd state temporarily
   ;then my take on highlight-symbol got goofy.  Try not running it in the
   ;minibufer
   ;
   ;(message "got here 1")
   (ignore-errors
   
   (unless (and 
            (window-minibuffer-p)
              (not (or
              (eq major-mode 'emacs-lisp-mode)
              (eq major-mode 'vhdl-mode)
              (eq major-mode 'verilog-mode)
              (eq major-mode 'tcl-mode)
              (eq major-mode 'text-mode)
              (eq major-mode 'dired-mode)
              (eq major-mode 'sr-mode)
              (eq major-mode 'shell-mode)
              (eq major-mode 'eshell-mode)
              (eq major-mode 'ruby-mode))))
   ;
     ;(message "got here 2")
     (if (not
            (or (eq this-command 'recenter-top-bottom)
            (eq this-command 'scroll-up-keep-cursor)
            (eq this-command 'scroll-down-keep-cursor)))
       
     ;(message "got here 3")
     (progn 
        (if (or (eq this-command 'highlight-symbol-next)
                (eq this-command 'highlight-symbol-prev))
              ;(message "got here 4")
              ;
              (progn
                 ;(message "hsm on")
                 (highlight-symbol-mode 1)
                 ;
                 ;
                 (if (boundp 'hl-line-when-idle-p)
                 (toggle-hl-line-when-idle 0)))
                 ;
              (progn 
                 (if (highlight-symbol-mode) 
                  (highlight-symbol-remove-all))
                 ;
                 (highlight-symbol-mode 0)
                 ;
                 (if (and (boundp 'hl-line-when-idle-p) (eq hl-line-when-idle-p nil))
                   ; Highlight only when idle
                   (toggle-hl-line-when-idle 1)))))))))

;try removing this
(add-hook 'pre-command-hook 'my-highlight-symbol-hook)
;(remove-hook 'pre-command-hook 'my-highlight-symbol-hook)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


(defvar highlight-symbol-timer nil)

(defun highlight-symbol-update-timer (value)
  (when highlight-symbol-timer
    (cancel-timer highlight-symbol-timer))
  (setq highlight-symbol-timer
        (and value (/= value 0)
             (run-with-idle-timer value t 'highlight-symbol-temp-highlight))))

(defvar highlight-symbol-mode nil)

(defun highlight-symbol-set (symbol value)
  (when symbol (set symbol value))
  (when highlight-symbol-mode
    (highlight-symbol-update-timer value)))

;; (defcustom highlight-symbol-idle-delay 1.5 ;mtf
(defcustom   highlight-symbol-idle-delay 0.125
  "*Number of seconds of idle time before highlighting the current symbol.
If this variable is set to 0, no idle time is required.
Changing this does not take effect until `highlight-symbol-mode' has been
disabled for all buffers."
  :type 'number
  :set 'highlight-symbol-set
  :group 'highlight-symbol)

(defcustom highlight-symbol-colors
  '("yellow" "DeepPink" "cyan" "MediumPurple1" "SpringGreen1"
    "DarkOrange" "HotPink1" "RoyalBlue1" "OliveDrab")
  "*Colors used by `highlight-symbol-at-point'.
highlighting the symbols will use these colors in order."
  :type '(repeat color)
  :group 'highlight-symbol)

(defcustom highlight-symbol-on-navigation-p nil
  "*Wether or not to temporary highlight the symbol when using
`highlight-symbol-jump' family of functions."
  :type 'boolean
  :group 'highlight-symbol)

(defvar highlight-symbol-color-index 0)
(make-variable-buffer-local 'highlight-symbol-color-index)

(defvar highlight-symbol nil)
(make-variable-buffer-local 'highlight-symbol)

(defvar highlight-symbol-list nil)
(make-variable-buffer-local 'highlight-symbol-list)

(defconst highlight-symbol-border-pattern
  (if (>= emacs-major-version 22) '("\\_<" . "\\_>") '("\\<" . "\\>")))

;;;###autoload
(define-minor-mode highlight-symbol-mode
  "Minor mode that highlights the symbol under point throughout the buffer.
Highlighting takes place after `highlight-symbol-idle-delay'."
  nil " hl-s" nil
  (if highlight-symbol-mode
      ;; on
      (let ((hi-lock-archaic-interface-message-used t))
        (unless hi-lock-mode (hi-lock-mode 1))
        (highlight-symbol-update-timer highlight-symbol-idle-delay)
        (add-hook 'post-command-hook 'highlight-symbol-mode-post-command nil t))
    ;; off
    (remove-hook 'post-command-hook 'highlight-symbol-mode-post-command t)
    (highlight-symbol-mode-remove-temp)
    (kill-local-variable 'highlight-symbol)))

;;;###autoload
(defun highlight-symbol-at-point ()
  "Toggle highlighting of the symbol at point.
This highlights or unhighlights the symbol at point using the first
element in of `highlight-symbol-faces'."
  (interactive)
  ;
  (message "\nReached beginning of highlight-symbol-at-point")
  ;
  (let ((symbol (highlight-symbol-get-symbol)))
    (unless symbol (error "No symbol at point"))
    (unless hi-lock-mode (hi-lock-mode 1))
    (if (member symbol highlight-symbol-list)
        ;; remove
        (progn
          (setq highlight-symbol-list (delete symbol highlight-symbol-list))
          (hi-lock-unface-buffer symbol))
      ;; add
      (when (equal symbol highlight-symbol)
        (highlight-symbol-mode-remove-temp))
      (let ((color (nth highlight-symbol-color-index
                        highlight-symbol-colors)))
        (if color ;; wrap
            (incf highlight-symbol-color-index)
          (setq highlight-symbol-color-index 1
                color (car highlight-symbol-colors)))
        (setq color `((background-color . ,color)
                      (foreground-color . "black")))
        ;; highlight
        (with-no-warnings
          (if (< emacs-major-version 22)
              (hi-lock-set-pattern `(,symbol (0 (quote ,color) t)))
            (hi-lock-set-pattern symbol color)))
        (push symbol highlight-symbol-list))))
  (message "Reached end of highlight-symbol-at-point\n"))
  
;;;###autoload
(defun highlight-symbol-remove-all ()
  "Remove symbol highlighting in buffer."
  (interactive)
  (mapc 'hi-lock-unface-buffer highlight-symbol-list)
  (setq highlight-symbol-list nil))

;;;###autoload
(defun highlight-symbol-next (arg)
  "Jump to the next location of the symbol at point within the function
  with M-- arg jump to the first occurance."
  (interactive "p")
  (if (looking-at "\\s-") ;MTF
  (progn
    (my-thing-finder)
    (highlight-symbol-mode 1))
  ;line below is orig, two above depend on thingatpoint+
  ;(highlight-symbol-mode 1)
  (highlight-symbol-jump 1 arg)))

;;;###autoload
(defun highlight-symbol-prev (arg)
  "Jump to the previous location of the symbol at point within the function.
  with M-- arg jump to the last occurance."
  (interactive "p")
  (if (looking-at "\\s-") 
  (my-thing-finder)
  ;line below is orig, two above depend on thingatpoint+
  (highlight-symbol-jump -1 arg)))

;;;###autoload
(defun highlight-symbol-next-in-defun ()
  "Jump to the next location of the symbol at point within the defun."
  (interactive)
  (save-restriction
    (narrow-to-defun)
    (highlight-symbol-jump 1)))

;;;###autoload
(defun highlight-symbol-prev-in-defun ()
  "Jump to the previous location of the symbol at point within the defun."
  (interactive)
  (save-restriction
    (narrow-to-defun)
    (highlight-symbol-jump -1)))

;;;###autoload
(defun highlight-symbol-query-replace (replacement)
  "*Replace the symbol at point."
  (interactive (let ((symbol (or (thing-at-point 'symbol)
                                 (error "No symbol at point"))))
                 (highlight-symbol-temp-highlight)
                 (set query-replace-to-history-variable
                      (cons (substring-no-properties symbol)
                            (eval query-replace-to-history-variable)))
                 (list
                  (read-from-minibuffer "Replacement: " nil nil nil
                                        query-replace-to-history-variable))))
  (goto-char (beginning-of-thing 'symbol))
  (query-replace-regexp (highlight-symbol-get-symbol) replacement))

(defun highlight-symbol-get-symbol ()
  "Return a regular expression dandifying the symbol at point."
  (let ((symbol (thing-at-point 'symbol))) 
  ;(let ((symbol (tap-symbol-name-nearest-point))) ;the inner defun returns a string
  ;
  ;added MTF the variable gets converted to a regex just below
  ;I want the stting         
  (setq my-symbol symbol)
  ;
    (when symbol (concat (car highlight-symbol-border-pattern)
                         (regexp-quote symbol)
                         (cdr highlight-symbol-border-pattern)))))

(defun highlight-symbol-temp-highlight ()
  "Highlight the current symbol until a command is executed."
  (when highlight-symbol-mode
    (let ((symbol (highlight-symbol-get-symbol)))
      (unless (or (equal symbol highlight-symbol)
                  (member symbol highlight-symbol-list))
        (highlight-symbol-mode-remove-temp)
        (when symbol
          (setq highlight-symbol symbol)
          (hi-lock-set-pattern symbol 'highlight-symbol-face))))))

(defun highlight-symbol-mode-remove-temp ()
  "Remove the temporary symbol highlighting."
  (when highlight-symbol
    (hi-lock-unface-buffer highlight-symbol)
    (setq highlight-symbol nil)))

(defun highlight-symbol-mode-post-command ()
  "After a command, change the temporary highlighting.
Remove the temporary symbol highlighting and, unless a timeout is specified,
create the new one."
  (if (eq this-command 'highlight-symbol-jump)
      (when highlight-symbol-on-navigation-p
        (highlight-symbol-temp-highlight))
    (if (eql highlight-symbol-idle-delay 0)
        (highlight-symbol-temp-highlight)
      (highlight-symbol-mode-remove-temp))))

(defun highlight-symbol-jump (dir &optional my-beg-or-end)
  "Jump to the next or previous occurence of the symbol at point.
DIR has to be 1 or -1."
  (interactive)
  (let ((symbol (highlight-symbol-get-symbol)) (my-orig-pos (point)) )
    (if symbol
        (let* ((case-fold-search nil)
               (bounds (bounds-of-thing-at-point 'symbol))
               ;(bounds (tap-bounds-of-symbol-nearest-point))
               (offset (- (point) (if (< 0 dir) (cdr bounds) (car bounds))))
               (my-special-case-first-or-last-line))
          (unless (eq last-command 'highlight-symbol-jump)
            (push-mark (point) t))
          
          ;"other-window" functionality
          ;removal of hightlighting in original buffer issue
          (when (eq my-beg-or-end -2) 
            (highlight-symbol-remove-all)
            (other-window 1)
	    (re-search-forward symbol nil t dir)
            (highlight-symbol-at-point))
          ;how does it act with a - arg
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
          ;FIRST OCCURANCE 
          (if
              ;want to locate the first occurance
              (and (eq my-beg-or-end -1) (eq dir 1))
                   (progn 
                   (goto-char (point-min))
                   (setq my-special-case-first-or-last-line t)
                   (message "Going to first occurance of symbol")))
          ;LAST OCCURANCE
          (if 
              (and (eq my-beg-or-end -1) (eq dir -1))
                   (progn
                   (goto-char (point-max))
                   (setq my-special-case-first-or-last-line t)
                   (message "Going to last occurance of symbol")))
          ;  
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;This is the jump section
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;move a little, so we don't find the same instance again
          ;MTF ONLY FOR NOT THE SPECIAL CASE
          (when (not my-special-case-first-or-last-line)
             (goto-char (- (point) offset)))
             ;
             (let (
                ;THIS IS THE JUMP
                (target (re-search-forward symbol nil t dir)))
                 
                ;DON'S SEE HOW THIS GETS EXECUTED
                (unless target
                  (goto-char (if (< 0 dir) (point-min) (point-max))) 
                  (setq target (re-search-forward symbol nil nil dir)))
                ;
                ;(when (not my-special-case-first-or-last-line)
                  (goto-char (+ target offset))
             )
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;  
          (setq this-command 'highlight-symbol-jump)
          ;
	  ;MTF add the symbol at point to the isearch ring
	  (isearch-update-ring my-symbol)
     )
      (error "No symbol at point"))
    ;
    ;is it the only one?
     (save-excursion
     (if (or
         (re-search-forward symbol nil t 1)
         (re-search-forward symbol nil t -1))
     ;T
     ;; (message "not the only one")
     (setq my-junk-temp t)
     ;
     ;F
     (progn
       (message "I am the only one")
       (if (not (< my-beg-or-end 0))
       (progn
        (message "No JUMPS Found for symbol \"%s\" in this buffer" my-symbol)
        (highlight-symbol-mode 0));no need to highlight the only one
       
       (highlight-symbol-mode 0)))
     ))

    
    
    
    ;; (when
    ;;     (and
    ;;      (not (< my-beg-or-end 0));
    ;;      (eq (point) my-orig-pos)
    ;;      );point has not moved before->after this cmd
    ;;       (message "No JUMPS Found for symbol \"%s\" in this buffer" my-symbol)
    ;;       (highlight-symbol-mode 0));no need to highlight the only one
;
    )

  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-highlight-symbol-other-window ()
 (interactive)
  "Grab symbol at point in current window, switch to next window, highlight, 
  symbol grabbed.  Assume working in 2-window split."
  (message "\n--Reached beginning of my-highlight-symbol-other-window")
  (let ((execute-window-jump-flow t))
     ;
     (setq  my-global-jump-symbol (highlight-symbol-get-symbol) )
     (other-window 1)
     ;
     ;Case where you change window and the same symbol is there
     ;Happens when you repeat my-highlight-symbol-other-window without
     ;moving the cursor.  Fix it by detecting it then moving.
     ;; (when  (string-equal my-global-jump-symbol (thing-at-point 'symbol) )
     (when  (string-equal my-global-jump-symbol (highlight-symbol-get-symbol) )
     ;perhaps quoto these regex's so if the font is differet they match
            (message "same'")
            (when (not (eq (forward-line -1) 0))
               (forward-line 1)))
     ;
     (if  (not (re-search-forward my-global-jump-symbol (point-max) t 1))
       ;
       (when (not (re-search-backward my-global-jump-symbol (point-min) t 1))
         (message "SYMBOL NOT FOUND OTHER WINDOW")
         (setq execute-window-jump-flow nil)
         (other-window 1)))
     ;  
     (when execute-window-jump-flow
       (highlight-symbol-at-point)
       (toggle-hl-line-when-idle 0)
       ;(forward-char -1)
       )
  )
  (message "--Reached end of my-highlight-symbol-other-window\n"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(provide 'highlight-symbol)

;;; highlight-symbol.el ends here

