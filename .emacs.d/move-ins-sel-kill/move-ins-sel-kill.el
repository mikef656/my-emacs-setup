;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  FUNCTIONS HERE
;; align-repeat-vhdl-signals-constants (start end)
;; call-first-line-of-buffer-p ()
;; call-last-line-of-buffer-p ()
;; chomp (str)
;; comment-dwim-line (&optional arg)
;; copy-paragraph (&optional arg)
;; copy-thing (begin-of-thing end-of-thing &optional arg)
;; copy-word-near-point ()
;; del-whole-line-with-end ()
;; del-word-backwards-mike ()
;; del-word-mike ()
;; delete-horizontal-space-forward ()
;; duplicate-line-or-region (&optional n)
;; extend-selection (arg &optional incremental)
;; first-line-of-buffer-p (&optional arg-verbose)
;; flush-blank-lines-buffer-or-region ()
;; forward-word-dont-go-over-non-words ()
;; flush-comp ()
;; flush-pm ()
;; get-point (symbol &optional arg)
;; insert-and-indent-line-above ()
;; insert-and-indent-line-below ()
;; insert-lastyank-above (arg)
;; insert-lastyank-next-line (arg)
;; insert-lastyank-this-line (arg)
;; jump-to-mark ()
;; kill-and-join-forward (&optional arg)
;; last-line-of-buffer-p (&optional arg-verbose)
;; my-mark-line-forward
;; my-mark-line-backward
;; make-room-around-line ()
;; move-line (n)
;; move-line-down (n)
;; move-line-region-down (start end n)
;; move-line-region-down-wrapper ()
;; move-line-region-up (start end n)
;; move-line-region-up-wrapper ()
;; move-line-up (n)
;; move-region (start end n)
;; move-region-down (start end n)
;; move-region-up (start end n)
;; my-backwards-indent ()
;; my-backwards-indent ()
;; my-delete-leading-whitespace (start end)
;; my-drag-symbol-or-selection-left ()
;; my-drag-symbol-or-selection-right ()
;; my-filter ()
;; my-fixup-whitespace ()
;; my-insert-file-name (filename &optional args)
;; my-move-word-left ()
;; my-move-word-rt ()
;; my-next-test-p ()
;; my-prev-test-p ()
;; my-sel-symbol ()
;; my-thing-finder ()
;; myjunk ()
;; next-line-is-blank-p (&optional arg-verbose)
;; paste-to-mark(&optional arg)
;; power-down-para ()
;; power-down-select-para ()
;; power-move-word-left ()
;; power-move-word-rt ()
;; power-select-word-left ()
;; power-select-word-rt ()
;; power-up-para ()
;; power-up-select-para ()
;; prev-line-is-blank-p (&optional arg-verbose)
;; push-mark-no-activate ()
;; quick-copy-line ()
;; quick-copy-line-bk ()
;; quick-copy-line-stay ()
;; recenter-top-bottom (&optional arg)
;; remove-newline-from-last-kill-as-new-kill (arg)
;; rotate-windows ()
;; scroll-down-keep-cursor ()
;; scroll-up-keep-cursor ()
;; select-current-line ()
;; select-current-word ()
;; select-text-in-quote ()
;; semnav-up (arg)
;; seq-times (name &optional max)
;; smart-beginning-of-line ()
;; smart-beginning-of-line-old ()
;; smart-beginning-of-line-select ()
;; smart-end-of-line ()
;; super-duper-power-down-para ()
;; super-duper-power-up-para ()
;; super-power-down-para ()
;; super-power-up-para ()
;; two-blank-lines ()
;; undouble-newline ()
;; whole-line-with-end ()
;; zap-up-to-char (arg char)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun insert-lastyank-next-line (arg)
"Insert last cut text in a newline below the current line
With a negative preflx make the insertion roomy by adding
an extra line above and below"
   (interactive "p")
   (setq mytempstr (car kill-ring-yank-pointer))
   (setq mystrNew
   (with-temp-buffer
   (insert (car kill-ring-yank-pointer))
   ;move point to just before the end of the buffer
   (end-of-buffer)
   (backward-char 2)
      ;
      ;1 Determine if the thing being pasted is a word or line
      ;2 by examining if it has an end of line.
      ;3 Remove that end of line if it has one
      (if (re-search-forward "\n" nil t)
         ;TRUE set a variable to indicate line
         (setq str_is_word_var (progn(replace-match "" nil nil)
         (message "Thing is a line") nil ))
         ;
         ;FALSE set a variable to indicate word
         (setq str_is_word_var (progn(message "Thing is a Word") t )))
         ;
      (buffer-string))) ; get result of temp buffer, pass it back
         ;;
      (if str_is_word_var
        ;TRUE:Indent for word
        (progn
           (insert-and-indent-line-below)
           ;add an extra line above and below
           (if(> 0 arg)
           (progn
              (insert-and-indent-line-above)
              (insert-and-indent-line-below))))
         ;
         ;FALSE insert at next BOL for line
        (progn
           (progn(end-of-line) (newline))
      ;(insert-and-indent-line-below)
      ;add an extra line above and below
      (if(> 0 arg)
      (progn
         (insert-and-indent-line-above)
         (insert-and-indent-line-below)))
      ;
      (beginning-of-line)))
         ;
   (insert mystrNew)
   (smart-beginning-of-line))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(defun insert-lastyank-this-line (arg)
"Insert last cut text on this line do not put in an newline
With a negative preflx make the insertion roomy by adding
an extra line above and below"
   (interactive "p")
   (setq mytempstr (car kill-ring-yank-pointer))
   (setq mystrNew
   (with-temp-buffer
   (insert (car kill-ring-yank-pointer))
   ;move point to just before the end of the buffer
   (end-of-buffer)
   (backward-char 2)
      ;
      ;1 Determine if the thing being pasted is a word or line
      ;2 by examining if it has an end of line.
      ;3 Remove that end of line if it has one
      (if (re-search-forward "\n" nil t)
         ;TRUE set a variable to indicate line
         (setq str_is_word_var (progn(replace-match "" nil nil)
         (message "Thing is a line") nil ))
         ;
         ;FALSE set a variable to indicate word
         (setq str_is_word_var (progn(message "Thing is a Word") t )))
         ;
      (buffer-string))) ; get result of temp buffer, pass it back
         ;;
      (if str_is_word_var
        ;TRUE:Indent for word
        (progn
           ;(insert-and-indent-line-below)
           ;add an extra line above and below
           (if(> 0 arg)
           (progn
              (insert-and-indent-line-above)
              (insert-and-indent-line-below))))
         ;
         ;FALSE insert at next BOL for line
        (progn
           ;; (progn(end-of-line) (newline))
           (progn(end-of-line) )
      ;(insert-and-indent-line-below)
      ;add an extra line above and below
      (if(> 0 arg)
      (progn
         (insert-and-indent-line-above)
         (insert-and-indent-line-below)))
      ;
      (beginning-of-line)))
         ;
   (insert mystrNew)
   (smart-beginning-of-line))
;
(defun insert-lastyank-above (arg)
"Insert last cut text in a newline above the current line.
With a negative preflx make the insertion roomy by adding
an extra line above and below"
   (interactive "p")
   (setq mytempstr (car kill-ring-yank-pointer))
   (setq mystrNew
   (with-temp-buffer
   (insert (car kill-ring-yank-pointer))
   ;move point to just before the end of the buffer
   (end-of-buffer)
   (backward-char 2)
      ;
      ;1 Determine if the thing being pasted is a word or line
      ;2 by examining if it has an end of line.
      ;3 Remove that end of line if it has one
      (if (re-search-forward "\n" nil t)
         ;TRUE:set a variable to indicate line
         (setq str_is_word_var (progn(replace-match "" nil nil)
         (message "Inserting a line") nil ))
         ;FALSE:set a variable to indicate word
         (setq str_is_word_var (progn(message "Inserting a Word") t )))
         (buffer-string))) ; get result of temp buffer, pass it back
      ;
      (if str_is_word_var
        ;TRUE:Indent for word
        (progn
           (insert-and-indent-line-above)
           ;add an extra line above and below
           (if(> 0 arg)
           (progn
              (insert-and-indent-line-above)
              (insert-and-indent-line-below))))
         ;
         ;FALSE:insert at prev BOL for line
        (progn
      (insert-and-indent-line-above)
      ;add an extra line above and below
      (if(> 0 arg)
      (progn
         (insert-and-indent-line-above)
         (insert-and-indent-line-below)))
      ;
      (beginning-of-line)))
      ;
      (insert mystrNew)
      (smart-beginning-of-line)
)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Home Key Behavior improvement
;http://stackoverflow.com/questions/145291/smart-home-in-emacs
(defun smart-beginning-of-line-old ()
 "Move point to first non-whitespace character or beginning-of-line.
   If point was already at indentation, move point to beginning of line.
   If point was at beginning of line, move to indentation"
 ;(interactive) ; Use (interactive "^") in Emacs 23 to make shift-select work
 (interactive "^")
 ;; (if (= (point) (line-beginning-position)) (end-of-line)
 (if (= (point) (line-beginning-position)) (back-to-indentation)
 (progn
 (let ((oldpos (point)))
   (back-to-indentation)
   (and (= oldpos (point))
        (beginning-of-line))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Home Key Behavior improvement
;http://stackoverflow.com/questions/145291/smart-home-in-emacs
(defun smart-beginning-of-line ()
 "Move point to first non-whitespace character or beginning-of-line on this line
If point was already at that position, move point to the other"
 ;(interactive) ; Use (interactive "^") in Emacs 23 to make shift-select work
 (interactive "^")
 (if (eq major-mode 'eshell-mode)
   ;T -> eshell
   (eshell-bol)
   ;F -> not eshell
   (progn
      (if (and (= (point) (point-min)) (eq this-command last-command))
        (progn
           (jump-to-mark))
        ;
        (progn
        ;
           (if (and (= (point) (line-beginning-position)) (eq this-command last-command))
               (progn
                 (push-mark)
                 ;; (goto-char (point-min)))
                 (back-to-indentation))
               (progn
                  (let ((oldpos (point)))
                    (back-to-indentation)
                    (and (= oldpos (point))
                         (beginning-of-line))))))))))

;; -----------------------------------------------------------------------------
;; Give this a try
;; -----------------------------------------------------------------------------
(defun xah-beginning-of-line-or-block ()
  "Move cursor to beginning of line or previous paragraph.

• When called first time, move cursor to beginning of char in current line. (if already, move to beginning of line.)
• When called again, move cursor backward by jumping over any sequence of whitespaces containing 2 blank lines.

URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
Version 2017-05-13"
  (interactive)
  (let (($p (point)))
    (if (or (equal (point) (line-beginning-position))
            (equal last-command this-command ))
        (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
            (progn
              (skip-chars-backward "\n\t ")
              (forward-char ))
          (goto-char (point-min)))
      (progn
        (back-to-indentation)
        (when (eq $p (point))
          (beginning-of-line))))))
          
; -----------------------------------------------------------------------------
; give this a try
; -----------------------------------------------------------------------------
(defun xah-end-of-line-or-block ()
  "Move cursor to end of line or next paragraph.

• When called first time, move cursor to end of line.
• When called again, move cursor forward by jumping over any sequence of whitespaces containing 2 blank lines.

URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
Version 2017-05-30"
  (interactive)
  (if (or (equal (point) (line-end-position))
          (equal last-command this-command ))
      (progn
        (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" ))
    (end-of-line)))

(defun smart-end-of-line ()
 "Move point to first non-whitespace character or beginning-of-line.
Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line.
If point was at beginning of line, move to the end"
 ;(interactive) ; Use (interactive "^") in Emacs 23 to make shift-select work
 (interactive "^")
 (if (and (= (point) (point-max)) (eq this-command last-command))
     (progn
        (jump-to-mark))
     ;
     (progn
     ;
        (if (and (= (point) (line-end-position)) (eq this-command last-command))
            (progn
            (push-mark)
            ;; (goto-char (point-max)))
            (next-line 1))
        (progn
               (end-of-line))))))

(defun smart-end-of-line-select ()
 "Move point to first non-whitespace character or beginning-of-line.
Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line.
If point was at beginning of line, move to the end"
 ;(interactive) ; Use (interactive "^") in Emacs 23 to make shift-select work
 (interactive "^")
 (if (and (= (point) (point-max)) (eq this-command last-command))
     (progn
        (jump-to-mark))
     ;
     (progn
     ;
        (if (and (= (point) (line-end-position)) (eq this-command last-command))
            (progn
            (push-mark)
            ;(goto-char (point-max)))    ;
            (next-line 1))
        (progn
               (set-mark (point)) (end-of-line))))))
;
(defun smart-beginning-of-line-select ()
 "Move point to first non-whitespace character or beginning-of-line.
Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line.
If point was at beginning of line, move to the end"
 ;(interactive) ; Use (interactive "^") in Emacs 23 to make shift-select work
 (interactive "^")
 (if (= (point) (line-beginning-position) )
 (progn (set-mark (point)) (end-of-line)  )
 (progn
 (let
   ((oldpos (point)))
   ;;(set-mark (point))
   (if (not (eq last-command 'smart-beginning-of-line-select))
   (set-mark (point)))
   (back-to-indentation)
   (and (= oldpos (point))
        (beginning-of-line))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-next-line ()
 "Next line, honor shift selection"
 (interactive "^")
 (next-line 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-next-line (arg)
;;  "Next line, honor shift selection
;;   C-u prefix arg skips that number of lines (minus number works)"
;;  (interactive "^p")
;;  (unless  (eq 1 arg)
;;    (message "Moving %s lines" arg))
;;  ;; (next-line arg)) ; help for next-line says it's for interactive use only
;;  (forward-line arg))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-forward-char ()
 "Next char, honor shift selection"
 (interactive "^")
 (forward-char 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-backward-char ()
 "backwards char, honor shift selection"
 (interactive "^")
 (backward-char 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-left-word ()
 "backwards word, honor shift selection"
 (interactive "^")
 (left-word 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-right-word ()
 "Forward word, honor shift selection"
 (interactive "^")
 (right-word 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-prev-line ()
 "previous line, honor shift selection"
 (interactive "^")
 (previous-line 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Move line and region
;http://www.emacswiki.org/emacs/MoveRegion
(defun move-line (n)
  "Move the current line up or down by N lines.  this is broken for the last
  line of a buffer it tries to move beyond point-max and errors out fix me by
  detecting last line of file and calling insert-and-indent-line-below.  Follow
  up, seem to work and i did nothing, when point is on the last line of a buffer
  and you run forward-char it can move down to the beginnig of the next line
  which means you are just past the newline.  This seems normal More follow up
  what I saw was some sort of buffer lf-cr at the end of the buffer that seems
  to always exist, except when starting a new buffer prior to saving it.  When
  the buffer is saved, it seems to have a newline char added to the end."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))
;
(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))
;
(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))
;
(defun move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))
;
(defun move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))
;
(defun move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))
;
(defun move-line-region-up (start end n)
  (interactive "r\np")
  (if (region-active-p) (move-region-up start end n) (move-line-up n)))
;
(defun move-line-region-up-wrapper ()
 "solves the issur where mark is nil after emacs starts, and the basic
 defun move-line-region-x has the interactive \"r\' spec that bombs out
 when the mark is nil"
  (interactive)
  (if (eq (mark) nil)
      (push-mark (point)));push-mark does not set the region
  (move-line-region-up  (mark) (point) nil))
;
;
(defun move-line-region-down (start end n)
  (interactive "r\np")
  (if (region-active-p) (move-region-down start end n) (move-line-down n)))
;
(defun move-line-region-down-wrapper ()
 "solves the issur where mark is nil after emacs starts, and the basic
 defun move-line-region-x has the interactive \"r\" spec that bombs out
 when the mark is nil"
  (interactive )
  (if (eq (mark) nil)
      (push-mark (point)));push-mark does not set the region
  (move-line-region-down  (mark) (point) nil))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Sequential Power move and select
;http://www.emacswiki.org/emacs/SequentialCommand
 ;; Sequence commands  1.0
 (defvar seq-store-times 0)
 (defvar seq-start-point 0
   "Stores location of pointer when sequence of calls of the same
 function was started. This variable is updated by `seq-times'")
;
 (defun seq-times (name &optional max)
   "Returns number of times command `name' was executed. If `max'
 is specified the counter will wrap around at the value of `max'
 never reaching it. It also updates `seq-start-point'."
   (if (eq last-command name)
       (if (= (setq seq-store-times (1+ seq-store-times)) max)
           (setq seq-store-times 0) seq-store-times)
     (setq seq-start-point (point) seq-store-times 0)))
;
(defun power-move-word-rt () "Go to end of line or first time 5 words, second time 2, third 1" (interactive)
   (let ((n (seq-times 'power-move-word-rt 8)))
   ;(if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (forward-word 8))
           ((= n 1) (forward-word 3))
           ((= n 2) (forward-word 1))
           ((= n 3) (forward-word 1))
           ((= n 4) (forward-word 1))
           ((= n 5) (forward-word 1))
           ((= n 6) (forward-word 1))
           (t (goto-char seq-start-point)))))
;
(defun power-select-word-rt () "Go to end of line or first time 8 words, second time 3, third 1" (interactive "^")
   (let ((n (seq-times 'my-end 8)))
   (if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (forward-word 8))
           ((= n 1) (forward-word 3))
           ((= n 2) (forward-word 1))
           ((= n 3) (forward-word 1))
           ((= n 4) (forward-word 1))
           ((= n 5) (forward-word 1))
           ((= n 6) (forward-word 1))
           (t (goto-char seq-start-point)))))
;
(defun power-move-word-left () "Go to end of line or first time 8 words, second time 3, third 1" (interactive)
   (let ((n (seq-times 'power-move-word-left 8)))
   ;(if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (backward-word 8))
           ((= n 1) (backward-word 3))
           ((= n 2) (backward-word 1))
           ((= n 3) (backward-word 1))
           ((= n 4) (backward-word 1))
           ((= n 5) (backward-word 1))
           ((= n 6) (backward-word 1))
           (t (goto-char seq-start-point)))))
;
(defun power-select-word-left () "Go to end of line or first time 8 words, second time 3, third 1" (interactive "^")
   (let ((n (seq-times 'my-end 8)))
   (if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (backward-word 8))
           ((= n 1) (backward-word 3))
           ((= n 2) (backward-word 1))
           ((= n 3) (backward-word 1))
           ((= n 4) (backward-word 1))
           ((= n 5) (backward-word 1))
           ((= n 6) (backward-word 1))
           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;From http://www.kieranhealy.org/esk/starter-kit-bindings.html
(defun rotate-windows ()
   "Rotate your windows" (interactive) (cond ((not (> (count-windows) 1)) (message "You can't rotate a single window!"))
(t
 (setq i 1)
 (setq numWindows (count-windows))
 (while  (< i numWindows)
   (let* (
          (w1 (elt (window-list) i))
          (w2 (elt (window-list) (+ (% i numWindows) 1)))
          (b1 (window-buffer w1))
          (b2 (window-buffer w2))
          (s1 (window-start w1))
          (s2 (window-start w2))
          )
     (set-window-buffer w1  b2)
     (set-window-buffer w2 b1)
     (set-window-start w1 s2)
     (set-window-start w2 s1)
     (setq i (1+ i)))))))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;from the Adams package at
;;http://www.emacswiki.org/emacs/misc-cmds.el
;;Cool functions one passes buffer file name to a shell command
;;;###autoload
(defun recenter-top-bottom (&optional arg)
  "Move current line to window center, top, and bottom, successively.
With a prefix argument, this is the same as `recenter':
 With numeric prefix ARG, move current line to window-line ARG.
 With plain `C-u', move current line to window center.
;
Otherwise move current line to window center on first call, and to
top, middle, or bottom on successive calls.
;
The starting position of the window determines the cycling order:
 If initially in the top or middle third: top -> middle -> bottom.
 If initially in the bottom third: bottom -> middle -> top.
;
Top and bottom destinations are actually `scroll-conservatively' lines
from true window top and bottom."
  (interactive "P")
  (if arg                               ; Always respect ARG.
      (recenter arg)
    (case last-command
      (recenter-tb-top                  ; Top -> middle -> bottom
       (setq this-command 'recenter-tb-middle)
       (recenter))
      (recenter-tb-middle
       (setq this-command 'recenter-tb-bottom)
       (recenter (1- (- scroll-conservatively))))
      (recenter-tb-bottom
       (setq this-command 'recenter-tb-top)
       (recenter scroll-conservatively))
      (recenter-tb-bottom-1             ; Bottom -> middle -> top
       (setq this-command 'recenter-tb-middle-1)
       (recenter))
      (recenter-tb-middle-1
       (setq this-command 'recenter-tb-top-1)
       (recenter scroll-conservatively))
      (recenter-tb-top-1
       (setq this-command 'recenter-tb-bottom-1)
       (recenter (1- (- scroll-conservatively))))
      (otherwise                        ; First time - save mode and recenter.
       (let ((top (1+ (count-lines 1 (window-start))))
             (current (1+ (count-lines 1 (point))))
             (total (window-height)))
         (if (< (- current top) (/ total 3))
             (setq this-command 'recenter-tb-middle)
           (setq this-command 'recenter-tb-middle-1)))
       (recenter)))))
(substitute-key-definition   'recenter 'recenter-top-bottom global-map)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-move-word-left ()
   "move left by a word honor shift selection"
   (interactive "^")
   (backward-word 1) )
;
(defun my-move-word-rt ()
   "move rt by a word honor shift selection"
   (interactive "^")
   (forward-word 1) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun myjunk ()
   "move rt by a word honor shift selection"
   (interactive)
   (icy-mode 0)
   (ido-mode 1)
   (ido-find-file)
   (sit-for 1.0)
   (ido-mode 0)
   (icy-mode 1))
;; (defadvice myjunk (after myjunk (arg))
;;   "Insert an empty line when moving up from the top line."
;;   (icy-mode t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun power-down-para ()
"Go down paragraphs first time 8, second time 4, third 2 4-7 1"
 (interactive "^")
   (let ((n (seq-times 'power-down-para 8)))
   ;(if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (forward-paragraph 8)(message "moving down 8 paragraphs"))
           ((= n 1) (forward-paragraph 4)(message "moving down 4 paragraphs"))
           ((= n 2) (forward-paragraph 2)(message "moving down 2 paragraphs"))
           ((= n 3) (forward-paragraph)  (message "moving down 1 paragraphs"))
           ((= n 4) (forward-paragraph)  (message "moving down 1 paragraphs"))
           ((= n 5) (forward-paragraph)  (message "moving down 1 paragraphs"))
           ((= n 6) (forward-paragraph)  (message "moving down 1 paragraphs"))
           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun power-down-select-para ()
"Go down paragraphs and select, first time 8, second time 4, third 2 4-7 1"
 (interactive "^")
   (let ((n (seq-times 'power-down-select-para 8)))
   ;(if (eq mark-active nil) (set-mark (point)))
   (if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (forward-paragraph 8)(message "selecting down 8 paragraphs"))
           ((= n 1) (forward-paragraph 4)(message "selecting down 4 paragraphs"))
           ((= n 2) (forward-paragraph 2)(message "selecting down 2 paragraphs"))
           ((= n 3) (forward-paragraph  )(message "selecting down 1 paragraphs"))
           ((= n 4) (forward-paragraph  )(message "selecting down 1 paragraphs"))
           ((= n 5) (forward-paragraph  )(message "selecting down 1 paragraphs"))
           ((= n 6) (forward-paragraph  )(message "selecting down 1 paragraphs"))
           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun power-up-para ()
"Go up  paragraphs first time 8, second time 4, third 2 4-7 1"
 (interactive "^")
   (let ((n (seq-times 'power-up-para 8)))
   ;(if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (backward-paragraph 8)(message "moving up 8 paragraphs"))
           ((= n 1) (backward-paragraph 4)(message "moving up 4 paragraphs"))
           ((= n 2) (backward-paragraph 2)(message "moving up 2 paragraphs"))
           ((= n 3) (backward-paragraph)  (message "moving up 1 paragraphs"))
           ((= n 4) (backward-paragraph)  (message "moving up 1 paragraphs"))
           ((= n 5) (backward-paragraph)  (message "moving up 1 paragraphs"))
           ((= n 6) (backward-paragraph)  (message "moving up 1 paragraphs"))
           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun super-power-up-para ()
"Go up  paragraphs first time 16, second time 8, third 4 4-7 1"
 (interactive "^")
   (let ((n (seq-times 'super-power-up-para 8)))
   ;(if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (backward-paragraph 16)(message "moving up 16 paragraphs"))
           ((= n 1) (backward-paragraph 8 )(message "moving up 8  paragraphs"))
           ((= n 2) (backward-paragraph 4 )(message "moving up 4  paragraphs"))
           ((= n 3) (backward-paragraph 2 )(message "moving up 2  paragraphs"))
           ((= n 4) (backward-paragraph   )(message "moving up 2  paragraphs"))
           ((= n 5) (backward-paragraph   )(message "moving up 1  paragraphs"))
           ((= n 6) (backward-paragraph   )(message "moving up 1  paragraphs"))
           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun super-power-down-para ()
"Go up  paragraphs first time  16, second time 8, third 4 4-7 1"
 (interactive "^")
   (let ((n (seq-times 'super-power-down-para 8)))
   ;(if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (forward-paragraph 16)(message "moving down 16 paragraphs"))
           ((= n 1) (forward-paragraph 8 )(message "moving down 8  paragraphs"))
           ((= n 2) (forward-paragraph 4 )(message "moving down 4  paragraphs"))
           ((= n 3) (forward-paragraph 2 )(message "moving down 2  paragraphs"))
           ((= n 4) (forward-paragraph   )(message "moving down 1  paragraphs"))
           ((= n 5) (forward-paragraph   )(message "moving down 1  paragraphs"))
           ((= n 6) (forward-paragraph   )(message "moving down 1  paragraphs"))
           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun super-duper-power-up-para ()
"Go up  paragraphs first time 32, second time 16..."
 (interactive "^")
   (let ((n (seq-times 'super-duper-power-up-para 8)))
   ;(if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (backward-paragraph 32)(message "moving up 32 paragraphs"))
           ((= n 1) (backward-paragraph 16)(message "moving up 16 paragraphs"))
           ((= n 2) (backward-paragraph 8 )(message "moving up 8  paragraphs"))
           ((= n 3) (backward-paragraph 4 )(message "moving up 4  paragraphs"))
           ((= n 4) (backward-paragraph 2 )(message "moving up 2  paragraphs"))
           ((= n 5) (backward-paragraph   )(message "moving up 1  paragraphs"))
           ((= n 6) (backward-paragraph   )(message "moving up 1  paragraphs"))
           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun super-duper-power-down-para ()
"Go up  paragraphs first time 32, second time 16..."
 (interactive "^")
   (let ((n (seq-times 'super-duper-power-down-para 8)))
   ;(if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (forward-paragraph 32)(message "moving down 32 paragraphs"))
           ((= n 1) (forward-paragraph 16)(message "moving down 16 paragraphs"))
           ((= n 2) (forward-paragraph 8 )(message "moving down 8  paragraphs"))
           ((= n 3) (forward-paragraph 4 )(message "moving down 4  paragraphs"))
           ((= n 4) (forward-paragraph 2 )(message "moving down 2  paragraphs"))
           ((= n 5) (forward-paragraph   )(message "moving down 1  paragraphs"))
           ((= n 6) (forward-paragraph   )(message "moving down 1  paragraphs"))
           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun power-up-select-para ()
"Go up  paragraphs and select first time 8, second time 4, third 2 4-7 1"
 (interactive "^")
   (let ((n (seq-times 'power-up-select-para 8)))
   (if (eq mark-active nil) (set-mark (point)))
     (cond ((= n 0) (backward-paragraph 8)(message "selecting up 8 paragraphs"))
           ((= n 1) (backward-paragraph 4)(message "selecting up 4 paragraphs"))
           ((= n 2) (backward-paragraph 2)(message "selecting up 2 paragraphs"))
           ((= n 3) (backward-paragraph  )(message "selecting up 1 paragraphs"))
           ((= n 4) (backward-paragraph  )(message "selecting up 1 paragraphs"))
           ((= n 5) (backward-paragraph  )(message "selecting up 1 paragraphs"))
           ((= n 6) (backward-paragraph  )(message "selecting up 1 paragraphs"))
           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Orginally http://www.emacswiki.org/emacs/CopyWithoutSelection#toc6
;;Pulled it for copy para perhaps my own sub expression
(defun get-point (symbol &optional arg)
      "get the point"
      (funcall symbol arg)
      (point)
     )
;;
     (defun copy-thing (begin-of-thing end-of-thing &optional arg)
       "copy thing between beg & end into kill ring"
        (save-excursion
          (let ((beg (get-point begin-of-thing 1))
             (end (get-point end-of-thing arg)))
            (copy-region-as-kill beg end)))
     )
;;
     (defun paste-to-mark(&optional arg)
       "Paste things to mark, or to the prompt in shell-mode"
       (let ((pasteMe
       (lambda()
         (if (string= "shell-mode" major-mode)
           (progn (comint-next-prompt 25535) (yank))
         (progn (goto-char (mark)) (yank) )))))
      (if arg
          (if (= arg 1)
         nil
            (funcall pasteMe))
        (funcall pasteMe))
      ))
;;
(defun copy-paragraph (&optional arg)
      "Copy paragraphes at point"
       (interactive "P")
       (copy-thing 'backward-paragraph 'forward-paragraph arg)
       ;;(paste-to-mark arg)
     )
;uding this binding for reeenter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;KILL-BLANK-LINE function
;It saves the location of point and mark, executes the body of the
; function, and then restores point and mark to their previous positions
;if their locations were changed. Its primary purpose is to keep the user
; from being surprised and disturbed by unexpected movement of point or mark.
(defun undouble-newline ()
  "Delete doubled newlines from the current buffer."
  (interactive)
  (save-excursion
    ;(replace-regexp "\n\n" "\n" nil mystart (point))))
    (replace-regexp "\n\n" "\n")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun dosomething-region (p1 p2)
  "Prints region starting and ending positions."
  (interactive "r")
  (message "Region starts: %d, end at: %d" p1 p2))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun duplicate-line-or-region (&optional n)
  "Duplicate current line, or region if active.
With argument N, make N copies.
With negative N, comment out original line and use the absolute value."
   (interactive "*p")
   (let ((use-region (use-region-p)))
      (save-excursion
         (let ((text
                  (if use-region        ;Get region if active, otherwise line
                     ;region true
                     (progn
              ;when M-h is used to select a paragraph point ends up
              ;behind mark which this function does not like
              (if (< (point)(mark)) (exchange-point-and-mark) )
                        ;Grab the region
                        (buffer-substring (region-beginning) (region-end))
           )
                     ;
                     ;FALSE
           ;
                     ;MTF, without activatinf the mark if it has never been set then the function does not work
           ;Note don't allways do this because it ruins the region in the region active case
           (push-mark (point) t)
           ;
                     (prog1 (thing-at-point 'line)
                        (end-of-line)
                        ;really samrt way to use return val from (forward-line 1) to manage
            ;what happens near the end of file!
                        (if (< 0 (forward-line 1)) ;Go to beginning of next line, or make a new one
                            (newline))
              ))));; end of assignment for let
              ;;symbol text contains a region or line
        ;
            (kill-new text);Push what was coped to the kill ring
            (dotimes (i (abs (or n 1)))     ;Insert N times, or once if not specified
               (insert text)
          )
        );;end of inside let
      );;end of save ex
      ;
       (if (> 0 n) ;Comment out original with negative arg
          (progn (comment-dwim-line)))
       ;
       (if   (eq use-region  nil)  ;make point end up at the beginning of new
          (progn (forward-line 1) (smart-beginning-of-line-old))
     (back-to-indentation);I think this is helpful??
       )
   );;end of outside let
)
  ;;end of defun
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://stackoverflow.com/questions/622440/emacs-command-to-insert-and-indent-line-above-cursor
;I frequently find myself typing on a line, when I realize I need(ed) a
;variable definition (or something similar) on the line above.
;What I would like is to
;  1.press C-return from anywhere on a line and have the cursor move to a
;  newly inserted blank line above, with correct indentation
;     (or at least the same as the original line).
;  2.be able to yank any text...
;  3.and C-u C-space to get back to the original position
(defun insert-and-indent-line-above ()
  (interactive)
  (push-mark (point) t)
  ;;
  ;;This form of let creates locals and assigns them without setq
  ;;locals are ipt,bol,indent
  (let*(;;assign position of indentation to local ipt
    (ipt (progn (back-to-indentation) (point)))
    ;
    ;;assign position of the orginal line begin to bol
    (bol (progn (move-beginning-of-line 1) (point)))
    ;
    ;;assign the string from BOL to the indent (blank) to local indent
    (indent (buffer-substring bol ipt)))
        ;;
        ;;Newline called from BOL
        (newline)
        (previous-line)
        (insert indent)))
;
(defun insert-and-indent-line-below ()
  (interactive)
  (push-mark (point) t)
  ;;
  ;;This form of let creates locals and assigns them without setq
  (let*(;;assign position of indentation to local ipt
    (ipt (progn (back-to-indentation) (point)))
    ;
    ;;assign position of the orginal line begin to bol
    (bol (progn (move-beginning-of-line 1) (point)))
    ;
    (indent (buffer-substring bol ipt)))
    ;;assign the string from BOL to the indent (blank) to local indent
        ;;
        ;;called from orginal line BOL
        (end-of-line)
        (newline)
        (insert indent)))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/98a0ed755d0999a0?pli=1
;; ;; by Nikolaj Schumacher, 2008-10-20. Released under GPL.
(defun semnav-up (arg)
  (interactive "p")
  (when (nth 3 (syntax-ppss))
    (if (> arg 0)
        (progn
          (skip-syntax-forward "^\"")
          (goto-char (1+ (point)))
          (decf arg))
      (skip-syntax-backward "^\"")
      (goto-char (1- (point)))
      (incf arg)))
  (up-list arg))
;;
(defun extend-selection (arg &optional incremental)
  "Select the current word.
Subsequent calls expands the selection to larger semantic unit."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     (or (and transient-mark-mode mark-active)
                         (eq last-command this-command))))
  (if incremental
      (progn
        (semnav-up (- arg))
        (forward-sexp)
        (mark-sexp -1))
    (if (> arg 1)
        (extend-selection (1- arg) t)
      (if (looking-at "\\=\\(\\s_\\|\\sw\\)*\\_>")
          (goto-char (match-end 0))
        (unless (memq (char-before) '(?\) ?\"))
          (forward-sexp)))
      (mark-sexp -1))))
;;
;
;; In the above, Alt+8 is assigned to the command, because selecting
;; whole word is a commonly needed operation, and Alt+8 is one key
;; simpler than Alt+@ on a standard American layout PC keyboard.
;;
;; Pressing Alt+8 will select the current whole word. Press it again
;; will extend the selection to the next outer parens. The above code
;; effectively does extend selection to higher level of semantic unit for
;; lisp or simply nested syntax.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun select-text-in-quote ()
  "Select text between the nearest left and right delimiters.
Delimiters are paired characters:
 () [] {}
For practical purposes, it also includes double straight quote
\", but not curly single quote matching pairs  because that is
often used as apostrophy. It also consider both left and right
angle brackets <> as either beginning or ending pair, so that it
is easy to get content inside HTML tags."
 (interactive)
 (let (b1 b2)
   (skip-chars-backward "^<>([{“「『‹«（〈《〔【〖⦗〘\"")
   (setq b1 (point))
   (skip-chars-forward "^<>)]}”」』›»）〉》〕】〗⦘〙\"")
   (setq b2 (point))
   (set-mark b1)
   )
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;don't forget m-w copies the line when nothing is selected, else the region
(defun copy-word-near-point ()
   "Copy word point get ready to move to the right using mark-thing"
    (interactive)
    ;move to the nearest word
    (cycle-thing-region)
    ;move on the nearest word
    (backward-char 1)
    ;copy word
    (thing-copy-symbol)
    ;;MTF do not re-select bc any key that involves C-x like C-x C-s will blow
    ;selection away
    ;;re-se;ect the word
    ;(cycle-thing-region)
    ;get ready to move to the right using C-M Space
    (exchange-point-and-mark))
    ;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;line oriented copy and kill functions overload some stantard EMACS commands
;;   kill-ring-save M-w
;;   kill-region C-w
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy the current line."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (progn
       (message "Current line is copied.")
       (list (line-beginning-position) (line-beginning-position 2)) ) ) ))
;
(defadvice kill-region (before slick-copy activate compile)
  "When called interactively with no active region, cut the current line."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (progn
       (list (line-beginning-position) (line-beginning-position 2)) ) ) ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Select LIne
(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))
;;Needs a binding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Select Word
(defun select-current-word ()
"Select the word under cursor. word is alphanumeric with _ or -."
 (interactive)
 (let (pt)
   (skip-chars-backward "-_A-Za-z0-9")
   (setq pt (point))
   (skip-chars-forward "-_A-Za-z0-9")
   (set-mark pt)))
;;Needs a binding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; aoeu  aoeu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun whole-line-with-end ()
  "if blank then delete line
      otherwise Kill Whole Line with end."
  (interactive)
  (if  (not (line-is-not-blank-p) )
     ;T -> line is blank
     (progn
     (del-whole-line-with-end)
     )
     (progn
     ;T -> line is blank
     (setq kill-whole-line t)
     (kill-whole-line)
     (setq kill-whole-line nil))
     ))
;
;line deletion
(defun del-whole-line-with-end ()
  "Delte Whole Line with end."
  (interactive)
  (beginning-of-line)
  (delete-region (point)
    (save-excursion
    (forward-line 1) (point))))
;
;Word deletion forward
(defun del-word-mike ()
  "Delte Word"
  (interactive)
  (delete-region (point)
    (save-excursion
    (forward-word 1) (point))))
;
;Word deletion forward
(defun del-word-backwards-mike ()
  "Delte Backwards Word"
  (interactive)
  (delete-region
    (save-excursion (backward-word 1) (point))
    (point)
     ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-kill-backwards ()
  (interactive)
  (if (and (bolp) )      ;
  ;(if (and (bolp) (not (eolp)))
     ;bol
     (progn
       (c-hungry-backspace))
       (if (eq major-mode 'eshell-mode);not bol
       (eshell-kill-input)
       (kill-line 0)))) ;0 arG -> kill before point
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;consider using delete-line"Like `kill-line', but does not save to the `kill-ring'."
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun kill-and-join-forward (&optional arg)
"Neg arg:
   bol: join with previous, hungry
   not bol: kills the text before point on the current line
 No arg:
   Blank:Eats blank lines after, leaves blank lines above
   Non Blank *kills text after point on the current line.
             *At end of line, delete blank below, otherwise join with next line"
   (interactive "p")
   (if(> 0 arg)
      ;T------------------------------
      ;NEG ARG
      ;
        (my-kill-backwards)
      ;
      ;F------------------------------
      ;NOT NEG ARG
      (progn
         (if (or
              (and (eolp) (not (bolp))) ;end and not beginning
              (and (eolp) (bolp)) ;the line is just a newline
             )
            ;T----------------------
            (if (and (not (bolp)) (eolp) )
               ;T not-beg & end
               (progn
                 (if (not (line-is-not-blank-se-p))
                  ;
                  ;; (delete-indentation)
                  (progn
                    (beginning-of-line)
                    (kill-line))
                  ;
                  (progn
                    (delete-indentation t)
                    (delete-blank-lines))))
               ;--------------------------------------
               ;F beg & end
               (if (next-line-is-blank-p)
                  ;T line below is blank
                  (progn
                    ;(while ( or (next-line-is-blank-p) (not (line-is-not-blank-se-p)))
                    (while  (not (line-is-not-blank-se-p))
                    ;NEXT OR CURRENT
                      (del-whole-line-with-end))
                    (previous-line)
                    )
               ;--------------------------------------
                  ;F line below is not blank
                  (progn
                      (if (prev-line-is-blank-p)
                        (delete-indentation)
                        (progn
                          ;last line behavior unique
                          ;don't leave point at a new junk line after the existing buffer
                          (if (last-line-of-buffer-p)
                          ;T
                          (progn
                             (message "last line")
                             (delete-indentation)
                             (beginning-of-line))
                          ;F
                          (delete-blank-lines))
                        )
                      )
                      ;
                  )
                 ;(indent-relative)
               )
               ;--------------------------------------
             )
            ;F----------------------
            ;NOT EOL
               (if (and (bolp) (not (eolp)))
               ;T---------------------------------------------------------------
                  ;BOL and NOT END
                  (progn
                    ;last line behavior unique
                    ;don't leave point at a new junk line after the existing buffer
                    (if (last-line-of-buffer-p)
                    ;T
                      (progn
                         (kill-line)
                         ;(message "last line")
                         (forward-line -1))
                    ;F
                      (kill-line)
                      )
                  )
               ;----------------------------------------------------------------
               ;
               ;F-------------------------
               ;not BOL and not EOL
                  (progn
                   (if (line-is-not-blank-se-p)
                      (kill-line)
                      ;; (delete-indentation))
                      ;; (delete-blank-lines))
                      (progn
                      (beginning-of-line)
                      (kill-line)))
                  ))
               ;-------------------------
         )
      )
   )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;sandbox
  ;sandbox sandboxg

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun delete-horizontal-space-forward () ; adapted from `delete-horizontal-space'
      "*Delete all spaces and tabs after point."
      (interactive "*")
      (delete-region (point) (progn (skip-chars-forward " \n") (point))))
;; (defun delete-horizontal-space-forward () ; adapted from `delete-horizontal-space'
;;       "*Delete all spaces and tabs after point."
;;       (interactive "*")
;;       ;(while (re-search-forward "^J" (line-end-position) t)
;;        ; (replace-match "" nil nil))
;;       (while (re-search-forward "\\(^\\s-*$\\)\n" nil t)
;;           (replace-match "\n")
;; )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun next-line-is-blank-p (&optional arg-verbose)
      ""
      (interactive "*")
      (push-mark)
      (forward-line)
      (if (not (line-is-not-blank-p))
           (setq next-line-blank t)
           (setq next-line-blank nil))
       (jump-to-mark)
       (setq my-temp next-line-blank))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun next-line-is-blank-se-p (&optional arg-verbose)
      ""
      (interactive "*")
      (save-excursion
      (push-mark)
      (forward-line)
      (if (not (line-is-not-blank-p))
           (setq next-line-blank t)
           (setq next-line-blank nil))
       (jump-to-mark)
       (setq my-temp next-line-blank)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun prev-line-is-blank-p (&optional arg-verbose)
      "MTF"
      (interactive "*")
      (if (not (first-line-of-buffer-p))
        ;T
        ;not starting on the first line
        (progn
          (push-mark)
          (previous-line)
          (if (not (line-is-not-blank-p))
               (setq prev-line-blank t)
               (setq prev-line-blank nil))
           (jump-to-mark)
           (setq my-temp prev-line-blank))
        ;F
        ;this is the firstt line so the line above is not blank
        (progn my-temp ))
       )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-prev-test-p ()
      ""
      (interactive "*")
      (if (prev-line-is-blank-p)
         (message "ret t, prev blank")
         (message "ret nil, prev not blank")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-next-test-p ()
      ""
      (interactive "*")
      (if (next-line-is-blank-p)
         (message "ret t")
         (message "ret nil")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://repo.or.cz/w/emacs.git/blob_plain/HEAD:/lisp/misc.el
(defun zap-up-to-char (arg char)
  "Kill up to, but not including ARGth occurrence of CHAR.
Case is ignored if `case-fold-search' is non-nil in the current buffer.
Goes backward if ARG is negative; error if CHAR not found.
Ignores CHAR at point."
  (interactive "p\ncZap up to char: ")
  (let ((direction (if (>= arg 0) 1 -1)))
    (kill-region (point)
       (progn
         (forward-char direction)
         (unwind-protect
             (search-forward (char-to-string char) nil nil arg)
           (backward-char direction))
         (point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;needed to get command c-hungry-backspace
;perhaps something smarter at beg and end (C-u ot prompt ot last command)
;or something smarter in the middle, like removing blank lines above and
;below
(require 'cc-mode)
;
(defun my-fixup-whitespace ()
  "On blank line, delete all surrounding blank lines, leaving just one.
   On isolated blank line, delete that one.
   On nonblank line, delete any immediately following blank lines.
   At the beginning of line delete preceding blank lines.
   At the end of line delete following blank lines."
   (interactive "*")
   ;-------------------------------------------------------------------------------
   (if  (not (line-is-not-blank-se-p) )
      ;T -> line is blank
      (progn
      (message "blank line(s) deleted")
      (delete-blank-lines)
      )
      (progn     ;progn-> line is not blank
      (message "OK not blank")
         ;(if t
         (if (eolp)
            ;T -> at eol
            (progn
            (message "line:eol")
            ;(save-excursion (beginning-of-line)
            (delete-blank-lines)
            )
            ;F -> NOT at eol
            (progn
            (if (bolp)
               ;T -> beginning of line
               (progn
               (message "line:bol")
               (c-hungry-backspace)
               (insert "\n")
               )
               ;F -> not beginning of line
               (progn
               (message "line:not blank, not bol, not eol")
               (save-excursion
               (delete-blank-lines)))
            ))
         )
      )
   )
   ;-------------------------------------------------------------------------------
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;sandbox
;
;
;
      ; kfgjkdfjgk
      ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;I;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))
;
(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
This is the same as using \\[set-mark-command] with the prefix argumentk."
  (interactive)
  (set-mark-command 1))

; pulled from emacswiki
(defun unpop-to-mark-command ()
   "Unpop off mark ring. Does nothing if mark ring is empty."
   (interactive)
   (when mark-ring
     (let ((pos (marker-position (car (last mark-ring)))))
       (if (not (= (point) pos))
           (goto-char pos)
         (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
         (set-marker (mark-marker) pos)
         (setq mark-ring (nbutlast mark-ring))
         (goto-char (marker-position (car (last mark-ring))))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
  If no region is selected and current line is not blank and we are not at the end of the line,
  then comment current line.
  Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
    (interactive "*P")
    (comment-normalize-vars)
    (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
        (comment-or-uncomment-region (line-beginning-position) (line-end-position))
      (comment-dwim arg)))
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun scroll-down-keep-cursor (arg)
   ;; Scroll the text one line up while keeping the cursor
   (interactive "P")
   (let ((inside-arg 3))
   (cond
     ;normal use
     ((equal arg nil)
      (setq inside-arg 3))
     ;M-
     ((equal arg '-)
      (setq inside-arg 1))
     ;C-u 1
      ((equal arg 1)
      (setq inside-arg 1))
     ;C-u
      ((equal arg '(4))
      (setq inside-arg 1))
     ;C-u arg
      (t
      (setq inside-arg arg)))
   ;
   (scroll-down inside-arg)))
;
(defun scroll-up-keep-cursor (arg)
   ;; Scroll the text one line up while keeping the cursor
   (interactive "P")
   (let ((inside-arg 3))
   (cond
     ;normal use
     ((equal arg nil)
      (setq inside-arg 3))
     ;M-
     ((equal arg '-)
      (setq inside-arg 1))
     ;C-u 1
      ((equal arg 1)
      (setq inside-arg 1))
     ;C-u
      ((equal arg '(4))
      (setq inside-arg 1))
     ;C-u arg
      (t
      (setq inside-arg arg)))
   ;
   (scroll-up inside-arg)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-insert-file-name (filename &optional args)
    "Insert name of file FILENAME into buffer after point.
;
  Prefixed with \\[universal-argument], expand the file name to
  its fully canocalized path.  See `expand-file-name'.
;
  Prefixed with \\[negative-argument], use relative path to file
  name from current directory, `default-directory'.  See
  `file-relative-name'.
;
  The default with no prefix is to insert the file name exactly as
  it appears in the minibuffer prompt."
    ;; Based on insert-file in Emacs -- ashawley 20080926
    (interactive "*fInsert file name: \nP")
    (cond ((eq '- args)
           (insert (file-relative-name filename)))
          ((not (null args))
           (insert (expand-file-name filename)))
          (t
           (insert filename))))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (global-set-key (kbd "ESC '")  (lambda()
;;                                  (interactive)
;;                                  (message "itserting 3 spaces as a tab ")
;;                                  (insert "   ")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun two-blank-lines ()
  "Generally create orderly space
   1)If on a blank line create two blank lines (1 before, 1 after)
   where one or more existed previously,
   2)If on a non-first, non-last and non-blank, then create two around it
   3)If on a first or last  non-blank, then create two around it after or before
   the assumpcion of 3 is that the first or last lines are usually well placed
   and don't change much/often, so the most common activity is after/before"
  (interactive)
                                        ;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;starting on first line
  (if  (equal (line-number-at-pos) 1)
    (setq my-first-line-flag t)
    (setq my-first-line-flag nil))
                                        ;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (if ( not (line-is-not-blank-se-p))
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;T original line is blank
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (progn
      ;moves down from the starting point
        (while ( not (line-is-not-blank-se-p))
          (del-whole-line-with-end))
        (forward-line -1)
        (while ( not (line-is-not-blank-se-p))
          (del-whole-line-with-end)
          (forward-line -1))

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;special cases
        (if ( equal (line-number-at-pos) (count-lines (point-min) (point-max)))
            ;last line
            (end-of-line)
                                        ;
          (if (and (equal (line-number-at-pos) 1) (equal my-first-line-flag t) )
              ;currently first and started out on first
              (beginning-of-line)
              ;not the last and not the first
            (end-of-line)))
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;
        (newline 2)
                                        ;
        (message "making 2 blank lines"))
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;F original line is not blank
    (progn
      (make-room-around-line))))
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun make-room-around-line ()
   "If original line blank, call two-blank-lines,if non-blank then make room"
   (interactive)
   ;save the column
   (setq my_col (current-column))
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   (when (not ( equal (line-number-at-pos) (count-lines (point-min) (point-max))))
      ;T is not the last line
      ;(progn
         (forward-line 1)
         (if  (not (line-is-not-blank-se-p))
            (delete-blank-lines))
         (forward-line -1)
   )
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;1b
   (when (not ( equal (line-number-at-pos) 1))
       ;T is not the first line
          ;allways move back
          (forward-line -1)
          ;
          (if  (not (line-is-not-blank-se-p)    )
             ;T
             ;its blank, do something
             (progn
                (delete-blank-lines)
                ;
                (if  (not (line-is-not-blank-se-p)) (forward-line 1) )
                ;blank again, so move fwd
             )
             ;F
             ;its not blank just move bact
             (forward-line 1)
           )
    )
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;2f
   (when (not ( equal (line-number-at-pos) (count-lines (point-min) (point-max))))
      ;T is not the last line
         (forward-line 1)
         (if  (not (line-is-not-blank-se-p))
            (delete-blank-lines))
         (forward-line -1)
   )
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;2b
   (when (not ( equal (line-number-at-pos)1))
       ;T is not the first line
         (forward-line -1)
         (if  (not (line-is-not-blank-se-p)    )
            (delete-blank-lines)
            ;
         (if   (line-is-not-blank-se-p)
            (forward-line 1))
         )
   )
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   (if ( equal (line-number-at-pos) (count-lines (point-min) (point-max)))
      ;T
      (progn
         ;last line
         (beginning-of-line)
         (newline 2)
         (message "making 2 blank lines before non-blank."))
      ;F
      (if ( equal (line-number-at-pos) 1)
         ;T
         ;not last line, firstline
            (progn
               (end-of-line)
               (newline 2)
               (forward-line -2)
               (message "making 2 blank lines after non-blank."))
                    ;
         ;F
         ;not last line, ;not firstline
            (progn
               (end-of-line)
               (newline)
               (forward-line -1)
               (newline)
               ;
               (end-of-line)
               (newline)
               (forward-line -1)
               (newline)
               (message "making 2 blank lines on both sides of non-blank."))
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         )
   )
   ;restore the column
   (forward-char my_col)
)
;(global-set-key (kbd "<f12>") 'make-room-around-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;related to drag stuff
(defun my-sel-symbol ()
  "select the symbol at point"
  (interactive "p")
  (beginning-of-thing 'symbol)
  (set-mark (point))
  (end-of-thing 'symbol))
;
(defun my-drag-symbol-or-selection-right ()
  "drag the symbol or selection"
  (interactive)
  (if (region-active-p)
      (drag-stuff-right 1)
    (progn
      (my-sel-symbol)
      (drag-stuff-right 1))))
;
(defun my-drag-symbol-or-selection-left ()
  "drag the symbol or selection"
  (interactive)
  (if (region-active-p)
      (drag-stuff-left 1)
    (progn
      (my-sel-symbol)
      (drag-stuff-left 1))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;consider this from the emacswike cookbook
(defun chomp (str)
      "Chomp leading and tailing whitespace from STR."
      (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'"
                           str)
        (setq str (replace-match "" t t str)))
      str)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;EXPERIMENTAL 4-25-2012
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun quick-copy-line-bk ()
      "Copy the whole line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
      (interactive)
      ;come back
      (when (not (eq last-command 'quick-copy-line-bk)) (push-mark))
      ;
      (if (not (eq last-command 'quick-copy-line-bk))
   (message "Mark Set, Copying line")
   (message "Appending line to copy"))
      ;
      (let ((beg (line-beginning-position 2))
            (end (line-beginning-position 1)))
        (if (eq last-command 'quick-copy-line-bk)
            (kill-append (buffer-substring beg end) (< end beg))
            (kill-new (buffer-substring beg end)))
        ;; (setq mymes (buffer-substring-no-properties  end (+ end 32 ) ))
        (setq mymes (buffer-substring-no-properties  beg end))
   (setq mymes_proc (chomp mymes))
      )
      (beginning-of-line 0)
      (remove-newline-from-last-kill-as-new-kill nil)
      (if (not (eq last-command 'quick-copy-line))
        (message "COPIED LN BEG IN: \"%s...\"  TO KILL RING" mymes_proc)
        (message "APPEND LN BEG IN: \"%s...\"  TO KILL RING" mymes_proc)))
;
(defun quick-copy-line ()
      "Copy the whole line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
      (interactive)
      ;come back
      (when (not (eq last-command 'quick-copy-line)) (push-mark (point) t))
      ;
      (if (not (eq last-command 'quick-copy-line))
        (message "Mark Set, Copying line")
        (message "Appending line to copy"))
      ;
      (let ((beg (line-beginning-position 1))
            (end (line-beginning-position 2)))
        (if (eq last-command 'quick-copy-line)
       ;
            (kill-append (buffer-substring beg end) (< end beg))
            (kill-new (buffer-substring beg end)))
   ;
        (setq mymes (buffer-substring-no-properties beg end) )
        (setq mymes_proc (chomp mymes))
      )
      (beginning-of-line 2)
      (remove-newline-from-last-kill-as-new-kill nil)
      (if (not (eq last-command 'quick-copy-line))
        (message "COPIED LN BEG IN: \"%s...\"  TO KILL RING" mymes_proc)
        (message "APPEND LN BEG IN: \"%s...\"  TO KILL RING" mymes_proc))
)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun quick-copy-line-stay ()
      "Copy the whole line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
      (interactive)
      ;come back
      (when (not (eq last-command 'quick-copy-line)) (push-mark (point) t))
      ;
      (if (not (eq last-command 'quick-copy-line))
        (message "Mark Set, Copying line")
        (message "Appending line to copy"))
      ;
      (let ((beg (line-beginning-position 1))
            (end (line-beginning-position 2)))
        ;
        (if (eq last-command 'quick-copy-line)
            (kill-append (buffer-substring beg end) (< end beg))
            (kill-new (chomp (buffer-substring beg end))))

          (setq mymes (buffer-substring-no-properties beg end) )
          (setq mymes_proc (chomp mymes)))
      ;
      (remove-newline-from-last-kill-as-new-kill nil)
      (message "COPIED LN BEG IN: \"%s...\"  TO KILL RING" mymes_proc))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-smart-copy-line ()
 ""
 (interactive )
      (if (eq this-command last-command)
      (my-mark-line-forward)
      (quick-copy-line-stay)))
;
;(global-set-key [f7] 'my-smart-copy-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun align-repeat-vhdl-signals-constants (start end)
    "Align signal region reference givee
    signal my_name        : std_logic ;  "
    (interactive "r")
    ;
    ;1st group is space to the left of
    ;   ^<space>signal  OR ^<space>constant
    (align-regexp start end "\\(^\\s-*\\)[sScC]" 1 1 nil)
    ;
    ;1st group is space to the left of my_name
    (align-regexp start end "^\\s-*\\w+\\(\\s-+\\)\\w+" 1 1 t)
    ;
    ;group is space to the left of :
    (align-regexp start end  "\\(\\s-*\\):" 1 1 t)
    ;
    ;;2nd group is space to the left of std_logic
    (align-regexp start end "^\\s-*\\w+\\(\\s-+\\)\\w+\\s-+:\\(\\s-+\\)\\w+" 2 1 t)
    ;
    ;space to the left of :=
    (replace-regexp "(\\([ ]+\\):=" ":=" nil start end)
    ;
    ;1st group is space to the left first word, align comments with other stuff
    (align-regexp start end "\\(^\\s-*\\)" 1 1 nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-filter ()
    "Remove the symbol at point, them move down a line
     consider changing this to positive logic"
    (interactive )
    (if (thing-at-point 'symbol)
       (progn
       (setq mytemystr (thing-at-point 'symbol))
       (forward-line)
       (flush-lines mytemystr)
       (forward-word)
       (backward-char))
       ;
       (forward-line)
       )
    )
    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun flush-pm ()
    "clean up the port map after processing"
    (interactive )
       (beginning-of-buffer)
       (flush-lines "^\\s-*$")
       (flush-lines "^\\s-*--")
       (flush-lines "open")
       (flush-lines "(")
       (flush-lines ")")
       (flush-lines "map")
       (flush-lines "\"")
       (flush-lines "\'")
       (flush-lines "true")
       (flush-lines "false")
       ;
       (while (re-search-forward "," nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;
       (while (re-search-forward "^.*=>" nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;q
       (while (re-search-forward "\\s-+$" nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;
       (while (re-search-forward "^\\s-+" nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;
       (while (re-search-forward "--.*$" nil t)
       (replace-match ""))
       (beginning-of-buffer)
;
       (sort-lines nil (point-min) (point-max) )
       )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun flush-comp ()
    "clean up the component statement before processing"
    (interactive )
       (beginning-of-buffer)
       (flush-lines "^\\s-*$")
       (flush-lines "^\\s-*--")
       (flush-lines "open")
       ;
       (while (re-search-forward "," nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;
       (while (re-search-forward "^\\s-+" nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;
       (while (re-search-forward "^\\s-*component" nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;
       (while (re-search-forward "^\\s-*end" nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;
       (while (re-search-forward "^\\s-*port" nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;
       (while (re-search-forward "^\\s-*generic" nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;
       (while (re-search-forward "\\s-+$" nil t)
       (replace-match ""))
       (beginning-of-buffer)
       ;
       (keep-lines ": in\\|: out")
       ;
       (align-regexp (point-min) (point-max) "\\(\\s-*\\):" 1 1 nil)
       )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;(global-set-key [f12] 'my-filter)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;From the comments section of
; http://www.masteringemacs.org/articles/2011/03/16/removing-blank-lines-buffer/
(defun flush-blank-lines-buffer-or-region ()
  "Removes all blank lines from buffer or just a region if one is active"
  (interactive)
  (save-excursion
    (let (min max)
      (if (equal (region-active-p) nil)
       (mark-whole-buffer))
   (setq min (region-beginning) max (region-end))
   (flush-lines "^ *$" min max t))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun remove-newline-from-last-kill-as-new-kill (arg)
"Insert last cut text in a newline below the current line
With a negative preflx make the insertion roomy by adding
an extra line above and below"
   (interactive "p")
   (setq mytempstr (car kill-ring-yank-pointer))
   (setq mystrNew
         (with-temp-buffer
         (insert (car kill-ring-yank-pointer))
         ;move point to just before the end of the buffer
         (end-of-buffer)
         (backward-char 2)
            ;
            ;not for emacs 24??
            ;Remove that end of line if it has one
            ;(if (re-search-forward "\n" nil t)
            ;   ;TRUE set a variable to indicate line
            ;   (setq str_is_word_var (progn(replace-match "" nil nil)
            ;   (message "removing ending newline") nil ))
            ;   ;
            ;   ;FALSE set a variable to indicate word
            ;   )
               ;
            (buffer-string))) ; get result of temp buffer, pass it back
            ;
   (kill-new mystrNew))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-thing-finder ()
"When looking at space, move to the closest word"
   (interactive)
   (when (looking-at "\\s-")
      (let (temp-pos) ;local to this defun
      (setq temp-pos (car (tap-bounds-of-symbol-nearest-point)))
      (if ( < (point) temp-pos)
         (progn
           ;(message "is to the right")
           (re-search-forward "\\<" nil t)
           (forward-char 1))
         (progn
           ;(message "is to the left")
           (re-search-backward "\\>" nil t)
           (forward-char -1))))))
;; aoeuaoeu     aoeuaoeu
;; xxxxxxxxxxx^
;; 61020
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;from emacswiki MTF DOOES NOT WORK 12-31-2012
;Update 6-15-2014 changed to use start if region, works better.
;rather just CALL delete-whitespace-rectangle whith a region selected.
;; (defun my-delete-leading-whitespace (start end)
;;           "Delete whitespace at the beginning of each line in region."
;;           (interactive "*r")
;;           (save-excursion
;;             (if (not (bolp)) (forward-line 1))
;;             (delete-whitespace-rectangle start end nil)))

;svn r 2700, put back the defun from emacs-wikij
;seems to work.
(defun my-delete-leading-whitespace (start end)
  "Delete whitespace at the beginning of each line in region."
  (interactive "*r")
  (message "Don't forget, I need an active region to work")
  (save-excursion
    (if (not (bolp)) (forward-line 1))
    (delete-whitespace-rectangle (point) end nil)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-backwards-indent ()
    "Like indent-relative but backwards."
    (interactive )
    ;
    ;
    ;If I don't do this, then text mid-word
    ;    ex     aoeu
    ;             |
    ;would be deleted.  Future option?
    (if  (looking-at "\\S-")
        (skip-chars-backward   "a-zA-Z0-9_\.\\\\/()$" ))
    ;
    (let ((orig-col) (prev-indent-col))
       (setq orig-col (current-column))
       (push-mark (point) t)
       ;
       ;use line-is-not-blank-p
       (previous-line)
       (while
           (not (line-is-not-blank-p)) (previous-line))
       ;
       ;without this the re-searches may cause the the word just above
       ;point to be mistakenly identified as the new indentation.
       ;(backward-char)
       (move-to-column (- orig-col 1) t)
       ;
       (re-search-backward "\\s-\\b" (line-beginning-position) t)
       (re-search-forward "\\s-\\b" (line-end-position) t)
       ;
       (setq prev-indent-col (current-column));this sets the target
       ;
       (jump-to-mark)
       (move-to-column prev-indent-col t)
       ;(tinyeat-forward-preserve)
       (if (eq remember-prev-indent-col (current-column))
          ;T means did not move from last time
          ;must be the left most indent
           (progn
             ;(when (eq this-command last-command)
             (beginning-of-line)
             (tinyeat-forward-preserve);)
             (setq remember-prev-indent-col nil))
           ;F
           (progn
             (tinyeat-forward-preserve)
             (setq remember-prev-indent-col prev-indent-col)))
       ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-backwards-indent ()
  "Like indent-relative but backwards."
  (interactive )
  (if (or (eq (current-column) 0) (eq (line-number-at-pos) 1))
     ;T
     (message "Can't indent this poisition backwards.")
     ;F
     (progn
       (setq last-target-indent-col nil)
       ;
       ;
       ;If I don't do this, then text mid-word
       ;    ex     aoeu
       ;             |
       ;would be deleted.  Future option?
       (if  (looking-at "\\S-")
           (skip-chars-backward   "a-zA-Z0-9_\.\\\\/()$" ))
       ;
       (let ((orig-col) (target-indent-col))
          (setq orig-col (current-column))
          (push-mark (point) t)
          ;
          ;use line-is-not-blank-p
          (previous-line)
          (while
              (not (line-is-not-blank-p)) (previous-line))
          ;-------------------------------------------------------------
          ;PARSE THE LINE THAT WAS MOVED TO
          ;
          ;WITHOUT this the re-searches may cause the the word just above
          ;point to be mistakenly identified as the new indentation.
          ;(backward-char)
          (move-to-column (- orig-col 1) t)
          ;
          (if (re-search-backward "\\s-\\b" (line-beginning-position) t)
             (progn
               (re-search-forward "\\s-\\b" (line-end-position) t)
               ;
               (setq target-indent-col (current-column));this sets the target
               ;
               ;(backward-char)
               (skip-chars-backward   " " )
               ;
               (if (looking-at "^\\s-*")
                 (setq lkng-at-beg-ln-sp-ref-line t) (setq lkng-at-beg-ln-sp-ref-line nil)))
            ;
            ;F
            (progn
              (setq target-indent-col 0);this sets the target
              (setq lkng-at-beg-ln-sp-ref-line nil)))
           ;-------------------------------------------------------------
             ;
          ;MOVE BACK TO THE LINE THAT IS BEING INDENTED
          ;
          (jump-to-mark)
          ;
          (if (< (current-column) target-indent-col)
          ;T
           (message "No indetnation to move back to")
          ;F
          (progn
            ;
            (if
               (and (eq (current-column) target-indent-col) lkng-at-beg-ln-sp-ref-line)
               ;T
               (progn
                 (message "yes looking at beg-of-line-space")
                 (beginning-of-line)
                 (tinyeat-forward-preserve))
              ;
                (progn
                  ;(jump-to-mark)
                  (move-to-column target-indent-col t)
                  (tinyeat-forward-preserve)))))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun last-line-of-buffer-p (&optional arg-verbose)
 (interactive)
 "Tell if last line of buffer by returning t, if arg-verbose
  create message"
 (let (temp-junk)
 (save-excursion
 (if (eq (forward-line 2) 1)
     (progn
     (if arg-verbose
       (message "last line of buffer"))
     (setq temp-junk t))
     (setq temp-junk nil)
      ))))
;
(defun first-line-of-buffer-p (&optional arg-verbose)
 (interactive)
 "Tell if first line of buffer by returning t, if arg-verbose
  create message"
 (let (temp-junk)
 (save-excursion
 (if (eq (forward-line -2) -2)
     (progn
       (if arg-verbose
         (message "first line of buffer"))
     (setq temp-junk t))
     (setq temp-junk nil)
      ))))
;
;
(defun call-last-line-of-buffer-p ()
 (interactive)
 "Test"
  (last-line-of-buffer-p t))
;
(defun call-first-line-of-buffer-p ()
 (interactive)
 "Test"
  (first-line-of-buffer-p))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-indentanion-fix-up (&optional arg-verbose)
 (interactive)
 "Move down a line, align to column above
  If a line is blank skip over it and move to the next line
  without user key presses.  Pop mark to go back to starting place"
 (when (not (last-line-of-buffer-p t))
   ;
     ;Welcome repeated runs
     ;Set goal column on first time only (this command not = last command).
     (when (not (eq this-command last-command))
       (setq starting-column (current-column))
       (push-mark)) ;able to go back
     ;
     (forward-line 1)
     (while (not (line-is-not-blank-se-p))
       (forward-line 1))
       (move-to-column starting-column)
     ;
     (if (looking-at "\\b") ;QUESTON: should be " \\S-"
       ;T
       (progn
         (when arg-verbose
           (message "Alignment already OK")))
         ;(previous-line));probably don't want this!
       ;F
       ;Need to handle last line of file differently?
       ;specifically looking at \s-*\$
       ;integrate somewhere around here
       (if (looking-at " ")
         (tinyeat-forward-preserve)
         (progn
           (skip-chars-backward "-_A-Za-z0-9");more flexable ex path, url's etc
           (indent-relative))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-mark-line-forward ()
 "DWIM"
 (interactive)
  (if (not (region-active-p))
    (progn
       (goto-char (line-beginning-position))
       (set-mark (point))
       (end-of-line)
       (forward-char 1))
    (progn
       (forward-line 1))))
;
(defun my-mark-line-backward ()
 (interactive)
 "DWIM"
  (if (not (region-active-p))
    (progn
       (end-of-line)
       (set-mark (point))
       (goto-char (line-beginning-position))
       )
    (progn
       (forward-line -1)
       (beginning-of-line))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-mark-line-forward ()
 "DWIM"
 (interactive)
  (if (not (region-active-p))
    (progn
       (goto-char (line-beginning-position))
       (set-mark (point))
       (end-of-line)
       ;; (forward-char 1))
       )
    (progn
       (forward-line 1)
       (end-of-line))))
;
(defun my-mark-line-backward ()
 (interactive)
 "DWIM"
  (if (not (region-active-p))
    (progn
       (end-of-line)
       (set-mark (point))
       (goto-char (line-beginning-position))
       )
    (progn
       (forward-line -1)
       (beginning-of-line))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-mark-paragraph (&optional arg)
  "Select the current block of next between empty lines,
  If called 2x in a row mark the next block
  if called with a prefix arg search only from the beginning of the current line"
  ;"P" is the raw, called with no arg -> nil
  (interactive "P")
  (if (eq last-command this-command)
       ;(eq last-command 'select-2nd-block))
      ;
  (select-2nd-block)
  (select-current-block arg)))
;
(defun select-current-block (&optional arg)
  "Select the current block of next between empty lines.
  if called with a prefix arg search only from the beginning of the current line"
  ;"P" is the raw, called with no arg -> nil
  (interactive "P")
  (let (p1 p2)
    (progn
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;--for partial para don't do this
      (if (not arg)
        (progn
          (if (re-search-backward "\n[ \t]*\n" nil "move")
              (progn (re-search-forward "\n[ \t]*\n")
                     (setq p1 (point) ) )
            (setq p1 (point) )))
      ;
      ;for partial para do this
      (progn
        (beginning-of-line)
        (setq p1 (point) )))
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;
      (if (re-search-forward "\n[ \t]*\n" nil "move")
          (progn (re-search-backward "\n[ \t]*\n")
                 (setq p2 (point) ))
        (setq p2 (point) ) ) )
    (set-mark p1)
    (forward-line 1)))
;
(defun select-2nd-block ()
  "Select the current block of next between empty lines."
  (interactive)
  (forward-line 1)
  (while (not (line-is-not-blank-p))
  (forward-line 1))
  (let (p1 p2)
    (progn
      (if (re-search-forward "\n[ \t]*\n" nil "move")
          (progn (re-search-backward "\n[ \t]*\n")
                 (setq p2 (point) ))))
  (forward-line 1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;
;;;;;;;;;;
;;;;;;;;;;
;;;;;;;;;;
;;;;;;;;;;
;;;;;;;;;;
;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun forward-word-dont-go-over-non-words ()
  "Limit word jumping to the current line, at eol jump to next line next word"
  (interactive)
     (if (looking-at "\\s-*$")
     ;Outside if T
     (progn (forward-word) (message "Moving to next line"))
     ;Outside if F
     (progn
       ;
       (if (looking-at "\\W+\\s-*$")
       ;Inside if T
       (progn (end-of-line) (message "Move over non-word")
       (if (looking-at "\\s-*$") (progn (message "EOL"))))
       ;
       ;Inside if F
       (progn
       (re-search-forward "\\w+\\W*" (line-end-position) t)
       (if (looking-at "\\s-*$")
       ;T
         (progn (message "EOL"))))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-goto-bob-meaningful (&optional arg)
  "Go near point min,end up in a meaningful place."
  (interactive)
  (if (eq major-mode 'dired-mode)
    (progn
    (goto-char (point-min))
    (while (looking-at " ")
      (forward-char 1)))
    ;
    (goto-char (point-min))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-goto-eob-meaningful (&optional arg)
  "Go near point max,end up in a meaningful place."
  (interactive)
  (if (eq major-mode 'eshell-mode)
      ;T
      (eshell-show-maximum-output)
      ;
      ;F
      (if (or (equal major-mode 'shell-mode)
              (equal major-mode 'eshell-mode)
              (equal major-mode 'inf-ruby-mode))
        ;T
        (comint-show-maximum-output)
        ;F
        (progn
            (goto-char (point-max))
            (forward-line -1)
            ;
            (if (eq major-mode 'dired-mode)
            (while (looking-at " ") (forward-char 1)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun replace-stars-in-middle-of-view-num (arg)
"Insert last cut text in a newline below the current line
With a negative preflx make the insertion roomy by adding
an extra line above and below"
   (interactive "p")

   (while (re-search-forward "*\n*\n*\n*\n" nil t)
       (replace-match "-\n-\n-\n-\n-\n")))

         ;
;
(defun insert-lastyank-this-line (arg)
"Insert last cut text on this line do not put in an newline
With a negative preflx make the insertion roomy by adding
an extra line above and below"
   (interactive "p")
   (setq mytempstr (car kill-ring-yank-pointer))
   (setq mystrNew
   (with-temp-buffer
   (insert (car kill-ring-yank-pointer))
   ;move point to just before the end of the buffer
   (end-of-buffer)
   (backward-char 2)
      ;
      ;1 Determine if the thing being pasted is a word or line
      ;2 by examining if it has an end of line.
      ;3 Remove that end of line if it has one
      (if (re-search-forward "\n" nil t)
         ;TRUE set a variable to indicate line
         (setq str_is_word_var (progn(replace-match "" nil nil)
         (message "Thing is a line") nil ))
         ;
         ;FALSE set a variable to indicate word
         (setq str_is_word_var (progn(message "Thing is a Word") t )))
         ;
      (buffer-string))) ; get result of temp buffer, pass it back
         ;;
      (if str_is_word_var
        ;TRUE:Indent for word
        (progn
           ;(insert-and-indent-line-below)
           ;add an extra line above and below
           (if(> 0 arg)
           (progn
              (insert-and-indent-line-above)
              (insert-and-indent-line-below))))
         ;
         ;FALSE insert at next BOL for line
        (progn
           ;; (progn(end-of-line) (newline))
           (progn(end-of-line) )
      ;(insert-and-indent-line-below)
      ;add an extra line above and below
      (if(> 0 arg)
      (progn
         (insert-and-indent-line-above)
         (insert-and-indent-line-below)))
      ;
      (beginning-of-line)))
         ;
   (insert mystrNew)
   (smart-beginning-of-line))
;
(defun insert-lastyank-above (arg)
"Insert last cut text in a newline above the current line.
With a negative preflx make the insertion roomy by adding
an extra line above and below"
   (interactive "p")
   (setq mytempstr (car kill-ring-yank-pointer))
   (setq mystrNew
   (with-temp-buffer
   (insert (car kill-ring-yank-pointer))
   ;move point to just before the end of the buffer
   (end-of-buffer)
   (backward-char 2)
      ;
      ;1 Determine if the thing being pasted is a word or line
      ;2 by examining if it has an end of line.
      ;3 Remove that end of line if it has one
      (if (re-search-forward "\n" nil t)
         ;TRUE:set a variable to indicate line
         (setq str_is_word_var (progn(replace-match "" nil nil)
         (message "Inserting a line") nil ))
         ;FALSE:set a variable to indicate word
         (setq str_is_word_var (progn(message "Inserting a Word") t )))
         (buffer-string))) ; get result of temp buffer, pass it back
      ;
      (if str_is_word_var
        ;TRUE:Indent for word
        (progn
           (insert-and-indent-line-above)
           ;add an extra line above and below
           (if(> 0 arg)
           (progn
              (insert-and-indent-line-above)
              (insert-and-indent-line-below))))
         ;
         ;FALSE:insert at prev BOL for line
        (progn
      (insert-and-indent-line-above)
      ;add an extra line above and below
      (if(> 0 arg)
      (progn
         (insert-and-indent-line-above)
         (insert-and-indent-line-below)))
      ;
      (beginning-of-line)))
      ;
      (insert mystrNew)
      (smart-beginning-of-line))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun line-is-not-blank-se-p (&optional arg-verbose)
"Determine if current line is not blank,
   return cursor to orginal position in the non-blank case"
 (interactive)
   (save-excursion
   (beginning-of-line)
   (if (not  (or (looking-at "^\\s-$") (looking-at "\n") (looking-at "^ +\n")))
      ;T
      (progn
         (if arg-verbose
        (message "not blank"))
         (setq line-is-not-blank-ret-val t))
      ;F
      (progn
         (if arg-verbose
        (message " blank"))
         (setq line-is-not-blank-ret-val nil)))))
;binding 4 test only (global-set-key (kbd "<f9>") 'line-is-not-blank-p)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun line-is-not-blank-p (&optional arg-verbose)
"Determine if current line is not blank"
 (interactive)
   (beginning-of-line)
   (if (not  (or (looking-at "^\\s-$") (looking-at "\n") (looking-at "^ +\n")))
      ;T
      (progn
         (if arg-verbose
        (message "not blank"))
         (setq line-is-not-blank-ret-val t))
      ;F
      (progn
         (if arg-verbose
        (message "not blank"))
         (setq line-is-not-blank-ret-val nil))))
;binding 4 test only (global-set-key (kbd "<f9>") 'line-is-not-blank-p)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mark-debug (start end)
"Insert last cut text in a newline below the current line
With a negative preflx make the insertion roomy by adding
an extra line above and below"
   (interactive "r")
   ;Create empty list
   (setq second-word-list (list ))

   (message "start is %s end is %s " start end)
   (goto-char start)

   (while (< (point) end)
       ;
       ;get the 2and word
       (re-search-forward "\\w+\\s-\\w+" nil t)
       ;
       ;get it's boundries
       (setq temp (bounds-of-thing-at-point 'symbol))
       (setq second-word (buffer-substring-no-properties (car temp) (cdr temp) ))
       ;
       ;push the 2and word to a list of all 2and words region
       (push second-word second-word-list)
       ;
       ;
     (forward-line 1)))

;; (setq temp '("\n" "aoeu\n" "htns\n"))

;; (dolist (myvar temp [RESULT])

;; BODY...)

;; (dolist (x '(1 2 3)) (insert (number-to-string x)))

;; (defun my-insert-list (arg)
;;   (dolist (x arg x)
;;     (insert  x)))

;; (setq htns (my-insert-list temp))
;; aoeu
;; htns

;region stuff
;stackoverflow.com/questions/14201740/replace-region-with-result-of-calling-a-function-on-region

;(length second-word-list)

; iterate a list of signal names, prepend and append mark_debug stuff.
;
; this is close
;; (setq temp (-map (lambda (num)
;;       (concat "attribute mark_debug of " num ": signal is \\"true\\";"))
;;   mylist))

; this is closer
; (setq temp (-map (lambda (num)
;       (concat "attribute mark_debug of " num ": signal is \"true\";"))
;   second-word-list))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; from https://emacs.stackexchange.com/questions/3809/indentation-of-newlines
; Find a key for this C-M-return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun indent-relative (&optional arg)
  "Newline and indent 2 spaces relative to previous line.  With
C-u, indent to same level as previous line."
  (interactive "P")
  (let* ((amount (if arg 0 2))
         (indent (+ amount (save-excursion
                             (back-to-indentation)
                             (current-column)))))
    (newline 1)
    (insert (make-string indent ?\s))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end if move-ins-sel-kill")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'move-ins-sel-kill)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
