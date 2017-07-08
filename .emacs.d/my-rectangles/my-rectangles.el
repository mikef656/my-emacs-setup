;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;New binding to toggle editing rectangle
;http://trey-jackson.blogspot.com/2008/10/emacs-tip-26-cua-mode-specifically.html
;I'm a big fan of cua-rectangles. But when I first started using them, 
;I found it very awkward to have two different keybindings for starting a 
;region and a rectangle. I wanted to have them both on C-SPC... So here's what
; I came up with:
;MTF also changed the binding in cua-base.el like this
  ;;remove: ; MTF (defcustom cua-rectangle-mark-key [(control return)]
  ;;add    (defcustom cua-rectangle-mark-key [(control f1)]
;control return is now free to do other things as in Icicles and w32browser  
;
;consider using
;tap-bounds-of-string-at-point
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;sequential-command
(message "reached before load sequential-command")
(when  load-sequential-command
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/sequential-command/")
    (require 'sequential-command))
    ;
  (message "--Error is load sequential-command--")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;make a new syntax table, that adds . to a word definition to tempororily
;search for VHDL identifiers that are record types first_part.second_part
;note that I needed to have the _ char here, so this did not add to what
;was already there, but rather over-wrote what was there
; . and _ are parts of words as defined here
(defvar my-rectangle-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?. "w" table)
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?- "w" table)
    (modify-syntax-entry ?= "w" table)
    (modify-syntax-entry ?+ "w" table)
    (modify-syntax-entry ?> "w" table)
    table))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar max-word-column 0 "aoeu")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(setq a ())
;(push "A" a)
;(listp a)


;(setq temp-result my-parse-lines)


(defun my-parse-lines (&optional arg-decend-raged)
   "select a col as a cua-rectangle, dont' go thur
   blank or almost blank (blank from current col to eol) lines"
   (interactive)
   (let (
         (started-here (point))
         (my-current-column (current-column))
         (all-lines-list ())
         (one-line-result-list ())
         )
   ;
   (while (line-is-not-blank-se-p)
      (setq one-line-result-list (parse-one-line))
      (push one-line-result-list all-lines-list)
      (forward-line)
      (move-to-column my-current-column))
   ;   
   ;(setq temp started-here)
   (goto-char started-here)
   ;
   ;instrumentation
   (setq aoeu all-lines-list)
   ;
   all-lines-list))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

       
;reverse

;(setq all-lines-list ())
;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun parse-one-line ()   
   (interactive)
   (with-syntax-table my-rectangle-syntax-table
   (let (my-list)
   (while (< (point) (line-end-position))
       ;(if current-column
       (push (re-search-forward "\\>" (line-end-position)  t) my-list )
       (unless (equal (point) (line-end-position)) (forward-char 1)))
   (reverse my-list))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun edge-check ()   
;;   (interactive)
;;     (let (current-not-at-blank previous-is-blank)
;;     (when (not (looking-at "\\s-+")) (setq current-not-at-blank t))
;;     ;
;;     (backward-char 1)
;;     (when (looking-at "\\s-+") (setq previous-is-blank t))
;;     (setq edge (and previous-is-blank current-not-at-blank)))
;;     edge)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun edge-check ()   
  (interactive)
    (save-excursion
    (backward-char 1)
    (if  (looking-at "\\S-\\S-") 
    t
    nil)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;   k
;;   k
;; kkk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;(setq my-list-reverse (nreverse my-list))
;(length my-list-reverse)

(defun my-string-geter ()
  (interactive)
  (setq temps (tap-bounds-of-string-at-point)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-rect-block-sel (&optional arg-verbose arg-decend-raged)
   "select a block as a cua-rectangler dont' go thur
   blank or almost blank (blank from current col to eol) lines"
   (interactive)
   arg-decend-raged
   (cua-set-rectangle-mark)
   ;
   (setq running-max-delta-to-eol 0)
   ;
   (while  (not (next-line-is-almost-blank-se-p nil arg-decend-raged))
     (my-longest-rect-block-line)
     (cua-resize-rectangle-down 1))
   ;
   ;one more time in case the last line is the longest
   (my-longest-rect-block-line)
   ;
   ;Resize to the end of longent line as discovered above
   (cua-resize-rectangle-right running-max-delta-to-eol)
   ;
   ;this protocol goes one to far
   (cua-resize-rectangle-left 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun next-line-is-almost-blank-se-p (&optional arg-verbose arg-decend-raged) 
      ""
      (interactive "*")
      arg-decend-raged
      (save-excursion
      (push-mark nil nil)
      (setq my-prev-keep-col (current-column))
      (forward-line)
      (move-to-column my-prev-keep-col nil)
      (if (almost-blank-line arg-decend-raged)
           (setq next-line-blank t)
           (setq next-line-blank nil))
       (jump-to-mark)
       (setq my-temp next-line-blank)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;add a prefix arg to so the user can choose to check the before space part
(defun almost-blank-line (&optional arg-decend-raged)
   (interactive)
   (let (almost-blank-termitate char-before-space)
     ;almost blank part
     (if (looking-at "\\s-*$")
         (setq almost-blank-termitate t)
         (setq almost-blank-termitate nil))
     ;
     ;this part checks char before is a space
     (unless arg-decend-raged
       (if (not (eq (current-column) 0))
         (progn
           (backward-char 1)
           (if (looking-at "\\s-")
             (setq char-before-space nil)
             (setq char-before-space t))
           (forward-char 1))))
     ;
     (or almost-blank-termitate char-before-space)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-rect-col-sel (&optional arg-decend-raged)
   "select a col as a cua-rectangle, dont' go thur
   blank or almost blank (blank from current col to eol) lines"
   (interactive)
   arg-decend-raged
   (cua-set-rectangle-mark)
   ;
   (setq running-max-delta-to-eol 0)
   ;
   (while  (not (next-line-is-almost-blank-se-p nil arg-decend-raged))
     (my-longest-rect-block-line)
     (cua-resize-rectangle-down 1))
   ;
   (cua-resize-rectangle-up 2)
   ;
   ;one more time in case the last line is the longest
   (my-longest-rect-block-line))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-longest-rect-block-line ()
  "helps find the longest line when doing block work,
  If this line is longer than the last make it the new
  longest.  The measure is from the current col rather than
  bol, because this is block\rectangle oriented"
   (interactive)
   (setq cur-max-delta-to-eol ( -(line-end-position) (point)))
   (if ( > cur-max-delta-to-eol running-max-delta-to-eol)
       (setq running-max-delta-to-eol cur-max-delta-to-eol)))
;
;
;; (defun almost-blank-line ()
;;  "almost blank means blank from current col to eol"
;;    (interactive)
;;    (if (looking-at "\\s-*$")
;;      (message "Almost")))
;
;
;CUA Rect with mouse, 
;S-mouse1 to set top left corner 
;then S-mouse1 to set bot rt corner
;http://askubuntu.com/questions/117522/
;  emacs-column-editing-cua-mode-is-it-possible-to-select-rectangular-region-with
(require 'cua-rect)
(defun hkb-mouse-mark-cua-rectangle (event)
  (interactive "e")
  (if (not cua--rectangle)
  (cua-mouse-set-rectangle-mark event)
(cua-mouse-resize-rectangle event)))
;
;(require 'cua-base)
(require 'cua-base)
; bindings in my-dvorak-bindings.el
;
;;(global-unset-key (kbd "<S-down-mouse-1>"))
;;(global-set-key (kbd "<S-mouse-1>") 'hkb-mouse-mark-cua-rectangle)
;;(define-key cua--rectangle-keymap (kbd "<S-mouse-1>") 'hkb-mouse-mark-cua-rectangle)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-blank-rect(arg &optional arg-decend-raged)
   "Make blank rectangles 1 col wide
    With no arg rect bottom is defined by the first blank line
    With numeric arg rect is that number of rows high"
   (interactive "p") 
   (cua-set-rectangle-mark)
   ;
   ;interactive p with no arg->1
   (if (eq arg 1)
      (progn
        ;(while (line-is-not-blank-p)        
        ;
        ;
        (while  (not (next-line-is-almost-blank-se-p nil arg-decend-raged))
          (cua-resize-rectangle-down 1)))
       ;;
       (progn
         (let ((counter arg))
         (while (> counter 0)        
           (cua-resize-rectangle-down 1)
           (setq counter (1- counter)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;New binding to toggle editing rectangle
;http://trey-jackson.blogspot.com/2008/10/emacs-tip-26-cua-mode-specifically.html
;I'm a big fan of cua-rectangles. But when I first started using them, 
;I found it very awkward to have two different keybindings for starting a 
;region and a rectangle. I wanted to have them both on C-SPC... So here's what
; I came up with:
;MTF also changed the binding in cua-base.el like this
  ;;remove: ; MTF (defcustom cua-rectangle-mark-key [(control return)]
  ;;add    (defcustom cua-rectangle-mark-key [(control f1)]
;control return is now free to do other things as in Icicles and w32browser  
(global-set-key (kbd "C-SPC") 'my-big-rect-defun)
;
(defun my-big-rect-defun (&optional arg-ragged-decent)
"First call: Set the mark.
Second call:Start a cua rectangle.
Third call : move down, creating a single column rectatgle, not wider left
  than the curent column.
Fourth call: Auto select a block, using the width of the widest line.

With any prefix arg just prior to the third call, move down thru ragged 
boundaries until a newline is encountered"
  (interactive "P")
     (if (or (not mark-active) nil)
       ;T, first call, mark not active-set it
       (progn 
         (cua-set-mark nil) 
         (setq editing_rect nil) 
         (setq orig_pos (point)))
       ;F, second call, mark active,start rect
       (if cua--rectangle
         ;T,third call already in a rect
         (progn (message "in a rect") 
            (if editing_rect 
               ;T,have run block sel->clear block, make a blank strip.
               (progn 
                 (cua-toggle-rectangle-mark) ;clear exitsting
                 (goto-char orig_pos)        ;go back to the orig point
                  (my-rect-block-sel) 
                 )          
               ;F have not run block sel ->run it
               (progn
                 arg-ragged-decent
                 (my-blank-rect 1 arg-ragged-decent)
                  (setq editing_rect t))))
         ;F
         (cua-toggle-rectangle-mark))))
;
;needs to happen one time to make above work
(cua-set-rectangle-mark)
(cua-toggle-rectangle-mark)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-rect-test-1 (&optional arg-ragged-decent)
"Narrow strip"
  (interactive "P")
  (my-blank-rect 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-rect-test-2 (&optional arg-ragged-decent)
"To end of block"
  (interactive "P")
  (my-rect-block-sel))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-rect-long-word-sel (&optional arg-decend-raged)
   "select a block where the rhs of the block is the rt most char of 
   words going down.  Don't go thru blank lines."
   (interactive)
   (let ((target-column nil))
   ;
   (setq max-word-column 0)
   arg-decend-raged
   ;
   (cua-set-rectangle-mark)
   (setq orig-column (current-column))
   ;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ; this loop is really awkward, maybe move the check to the end by
   ; moving it there and assigning it to a var, and the var is checked
   ; at the top using while
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   (while  (not (next-line-is-almost-blank-se-p nil arg-decend-raged))
     (progn
       (setq target-column (my-last-col-of-word))
       (cua-resize-rectangle-down 1)))
   ;
   (setq target-column (my-last-col-of-word))
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;
   ;re-size is the delta rather than absolute column
   ;"How many additional columns rt to move"
   (cua-resize-rectangle-right (-  target-column orig-column 1))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-last-col-of-word ()
  "- and _ need to be part of the word for this to work"
  (interactive)
  ;
  (with-syntax-table my-rectangle-syntax-table
  ;
  (let ((new-end-of-word-column 0))
  ;
  ; need to be of a word boundry for this to work
  (when (looking-at "\\>") (forward-char 1))
  ;
  ;find the end of a word
  (re-search-forward "\\>" (line-end-position) t)
  ;
  ;save the colum at the end of the word boundry
  (setq new-end-of-word-column (current-column))
  ;
  ;if it's > the old max then save it as the new max
  (if (> new-end-of-word-column max-word-column)
    (setq max-word-column new-end-of-word-column))
  ;
  max-word-column)))

; example
; use1 this t o get the word bound (bounds-of-thing-at-point 'symbol)
; use12 this t o get the word bound (bounds-of-thing-at-point 'symbol)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;New binding to toggle editing rectangle
;http://trey-jackson.blogspot.com/2008/10/emacs-tip-26-cua-mode-specifically.html
;I'm a big fan of cua-rectangles. But when I first started using them, 
;I found it very awkward to have two different keybindings for starting a 
;region and a rectangle. I wanted to have them both on C-SPC... So here's what
; I came up with:
;MTF also changed the binding in cua-base.el like this
  ;;remove: ; MTF (defcustom cua-rectangle-mark-key [(control return)]
  ;;add    (defcustom cua-rectangle-mark-key [(control f1)]
;control return is now free to do other things as in Icicles and w32browser  
(global-set-key (kbd "C-SPC") 'my-big-rect-defun)
;
;
;needs to happen one time to make above work
(cua-set-rectangle-mark)
(cua-toggle-rectangle-mark)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;needs to happen one time to make above work
(cua-set-rectangle-mark)
(cua-toggle-rectangle-mark)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




 ;;    aoeu
 ;;     aoeu
 ;;     aoeu
 ;;     aoeu
 ;;     aoeu
 ;;     aoeu

 ;; htnsaoeuaoeuaoeuaoeu
 ;; htnsaoeuaoeuaoeuaoeu
 ;; htnsaoeuaoeuaoeuaoeu
 ;; htnsaoeuaoeuaoeuaoeu
 ;; htnsaoeuaoeuaoeuaoeu
 ;; htnsaoeuaoeuaoeuaoeu

 ;;        1234
 ;;        1234
 ;;        1234
 ;;        1234
 ;;        1234


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://ergoemacs.org/emacs/emacs_copy_rectangle_text_to_clipboard.html
(defun youngfrog/copy-rectangle-to-kill-ring (start end)
  "Saves a rectangle to the normal kill ring. Not suitable for yank-rectangle."
  (interactive "r")
  (let ((lines (extract-rectangle start end)))
    (with-temp-buffer
      (while lines ;; insert-rectangle, but without the unneeded stuff
        ;; (most importantly no push-mark)
        (insert-for-yank (car lines))
        (insert "\n")
        (setq lines (cdr lines)))
      (kill-ring-save (point-min) (point-max)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-rect-wrap-set-cua-mark (&optional arg-ragged-decent)
"Set the regular mark"
  (interactive "P")
  (setq orig-rect-start (point))
  (cua-set-mark))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-rect-wrap-set-rect-mark (&optional arg-ragged-decent)
"Set the cua rec mark which starts a rectangle "
  (interactive "P")
  (cua-toggle-rectangle-mark))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-rect-wrap-thin-strip (&optional arg-ragged-decent)
"Narrow strip rect"
  (interactive "P")
  (my-blank-rect 1 arg-ragged-decent))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-rect-wrap-end-of-words (&optional arg-ragged-decent)
"End of first word"
  (interactive "P")
  (cua-toggle-rectangle-mark)
  (goto-char orig-rect-start)
  (my-rect-long-word-sel  arg-ragged-decent))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-rect-wrap-block-to-end-of-line (&optional arg-ragged-decent)
"Block to end of line"
  (interactive "P")
  (cua-toggle-rectangle-mark)
  (goto-char orig-rect-start)
  (my-rect-block-sel))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clean-up-from-last-rert ()
  "Helpful"
  (interactive)
  (cua-toggle-rectangle-mark)
  (goto-char orig-rect-start))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (define-sequential-command seq-rect
    my-rect-wrap-set-cua-mark
    my-rect-wrap-set-rect-mark
    my-rect-wrap-thin-strip
    my-rect-wrap-end-of-words
    my-rect-wrap-block-to-end-of-line)
;
;(global-set-key "\C-x\C-z" 'seq-rect)
; above  binding conflicts with a frames binding

;;(global-set-key (kbd "<M-f9>") 'seq-rect)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rectangle to register
; use
; M-x view-register
; C-x r i  which prompts the user to which rectangle register to paste
(defun rtr1 ()
  "Rectangle to register
  use
  M-x view-register
  C-x r i  which prompts the user to which rectangle register to paste"
  (interactive)
  (copy-rectangle-to-register 
   (string-to-char (number-to-string 1)) (mark) (point) nil))
;
(defun rtr2 ()
  "Rectangle to register                                               
  use                                                                  
  M-x view-register                                                    
  C-x r i  which prompts the user to which rectangle register to paste"
  (interactive)
  (copy-rectangle-to-register 
   (string-to-char (number-to-string 2)) (mark) (point) nil))
;
(defun rtr3 ()
  "Rectangle to register                                               
  use                                                                  
  M-x view-register                                                    
  C-x r i  which prompts the user to which rectangle register to paste"
  (interactive)
  (copy-rectangle-to-register 
   (string-to-char (number-to-string 3)) (mark) (point) nil))
;
(defun rtr4 ()
  "Rectangle to register                                               
  use                                                                  
  M-x view-register                                                    
  C-x r i  which prompts the user to which rectangle register to paste"
  (interactive)
  (copy-rectangle-to-register 
   (string-to-char (number-to-string 4)) (mark) (point) nil))
;
(defun rtr5 ()
  "Rectangle to register                                               
  use                                                                  
  M-x view-register                                                    
  C-x r i  which prompts the user to which rectangle register to paste"
  (interactive)
  (copy-rectangle-to-register 
   (string-to-char (number-to-string 5)) (mark) (point) nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun position-prior-to-ace-jump ()
  "Return the position of where ace jump started"
  (interactive)
    (setq my-orig-position (point)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun ace-jump-rectangle()
  (interactive)
    (add-hook 'ace-jump-mode-end-hook 'get/save-position-end-of-ace-jump)
    (call-interactively 'ace-jump-char-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get/save-position-end-of-ace-jump ()
  "return the position of where ace jumps to"
  (interactive)
    ;
    (setq ace-jump-end-position (point))
    (setq ace-jump-end-column (current-column))
    (setq ace-jump-end-line  (line-number-at-pos))
    ;
    (goto-char my-orig-position)
    ;
    (setq ace-jump-mode-end-hook nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-after-load ace-jump-mode
  (add-hook 'ace-jump-mode-before-jump-hook 'position-prior-to-ace-jump 'append))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun goto-orig-end-of-ace-jump (&optional arg)
  "return the position of where ace jumps to"
  (interactive)
    (if arg (goto-char my-orig-position) (message "no arg")) 
    (setq my-go-back nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (message "reached the end of my-rectangles.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-rectangles)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
