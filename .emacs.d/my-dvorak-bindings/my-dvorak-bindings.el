;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Begin bindings
;b0
;bob

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the beginning of my-dvorak-bindings.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;use this to put a newline in the minibuffor
;AHK helps by sending C-q when C-M-' is keyed
; To put a newline in
; 1) M-'
; 2) C-j
;Recall
(global-set-key (kbd "M-'") 'quoted-insert)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-SPC") 'my-big-rect-defun)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Occur 
(global-set-key [(control c) (O)] 'multi-occur-in-this-mode)
(global-set-key [(control c) (o)] 'myoccur)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [(control O)] 'open-line)
(global-set-key [(control o)] 'icicle-file)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Enable the copy paste sequence
;  1)C-c copy
;  2)C-v paste
;  3)C-S-v kill ring pop
(global-set-key (kbd "C-S-v")  'cua-paste-pop)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;buffer-window-frame kill
;
;;kill window + frame + buffer
;Calling just kill buffer prompts for the buf name, this is faster to ;be 
;explicit and specify the current bufferr.
(global-set-key (kbd "C-\\") '(lambda ()
				(interactive) (kill-buffer (current-buffer)))) 
;
;like Windows                
(global-set-key [C-f4] '(lambda ()
				(interactive) (kill-buffer (current-buffer)))) 
;
;;keeps the buffer open, kill window + frame
(global-set-key (kbd "M-\\") nil) 
(global-set-key (kbd "M-\\") 'delete-window);leaves tho 
;
;
;kill-this-buffer is re-defined in menu-bar+ to
;  (kill-buffer-and-its-windows (current-buffer))
(global-set-key (kbd "M-C-\\") nil)
(global-set-key (kbd "M-C-\\") 
                      '(lambda ()
			(interactive) (kill-buffer-and-its-windows (current-buffer))))
			

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-kill-buffer-and-its-windows ()
  (interactive) 
  (kill-buffer-and-its-windows (current-buffer)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [(control c) r] query and replaces
;this cancels a selected region (global-set-key [(control c) (r)] 'query-replace)
  ;(global-set-key [(control meta r)] 'query-replace)
  (global-set-key [(control c) (d)] 'edit-dot-emacs)
  (global-set-key [(control c) (C)] 'edit-cheat-dot-org)
  ;dvorak
  (global-set-key [(control c) (e)] 'edit-dot-emacs)
  ;
  (if(eq home-work 'work )
  (global-set-key [(control c) (control d)] '(lambda ()
    (interactive)
    (shell-command "c:/Users/mfitzgerald/AppData/Roaming/save_dot_emacs.bat")
    (shell-command "c:/Users/mfitzgerald/AppData/Roaming/save_dot_bmk.bat"))))
  ;
  (if(eq home-work 'home )
  (global-set-key [(control c) (control d)] '(lambda ()
    (interactive)
    (shell-command "c:/Users/family/AppData/Roaming/save_dot_emacs.bat")
    (shell-command "c:/Users/family/AppData/Roaming/save_dot_bmk.bat"))))
  ;
  (global-set-key [(control c) (control h)] '(lambda ()
     (interactive)
     (message "Saving emacs related files to flash drive")
     (shell-command "c:/Users/mfitzgerald/AppData/Roaming/copy_emacs_files_to_flash_drive.bat")))
  ;   
  (global-set-key [(control c) (control H)] '(lambda ()
    (interactive)
    (message "Copying emacs related files from flash drive")
    (shell-command "c:/Users/family/AppData/Roaming/copy_emacs_files_from_flash_drive.bat")))
  ;
  ;Icicles M-k caused an unessary re-display of the completions buffers
  (global-set-key [(control c) (return)] '(lambda ()
                                  (interactive)
                                     (delete-minibuffer-contents)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;open Tortice repo browser dir associated with current buffer
;; (global-set-key [(control meta f4)] '(lambda ()
;(global-set-key [(control meta l)] '(lambda ()
(global-set-key [(control meta f4)] 'my-open-tortise)

;open console in emacs cwd
;;(global-set-key [(control meta f2)] 'my-open-console)
;
;Autohotkey sends [(control meta v )] when win-e in pressed in emacs
; ! fixme need a good binding for this !
; ! fixme need a good binding for this !
;(global-set-key [(control meta v )] 'my-open-win-explorer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;make \ easier to type
;; (global-set-key (kbd "C-/") '(lambda ()
;;                                   (interactive)
;;                                      (insert "\\")
;;                                   ))
;
;make :\ easier to type (note DOS slash)
;; (global-set-key (kbd "M-/") '(lambda ()
;;                                   (interactive)
;;                                      (insert ":")
;;                                      (insert "\\")
;;                                   ))
;
;
;b1
;
(global-set-key [(control c) (a)] 'mark-whole-buffer)
(global-set-key [(control c) (h)] 'recentf-open-files)
(global-set-key [(control c) (p)] 'print-buffer)
;(global-set-key [(control c) (e)] 'recenter)
(global-set-key [(control c) (v)] 'revert-buffer)
(global-set-key [(control c) (s)] 'shell-current-directory)
;(global-set-key [(control c) (m)] 'my-fixup-whitespace)
;(global-set-key [(control c) (m)] 'my-fixup-whitespace)
;;
;(define-key global-map (kbd "C-+") 'text-scale-increase)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; defun xsteve-exchange-slash-and-backslash-4-minibuf is bound to C-.
; in the minibuffer map in my-icicle-setup.el
;
;(define-key minibuffer-local-map (kbd "C-\.") 'nil)
;(define-key minibuffer-local-map (kbd "C-\.") 'xsteve-exchange-slash-and-backslash-4-minibuf)
;(define-key minibuffer-local-map (kbd "C-\.") 'xsteve-exchange-slash-and-backslash-4-minibuf)
;(define-key minibuffer-local-map (kbd "M-7") 'xsteve-exchange-slash-and-backslash-4-minibuf)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-key global-map (kbd "C--") 'iswitchb-buffer)
(define-key global-map [M-f7] 'text-scale-increase)

(define-key global-map [M-f6] 'text-scale-decrease)
;
(global-set-key "\C-cl" 'goto-line)
(define-key global-map "\C-x\C-r" 'rgrep)
(global-set-key (kbd "C-h a") 'apropos)
;
;Windows like operation
(if load-ido
    (global-set-key "\C-r" 'my-ido-find-file)
    (global-set-key "\C-r" 'find-file))

(global-set-key "\C-o" 'save-buffer)
;(global-set-key "\C-f" 'isearch-forward)
;; (global-set-key "\C-n" 'isearch-forwardt)
(global-set-key "\C-s" 'isearch-forward)
(global-set-key [(control shift s )] 'isearch-backward)

(global-set-key [f12] 'write-file)
(global-set-key [M-f4] 'save-buffers-kill-emacs)
;isearch

(global-set-key [(meta f12)] 'block-right)
(global-set-key [(control f12)] 'block-left)

;org mode global
(global-set-key (kbd "\C-cA") 'org-agenda)
;
;(define-key  "\M-f" 'my-erase) ;
;
; switching
(global-set-key (kbd "<C-lwindow>") 'other-window)

; vnc to linux at MSI
(global-set-key (kbd "s-b") 'backward-word)
(global-set-key (kbd "s-1") 'other-window)
(global-set-key (kbd "s-2") 'other-window)
(global-set-key (kbd "s-h") 'other-window)
;
(global-set-key (kbd "s-!") 'my-other-frame)
(global-set-key (kbd "s-@") 'my-other-frame)
(global-set-key (kbd "s-t") 'my-other-frame)

(global-set-key (kbd "<C-M-lwindow>") 'bookmark-bmenu-list)
;vnc to linux at MSI
(global-set-key (kbd "s-b") 'bookmark-bmenu-list)

;try stuff bc (other-frame 1) acts goofy at times
;(global-set-key (kbd "<M-lwindow>") 'my-other-frame)
(global-set-key (kbd "<M-lwindow>") 'my-other-frame)

;this might work also
;(global-set-key (kbd "<M-lwindow>") 'next-multiframe-window)

;Added these to support Linux where the <windo\ws> key does not work
;(global-set-key (kbd "<C-left> ") 'icicle-other-window-or-frame)
;(global-set-key (kbd "<C-right> ") 'my-other-frame)

;------------------------------------------------------------------------
;------------------------------------------------------------------------
;delete/cut/zap
   (global-set-key (kbd "M-D") 'kill-word)
   (global-set-key (kbd "M-d") 'mark-paragraph)    ;qwerty "h" should be familiar
   (global-set-key (kbd "<C-backspace>") 'del-word-backwards-mike)
   ;(global-set-key "\C-\M-t"       'tinyeat-kill-line-backward)
   ;don't forget C-M-d runs the command tinyeat-delete-paragraph
   ;
;TINY
   ;whole word better than EMACS just-one-space
   ;whole word more efficienr than b.p. reverse the orignal bindings
   (global-set-key (kbd "M-SPC")         'tinyeat-delete-whole-word)
   (global-set-key (kbd "<C-delete>")    'tinyeat-backward-preserve)
   ;
   ; on linux an MSI M-backspace is getting translated to M-delete
   (global-set-key (kbd "<M-backspace>") 'tinyeat-forward-preserve)
   (global-set-key (kbd "<M-delete>")    'tinyeat-forward-preserve)
   (global-set-key "\C-\M-d"             'tinyeat-delete-paragraph)
   ;Want _ tp be part of a word
   ;works to inclide _ as part of a word 
     ;(setq tinyeat--non-word-chars "][=~+!@#&*:;'\"`,.<>(){}>?/|\\\\\n \t-")
      ;tried to eat thru newlines
      ;(setq tinyeat--non-word-chars "][=~+!@#&*:;'\"`,.<>(){}>?/|\t-")
   ;
;ZAP
   ;; (global-set-key (kbd "M-z") 'zap-up-to-char)
   ; In conflict with M-z as hippie expand
   ;(global-set-key (kbd "M-z") 'zap-up-to-char)
   ;(global-set-key "\M-z" 'fastnav-zap-up-to-char-forward)
   ;(global-set-key "\M-Z" 'fastnav-zap-up-to-char-backward)
   ;-------------------------------------------------------------;
;b2
;Fastnav
   ;(global-set-key  [(control c) (f)] 'fastnav-sprint-forward) ;
   ;(global-set-key "\M-m" 'fastnav-mark-to-char-forward)
   ;(global-set-key "\M-M" 'fastnav-mark-to-char-backward)    
   ;(global-set-key  [(control c) (b)] 'fastnav-sprint-backward);interfers
   ;(global-set-key "\M-f" 'fastnav-jump-to-char-forward)
   ;(global-set-key "\M-b" 'fastnav-jump-to-char-backward)
;-------------------------------------------------------------
;-------------------------------------------------------------
;mob
;
;Show and process file/path name
(global-set-key (kbd "C-.") 'show-file-name-general)
(global-set-key (kbd "C->") 'xsteve-exchange-slash-and-backslash)
;
;
;SMEX
;(global-set-key (kbd "M-j") 'smex)
(global-set-key (kbd "M-j") 'comment-indent-new-line) ;emacs default binding
;
(when load-my-smex-setup
  (global-set-key (kbd "M-x") 'smex))
;
(if load-my-smex-setup
  (global-set-key (kbd "M-q") 'smex)
  ;this one helps when not loading smex and Dvorak keyboard
  (global-set-key (kbd "M-q") 'execute-extended-command))
;
(global-set-key (kbd "M-Q") 'execute-extended-command)
;(global-set-key (kbd "M-k") 'execute-extended-command)
;DON'T FORGET THESE!
  ; C-h f,runs describe-function 
  ; M-. jumps to the definition
;
;Thing Copy
;(global-set-key "\C-l" 'thing-copy-line)
;
;Hippie Expand
;;use hippie-expandk;mostly for .el and .emacs files 
;  because vhdl mode already overloads the tab key
;; (global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "M-z") 'hippie-expand)
(global-set-key (kbd "M-Z") 'company-manual-begin)

;
;Undo-Tree
(global-set-key (kbd "C-S-z") 'undo-tree-redo)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;Comment
(global-set-key "\M-;" 'comment-dwim-line)
;
;Bookmarks
;(global-set-key (kbd "<f2>")   'bmkp-next-bookmark-this-file/buffer-repeat)
(global-set-key [f2] 'hydra-zoom/body)
;Fixed by D. Addams
(global-set-key [(control meta f2)] 'bmkp-next-bookmark-this-buffer-repeat)
;(global-set-key (kbd "<f2>")   'bmkp-next-bookmark-this-buffer-repeat)
(global-set-key (kbd "<S-f2>") 'bmkp-toggle-autonamed-bookmark-set/delete)
(global-set-key (kbd "<M-f2>") 'bookmark-bmenu-list)
;
;(global-set-key (kbd "<f2>")   'bmkp-next-bookmark-this-file/buffer-repeat)
;Fixed by D. Addams
;(global-set-key (kbd "<f2>")   'bmkp-next-bookmark-this-buffer-repeat)
;
;Ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
;
;Highlight-Symbol
(global-set-key [(control f3)] 'my-highlight-symbol-other-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; sometimes use f3 & f4 for macros
; call this interactively my-use-macro-keys when it's needed 
; simple use case is 
; * f3  to start defining
; * do something to repeat as a marco
; ** can use f3 again to insert a marco counter
; * f4 to end
; * f4 again and again...to execute
;
; More tips
; * <F3> C-u 2 <F3> . <ENTER> <F4> will increment with +2 (instead of +1)
; 
; * C-u 100 <F3> <F3> . <ENTER> C-u 50 <F4> will start at 100 and finish at 149
;
; C-x C-k C-f %03d <ENTER> <F3> <F3> . <ENTER> <F4> will pad with zero like "000"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-use-macro-keys () 
  (interactive)
   (global-set-key [f3] 'kmacro-start-macro-or-insert-counter)
   (global-set-key [f4] 'kmacro-end-or-call-macro))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-unuse-macro-keys () 
  (interactive)
   (global-set-key [f3] 'highlight-symbol-next)
   (global-set-key [f4] 'my-toggle-dired-same-frame))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Highlight-Symbol
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [f3] 'highlight-symbol-next)
;
;dired jump
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f4>") 'my-toggle-dired-same-frame)

;(global-set-key [(meta f3)] 'highlight-symbol-remove-all)
(global-set-key [(meta f3)] (lambda () 
  (interactive)
  (add-hook 'pre-command-hook 'my-highlight-symbol-hook)))

(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(control meta f3)] 'highlight-symbol-query-replace)
;
;Rotate Windows
;(global-unset-key (kbd "C-x m")) is compose mail
(global-set-key (kbd "C-c r") 'rotate-windows)
;
;use all these three together (How about some better bindings)
;   recenter-top-bottom            M-. (rt middle finger)
;   move-to-window-line-top-bottom M-c (left Middle finger)
;   scroll-down-keep-cursor        kp-addmy
(global-set-key (kbd "C-,") 'recenter-top-bottom)
(global-set-key (kbd "M-,") 'move-to-window-line-top-bottom)
;
;autohotkey stuff
(global-set-key (kbd "<apps> u") 'my-move-word-left)
(global-set-key (kbd "<apps> o") 'my-move-word-rt)
;
;Utilities
;(global-set-key  (kbd "C-S-t") 'my-fixup-whitespace)
;(global-set-key  "\M-k" 'my-fixup-whitespace)
 

;dvorak
(global-set-key (kbd "C-S-E") 'duplicate-line-or-region)
(global-set-key  (kbd "C-S-d") 'duplicate-line-or-region) 
(global-unset-key (kbd "M-v"))
(global-set-key  (kbd "M-v") 'duplicate-line-or-region) 

;(global-set-key (kbd "<S-f10>") 'insert-and-indent-line-below)
(global-set-key (kbd "<M-RET>") 'insert-and-indent-line-below)
(global-set-key  "\C-w" 'copy-word-near-point)
;(global-set-key (kbd "\C-k" ) 'kill-and-join-forward)
(global-set-key "\C-c\C-i" 'my-insert-file-name)
;
(global-unset-key (kbd "M-w"))
(global-set-key [(meta w)] 'insert-lastyank-next-line)
;
(global-unset-key (kbd "M-S-w"))
(global-set-key [(meta shift w)] 'insert-lastyank-above)
;
(global-unset-key (kbd "C-M-w"))
(global-set-key [(control meta w)] 'insert-lastyank-this-line)

;(global-set-key [(control p)] 'scroll-down-keep-cursor)
(global-set-key [(control shift p)] 'scroll-up-keep-cursor)

(global-set-key [(control n)] 'scroll-up-keep-cursor)
(global-set-key [(control shift n)] 'scroll-down-keep-cursor)
;
;  add and subtract are useful during M-x quick-calc
;; (global-set-key [kp-subtract] 'scroll-up-keep-cursor)
;; (global-set-key [kp-add] 'scroll-down-keep-cursor) 
;

(global-set-key [(control c) (n)] 'fancy-narrow)
(global-set-key [(control c) (w)] 'fancy-widen)
;b2i

(global-set-key [(home)] 'smart-beginning-of-line)
(global-set-key "\C-a" 'smart-beginning-of-line)
(global-unset-key (kbd "C-e"))
(global-set-key "\C-e" 'smart-end-of-line)
;(global-set-key  (kbd "C-e") 'icicle-end-of-line+)
;
(global-set-key [(shift home)] 'smart-beginning-of-line-select)
(global-set-key [(shift control a)] 'smart-beginning-of-line-select)
(global-set-key (kbd "M-<up>") 'move-line-region-up-wrapper)
(global-set-key (kbd "M-<down>") 'move-line-region-down-wrapper)
(global-set-key (kbd "<C-M-right> ") 'power-move-word-rt)
(global-set-key (kbd "<C-M-S-right> ") 'power-select-word-rt)
(global-set-key (kbd "<C-M-left> ") 'power-move-word-left)
(global-set-key (kbd "<C-M-S-left> ") 'power-select-word-left)
;(global-set-key (kbd "<M-S-left> ") 'my-move-word-left)
;(global-set-key (kbd "<M-S-right> ") 'my-move-word-rt)
(global-set-key [(shift f12)] 'myjunk)
(global-set-key (kbd "<C-M-down> ") 'power-down-para)
(global-set-key (kbd "<C-M-S-down> ") 'power-down-select-para)
(global-set-key (kbd "<C-M-up> ") 'power-up-para)
(global-set-key (kbd "<C-prior> ") 'super-power-up-para)
(global-set-key (kbd "<C-next> ") 'super-power-down-para)
(global-set-key (kbd "<C-M-prior> ") 'super-duper-power-up-para)
(global-set-key (kbd "<C-M-next> ") 'super-duper-power-down-para)
(global-set-key (kbd "<C-M-S-up> ") 'power-up-select-para)
;
;; (global-set-key (kbd "<M-prior> ") 'my-find-def-inst-back)
;; (global-set-key (kbd "<M-next> ") 'my-find-def-inst-fwd)
(global-set-key (kbd "<M-prior> ") 'my-find-comp-entity-inst-back)
(global-set-key (kbd "<M-next> ") 'my-find-comp-entity-inst-fwd)
;
;(global-set-key [(meta p)] ' copy-paragraph)
  ;(global-set-key (kbd "<f10>") 'insert-and-indent-line-above)
  (global-set-key (kbd "<C-return>") 'insert-and-indent-line-above)
  (global-set-key (kbd "<C-M-return>") 'newline-and-indent)
;; (global-set-key (kbd "M-8") 'extend-selection) 
(global-set-key (kbd "M-8") 'er/expand-region) 
(global-set-key (kbd "M-*") 'select-text-in-quote) 
;; (global-unset-key  [(control c) (w)] )
;; (global-set-key  [(control c) (w)] 'copy-word-near-point)
(global-unset-key  [(control) (w)] )
;(global-set-key  [(control) (w)] 'copy-word-near-point)
(global-set-key (kbd "C-`") 'push-mark-no-activate)
(global-set-key (kbd "M-`") 'jump-to-mark)
(global-set-key (kbd "M-~") 'unpop-to-mark-command)
(global-set-key (kbd "M-U") 'capitalize-word)

;;;;;;;;;;;;
;dvorak only
;;;;;;;;;;;;
(global-set-key (kbd "C-q") ctl-x-map)
(global-set-key (kbd "C-;") 'undo-tree-undo)
(global-set-key (kbd "C-:") 'undo-tree-redo)
;Note that the positional equielent to g is i, but C-i is ASCII tab
;
;http://www.gnu.org/software/emacs/manual/html_node/emacs/Quitting.html
;; (global-set-key (kbd "C-'") 'keyboard-quit)
; C-" is icicle-abort-recursive-edit bound in icicles
;
(global-set-key (kbd "C-h t") 'describe-key)
(global-set-key [?\C-,] 'recenter-top-bottom)
(global-set-key (kbd "C-x x") 'iswitchb-buffer)
(global-set-key (kbd "C-x C-'") 'dired-toggle-read-only)
(global-set-key (kbd "C-x C-'") 'dired-finish-edit)

;(define-key minibuffer-local-map (kbd "M-n") 'nil)
;; (define-key dired-mode-map  (kbd "C-g") 'nil)
;; (define-key dired-mode-map  (kbd "C-g") 'isearch-forward)

;
(global-set-key (kbd "M-e") 'del-whole-line-with-end);qwerty M-d
;note the change of of a VHDL mode binding
;
(global-set-key (kbd "C-t") 'kill-and-join-forward);qwerty C-k
(global-set-key (kbd "C-S-t") (lambda ()
                            (interactive)
                            (kill-and-join-forward -1)))

;
;http://xahlee.org/emacs/emacs_key-translation-map.html
(define-key key-translation-map (kbd "C-S-k") (kbd "C-S-v"))
;;;;;;;;;;;;
;dvorak only
;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;copy-from-above-command stuff
 (autoload 'copy-from-above-command "misc"
    "Copy characters from previous nonblank line, starting just above point.
  \(fn &optional arg)"
    'interactive)
; 
(global-set-key (kbd "C-M-l") 'copy-from-above-command)
;
;; (global-set-key (kbd "C-M-c") (lambda ()
;;                             (interactive)
;;                             (message "copy line from above")
;;                             (copy-from-above-command)))
;
(global-set-key (kbd "C-M-f") (lambda ()
                            (interactive)
                            (copy-from-above-command 1)))
;
(global-set-key (kbd "C-M-b") (lambda ()
                           (interactive)
                            (copy-from-above-command -1)
                            (forward-char -1)
                            (delete-char -1)))
;
(global-set-key (kbd "C-M-l") (lambda ()
                           (interactive)
                           (message "copy current lineR to below")
                           (forward-line 1)
                           (open-line 1)
                           (copy-from-above-command)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;line marking
;(global-set-key (kbd "<f7>") 'my-mark-line-forward)
(global-set-key [f7] 'my-smart-copy-line)
(global-set-key (kbd "<M-f7>") 'my-mark-line-forward)
(global-set-key (kbd "<C-f7>") 'my-mark-line-backward)
;
;line copy
;(global-set-key (kbd "<f6>") 'quick-copy-line-stay)
;(global-set-key [f6] 'my-avy-jump)
(global-set-key (kbd "<C-f6>") 'quick-copy-line-bk)
(global-set-key (kbd "<M-f6>")'quick-copy-line)

(global-set-key (kbd "<f8>") 'whitespace-mode)

;f9 adds/grooms space, shift f9 reduces/grooms
(global-set-key (kbd "<f9>") 'two-blank-lines)
(global-set-key (kbd "<S-f9>") 'my-fixup-whitespace)
(global-set-key (kbd "<M-f9>") 'seq-rect)

;; (global-set-key [(shift f11)]
;;   ;; '(lambda () "Previous" (interactive) (filesets-open nil "scancntl" )))
;;   '(lambda () "Previous" 
;;    (interactive) 
;;    ;; (filesets-open nil "surecom_scrt" )
;;    (filesets-open nil "surecom_svcont" )
;;    (make-frame-on-display t)
;;    (dired "m:/VHDL/fpga_designs/mfitzgerald/my_working_copies/svcont/trunk/")
;;    ;(dired-sort-menu-toggle-dirs-first)
;;    (split-window-horizontally)
;;    (dired "~/")
;;    (dired-sort-name)
;;    (dired-sort-extension)
;;    (split-window-horizontally)
;;    (dired "c:/users/mfitzgerald/desktop/")
;;    (dired-sort-name)
;;    (dired-sort-extension)))

;
(global-set-key [(meta control f11)] 'buffers-visiting-2-fileset)
;(global-set-key [(control f11) ] 'open-from-cache)

; (global-set-key "\C-f" 'occur-by-moccur)
; (global-set-key "\C-f" 'smart-beginning-of-line)
;(global-set-key "\C-b" 'smart-end-of-line)
(global-set-key [(control shift f )] 'moccur-grep-find)
;(global-set-key [(control f )] 'icicle-occur)

;def's in special-searches.el
;(global-set-key [f5] 'my-avy-jump)
(global-set-key [f5] 'my-find-def)
(global-set-key [(shift f5)]    'my-find-def)
(global-set-key [(meta f5)]     'my-find-def)
(global-set-key [(control f5)]  'my-find-def)

;;(global-set-key [(control \')] 'keyboard-quit)
(global-set-key (kbd "C-'") 'keyboard-escape-quit)

(defalias 'a     'ace-window)
(defalias 'rc    'rebox-cycle)
(defalias 'c     'my-frame-clean)
(defalias 'sr     'mike/sunrise)
;; (defalias 'ma     'maximize-frame-vertically)
(defalias 'm     'maximize-frame-vertically)
(defalias 'z     'delete-line)
;
(defalias 'qrr   'query-replace-regexp)
(defalias 'oks   'org-cut-subtree)
(defalias 'ocs   'org-copy-subtree)
(defalias 'ops   'org-paste-subtree)
(defalias 'oy    'org-yank)
(defalias 'fp    'fill-paragragh)
(defalias 'eb    'ediff-buffers)
(defalias 'er    'ediff-revision)
(defalias 'fo    'filesets-open)
(defalias 'fa    'filesets-add-buffer)
(defalias 'fs    'filesets-save-config)
(defalias 'obm   'occur-by-moccur)
(defalias 'tsrad 'toggle-search/replace-region-as-default)
(defalias 'ffip  'find-file-in-project)
(defalias 'ct    'my-create-tag-wizard-mult-frames-wrapped-4-error)
(defalias 'fn    'fancy-narrow-to-region)
(defalias 'fw    'fancy-widen)
(defalias 'mfsl 'move-frame-to-screen-left)
(defalias 'mfsr 'move-frame-to-screen-right)
(defalias 'dr 'downcase-region)
(defalias 'ur 'downcase-region)
(defalias 'ibk  'insert-bracket)
(defalias 'ibr 'insert-brace)
(defalias 'ip   'insert-paren)

;use the meta key for many curser movements
(global-set-key   (kbd "M-h")	'my-backward-char)
(global-set-key   (kbd "M-n")	'my-forward-char)
(global-set-key   (kbd "M-t")	'my-next-line)
(global-set-key   (kbd "M-c")	'my-prev-line)
;
(global-set-key   "\C-\M-t"	'forward-paragraph)
(global-set-key   (kbd "C-M-S-t") 'power-down-para)
(global-set-key   (kbd "C-M-S-c") 'power-up-para)
(global-set-key   "\C-\M-c"	    'backward-paragraph)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;words
(if (< emacs-major-version 24) 
  ;T
  (global-set-key   (kbd "M-b")	'backward-word)
  ;F
  (global-set-key   (kbd "M-b")	'my-left-word))
;
; maybe some good ideas, poorly implemented
;; (global-set-key   (kbd "M-f")	'forward-word-dont-go-over-non-words)
;; (global-set-key   (kbd "M-f")	'forward-word)
(global-set-key   (kbd "M-f")	'my-right-word)
;
;bob, eob
(global-set-key   (kbd "M-F")	'my-goto-bob-meaningful)
(global-set-key   (kbd "M-B")	'my-goto-eob-meaningful)
;
;bol, eol
(global-set-key   (kbd "M-r")	'smart-end-of-line)
(global-set-key   (kbd "M-R")	'smart-end-of-line-select)
(global-set-key   (kbd "M-g")	'smart-beginning-of-line)
(global-set-key   (kbd "M-G")	'smart-beginning-of-line-select)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key   (kbd "C-_")	'text-scale-increase)
(global-set-key   (kbd "C-M-_")	'text-scale-decrease)

;quickly switch buffers
;; (global-set-key [f4] (lambda ()
;;    (interactive)
;;    (switch-to-buffer (other-buffer (current-buffer) nil)
;;     ))) 
;
;; (global-set-key (kbd "C-b") (lambda ()
;;    (interactive)
;;    (switch-to-buffer (other-buffer (current-buffer) nil)
;;     ))) 

;http://xahlee.org/emacs/reclaim_keybindings.html
;(define-key minibuffer-local-map (kbd "M-n") 'nil)
;
;note icicles has another command on the same binding
;don't do it !"(global-set-key  (kbd "M-.") 'next-history-element)

;Needed to add this for moccur, 
(if load-icy-mode
  (define-key minibuffer-local-map (kbd "M-t") 'my-erase)
  (progn
  ;
  ;ido
    (define-key minibuffer-local-map (kbd "M-t") 'nil)
    (define-key minibuffer-local-map (kbd "M-t") 'repeat-clr-insert-minib-ido)))
  
;was dabbrev-expand
;; (define-key esc-map [?\C-/] 'nil)
;; (define-key esc-map [?\M-/] 'nil)
(global-unset-key [?\M-/])
(global-unset-key [?\C-/])
(global-set-key [?\M-/] 'smex)
(global-set-key [?\C-/] 'smex)

(global-unset-key (kbd "C-x i") )
(global-set-key (kbd "C-x i") 'mike/ibuffer)

(global-set-key (kbd "M-\]") 'my-enlarge-window-horizontally)
(global-set-key (kbd "M-\[") 'my-shrink-window-horizontally)

(global-set-key (kbd "M-\{") (lambda ()
   (interactive)
   ;( sr-shrink-panes )
   (my-sr-shrink-panes-dwim)
    )) 

(global-set-key (kbd "M-\}") (lambda ()
   (interactive)
   ;(sr-enlarge-panes)
   (my-sr-enlarge-panes-dwim)
    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-sr-shrink-panes (&optional arg) 
  (interactive)
  (let ((ctr 0) (my-trmcnt 5))
    (if arg
       (setq my-trmcnt arg))
    ; 
    (while (< ctr my-trmcnt )
    (setq ctr (+ ctr 1))
    (message "OK")
   (sr-shrink-panes)
   (sit-for .001)
  )))

(defun my-sr-enlarge-panes (&optional arg) 
  (interactive)
  (let ((ctr 0) (my-trmcnt 5))
    (if arg
       (setq my-trmcnt arg))
    ; 
    (while (< ctr my-trmcnt )
    (setq ctr (+ ctr 1))
    (message "OK")
   (sr-enlarge-panes)
   (sit-for .001)
  )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun resize-window (&optional arg)    ; Hirose Yuuji and Bob Wiener
  "*Resize window interactively."
  (interactive "p")
  (if (one-window-p) (error "Cannot resize sole window"))
  (or arg (setq arg 1))
  (let (c)
    (catch 'done
      (while t
	(message
	 "h=heighten, s=shrink, w=widen, n=narrow (by %d);  1-9=unit, q=quit"
	 arg)
	(setq c (read-char))
	(condition-case ()
	    (cond
	     ((= c ?h) (enlarge-window arg))
	     ((= c ?s) (shrink-window arg))
	     ((= c ?w) (enlarge-window-horizontally arg))
	     ((= c ?n) (shrink-window-horizontally arg))
	     ((= c ?\^G) (keyboard-quit))
	     ((= c ?q) (throw 'done t))
	     ((and (> c ?0) (<= c ?9)) (setq arg (- c ?0)))
	     (t (beep)))
	  (error (beep)))))
    (message "Done.")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun resize-window (&optional arg)    ; Hirose Yuuji and Bob Wiener
  "*Resize window interactively."
  (interactive "p")
  (if (one-window-p) (error "Cannot resize sole window"))
  (or arg (setq arg 1))
  (let (c)
    (catch 'done
      (while t
	(message
	 "h=heighten, s=shrink, w=widen, n=narrow (by %d);  1-9=unit, q=quit"
	 arg)
	(setq c (read-char))
	(condition-case ()
	    (cond
	     ((= c ?h) (enlarge-window arg))
	     ((= c ?s) (shrink-window arg))
	     ((= c ?w) (enlarge-window-horizontally arg))
	     ((= c ?n) (shrink-window-horizontally arg))
	     ((= c ?\^G) (keyboard-quit))
	     ((= c ?q) (throw 'done t))
	     ((and (> c ?0) (<= c ?9)) (setq arg (- c ?0)))
	     (t (beep)))
	  (error (beep)))))
    (message "Done.")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-sr-enlarge-panes-dwim (&optional arg) 
  (interactive)
  (if (or (equal major-mode 'sr-mode)
           (equal major-mode 'sr-virtual-mode))
    (progn
      ;T
      (if (< (window-height) 40)
      (my-sr-enlarge-panes 7)
      (my-sr-enlarge-panes 3)))
      ;
      (progn (one-quarter-other-window-height))))
;(global-set-key (kbd "<S-f6>") 'my-sr-shrink-panes-dwim)
;(global-set-key (kbd "<M-S-f6>") 'my-sr-enlarge-panes-dwim)
;
(defun my-sr-shrink-panes-dwim (&optional arg) 
  (interactive)
  (if (or (equal major-mode 'sr-mode)  
          (equal major-mode 'sr-virtual-mode))
    ;T
    (progn
      (if (> (window-height) 30)
      (my-sr-shrink-panes 8)
      (my-sr-shrink-panes 3)))
      ;
    (progn (four-x-other-window-height))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun one-quarter-other-window-height ()
  "Expand current window to use 1/4 of the other window's lines."
  (interactive)
  (enlarge-window (/ (window-height (next-window)) 4)))
;
(defun four-x-other-window-height ()
  "Expand current window to use 4x of the other window's lines."
  (interactive)
  (enlarge-window (-(/ (window-height (next-window)) 4))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-sr-enlarge-left-pane (&optional arg) 
  (interactive)
  (let ((ctr 0) (my-trmcnt 5))
    (if arg
       (setq my-trmcnt arg))
    ; 
    (while (< ctr my-trmcnt )
    (setq ctr (+ ctr 1))
    (message "OK")
   (sr-enlarge-left-pane)
   (sit-for .001))))
;
;
(defun my-sr-enlarge-right-pane (&optional arg) 
  (interactive)
  (let ((ctr 0) (my-trmcnt 5))
    (if arg
       (setq my-trmcnt arg))
    ; 
    (while (< ctr my-trmcnt )
    (setq ctr (+ ctr 1))
    (message "OK")
   (sr-enlarge-right-pane)
   (sit-for .001))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Ace jump mode
;(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-avy-jump (&optional arg)
  "Use avy the way that ace-jump did, except 
     1) Numeric prefix, (CNTL 2 or Meta 2) copy that number lines above current
     2) - prefix (Meta -)jump to char this line"
  (interactive "P"); raw prefix
  ;
  (if (equal current-prefix-arg nil)
   (call-interactively 'avy-goto-word-1))
  ;
  (if  (equal current-prefix-arg '(4))
      (progn
        (message "got here 4")
        ; set the prefix differently bc avy does something different with it!
        (setq current-prefix-arg nil)
        (call-interactively 'avy-goto-char)))
  ;
  (if  (equal current-prefix-arg '(16))
      (progn
        (message "got here 16")
        (call-interactively 'avy-goto-line)))
  ;
  (when (numberp arg)
      (progn
        (message "got here numeric")
        (avy-copy-line arg)))
  ;
  (when (equal arg '-)
      (progn
        (message "got here numeric")
        (call-interactively 'avy-goto-char-in-line))))
;
(global-set-key (kbd "C-c SPC") 'my-avy-jump)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (define-key global-map [(control meta ?z)] 'ace-jump-zap-to-char)
;; (define-key global-map [(control meta ?Z)] 'ace-jump-zap-up-to-char)
(define-key global-map [(control meta ?z)] 'zop-to-char)
(define-key global-map [(control meta ?Z)] 'zop-up-to-char)
;(define-key esc-map "~" 'ace-jump-mode-pop-mark)

(global-set-key (kbd "<S-f10>") 'my-indentanion-fix-up)

;experiment
;(global-set-key (kbd "<M-f1>") 'iconify-frame)

(define-key ctl-x-4-map "t" 'toggle-window-split)

;(global-set-key [(control meta kp-down)] 'my-enlarge-frame)
;; (global-set-key [(control meta kp-right)] 'my-enlarge-frame-horzontally)
(global-set-key [(control meta kp-right)] 'my-enlarge-frame-horizontal)
(global-set-key [(control meta kp-6)] 'my-enlarge-frame-horizontal)

(global-set-key [(control meta kp-left)] 'my-shrink-frame-horizontal-test)
(global-set-key [(control meta kp-4)] 'my-shrink-frame-horizontal-test)
;
(global-set-key [(control meta kp-up)] 'my-shrink-frame-test)
(global-set-key [(control meta kp-8)] 'my-shrink-frame-test)
;
(global-set-key [(control meta kp-down)] 'my-enlarge-frame-test)
(global-set-key [(control meta kp-2)] 'my-enlarge-frame-test)

;-------------------------------------------------------------------------
(global-set-key [(shift meta kp-right)] (lambda ()
   (interactive);note you need this line for the anano to evaluate!
   ;(fit-frame)
   ;(sit-for 1)
   ;; (move-frame-to-screen-right move-pop-up-frame-to-screen-right-amount)
   (move-frame-to-screen-right 10)
    ))
;
(global-set-key [(shift meta kp-6)] (lambda ()
   (interactive);note you need this line for the anano to evaluate!
   ;(fit-frame)
   ;(sit-for 1)
   ;; (move-frame-to-screen-right move-pop-up-frame-to-screen-right-amount)
   (move-frame-to-screen-right 10)
    ))
;-------------------------------------------------------------------------

;-------------------------------------------------------------------------
(global-set-key [(shift meta kp-down)] (lambda ()
   (interactive);note you need this line for the anano to evaluate!
   ;(fit-frame)
   ;(sit-for 1)
   (move-frame-to-screen-bottom 70)
    ))
(global-set-key [(shift meta kp-2)] (lambda ()
   (interactive);note you need this line for the anano to evaluate!
   ;(fit-frame)
   ;(sit-for 1)
   (move-frame-to-screen-bottom 70)
    ))
;-------------------------------------------------------------------------
;    
(global-set-key [(shift meta kp-left)] 'move-frame-to-screen-left)
(global-set-key [(shift meta kp-4)] 'move-frame-to-screen-left)
(global-set-key [(meta kp-4)] 'move-frame-left)
;
(global-set-key [(shift meta kp-up)] 'move-frame-to-screen-top)
(global-set-key [(shift meta kp-8)] 'move-frame-to-screen-top)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Suggested key bindings from frame-cmds.el:

(global-set-key (kbd "C-\\") '(lambda ()
				(interactive) (kill-buffer (current-buffer)))) 

   (global-set-key [(meta kp-up)] 'move-frame-up)
   ;
   (global-set-key [(meta kp-7)] '(lambda ()
                                  (interactive) 
                                  (maximize-frame-vertically)
                                  (move-frame-to-screen-left nil)))
                                  
   (global-set-key [(meta kp-8)] 'move-frame-up)
   (global-set-key [(meta kp-down)] 'move-frame-down)
   (global-set-key [(meta kp-2)] 'move-frame-down)
   (global-set-key [(meta kp-left)] 'my-move-frame-left)
   (global-set-key [(meta kp-4)] 'my-move-frame-left)
   (global-set-key [(meta kp-right)] 'my-move-frame-right)
   
   (global-set-key [(meta kp-6)] 'my-move-frame-right)

;;   (global-set-key [(control ?x) (control ?z)] 'iconify-everything)
;;   (global-set-key [vertical-line S-down-mouse-1] 'iconify-everything)
;;   (global-set-key [(control ?z)] 'iconify/map-frame)
     (global-set-key [mode-line mouse-3] 'mouse-iconify/map-frame)
     (global-set-key [mode-line C-mouse-3] 'mouse-remove-window)
;;   (global-set-key [(control meta ?z)] 'show-hide)
;;   (global-set-key [vertical-line C-down-mouse-1] 'show-hide)
;;   (global-set-key [C-down-mouse-1] 'mouse-show-hide-mark-unmark)
;;   (substitute-key-definition 'delete-window 'remove-window global-map)
     (define-key ctl-x-map "o" 'other-window-or-frame)
     (define-key ctl-x-4-map "1" 'delete-other-frames)
     (define-key ctl-x-5-map "h" 'show-*Help*-buffer)
     (substitute-key-definition 'delete-window 'delete-windows-for global-map)
;;   (define-key global-map "\C-xt." 'save-frame-config)
;;   (define-key ctl-x-map "o" 'other-window-or-frame)
;;
;;   (defalias 'doremi-prefix (make-sparse-keymap))
;;   (defvar doremi-map (symbol-function 'doremi-prefix) "Keymap for Do Re Mi commands.")
;;   (define-key global-map "\C-xt" 'doremi-prefix)
;;   (define-key doremi-map "." 'save-frame-config)
   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Not sure where to put these, there does not seem to be a hook
(define-key vc-prefix-map (kbd "a") 'vc-register);like svn add
(define-key vc-prefix-map (kbd "A") 'vc-annotate)
(define-key vc-prefix-map (kbd "r") 'vc-revert)
;; (define-key vc-prefix-map (kbd "U") 'svn-update);big U whole tree
(define-key vc-prefix-map (kbd "U") 'my-svn-update-for-vc-map)
;   
(define-key vc-prefix-map (kbd "u") 'vc-update);small u is only 1 file
; probably not for git ?? (define-key vc-prefix-map (kbd "=") 'my-ediff-cur-buf-against-repo-head)

(global-set-key (kbd "C-=") 'iedit-dwim)
(global-set-key [(control meta f12)] 'insert-text-move-block-right)
(global-set-key [(control meta S f12)] 'my-blank-rect)

;Ide Skel (not used?)
; (global-set-key [f4] 'ide-skel-proj-find-files-by-regexp)
; (global-set-key [f5] 'ide-skel-proj-grep-files-by-regexp)
; (global-set-key [f10] 'ide-skel-toggle-left-view-window)
; (global-set-key [f11] 'ide-skel-toggle-bottom-view-window)
; (global-set-key [f12] 'ide-skel-toggle-right-view-window)
; (global-set-key [C-next] 'tabbar-backward)
; (global-set-key [C-prior]  'tabbar-forward)

;double char there has to be something cool to do with this
;(global-set-key (kbd "<") 'double-char---great)

;Smart forwar
;(global-set-key (kbd "M-S-c") 'smart-up) ;what it bind n n nd
;(global-set-key (kbd "M-S-t") 'smart-down)
(global-set-key (kbd "M-H") 'smart-backward)
(global-set-key (kbd "M-N") 'smart-forward)

;buffer stack
(global-set-key (kbd "C-S-<tab>") 'buffer-stack-up) ; 
(global-set-key (kbd "C-<tab>") 'buffer-stack-down) ; 

;Rectangles
(global-unset-key (kbd "<S-down-mouse-1>"))
(global-set-key (kbd "<S-mouse-1>") 'hkb-mouse-mark-cua-rectangle)
(define-key cua--rectangle-keymap (kbd "<S-mouse-1>") 'hkb-mouse-mark-cua-rectangle)

;Marco math
(global-set-key "\C-x~" 'macro-math-eval-and-round-region)
(global-set-key "\C-x=" 'macro-math-eval-region)

;select paragraphs uniformly across modes
(global-set-key [(meta d)] 'my-mark-paragraph)

;(global-set-key [(meta c)] 'cua-exchange-point-and-mark)
;(global-set-key "\C-b" 'cua-exchange-point-and-mark)

;Use  bindings for meta keys in the minibuffer
(define-key minibuffer-local-map [(meta r)] 'nil)
(define-key minibuffer-local-map [(meta r)] 'smart-end-of-line)
(define-key minibuffer-local-map [(meta g)] 'smart-beginning-of-line)
(define-key minibuffer-local-map [(meta n)] 'forward-char)
(define-key minibuffer-local-map [(meta h)] 'backward-char)
(define-key minibuffer-local-map [(meta shift p)] 'next-history-element)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'log-edit-mode-hook
   (lambda ()
   ;Use  bindings for meta keys in log edit mode
   (define-key log-edit-mode-map [(meta r)] 'smart-end-of-line)
   (define-key log-edit-mode-map [(meta g)] 'smart-beginning-of-line)
   (define-key log-edit-mode-map [(meta n)] 'forward-char)
   (define-key log-edit-mode-map [(meta h)] 'backward-char)
   (define-key log-edit-mode-map [(meta shift p)] 'log-edit-next-comment)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;recent file

;(global-set-key [(control f11)] 'find-file-from-cache)
(global-set-key [(control f11)] 'open-from-cache)

(if load-icy-mode
 (global-set-key [(meta f11)] 'icicle-recent-file))

;(global-set-key [(meta f11)] 'my-icicle-recent-file)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x C-'") 'dired-finish-edit)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key [(control p)] 'ace-window)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; my take on moving by words
(global-set-key [(control meta r)] 'my-hdl-right-syntax-or-subword) 
(global-set-key [(control meta r)] 'my-hdl-right-syntax-or-subword) 
(global-set-key [(control meta g)] 'my-hdl-left-syntax-or-subword) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(global-set-key [(control meta r)] 'syntax-subword-right)
;(global-set-key [(control meta g)] 'syntax-subword-left)
(global-set-key (kbd "C-M-r") 'syntax-subword-right)
(global-set-key (kbd "C-M-g") 'syntax-subword-left)

;  probably not ; Idea to use these bindings from Xah Lee
;  probably not (global-set-key (kbd "<kp-divide>") 'buffer-stack-down)
;  probably not (global-set-key (kbd "<kp-multply>") 'buffer-stack-up)
;  probably not ;(global-set-key (kbd "<kp-multiply>") 'xah-next-user-buffer)
;  probably not  
;  probably not (global-set-key (kbd "<kp-subtract>") '(lambda ()
;  probably not    			(interactive) (kill-buffer (current-buffer)))) 


  ; this toggels from existing window config to 1 and back. 
  (if load-zygospore
    (global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; better binding and functionality than the default C-M-Ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key  (kbd "<C-M-RET>") 'indent-relative)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end of my-dvorak-bindings.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(provide 'my-dvorak-bindings)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
