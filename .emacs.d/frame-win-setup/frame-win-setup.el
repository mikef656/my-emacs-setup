;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; defuns this file
;; set-frame-size-according-to-resolution ()
;; mikes-word-wrap-tog ()
;; close-and-kill-next-pane ()
;; close-and-kill-this-pane ()
;; next-user-buffer ()
;; previous-user-buffer ()
;; no-pdf ()
;; my-dired-jump-same-frame ()
;; my-dired-find-file-other-window-same-frame ()
;; my-dired-ff-other-win-same-frm-maybe-replace (arg)
;; my-ff ()
;; my-dired-jump () 
;; my-dired-jump-back ()
;; toggle-window-split ()
;; w32-maximize-frame ()
;; fix-frame-horizontal-size (width)
;; fix-window-horizontal-size (width)
;; fix-horizontal-size (width)
;; set-window-width (n)
;; set-window-width-vertical (n)
;; set-20-columns ()
;; my-enlarge-frame-horzontally ()
;; my-enlarge-frame-test ()
;; my-shrink-frame-test ()
;; my-enlarge-frame-horizontal ()
;; my-shrink-frame-horizontal-test ()
;; my-enlarge-window-horizontally ()
;; my-shrink-window-horizontally ()
;; win-resize-top-or-bot ()
;; win-resize-left-or-right ()
;; my-toggle-dired-same-frame ()
;; left-most-window-mode ()
;; my-delete-leftmost-window ()
;; my-make-buffer-utf8 () 
;; my-make-frame-one-char-taller ()
;; my-move-framer ()
;; temp-test ()
;; move-frame-top (&optional arg)
;; move-frame-top-left (&optional arg-top arg-left)
;; call-move-frame-top ()
;; call-move-frame-top-left ()
;; my-move-frame ()
;; my-other-frame ()
;; my-other-frame (&optional arg)
;; my-frame-switch-for-thums ()
;; frame-foo ()
;; frame-foo-2 ()
;; frame-foo-show-frame-list ()
;; frame-foo-show-visible-frame-list ()
;; my-make-all-frames-visible ()
;; frame-foo-show-hide-2k ()
;; lab ()
;; multi-lab ()
;; transition-to-from-lab ()
;; dont-mess-with-this-frame ()
;; frame-lhs-manage-lt-zero (&optional move-to-lhs-zero verbose)
;; quit-window (&optional kill window)
;; print-list-to-temp-pop-up (arg-list)
;; print-list-to-temp-pop-up-interactive (&optional arg)
;; my-move-frame-left (arg)
;; my-move-frame-right (arg)
;; check-env ()
;; set-frame-size-according-to-resolution ()
;; mikes-word-wrap-tog ()
;; close-and-kill-next-pane ()
;; close-and-kill-this-pane ()
;; next-user-buffer ()
;; previous-user-buffer ()
;; no-pdf ()
;; my-dired-jump-same-frame ()
;; my-dired-find-file-other-window-same-frame ()
;; my-dired-ff-other-win-same-frm-maybe-replace (arg)
;; my-ff ()
;; my-dired-jump () 
;; my-dired-jump-back ()
;; toggle-window-split ()
;; w32-maximize-frame ()
;; fix-frame-horizontal-size (width)
;; fix-window-horizontal-size (width)
;; fix-horizontal-size (width)
;; set-window-width (n)
;; set-window-width-vertical (n)
;; set-20-columns ()
;; my-enlarge-frame-horzontally ()
;; my-enlarge-frame-test ()
;; my-shrink-frame-test ()
;; my-enlarge-frame-horizontal ()
;; my-shrink-frame-horizontal-test ()
;; my-enlarge-window-horizontally ()
;; my-shrink-window-horizontally ()
;; win-resize-top-or-bot ()
;; win-resize-left-or-right ()
;; my-toggle-dired-same-frame ()
;; left-most-window-mode ()
;; my-delete-leftmost-window ()
;; my-make-buffer-utf8 () 
;; my-make-frame-one-char-taller ()
;; my-move-framer ()
;; temp-test ()
;; move-frame-top (&optional arg)
;; move-frame-top-left (&optional arg-top arg-left)
;; call-move-frame-top ()
;; call-move-frame-top-left ()
;; my-move-frame ()
;; my-other-frame ()
;; my-other-frame (&optional arg)
;; my-frame-switch-for-thums ()
;; frame-foo ()
;; frame-foo-2 ()
;; frame-foo-show-frame-list ()
;; frame-foo-show-visible-frame-list ()
;; my-make-all-frames-visible ()
;; frame-foo-show-hide-2k ()
;; lab ()
;; multi-lab ()
;; transition-to-from-lab ()
;; dont-mess-with-this-frame ()
;; frame-lhs-manage-lt-zero (&optional move-to-lhs-zero verbose)
;; quit-window (&optional kill window)
;; print-list-to-temp-pop-up (arg-list)
;; print-list-to-temp-pop-up-interactive (&optional arg)
;; my-move-frame-left (arg)
;; my-move-frame-right (arg)
;; check-env ()
;; split-window-right (&optional size)
;; split-window-right (&optional size)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   HERE IS SOME FRAME PAREMETER KNOWLEDGE
   ;http://www.gnu.org/software/emacs/manual/html_node/elisp/
;      Parameter-Access.html#Parameter-Access
;
;   ;how to set a var to the frame width
;   (setq my-frame-rhs-pix
;         (+ (frame-parameter nil 'left) (frame-pixel-width)))
;    
;   ;list em
;
;   (frame-parameters) --mtf note the plural s
;
;   (frame-parameter (selected-frame) 'left) --mtf note singular
;    
;    
;   ;change just the left
;   (modify-frame-parameters nil '((left . 0))
;    
;    
;   (add-to-list 'default-frame-alist `(width . ,my-frame-width))
;    
;    
;   (modify-frame-parameters nil `(
;                                  ;(top . +100) ;from the lhs
;                                  ;(left . +100) ;from the lhs
;                                  (left . ,my-frame-rhs-pix);pix
;                                  ;(width . 100)
;                                  ;(width . 200);char
;                                  ))
;    
;    
;   ;Great example of using the backquote to force evaluation
;   ;of a quoted list.  Also see 
;   http://stackoverflow.com/questions/1664202/
;     emacs-lisp-evaluate-variable-in-alist
;
;
;   (modify-frame-parameters nil `((left . ,my-frame-rhs-pix)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(defvar SYMBOL &optional INITVALUE DOCSTRING)
(defvar screen-size nil "set acording to screen size")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use different sized frames for different displays
    ;note home pc is ==1280
    (if (> (x-display-pixel-width) 1280)
    ;T Work
    (progn
      ;
       (if (> (x-display-pixel-width) 1900)
          ;T 
          ;desktop is 1920
          (progn
          (setq default-frame-alist (append (list
          '(top . 10)
          '(left . 10)
            ;; 7-2-12 a littli wider ? '(width  . 220) 
            '(width  . 228) 
            '(height . 60))  
            default-frame-alist))
            (setq screen-size 'work-big))
          ;F
          ;W laptop pc is ==1600
          (progn
          (setq default-frame-alist (append (list
          '(top . 7)
          '(left . 7)
            '(width  . 180) 
            '(height . 45))  
            default-frame-alist))
           (setq  screen-size 'work-small )
           (if (string-equal system-type "gnu/linux")
             (setq fit-frame-max-height-percent 70))))
    ;
    )
    ;F
    (progn
    (setq default-frame-alist (append (list
    '(top . 10)
    '(left . 10)
      '(width  . 110) 
      '(height . 33)) 
      default-frame-alist))
    (setq screen-size 'home)
    (message "home sized frame")
    ))))
    
    ;used by frame re-sizing functions, part of set-frame-size-according-to-resolution
     (cond 
      ((eq screen-size 'work-big)
         (setq max-vertical-frame-size 40)          
         (setq max-horizontal-frame-size 231)
         (setq fit-frame-max-height-percent 82 ))
         ;
      ((eq screen-size 'work-small)
         (setq max-vertical-frame-size 49)
         (setq max-horizontal-frame-size 180)
         (setq fit-frame-max-height-percent 86 )) ; hackd
         ;
      ((eq screen-size 'home)
         (setq max-vertical-frame-size 46)     
         (setq max-horizontal-frame-size 156))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Mtf not sure why this needs to be called bc it was just eval'd above
; but it makes some error that needs to be chased down if it's not called
; 6-17-2013
(set-frame-size-according-to-resolution)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;This may be usefull sometime
;(set-frame-size (selected-frame) 110 33)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; turn on highlighting current line
;(global-hl-line-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Don't need it create space
;(tool-bar-mode 0)  ;note that (tool-bar-mode nil) turns it on
;this is interesting bc I had nil before, try to control it in the .emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://xahlee.org/emacs/emacs_make_modern.html
;Madening that these two interact porrly
;Also madening that setting truncate lines using setq does not seem
;   to work from the code but does work vis customization
;   C-h-v trun..-li.. choose customize set to non nil
(global-visual-line-mode 0) ; 1 for on, 0 for off.
;
;
;(global-set-key (kbd "<f8>") 'visual-line-mode)
;(global-set-key (kbd "<f9>") 'toggle-truncate-lines)
;
;;Make it a toggle 
;(defun mikes-fn ()
;  "Move Stuff"
;(interactive)
;(visual-line-mode  1) 
;(setq truncate-lines nill)
;)
;(global-set-key (kbd "<f8>") 'mikes-fn)
;
(defun mikes-word-wrap-tog ()
  "Move Stuff"
 (interactive) 
'visual-line-mode;do not unserstand why thins works
;(toggle-vlm);did no twork
(toggle-truncate-lines)
)
;Binding
(global-set-key (kbd "<M-f8>") 'mikes-word-wrap-tog)
;
;related to above did not work
;(defun toggle-vlm ()
;"Toggle whether to wrap lines at right window border."
;(interactive)
;   (if (eq visual-line-mode nil)
;     (visual-line-mode  1)
;     (visual-line-mode  nil)
;    ) )
;(setq truncate-lines t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; make whitespace-mode use just basic coloring
(setq whitespace-style (quote
  ( spaces tabs newline space-mark tab-mark newline-mark)))
;Make WS mode display chars look nice
(setq whitespace-display-mappings
 '(
   (space-mark 32 [183] [46]) ; normal space
   (space-mark 160 [164] [95])
   (space-mark 2208 [2212] [95])
   (space-mark 2336 [2340] [95])
   (space-mark 3616 [3620] [95])
   (space-mark 3872 [3876] [95])
   (newline-mark 10 [182 10]) ; newlne
   (tab-mark 9 [9655 9] [92 9]) ; tab
))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; turn on highlight matching parens when cursor is on one
(show-paren-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Scroll down with the cursor,move down the buffer one 
;; line at a time, instead of in larger amounts.
(setq scroll-step 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;window/buffer close
(defun close-and-kill-next-pane ()
      "Close the other pane and kill the buffer in it also."
      (interactive)
      (other-window 1)
      (kill-buffer)
      (delete-window)
    ) 
(defun close-and-kill-this-pane ()
      "Close this pane and kill the buffer in it also."
      (interactive)
      (kill-buffer)
      (delete-window)
    )
(global-set-key "\C-ck" 'close-and-kill-this-pane)
(global-set-key "\C-cK" 'close-and-kill-next-pane)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'uniquify) 
;set in custom
;; (setq 
;;   uniquify-buffer-name-style 'post-forward
;;   uniquify-separator ":")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Buffer Switching
(defun next-user-buffer ()
  "Switch to the next user buffer in cyclic order.\n
User buffers are those not starting with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))
;try buffer stack package
;(global-set-key (kbd "C-<tab>") 'next-user-buffer) ; 
;
;
(defun previous-user-buffer ()
  "Switch to the previous user buffer in cyclic order.\n
User buffers are those not starting with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))
;try buffer stack package
;(global-set-key (kbd "C-S-<tab>") 'previous-user-buffer) ; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;line numbers in most modes, not info
(add-hook 'Info-mode-hook
(lambda ()
   ;(dired-sort-menu-toggle-dirs-first)
   (linum-mode 0)
))
;
(add-hook 'Info-selection-hook
(lambda ()
   ;(dired-sort-menu-toggle-dirs-first)
   (linum-mode 0)
))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;open .pdf's as text
;note a download of the xpdf package
;(non emacs) from http://ctan.org/tex-archive/support/xpdf
;then unzip and move the 6 or so executables into c:\cygwin\bin
;so that they are in the path.
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . no-pdf))
;
;found this at http://www.emacswiki.org/emacs/UnPdf
;needed to add the -layout option messy to get tables to look right
(defun no-pdf ()
  "Run pdftotext on the entire buffer."
  (interactive)
  (let ((modified (buffer-modified-p)))
    (erase-buffer)
    (shell-command
     (concat "pdftotext -layout " (buffer-file-name) " -")
     (current-buffer)
     t)
    (set-buffer-modified-p modified)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-dired-jump-same-frame ()
 (interactive)
 "Open a dired buffer in the same frame different window
  while running oneonone and fit-frame"
 (if  (not (eq major-mode 'dired-mode))
     (progn   
     (let
      ((window-min-width 10) (pop-up-frames))
         (split-window-right)
         (dired-jump -1)
         (rotate-windows)
         (other-window 1)
         (set-window-width mywin-side-dired-width)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq mywin-side-dired-width 25)
;
(cond 
  ((eq home-work 'home) (setq mywin-frame-height 25));home
  ((eq home-work 'work) (setq mywin-frame-height 40))  ;work
  (t (setq mywin-frame-height 40))
)
;
(defun my-dired-find-file-other-window-same-frame ()
 (interactive)
 "bind as 'o' in dired, ff other window in the same
 frame for a oneonone enviornment"
  (let
      ((window-min-width 10) (pop-up-frames))
      ;
  (if (= (length (window-list)) 1)
     (progn
       ;T
       (split-window-right)
       (dired-find-file-other-window)
       ;
       ;Want to see the new buffer opened without any horz scroll
       (beginning-of-line)
       (other-window 1)
       (fix-frame-horizontal-size 100)
       ;
       ;this is terrible, but it setting to 20 fails without the wait.
       (sit-for .00001 t)
       (set-window-width mywin-side-dired-width)
       ;
       ;Don't want to see any super short frames
       (if (> 20 (frame-height))
         (set-frame-height nil mywin-frame-height)))
      
     ;(message "finished")
    ;F
    ;assume that you are in a left hand dired pane pointing
    ;at a file.
    (setq my-path-name (dired-get-filename nil t))
    ;(message "Window already split")
    (message "Opening %sq" (dired-get-filename nil t) )
    (fix-frame-horizontal-size max-horizontal-frame-size)
    (sit-for .00001 t)
    (set-window-width mywin-side-dired-width)
    (other-window 1)
    (split-window-right)
    ;(other-window -1)
    (find-file my-path-name)
    )))



(defun my-dired-ff-other-win-same-frm-maybe-replace (arg)
 (interactive "p")
 "bind as 'o' in dired, ff other window in the same
 frame for a oneonone enviornment, if in C-x 2 split and - arg
 replace the window that is there now"
  (let
      ((window-min-width 10) (pop-up-frames))
      ;
  (if (= (length (window-list)) 1)
     (progn
       ;T
       (split-window-right)
       (dired-find-file-other-window)
       ;
       ;Want to see the new buffer opened without any horz scroll
       (beginning-of-line)
       (other-window 1)
       (fix-frame-horizontal-size 100)
       ;
       ;this is terrible, but it setting to 20 fails without the wait.
       (sit-for .00001 t)
       (set-window-width mywin-side-dired-width)
       ;
       ;Don't want to see any super short frames
       (if (> 20 (frame-height))
         (set-frame-height nil mywin-frame-height)))
      
     ;(message "finished")
    ;F
    ;assume that you are in a left hand dired pane pointing
    ;at a file.
    (setq my-path-name (dired-get-filename nil t))
    ;(message "Window already split")
    (message "Opening %sq" (dired-get-filename nil t) )
    ;(fix-frame-horizontal-size 100)
    (if ( < arg 0)
       ;
       ;t replace existing window, switch to it
       (progn
          (sit-for .00001 t)
          ;(set-20-columns)
          (delete-other-windows)
          (sit-for .00001 t)
          ;(set-window-width mywin-side-dired-width)
          (split-window-right)
          (other-window 1)
          ;(other-window -1)
          (find-file my-path-name)
          (other-window 1)
          (set-window-width mywin-side-dired-width)
          (other-window 1))
      ;
      ;add another window
      (progn
         (fix-frame-horizontal-size max-horizontal-frame-size)
         (sit-for .00001 t)
         (set-window-width mywin-side-dired-width)
         (other-window 1)
         (split-window-right)
         ;(other-window -1)
         (find-file my-path-name))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-ff ()
 (interactive)
 ""
      (fit-frame nil 120 nil nil)
      )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-dired-jump () 
 (interactive)
 "Open a dired buffer in the same frame different window
  while running oneonone and fit-frame"
 (if  (not (eq major-mode 'dired-mode))
    (progn   
    (let (pop-up-frames)
    (dired-jump -1)
    (toggle-window-split)))

    (progn
    (delete-window)
    (fit-frame))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-dired-jump-back ()
 (interactive)
 "Tell if first line of buffer by returning t"
(delete-window)
 (fit-frame))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun w32-maximize-frame ()
  "Maximize the current frame"
  (interactive)
  (w32-send-sys-command 61488))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://dse.livejournal.com/67732.html
(defun fix-frame-horizontal-size (width)
  "Set the frame's size to 80 (or prefix arg WIDTH) columns wide."
  (interactive "P")
  (if window-system
      (set-frame-width (selected-frame) (or width 80))
    (error "Cannot resize frame horizontally: is a text terminal")))
;
(defun fix-window-horizontal-size (width)
  "Set the window's size to 80 (or prefix arg WIDTH) columns wide."
  (interactive "P")
  (enlarge-window (- (or width 80) (window-width)) 'horizontal))
;
(defun fix-horizontal-size (width)
  "Set the window's or frame's width to 80 (or prefix arg WIDTH)."
  (interactive "P")
  (condition-case nil
      (fix-window-horizontal-size width)
    (error 
     (condition-case nil
	 (fix-frame-horizontal-size width)
       (error
	(error "Cannot resize window or frame horizontally"))))))
;
;(global-set-key (kbd "C-x W") 'fix-horizontal-size)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://nullprogram.com/blog/2010/10/06/
(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t)
  (message "set-window-width OK"))
;
(defun set-window-width-vertical (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) nil)
  (message "set-window-width OK"))
;
;Wrap it with an interactive function and bind it.
;
(defun set-20-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 20))
;
;(global-set-key "\C-x~" 'set-20-columns)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;How do I detect that an Emacs window has already been split?
;window-list will return you a list of the windows (for the current frame),
;  so you should be able to do:
;
;when (= (length (window-list)) 1)
; (split-window-horizontally))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; To change the size of an Emacs frame using elisp, you can use the two
;;     functions set-frame-width and set-frame-height. For example, to resize
;;     Emacs to display 40 lines by 80 columns, you could use: (set-frame-height
;;     (selected-frame) 40) (set-frame-width (selected-frame) 80)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Used by frame re-sizing functions, run outside a defun should be used by
; the environment by default.
 (cond 
  ((eq screen-size 'work-big) ;; MSI Linux
     (setq max-vertical-frame-size 40)          
     (setq max-horizontal-frame-size 171))
     ;
  ((eq screen-size 'work-small)
     (setq max-vertical-frame-size 49)
     (setq max-horizontal-frame-size 185))
     ;
  ((eq screen-size 'home)
     (setq max-vertical-frame-size 46)     
     (setq max-horizontal-frame-size 156)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;amounts
;;  (cond 
;;   ((eq screen-size 'work-big)
;;      (setq my-large-enlarge-vertical-amount 25)
;;      (setq my-medium-enlarge-vertical-amount 15)
;;      (setq my-small-enlarge-vertical-amount 4)
;;      (setq my-very-small-enlarge-vertical-amount 1)     
;;      ;
;;      (setq move-pop-up-frame-to-screen-right-amount 425)     
;;      ;
;;      (setq my-large-enlarge-horiz-amount 70)
;;      (setq my-medium-enlarge-horiz-amount 25)
;;      (setq my-small-enlarge-horiz-amount 12)
;;      (setq my-very-small-enlarge-horiz-amount 4))
;;   ;
;;   ((eq screen-size 'work-small)
;;    (setq my-large-enlarge-vertical-amount 22)
;;      (setq my-medium-enlarge-vertical-amount 12)
;;      (setq my-small-enlarge-vertical-amount 3)
;;      (setq my-very-small-enlarge-vertical-amount 1)     
;;      ;
;;      (setq move-pop-up-frame-to-screen-right-amount 100)     
;;      ;
;;      (setq my-large-enlarge-horiz-amount 60)
;;      (setq my-medium-enlarge-horiz-amount 30)
;;      (setq my-small-enlarge-horiz-amount 6)
;;      (setq my-very-small-enlarge-horiz-amount 2))
;;    ;
;;    ((eq screen-size 'home)
;;      (setq my-large-enlarge-vertical-amount 20)
;;      (setq my-medium-enlarge-vertical-amount 6)
;;      (setq my-small-enlarge-vertical-amount 3)
;;      (setq my-very-small-enlarge-vertical-amount 2)     
;;      ;
;;      (setq move-pop-up-frame-to-screen-right-amount 50)     
;;      ;
;;      (setq my-large-enlarge-horiz-amount 60)
;;      (setq my-medium-enlarge-horiz-amount 30)
;;      (setq my-small-enlarge-horiz-amount 6)
;;      (setq my-very-small-enlarge-horiz-amount 2))
;;  )
;(frame-height)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-enlarge-frame-horzontally ()
  "DWIM"
    (interactive) 
    ;
    (if
       (and (< (frame-width) 41)
            (or (eq major-mode 'dired-mode)
                (eq major-mode 'help-mode)
                (eq major-mode 'custom-mode)
                ));
      ;T
      (progn 
         (enlarge-frame-horizontally 40)
         (sit-for .01)
         (enlarge-frame 20)
         (message "enlarging frame both ways"))
      ;
      ;F
      (progn
       (if (<(frame-width) my-small-frame-boundry-for-horiz-enlarge ) 
         (enlarge-frame-horizontally my-large-enlarge-horiz-amount)
         ;
         (if (<(frame-width) my-medium-frame-boundry-for-horiz-enlarge )
           (enlarge-frame-horizontally my-medium-enlarge-horiz-amount)
           ;
           (if (<(frame-width) my-large-frame-boundry-for-horiz-enlarge )
              (enlarge-frame-horizontally my-small-enlarge-horiz-amount)
              (enlarge-frame-horizontally my-very-small-enlarge-horiz-amount)))
         ;
         (sit-for .001)))
    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
       

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
;depricated
;; (global-set-key [(control meta kp-left)] (lambda ()
;;        (interactive)          
;;        (if (> (frame-width) 200 ) 
;;          (shrink-frame-horizontally 80)
;;          ;
;;          (if (>(frame-width) 140 )
;;            (shrink-frame-horizontally 50)
;;            ;
;;             (shrink-frame-horizontally 10))
;;          ;
;;          (sit-for .001) 
;;        )
;;     ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
;(global-set-key [(control meta kp-up)] 'my-shrink-frame)
;(global-set-key [(control meta kp-up)] 'my-shrink-frame-test)
;(global-set-key [(control meta kp-down)] 'my-enlarge-frame-test)
;
;; (defun my-shrink-frame ()
;;   (interactive)          
;;    (if (eq last-command 'my-enlarge-frame) 
;;       ;T shrink by 1/2 of what it was just enlarged
;;       ;no counting on the result of 0/2
;;       (if (>= cur-enlrg-vert-amount 2)
;;         (shrink-frame ( / cur-enlrg-vert-amount 2))   
;;         (shrink-frame cur-enlrg-vert-amount ))   
;;       ;
;;       ;F
;;       (if (> (frame-height) 60 ) 
;;         (shrink-frame 30)
;;         ;
;;         (if (>(frame-height) 40 )
;;           (shrink-frame 20)
;;           ;
;;            (shrink-frame 10)) 
;;       )
;;    )
;;    (sit-for .001) 
;;  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-enlarge-frame ()
;;  "Nice steps for whatever machine you are on"
;;     (interactive)     
;;     (if
;;        (and (< (frame-width) 40)
;;        (or (eq major-mode 'dired-mode)
;;            (eq major-mode 'help-mode)
;;            (eq custom-mode 'custom-mode)))
;;     ;
;;     ;T special mode       
;;     (progn 
;;       ;(menu-bar-mode 0)
;;       (enlarge-frame 4))
;;     ;
;;     ;F Not a special mode
;;     (progn
;;      ;small vertical frame
;;       (if (<=(frame-height) my-small-frame-boundry-for-vertical-enlarge ) 
;;         ;
;;         (progn
;;         (enlarge-frame my-large-enlarge-vertical-amount)
;;         (setq cur-enlrg-vert-amount my-large-enlarge-vertical-amount))
;;         ;
;;         ;medium vert frame
;;         (if (<=(frame-height) my-medium-frame-boundry-for-vertical-enlarge )
;;           (progn
;;           (enlarge-frame my-medium-enlarge-vertical-amount)
;;           (setq cur-enlrg-vert-amount my-medium-enlarge-vertical-amount))
;;           ;
;;           ;large vertical frame
;;           (if (<(frame-height) my-small-frame-boundry-for-vertical-enlarge )
;;              (progn
;;              (enlarge-frame my-small-enlarge-vertical-amount)
;;              (setq cur-enlrg-vert-amount my-small-enlarge-vertical-amount))
;;              ;very large vertical frame
;;              (progn
;;              (enlarge-frame my-very-small-enlarge-vertical-amount)
;;              (setq cur-enlrg-vert-amount my-very-small-enlarge-vertical-amount))
;;              )))));end outside if
;;        ;
;;       (sit-for .001)) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-enlarge-frame-test ()
 "INTERESTING"
 (interactive)
;
   (if (eq last-command 'my-shrink-frame-test) 
      ;T shrink by 1/2 of what it was just enlarged
      ;no counting on the result of 0/2
      (if (>= cur-shrink-vert-amount 2)
        (setq cur-enlrg-vert-amount ( / cur-shrink-vert-amount 2))   
        (setq cur-enlrg-vert-amount cur-shrink-vert-amount ))   
      ;
      ;F
      (if  (<  (frame-height) (- max-vertical-frame-size 2) )
        ;T
        (progn
        (setq cur-enlrg-vert-amount
              (/ (- max-vertical-frame-size-hurry (frame-height) ) 2))
        ;don't enlarge more that the max
          (if (> (+ (frame-height) cur-enlrg-vert-amount) max-vertical-frame-size)
              (setq cur-enlrg-vert-amount
                    (- max-vertical-frame-size (frame-height)))));matches progn
        ;F
        (setq cur-enlrg-vert-amount  1)))
      ;
   ;always do this
   (enlarge-frame cur-enlrg-vert-amount ))
;   
  ;used to move the frame boundry where it is needed in less key presses
  (setq max-vertical-frame-size-hurry (/ (* max-vertical-frame-size 5  ) 4))
;
(defun my-shrink-frame-test ()
 "INTERESTING"
 (interactive)
;
   (if (eq last-command 'my-enlarge-frame-test) 
      ;T shrink by 1/2 of what it was just enlarged
      ;no counting on the result of 0/2
      (if (>= cur-enlrg-vert-amount 2)
        (setq cur-shrink-vert-amount ( / cur-enlrg-vert-amount 2))   
        (setq cur-shrink-vert-amount cur-enlrg-vert-amount ))   
      ;
      ;F
      (setq cur-shrink-vert-amount  (/  (frame-height)  2))
   )
      (shrink-frame cur-shrink-vert-amount ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-enlarge-frame-horizontal ()
 "Enlarge frame to 7/8 full size, unless it's already near full size,
  in that case enlarge only s"
 (interactive)
   (setq frame-size-before (frame-width)) 
   ; if the frame is much smaller than the max size then...
   (if  (<  (frame-width) (- max-horizontal-frame-size 4) )
   (progn
      (setq distance-to-max (- max-horizontal-frame-size (frame-width)))
      ; use 7/8 (.875) of the distance to the edge as the increase factor
      (setq distance-to-max-7-8   (round (* distance-to-max .875)))
      (setq cur-enlarge-horizontal-amount distance-to-max-7-8))
   ;F  
   ;if near the max size enlarge a tiny bit
   (setq cur-enlarge-horizontal-amount  1)) ;here
   ;  
   ; This is where the enlarge actually occurs.
   (enlarge-frame-horizontally cur-enlarge-horizontal-amount )
   ;
   (setq frame-size-after (frame-width))
   ;
   (setq debug-frame-messages-verbose nil)
   ;(setq debug-frame-messages-verbose t)
   (if debug-frame-messages-verbose
   (message "Before=%s, after =%s,max =%s, to max =%s,7/8 =%s "  
     frame-size-before 
       frame-size-after 
         max-horizontal-frame-size 
           distance-to-max
             distance-to-max-7-8)))
;
  ;used to move the frame boundry where it is needed in less key presses
  ; max hurry = (max h size*40)/32 
  (setq max-horiz-frame-size-hurry (/ (* max-horizontal-frame-size 40  ) 32) )
;
(defun my-shrink-frame-horizontal-test ()
 "INTERESTING"
 (interactive)
;
   (if (eq last-command 'my-enlarge-frame-horizontal) 
      ;T shrink by 1/2 of what it was just enlarged
      ;no counting on the result of 0/2
      (if (>= cur-enlarge-horizontal-amount 2)
        (setq cur-shrink-horizontal-amount ( / cur-enlarge-horizontal-amount 2))   
        (setq cur-shrink-horizontal-amount cur-enlarge-horizontal-amount ))   
      ;
      ;F
      (setq cur-shrink-horizontal-amount  (/  (frame-width)  2))
   )
      (shrink-frame-horizontally cur-shrink-horizontal-amount ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (eq home-work 'work)
  (progn
    (setq enlarge-window-horizontally-amount 8)
    (setq enlarge-window-horizontally-amount-minus -8))
  (progn
    (setq enlarge-window-horizontally-amount 4)
    (setq enlarge-window-horizontally-amount-minus -4)))
;
;
(defun my-enlarge-window-horizontally ()
   (interactive)
   (if
     (or 
     (string-equal  (win-resize-left-or-right) "mid")
     (string-equal  (win-resize-left-or-right) "left"))
       (progn
       ;(message "left") 
       (enlarge-window-horizontally enlarge-window-horizontally-amount))
       (enlarge-window-horizontally enlarge-window-horizontally-amount-minus)))
;
;
(defun my-shrink-window-horizontally ()
   (interactive)
   (if 
     (or 
     (string-equal  (win-resize-left-or-right) "mid")
     (string-equal  (win-resize-left-or-right) "left"))
       (progn
       ;(message "left") 
       (enlarge-window-horizontally enlarge-window-horizontally-amount-minus))
       (enlarge-window-horizontally enlarge-window-horizontally-amount)))
;
;
(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the
middle"
  (let* ((win-edges (window-edges))
	 (this-window-y-min (nth 1 win-edges))
	 (this-window-y-max (nth 3 win-edges))
	 (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))
;
;
(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the
middle"
  (let* ((win-edges (window-edges))
	 (this-window-x-min (nth 0 win-edges))
	 (this-window-x-max (nth 2 win-edges))
	 (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 0) this-window-x-max) "right");0 is dffret from internet 
     (t "mid"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(defun my-toggle-dired-same-frame ()
 "if dired is not open in a left window open it
  if dired is open in a left window delete the window"
 (interactive)
  (if (or
      (string-equal (left-most-window-mode) "dired-mode")
      (string-equal (left-most-window-mode) "sr-mode") )
    (progn
      (message "deleting dired-mode window")
      (my-delete-leftmost-window))
    (my-dired-jump-same-frame)))
;
;
(defun left-most-window-mode ()
 (interactive)
  "return the major mode of the buffer in the left most window"
  ;
  ;(with-current-buffer BUFFER-OR-NAME &rest BODY)  
  ;Execute the forms in BODY with BUFFER-OR-NAME temporarily current.
  (with-current-buffer
      ;Return the buffer displayed in window WINDOW
      (window-buffer
         ;Return the topmost, leftmost live window on FRAME-OR-WINDOW
         (frame-first-window)) major-mode) ) 
;
(defun my-delete-leftmost-window ()
 (interactive)
 "DWIK"
 (delete-window (frame-first-window)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;might want to play with this one day (does not play nice with oneonone
;https://groups.google.com/forum/
;  ?fromgroups#!msg/comp.emacs/ME30vAZ38kM/6oAgksar3dYJ
;
(when (eq load-cascading-frames t)
  ;
  (if (eq window-system 'w32)
     (progn
       (require 'cl)
       (defvar top-step 30        
          "The increment for top in default-frame-alist.")
       (defvar left-step 30
          "The increment for left in default-frame-alist.")
       (defvar max-top 300
          "The maximum increment for top in default-frame-alist.")
       (defvar max-left 700
          "The maximum increment for left in default-frame-alist.")
       (add-hook 'after-make-frame-functions
         (lambda (dummy)
           (let ((top (assq 'top default-frame-alist))
                 (left (assq 'left default-frame-alist)))
             (if left
                 (progn
                   (incf (cdr left) left-step)
                   (if (> (cdr left) max-left)
                       (setf (cdr left) left-step)))
               (push (append '(left) left-step) default-frame-alist))
             (if top
                 (progn
                   (incf (cdr top) top-step)
                   (if (> (cdr top) max-top)
                       (setf (cdr top) top-step)))
               (push (append '(top) top-step) default-frame-alist)))))
       (message "Cascading frames loaded!")))
 )       
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-make-buffer-utf8 () 
 "Make me one char taller, might want to call this after fit-frame. How?"
 (interactive)
 (set-buffer-file-coding-system 'utf-8))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-make-frame-one-char-taller ()
  "Make me one char taller, might want to call this after fit-frame. How?"
  (interactive)
  (setq my-temp-frame-height  (+ (frame-parameter nil 'height) 1))
  (modify-frame-parameters nil `((height . ,my-temp-frame-height))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-move-framer ()
  "Make me one char taller, might want to call this after fit-frame. How?"
  (interactive)
  
  (setq my-temp-height  (+ (frame-parameter nil 'height) 1))
  ;
  (modify-frame-parameters nil `((height . ,my-temp-frame-height))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun temp-test ()
  (interactive)
  (setq temp 100)
  (setq my-temp-height  (+ (frame-parameter nil 'top) temp))
  ;; (modify-frame-parameters nil `((top . ,my-temp-height))))
  (modify-frame-parameters nil `((top . ,temp))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun move-frame-top (&optional arg)
  (interactive)
  (let (temp-top)
  (if arg
    (setq temp-top arg)
    (setq temp-top 100))
  (modify-frame-parameters nil `((top . ,temp-top)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun move-frame-top-left (&optional arg-top arg-left)
  "move a frame to a specified position"
  (interactive)
  (let ((temp-top) (temp-left))
  (if arg-top
    (setq temp-top arg-top)
    (setq temp-top 20))
  (if arg-left
    (setq temp-left arg-left)
    (setq temp-left 20))
  (modify-frame-parameters nil `((left . ,temp-left)))
  (modify-frame-parameters nil `((top . ,temp-top)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun call-move-frame-top ()
  (interactive)
  (move-frame-top 200))  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun call-move-frame-top-left ()
  (interactive)
  (move-frame-top-left 40 40))  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;instrumentation
  (frame-parameter (selected-frame) 'top) 
  (modify-frame-parameters nil `((top . ,100)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-move-frame ()
  ""
  (interactive)
  (setq my-temp-new-top  (+ (frame-parameter nil 'top) 10))
  (setq my-temp-new-left  (+ (frame-parameter nil 'left) 10))
  (modify-frame-parameters nil `((top . ,my-temp-new-top)))
  (modify-frame-parameters nil `((left . ,my-temp-new-left))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;frame switching
;; (defun my-other-frame (&optional arg)
;;  "Change other-frame behavior if one or more frames thumified"
;;   (interactive "p")
;;   ;
;;   (cond 
;;     ;choose\w completion
;;     ((eq arg 4) (message "arg 4") (icicle-select-frame))
;;     ;
;;     ;Maybe change to SUNRISE
;;     ((eq arg 16)
;;      ;; (setq myjunk (select-frame-by-name "SUNRISE"))
;;      (if (select-frame-by-name "SUNRISE")
;;          (message "Selecting Frame Sunrise") 
;;          (message "No SUNRISE"))
;;     )
;;     ;
;;     ;Others is (other-frame 1)
;;     ;; (t (message "no arg") (other-frame 1))
;;     ;
;;     ;
;;     (t
;;       (deiconify-everything) 
;;       (my-frame-switch-for-thums)
;;       (message "Switching to frame: %s" (buffer-name)) 
;;      )
;;   ;
;;   );end cond
;;  )
;
; 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; use this one if the more complex one has trouble, I think it did but
; dont' remember exactly what.
(defun my-other-frame ()
 (interactive)
 ;; (next-frame (selected-frame)) 
 (other-frame 1)
 (message "Switching to frame: %s" (get-frame-name)))
;
;

(defun my-other-frame (&optional arg)
 "Change other-frame behavior if one or more frames thumified
  From DA.  Instead of testing whether the prefix arg numeric value is 4 or 16 directly,
  you might want to let ARG be the raw prefix arg.  IOW, if you want to test plain
  C-u and C-u C-u, then use the raw arg and then distinguish its numeric value.
  Doesn't matter here, but if you wanted a numeric arg to mean something else then
  everytime you used M-4 it would be interpreted the same as plain C-u - not too
  good."
  (interactive "P")
  (cond   ;
     ((atom arg) 
        (deiconify-everything)  
        (my-frame-switch-for-thums) 
        (message "Switching to frame: %s" (buffer-name))) ; no prefix arg or numeric prefix arg
     ;   
     ((= 4 (prefix-numeric-value arg)) 
        (icicle-select-frame)) ; plain C-u
     ;
     ((= 16 (prefix-numeric-value arg)) 
         (select-frame-by-name "SUNRISE")))) ; C-u C-u
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-frame-switch-for-thums ()
  "based on email with Drew"
  (interactive)
  (if (and (fboundp 'thumfr-thumbnail-frames)  (thumfr-thumbnail-frames))
  ;(if (thumfr-thumbnail-frames)
      ;T
      ;something is thumified
      (progn 
        (thumfr-fisheye-next-frame) 
        (sit-for .00001 t) 
        ;
        ;(fit-frame) ;commented bc this causes funny buisness with Sunrise
        ;probably the correct thing to do is to fit-frame if not 
        ;frame-name *Sunrise* or *eshell*
        ;
        (thumfr-stack-thumbnail-frames)
        ;
        ;this is necessary to make the frame you are interested in topmost
        ;what you don't want is a thum frame on top.
        (select-frame-set-input-focus (selected-frame))
        ;not sure if I want to always move the frame to the left give it a try
        (move-frame-to-screen-left nil))
      ;F
      ;Nothing is thumified
      ;; (icicle-other-window-or-frame 1)))
      (other-frame 1)))
;
;think about this
    ;(if frame
    ;    (select-frame-set-input-focus frame)
    ;  (error "There is no frame named `%s'" name))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defadvice icicle-other-window-or-frame (around  icicle-other-window-or-frame-advice 0 nil activate)
  (if (highlight-symbol-mode) 
   (progn
     (highlight-symbol-remove-all)
     ;
     (highlight-symbol-mode 0)))
  ;
  ad-do-it
  ;(set-frame-name (buffer-name)); ARGS: frame FORCE
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defadvice other-frame (around  other-frame-advice 0 nil activate)
  (if (highlight-symbol-mode) 
   (progn
     (highlight-symbol-remove-all)
     ;
     (highlight-symbol-mode 0)))
  ;
  ad-do-it
  ;(set-frame-name (buffer-name)); ARGS: frame FORCE
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun frame-foo ()
  (interactive)
  (setq my-temp-param (frame-parameter nil 'visibility) )
  (message "this is the vis %s" my-temp-param)
  (setq my-visible-frame-list (visible-frame-list))
  (message "visible frame list: %s" my-visible-frame-list)
  )
;
;(frame-parameters)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun frame-foo-2 ()
  (interactive)
  (frame-parameter .emacs 'visibility)
  (frame-parameter (car (frame-list)) 'visibility)
  (frame-parameter nil 'name)
  )
;
(defun frame-foo-show-frame-list ()
   (interactive)
   (setq my-temp-frame-list (visible-frame-list))
   (frame-list))
;
(defun frame-foo-show-visible-frame-list ()
   (interactive)
   (setq my-temp-visible-frame-list (visible-frame-list)))
;
(defun my-make-all-frames-visible ()
  "Make all my frames visible"
  (interactive)
     (dolist (element frame-list value)
       (set-frame-parameter element visibility t)))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun frame-foo-show-hide-2k ()
  (interactive)
  (show-hide )
  (show-hide )
  )
;
;(frame-parameters)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DA put these in frama-cmds.el
;; (defun deiconify-everything ()
;;   "Deiconify any iconified frames."
;;   (interactive)
;;   (frame-configuration-to-register frame-config-register)
;;   (dolist (frame  (frame-list))
;;     (when (eq 'icon (frame-visible-p frame)) (make-frame-visible frame))))
;;
;; (defun iconify/map-frame (&optional all-action)
;;   "Iconify selected frame if now mapped.  Map it if now iconified.
;; With non-nil prefix arg ICONIFY-ALL, iconify all visible frames."
;;   (interactive "P")
;;   (cond ((not all-action)
;;          (when rename-frame-when-iconify-flag (rename-non-minibuffer-frame))
;;          (iconify-or-deiconify-frame))
;;         ((natnump (prefix-numeric-value all-action))
;;          (iconify-everything))
;;         (t
;;          (deiconify-everything))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun lab ()
  "switch to lab or back"
  (interactive)
  (set-frame-size-according-to-resolution)
  (maximize-frame-vertically)
  (fit-frame))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun multi-lab ()
  "switch to lab or back (actually different screen resolutions"
  (interactive)
  (message "now on %s" (selected-frame))
  ;
  (if (dont-mess-with-this-frame) 
    ;T
    (progn
      ;if the frame lhs is <0, move it to 0, without this the other operations
      ;have issues
      (frame-lhs-manage-lt-zero t)
      (set-frame-size-according-to-resolution)
      )
    ;F
    (progn
      (frame-lhs-manage-lt-zero t)
      (fit-frame)
      (maximize-frame-vertically)))
  ;
  (select-frame (next-frame)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun transition-to-from-lab ()
  "Hat it says, come back to the frame user started on"
  (interactive)
  (set-frame-size-according-to-resolution)
  (let ((beg-frame (selected-frame)))
  (dolist ( x (visible-frame-list)) 
    (multi-lab))
  (select-frame beg-frame)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun dont-mess-with-this-frame ()
  "Determine frames and certian buffers not to process"
  (interactive)
  (let (
        (local-frame-name (frame-parameter (selected-frame) 'name))
        )
    (if (or 
        (equal major-mode "sr-mode") 
        (equal major-mode "eshell-mode") 
        (string-equal local-frame-name "*Help*") 
        (string-equal local-frame-name "*vc-log*"))
         ;T
         (progn (message "is vc-log or help") t)
         ;F
         (progn  nil))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun frame-lhs-manage-lt-zero (&optional move-to-lhs-zero verbose)
  "Return frame lhs as a number in pixels, if optional arg non-nil then 
   move the frame lhs to 0. 
   The call to 
   (frame-parameter (selected-frame) 'left) )
   produces a number or a list for results >= 0, < 0 respectively"
  (interactive)
  (let 
      ((extracted-val) 
       (temp-left (frame-parameter (selected-frame) 'left) ))
    (if (listp temp-left)
        (progn
          (when verbose (message "list"))
          (setq extracted-val (nth 1 temp-left ))
          (when verbose (message "my ex val %s" extracted-val))
          (when move-to-lhs-zero
            (if ( < extracted-val 0) 
                (modify-frame-parameters nil '((left . 0)))))
          extracted-val)
        (progn 
          (message "not list")
          temp-left)
    )))
;(frame-lhs-manage-lt-zero nil t) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;superuser.com/questions/397806/
;  emacs-modify-quit-window-to-delete-buffer-not-just-bury-it
; the defun at the link does not always work, bc it accepts no args and the
; original quit-window accepts 2.  Added them.
(defun quit-window (&optional kill window)
 "Over-ride quit window, want keyboard q to run this rather than burry buffer"
 (interactive)
 (kill-buffer-and-window))
 ;; (kill-buffer-and-its-windows (current-buffer)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;simplified example of dolist  
;(dolist (x '(1 2 )) (insert (number-to-string x))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (setq aa (list "aoeu" "htns"))
;idea from
;www.jakemccrary.com/blog/2013/08/10/
;  emacs-capture-shell-command-output-in-temporary-buffer/
(defun print-list-to-temp-pop-up (arg-list)
  "Print list one item/line"
  (interactive)
  (with-output-to-temp-buffer "*Mikes-list*"
    ;; (princ (format "Hello, %s!\n" "World"))
    (princ (format "Length of list:%s\n" (length arg-list)))
    (dolist (x-placeholder arg-list)
    (princ (format "%s\n" x-placeholder)))
    (pop-to-buffer "*Mikes-list*")))
;
(defun print-list-to-temp-pop-up-interactive (&optional arg)
  "Print list one item/line"
  (interactive)
  ;
  (if arg
    (setq arg-list arg)
    (listp (setq arg-list (eval-minibuffer "obj:"))))
  ;
  (with-output-to-temp-buffer "*Mikes-list*"
     ;   
    (princ (format "Length of list:%s\n" (length arg-list)))
    (dolist (x-placeholder arg-list)
    (princ (format "%s\n" x-placeholder)))
    (pop-to-buffer "*Mikes-list*"))
    ;these do not seem to have affect of taking the user to the bob
    (switch-to-buffer "*Mikes-list*") 
    (sit-for .1 t)
    (maximize-frame-vertically)
    (fit-frame)
    (goto-char 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-move-frame-left (arg)
 "Move left or screen left with - arg C-u" 
 (interactive "p")
 (if (or (< arg 0) (equal arg 4))
 (progn
   (move-frame-to-screen-left nil)      
   (maximize-frame-vertically)
   (fit-frame))
 (move-frame-left))) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-frame-clean ()
 "Clean up the selected frame by moving it left, and running fit-frame" 
 (interactive)
 (progn
   (move-frame-to-screen-left nil)      
   (maximize-frame-vertically)
   (fit-frame)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-move-frame-right (arg)
 "Move right or screen right with - arg C-u"
 (interactive "p")
 (if (or (< arg 0) (equal arg 4))
 (move-frame-to-screen-right 10)      
 (move-frame-right))) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun check-env ()
  (interactive)
  (message "the var is %s"(getenv "myenv"))
  (if  
    (message "yes") 
   (message "no")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (print-list-to-temp-pop-up master-comp-name-drction-list)
;; (print-list-to-temp-pop-up my-cmpnt-alist)
;; (print-list-to-temp-pop-up cmpnt-stmnt-ports-list)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;mtf took this from an emacs 24.3 installation
(if (<  emacs-major-version 24)
;
;
(defun split-window-right (&optional size)
  "Split the selected window into two side-by-side windows.
The selected window is on the left.  The newly split-off window
is on the right, and displays the same buffer.  Return the new
window.
;
If optional argument SIZE is omitted or nil, both windows get the
same width, or close to it.  If SIZE is positive, the left-hand
\(selected) window gets SIZE columns.  If SIZE is negative, the
right-hand (new) window gets -SIZE columns.  Here, SIZE includes
the width of the window's scroll bar; if there are no scroll
bars, it includes the width of the divider column to the window's
right, if any."
  (interactive "P")
  (let ((old-window (selected-window))
   (size (and size (prefix-numeric-value size)))
   new-window)
    (when (and size (< size 0) (< (- size) window-min-width))
      ;; `split-window' would not signal an error here.
      (error "Size of new window too small"))
    (setq new-window (split-window nil size t))
    ;; Always copy quit-restore parameter in interactive use.
    (let ((quit-restore (window-parameter old-window 'quit-restore)))
      (when quit-restore
   (set-window-parameter new-window 'quit-restore quit-restore)))
    new-window)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end of %s" (buffer-name))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'frame-win-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
