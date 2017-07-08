;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;this format should be maintainable, use sort-lines
(setq icicle-files-to-download-list (quote (
"autofit-frame.el"
"bookmark+-1.el"   
"bookmark+-bmu.el" 
"bookmark+-chg.el" 
"bookmark+-doc.el" 
"bookmark+-key.el" 
"bookmark+-lit.el" 
"bookmark+-mac.el" 
"bookmark+.el"     
"buff-menu+.el"     
"col-highlight.el"
"crosshairs.el"
"dired+.el"
"dired-details+.el"
"dired-sort-menu+.el"
"doremi-cmd.el"
"doremi-frm.el"
"doremi.el"
"eyedropper.el"
"faces+.el"
"facemenu+.el"
"frame+.el"
"fit-frame.el"
"frame-cmds.el"
"frame-fns.el"
"grep+.el"
"help+.el"
"help-fns+.el"
"hexrgb.el"
"hide-comnt.el"
"hl-line+.el"
"highlight.el"
"icicles-chg.el"
"icicles-cmd1.el"
"icicles-cmd2.el"
"icicles-doc1.el"
"icicles-doc2.el"
"icicles-face.el"
"icicles-fn.el"
;"icicles-iswitchb.el"
"icicles-mac.el"
"icicles-mcmd.el"
"icicles-mode.el"
"icicles-opt.el"
"icicles-var.el"
"icicles.el"
"info+.el"
"isearch+.el"
"icomplete+.el"
"lacarte.el"
"misc-cmds.el"
"menu-bar+.el"
"oneonone.el"
"ring+.el"
"synonyms.el"
"replace+.el"
"thing-cmds.el"
"thingatpt+.el"
"thumb-frm.el"
"vline.el"
"window+.el"
"w32-browser.el"
"zoom-frm.el"
)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Iswitchb
;iswitch files in ~/.emacs.d/icicles/ now
;(add-to-list 'load-path "~/.emacs.d/icicles-iswitchb/")    
;
(when (eq load-icicles-iswitchb t)
  (require 'icicles-iswitchb)
  ;(iswitchb-default-keybindings);had to comment this and 
)
(iswitchb-mode 1);uncomment this for emacs 24
;
;Have modified errors in this, don't let the download wizard overwrite it!
(add-to-list 'load-path "~/.emacs.d/iswitchb-highlight/")    
(when (eq load-iswitchb-highlight t)
  (require 'iswitchb-highlight))
;
(setq iswitchb-buffer-ignore
    '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"  
 "^\*compilation" "^\*GTAGS" "^\*Help" "^session\.*" "^\*"))
;
(defun iswitchb-local-keys ()
  (mapc (lambda (K) 
      (let* ((key (car K)) (fun (cdr K)))
            (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
    '(("<right>" . iswitchb-next-match)
      ("<left>"  . iswitchb-prev-match)
      ("<up>"    . ignore             )
      ("<down>"  . ignore             ))))
    ;
   (add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)
;
;like the ido does not work, come back someday
;; (defun isw-disable-line-trucation () 
;;   (set (make-local-variable 'truncate-lines) nil))
;;   (add-hook 'iswitchb-minibuffer-setup-hook 'isw-disable-line-trucation)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-erase ()
   "replacement for icicle-erase-minibuffer-or-history-element
   does not cause the completions window to update(this was slow)"
  (interactive)
       (icicle-clear-minibuffer))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://emacswiki.org/emacs/Icicles_-_Customizing_Key_Bindings#toc4
(when load-icy-mode
 (add-hook 'icicle-mode-hook 'bind-my-icicles-keys)
 ;
     (defun bind-my-icicles-keys ()
       "Replace some default Icicles minibuffer bindings with others."
       (dolist (map (append (list minibuffer-local-completion-map
                                 minibuffer-local-must-match-map)
                            (and (fboundp 'minibuffer-local-filename-completion-map)
                                 (list minibuffer-local-filename-completion-map))))
         (when icicle-mode
            (define-key map "\M-t" 'my-erase);dvorak for M-k, erase the minibuffer
            ; Why did I define this? (define-key map [(control \,)] 'keyboard-quit)
       ;
            ;(define-key map "\M-s" 'my-erase);dvorak for M-k, erase the minibuffer
       ;
       ;C-' is quit, C-" is quit recursive
            (define-key map [(control \")] 'icicle-abort-recursive-edit)
            ; needed to make this a global binding ???
       ; perhaps in the icicle top level custom ???(define-key map [(control o)] 'icicle-file)
            ;
            ;binding changed with C-"
            ;swaps value of 
       ;   icicle-expand-input-to-common-match with 
       ;      icicle-expand-input-to-common-match-alt
            (define-key map "\M-\"" 'icicle-toggle-expand-to-common-match)
            (define-key map (kbd "<delete>") 'nil)
            ; this was unsuccessful in removing the binding (define-key map (kbd "C-x SPC") 'nil)
            (define-key map (kbd "<C-delete>") 'icicle-remove-candidate)
            (define-key map (kbd "<home>") 'nil)
            (define-key map (kbd "<end>") 'nil)
            (define-key map (kbd "C-.") 'nil) ;
            ;
            (define-key map [(meta b)] 'backward-word)
       (define-key map [(meta f)] 'forward-word)
       (define-key map [(meta n)] 'nil)
       (define-key map [(meta n)] 'forward-char)
       (define-key map [(meta h)] 'backward-char)
       (define-key map [(meta r)] 'nil)
       (define-key map [(meta r)] 'smart-end-of-line)
       (define-key map [(meta R)] 'smart-end-of-line-select)
       (define-key map [(meta g)] 'smart-beginning-of-line)
            ;
            (define-key map (kbd "C-.") 'xsteve-exchange-slash-and-backslash-4-minibuf) ;
            ;(define-key map (kbd "C-f") 'my-open-dired-on-candidate) ;
            ;
            ;needs icicle-kbd for some reaseon had a hard time , 
            ;with binding C-~??? Follow up sometime, because this is an
            ;un-healthy dependatcy.
            ;(global-set-key (icicle-kbd "C-~") 'moccur-flush-lines)
            ))))
;
;NOTE That the binding for icicle-complete-thesaurus-entry was removed
;because of a conflict with org mode by removing it from 
;icicle-top-level-key-bingings with the custom interface
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;make work at minibuffers outside icicles
;C-' is quit, C-" is quit recursive
(global-set-key [(control \")] 'icicle-abort-recursive-edit)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (and load-icicles load-icy-mode)
  (require 'icicles)
  (icy-mode)
  ;moved to .emacs (load "~/.emacs.d/icicles-install/icicles-install")
  (setq icicle-network-drive-means-remote-flag nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-help-fns+ t)
  (require 'help-fns+))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Facemenu Improvement
(add-to-list 'load-path "~/.emacs.d/icicles/")
(require 'doremi-frm) ;added at work, bc facemenu+ really wanted it??

(when (eq load-facemenu+ t)    
  (require 'facemenu+))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;; (defun my-c-return ()
;;   "When in minibuffer use `icicle-candidate-action', otherwise use `cua-set-rectangle-mark'."
;;   (interactive)
;;   (if (window-minibuffer-p (selected-window))
;;       (call-interactively 'icicle-candidate-action)
;;     (call-interactively 'cua-set-rectangle-mark)))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-browse-kill-ring+ t)
  (add-to-list 'load-path "~/.emacs.d/browse_kill_ring_plus/")
  (require 'browse-kill-ring+))
;;needed for Browse kill ring, delete select operation
;note cua-mode had some functionality for  delete select functionality
;but does not load delete-selection-mode.
;(delete-selection-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;MTF 3-14-12 When icicle-default-value is set to insert-end my-yank-command
; breaks in a way such that completiona are not offered,  just the last yank.
(defun my-yank-command ()
  (interactive)
  (let ((icicle-default-value nil))
  (icicle-yank-maybe-completing -1)
))
;
;register with delete-selection mode
(put 'my-yank-command 'delete-selection 'yank)
;
(defun my-imenu-command ()
  (interactive)
  (icy-mode t)
  (icicle-imenu)
  (icy-mode nil))
;
;additional binding
; (global-set-key [(control y)] 'icicle-yank-maybe-completing )
;; (global-set-key [( shift return)] 'icicle-candidate-action )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;primarily use with icicle find-file
;
(if (eq home-work 'work)
(defun repeat-clr-insert-minib () 
 "Erase what appears in the minibuffer and replace with 
 something more interesting"
 (interactive "^")
    (let ((n (seq-times 'repeat-clr-insert-minib 11)))
    (cond   ((= n 0) (my-erase)(icicle-insert-thing "~/"))
            ((= n 1) (icicle-insert-thing "~/.emacs.d/"))
            ((= n 2) (icicle-insert-thing "c:/users/mfitzgerald/desktop/"))
            ((= n 3) (icicle-insert-thing "c:/users/mfitzgerald/mydata/"))
            ((= n 4) (icicle-insert-thing "c:/users/mfitzgerald/mybin/"))
            ((= n 5) (icicle-insert-thing "m:/VHDL/fpga_designs/mfitzgerald/"))
            ((= n 6) (icicle-insert-thing "m:/VHDL/fpga_designs/Surecom/"))
            ((= n 7) (icicle-insert-thing "m:/VHDL/fpga_designs/mfitzgerald/scratch.txt"))
            ;
            ((= n 8) (message "lisp beginngng of line word, 2 groups")
               (icicle-insert-thing my_lisp_beginngng_of_line_word))
               ;
            ((= n 9) (message "end of line word  2 groups")
               (icicle-insert-thing my_end_of_line_word))
               ;
            ((= n 10) (message "beginning of line word 2 groups")
               (icicle-insert-thing my_beginngng_of_line_word ))
               ;
            ((= n 11) (icicle-insert-thing "~/"))
            (T (GOTO-CHAR SEQ-START-POINT))))))
;
; don't know why this code was there bc it's functionality is already defined for
; work and home keep an eye open for any strange behavior than may be caused by 
; commenting this
;; (defun repeat-clr-insert-minib () 
;;  "Erase what appears in the minibuffer and replace with 
;;  something more interesting"
;;  (interactive "^")
;;     (let ((n (seq-times 'repeat-clr-insert-minib 10)))
;;     (cond   ((= n 0) (my-erase)(icicle-insert-thing "~/"))
;;             ((= n 1) (icicle-insert-thing "~/.emacs.d/"))
;;             ((= n 2) (icicle-insert-thing "m:/VHDL/fpga_designs/mfitzgerald/"))
;;             ((= n 3) (icicle-insert-thing "c:/users/mfitzgerald/desktop/stuff/"))
;;             ((= n 4) (icicle-insert-thing "c:/users/mfitzgerald/downloads/"))
;;             ;
;;             ((= n 5) (message "lisp beginngng of line word, 2 groups")
;;                (icicle-insert-thing my_lisp_beginngng_of_line_word))
;;                ;
;;             ((= n 6) (message "end of line word  2 groups")
;;                (icicle-insert-thing my_end_of_line_word))
;;                ;
;;             ((= n 7) (message "beginning of line word 2 groups")
;;                (icicle-insert-thing my_beginngng_of_line_word ))
;;                ;
;;             ((= n 8) (icicle-insert-thing "~/"))
;;             (T (GOTO-CHAR SEQ-START-POINT)))))
;
(if (eq home-work 'home)
(defun repeat-clr-insert-minib () 
 "Erase what appears in the minibuffer and replace with 
 something more interesting"
 (interactive "^")
    (let ((n (seq-times 'repeat-clr-insert-minib 10)))
    (cond   ((= n 0) (my-erase)(icicle-insert-thing "~/"))
            ((= n 1) (icicle-insert-thing "~/.emacs.d/"))
            ((= n 2) (icicle-insert-thing "c:/users/FAMILY/documents/"))
            ((= n 3) (icicle-insert-thing "c:/users/FAMILY/documents/life/"))
            ((= n 4) (icicle-insert-thing "c:/users/family/desktop/"))
            ;
            ((= n 5) (message "lisp beginngng of line word, 2 groups")
               (icicle-insert-thing my_lisp_beginngng_of_line_word))
               ;
            ((= n 6) (message "end of line word  2 groups")
               (icicle-insert-thing my_end_of_line_word))
               ;
            ((= n 7) (message "beginning of line word 2 groups")
               (icicle-insert-thing my_beginngng_of_line_word ))
               ;
            ((= n 8) (icicle-insert-thing "~/"))
            (T (GOTO-CHAR SEQ-START-POINT))))))
;
 (global-unset-key [( meta T)])
 (global-set-key [( meta T)] 'repeat-clr-insert-minib )
;emable the sequence: 
;   "my-erase" followed by "repeat-clr-insert-minib"
;   M-t -> M-T
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun my-erase-is ()
"erase the minibuf, during isearch"
  (interactive)
  (setq isearch-string "")
  (isearch-edit-string))


(if (eq home-work 'work)
(defun repeat-clr-insert-minib-is () 
 "Erase what appears in the minibuffer and replace with 
 something more interesting"
 (interactive "^")
    (let ((n (seq-times 'repeat-clr-insert-minib-is 8)))
    (cond   ((= n 0)
               (if (eq isearch-string "")
                  (insert "^[ ]*")
                   (insert "")))
            ;
            ((= n 1)(delete-minibuffer-contents)(insert "[ ]*$"))
            ((= n 2)(delete-minibuffer-contents)(insert "\\(function \\|task\\)"))
            ((= n 3)(delete-minibuffer-contents)(insert "<=.*name-here"))
            ((= n 4)(delete-minibuffer-contents)(insert "^\\s-*$"))
            ((= n 5)(delete-minibuffer-contents)(insert "\\<[a-zA-z_0-9]+\\>+[ ]+$"))
            ((= n 6) (icicle-insert-thing my_lisp_beginngng_of_line_word))
            ((= n 7) (icicle-insert-thing "c:/users/FAMILY/DESKTOP/"))
            ((= n 8) (icicle-insert-thing my_lisp_beginngng_of_line_word))
            (T (GOTO-CHAR SEQ-START-POINT))))))


(if (eq home-work 'home)
(defun repeat-clr-insert-minib-is () 
 "Erase what appears in the minibuffer and replace with 
 something more interesting"
 (interactive "^")
    (let ((n (seq-times 'repeat-clr-insert-minib-is 8)))
    (cond   ((= n 0)
               (if (eq isearch-string "")
                  (insert "^[ ]+");leading space
                   (insert "")))
            ;
            ((= n 1 ) (delete-minibuffer-contents)(insert "\\(task \\|function\\)"));signal
            ((= n 2 ) (delete-minibuffer-contents)(insert "\\_<symbol\\_>"));symbol
            ((= n 3 ) (delete-minibuffer-contents)(insert "[ ]+$")) ;blank line
            ((= n 4 ) (delete-minibuffer-contents)(insert "^\\s-*$"))
            ((= n 5 ) (delete-minibuffer-contents)(insert "\\<[a-zA-z_0-9]+\\>+[ ]+$"));leading word
            ((= n 6 ) (icicle-insert-thing "\\_<symbol\\_>"))
            ((= n 7 ) (icicle-insert-thing "~/"))
            ((= n 8 ) (icicle-insert-thing "~/"))
            (T (GOTO-CHAR SEQ-START-POINT))))))


;; (defun my-isearch-del-line ()
;;   ""
;;   (interactive)
;;   (if (= 0 (length isearch-string))
;;       (ding)
;;     (setq isearch-string ""
;;           isearch-message (mapconcat 'isearch-text-char-description
;;                                      isearch-string "")))
;;   ;; Use the isearch-other-end as new starting point to be able
;;   ;; to find the remaining part of the search string again.
;;   (if isearch-other-end (goto-char isearch-other-end))
;;   (isearch-search)
;;   (isearch-push-state)
;;   (isearch-update))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-erase-is ()
;;    "replacement for icicle-erase-minibuffer-or-history-element
;;    does not cause the completions window to update(this was slow)"
;;   (interactive)
;;   ;(isearch-edit-string)
;;   (my-isearch-del-line))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;To rotate with mouse:
;M-x doremi-color-themes+
;M-x doremi-window-width+
;Hold the Meta key down to increase the resizing speed (increment)
(when (eq load-doremi-cmd t)
  (require 'doremi-cmd))
  ;
;; (global-set-key (kbd "C-x t w") ' doremi-window-width+)
;
;End Icicleso
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;icicle only bindings
;(global-set-key (kbd "C-/") ' doremi-window-width+)
;(global-set-key (kbd "C-M--") ' doremi-window-width+)
;(global-set-key (kbd "C-M-_") ' doremi-window-height+)
;playing around (global-set-key [(meta q)] 'my-imenu-command)
;
(global-set-key [(meta m)] 'my-yank-command);dvorak M-y
(global-set-key [(meta y)] 'my-yank-command)
;(global-set-key [(control f11)] 'icicle-recent-file)
;(global-set-key [(meta f12)] 'my-erase)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;icicle-insert-string-from-variable candidates 
;C-= inserts icicle.. var defined in custom in minibuf 
;C-u C-= ... with string vars as completion candidates, use my then tab to complete
;
;(setq my_home "~/") !!!!JUST USE C-=!!!!
;
(setq my_dot_emacs_dot_d "~/.emacs.d")
(setq my_color_themes_dot_d "~/.emacs.d/color-theme-6.6.0/themes")
(setq my_icicle_source_files "~/.emacs.d/icicles")
(setq my_bookmarks_source_files "~/.emacs.d/bookmarks_plus")
(setq my_stuff "h:/stuff/")
(setq my_desktop "c:/users/mfitzgerald/desktop/")
(setq my_vhdl_file_names "[a-z_0-9]+\.vhd$")
;
;capture last word,word is the group
(setq my_end_of_line_word  "\\(\\<[a-zA-z_0-9]+\\>\\)+\\([ ]+$\\)")
;
;capture first word
;first group is beg whitespace and second group is a word
;useful for qreplacing all the first words
(setq my_beginngng_of_line_word  "\\(^[ ]+\\)\\(\\<[a-zA-z_0-9]+\\>\\)+")
;
;first group is leading space, 2nd in word, third is word
;use
     ;old signal ser_cpu_inject_msg_length_errg 
     ;old signal ser_cpu_inject_msg_length_errg_t 
     ;Edit replacement string: \1\2 \3_tb
(setq my_beginngng_of_line_2nd_word  
"\\(^[ ]+\\)\\(\\<[a-zA-z_0-9]+\\>\\)+[ ]+\\(\\<[a-zA-z_0-9]+\\>\\)")
;
;first group is beg whitespace and (, second group is a word
;useful for qreplacing
   ;old  (require
   ;new  (my-require
;in .el files
(setq my_lisp_beginngng_of_line_word  "\\(^[ ]+\(\\)\\(\\<[(a-zA-z_0-9]+\\>\\)+")
;
(setq my_lisp_end_of_line_word  "\\(^[ ]+\\)\\(\\<[(a-zA-z_0-9]+\\\(>\\)+")
;
(setq my_lisp_end_of_line_word  "\\(\\<[(a-zA-z_0-9]+\\>+\\)\\([ ]*\\(,\\|;\\|\)\\)+[ ]*$\\)")

(setq my_lisp_blank_line  "^\\s-*$")

;use case
;to replace arst_out,
;with       arst_out_tb 
; 
; use \1_tb\3\4
;
;to replace nil)
;with       t) 
; 
; use t\3\4
;
;worke for delim of ) also
;generally works for one of the three , ) ;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun foo ()
 "use this when many ex 10 dired buffer are open
  and you can't see the path.  Drew shows the path in the mode line during
   icicle buffer"
 (interactive)
 (let ((current-prefix-arg  '(4)))
   (icicle-buffer)))
;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-oneonone-params t)
   ; this is in a defvar, rather defcustom
   (setq 1on1-special-frame-cursor-color "red")
   ;
   (remove-hook 'same-window-buffer-names "*info*")
   (remove-hook 'same-window-regexps "\\`\\*Customiz.*\\*\\'")
   (remove-hook 'same-window-regexps "\\*info\\*\\(\\|<[0-9]+>\\)")
    
   ;only 4 oneonone
   ;
   (when (or (<  (string-to-number emacs-version) 24.3) t);force it
     (setq special-display-regexps  '("[ ]?[*][^*]+[*]")))
    
   ;
   ;don't battle with color theme (let color theme set them)
   (setq 1on1-color-mode-line-flag nil)
   ;;2 below only used when 1on1-color-mode-line-flag is t	
   ;;(setq 1on1-active-mode-line-background "gray80")
   ;;(setq 1on1-inactive-mode-line-background "Gray50")
    
   ;not sure this is needed, played with t and nil did not 
   ;seem to make a difference
   (setq 1on1-*Help*-frame-flag t)
   ;; 
   (when (boundp 'my-background)
     (setq 1on1-help-frame-background my-background))
   ;
   ;The special-frame alist gets written by this if it is
   ;not assigned,  this does not overwright whan was
   ;assigned if there was something. Seems more sane to
   ;make a explicit special frames alist, perhaps control
   ;it from a "color-theme-..."
   ;;(setq 1on1-default-special-frame-foreground "white")
    					   
   ;NOT assigned from an alist, and is used dynamically
   ;to change the color of the minibuffer using something like:
   ;;(select-frame 1on1-minibuffer-frame)
   ;;    (sMYet-background-color 1on1-active-minibuffer-frame-background)
   ;So it must be set as part of an init config
   (when (boundp 'my-background)
     (setq 1on1-active-minibuffer-frame-background my-background)
     (setq 1on1-inactive-minibuffer-frame-background my-background))
    	 
    
   ;NOT set from an emacs alist, must set explititly as part
   ;of a configuration.
   (when (boundp 'my-background)
     (setq 1on1-completions-frame-background my-background)
     (setq 1on1-isearch-minibuffer-frame-background my-background))
   ;
   ;interesting
   ;(load-theme wombat t)
   ;(load-theme deeper-blue t)
   ;(load-theme 'tango-dark t)
   ;
   ;Note that on the home machine lib "color-theme" seems problematic
   ;with oneonone in emacs 24 with what I was using as "color-theme-tango.
   ;When oneonone is loaded before color theme the default font seems to be
   ;black  When the other way oround the font is black and the 
   ;frame has white splotches.  This is with careful setting of 
   ;default-frame-alist.  The other dark themes
   ;I was using seem to work with oneonone and the alists above.
   ;Do I need the alists above?  They seem like a good idea, espicailly
   ;for the mini-buffer, oneonone did not seem to pick up the paremeter
   ;that Drew provided, but it seems to see the alist
   )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;frame related stuff
(when (eq load-fit-frame t)   
   (require 'fit-frame)
   (add-hook 'after-make-frame-functions 'fit-frame))
   ;
(when (eq load-autofit-frame t)   
   (require 'autofit-frame)
   (add-hook 'after-make-frame-functions 'fit-frame))
;
;zooming
(when (eq load-zoom-frm t)
   (require 'zoom-frm)
   ;
   (global-set-key (if (boundp 'mouse-wheel-down-event) ; Emacs 22+
               (vector (list 'control mouse-wheel-down-event))
             [C-mouse-wheel])    ; Emacs 20, 21
           'zoom-in)
   (when (boundp 'mouse-wheel-up-event) ; Emacs 22+
     (global-set-key (vector (list 'control mouse-wheel-up-event))
             'zoom-out))
   ;this binding used for rect selection with a mouse
   ;(global-set-key [S-mouse-1]    'zoom-in)
   ;(global-set-key [C-S-mouse-1]  'zoom-out)
   ;(global-set-key [S-down-mouse-1] nil)
   )
;zooming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-frame-cmds t)
   (require 'frame-cmds))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-oneonone t)
   ;(add-to-list 'load-path "~/.emacs.d/oneonone/")
   (require 'oneonone)
   ;
   (eval-after-load "window" '(require 'window+));emacs 24
   ;
   (message "-----THE VALUE: %S-----" 1on1-minibuffer-frame-flag)
   ;
   ; this param did not want to be customized to an intger
   (setq 1on1-minibuffer-frame-top/bottom -45)
   ;
   (1on1-emacs)
   (toggle-box-cursor-when-idle 1) ; Turn on box cursor when idle.
   (require 'misc-cmds)
   ;



   (scroll-bar-mode 0) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(eval-after-load "misc-cmds"
  ;; '(when sub-kill-buffer-and-its-windows
  '(when t
    (substitute-key-definition   'kill-buffer
                                'kill-buffer-and-its-windows global-map)
    ;
    (substitute-key-definition   'kill-this-buffer
                                'kill-buffer-and-its-windows global-map)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq sub-kill-buffer-and-its-windows t);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(eval-after-load "menu-bar" '(require 'menu-bar+));menu-bar+ makes a goofy
;problem where enlarge-frame shrinks rather that enlarges.  
;Grabbed one defun needed from menu-bar+ and put it here with eval-after-load
;bc the orginal is in menu-bar.el
(eval-after-load "menu-bar"
'(defun kill-this-buffer ()
"Delete the current buffer and delete all of its windows."
  (interactive)
  (if (and (boundp 'sub-kill-buffer-and-its-windows) ; In `setup-keys.el'.
           sub-kill-buffer-and-its-windows
           (fboundp 'kill-buffer-and-its-windows))
      (kill-buffer-and-its-windows (current-buffer)) ;`misc-cmds.el'
    (kill-buffer (current-buffer)))))    ; <-- original defn.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-fisheye t)
 (require 'thumb-frm)
   (global-set-key [(shift mouse-3)] 'thumfr-toggle-thumbnail-frame)
   ;
   (global-set-key [(shift control mouse-3)] 'thumfr-thumbify-other-frames)
   ;(global-set-key [(shift control ?z)] 'thumfr-thumbify-other-frames)
   ;
   (global-set-key [(shift control ?p)] 'thumfr-fisheye-previous-frame)
   ;(global-set-key [(shift control ?n)] 'thumfr-fisheye-next-frame)
   ;
   (global-set-key [(control meta ?z)] 'thumfr-really-iconify-or-deiconify-frame)
   ;
   (global-set-key [(control meta shift ?z)] 'show-hide)
   ;(global-set-key [(control ?x) (control ?z)] 'iconify-everything)
   (global-set-key [C-down-mouse-1] 'mouse-show-hide-mark-unmark)
   (global-set-key [mode-line mouse-3] 'mouse-iconify/map-frame)
   ;(global-set-key [(control ?z)] 'iconify/map-frame)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-icomplete+ t)
  (icomplete-mode 1)
  (require 'icomplete+)
  (setq icomplete-with-completion-tables  t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-icicle-recent-file (arg)
   "Call i.r.f my favorite ways"
   (interactive "P")
   ;
   ;(let ((icicle-show-Completions-initially-flag t))
      (when (not (equal arg '-))
        (let ( 
               (current-prefix-arg)
               ; (icicle-sort-comparer  'icicle-2nd-part-string-less-p)
               ; (icicle-show-Completions-initially-flag t)
       	  )
           ;       
           ;(my-icicle-recent-file-sort-by-spf)
           (icicle-recent-file)
           ;(message "%s"  icicle-sort-comparer)
         ))
      ;
      (when  (equal arg '-) 
        (let ( 
                (current-prefix-arg  '(-1))
               ; (icicle-sort-comparer  'icicle-2nd-part-string-less-p)
       	  )
           ;       
           (my-icicle-recent-file-sort-by-spf)
           ;(message "%s"  icicle-sort-comparer)
         ))
       
   ;)
 )
;(global-set-key [(meta f11)] 'my-icicle-recent-file)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;need these for defining an icicle multicommand 
;  (as in my-icicle-recent-file-sort-by-spf below)
;eval-when-compile behaves as (progn ...) when not compiling
(eval-when-compile (require 'recentf)) ;; recentf-mode
(eval-when-compile
 (or (condition-case nil
         (load-library "icicles-mac")   ; Use load-library to ensure latest .elc.
       (error nil))
     (require 'icicles-mac)))           ; Require, so can load separately if not on `load-path'.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(icicle-define-command my-icicle-recent-file-sort-by-spf ; Command name
  "Open a recently used file.
With a prefix argument, you can choose also by date: Completion
candidates include the last modification date.

Note that completion here matches candidates as ordinary strings.  It
knows nothing of file names per se.  In particular, you cannot use
remote file-name syntax.

Remember that you can use `C-x .' to hide the common match portion of
each candidate.  That can be particularly helpful for files that are
in a common directory.

During completion (`*' means this requires library `Bookmark+'):

 *You can use `C-x a +' or `C-x a -' to add or remove tags from the
   current-candidate file.  You are prompted for the tags.
 *You can use `C-x m' to access file bookmarks (not just autofiles).
  You can use `C-c +' to create a new directory.
  You can use `M-|' to open Dired on currently matching file names.
  You can use `S-delete' to delete a candidate file or (empty) dir.

You can use any of the alternative-action keys, such as `C-S-RET', to
remove a candidate file from the recent files list, `recentf-list'.
\(The file itself is not deleted.)

These options, when non-nil, control candidate matching and filtering:

 `icicle-file-extras'           - Extra absolute file names to display
 `icicle-file-match-regexp'     - Regexp that file names must match
 `icicle-file-no-match-regexp'  - Regexp file names must not match
 `icicle-file-predicate'        - Predicate file names must satisfy
 `icicle-file-sort'             - Sort function for candidates

For example, to show only names of files larger than 5000 bytes, set
`icicle-file-predicate' to:

  (lambda (file) (and (numberp (nth 7 (file-attributes file)))
                      (> (nth 7 (file-attributes file)) 5000)))

Option `icicle-file-require-match-flag' can be used to override
option `icicle-require-match-flag'.

Option `icicle-files-ido-like' non-nil gives this command a more
Ido-like behavior."                     ; Doc string
  (lambda (f) (find-file (icicle-transform-multi-completion f) 'WILDCARDS)) ; Action function
  prompt icicle-abs-file-candidates nil ; `completing-read' args
  (and (fboundp 'confirm-nonexistent-file-or-buffer)  (confirm-nonexistent-file-or-buffer)) ;Emacs 23.
  nil 'file-name-history (car recentf-list) nil
  (icicle-file-bindings                 ; Bindings
   ((prompt                                 "Recent file (absolute): ")
    (icicle-full-cand-fn                `(lambda (file)
                                          (setq file  (if (file-directory-p file)
                                                          (file-name-as-directory file)
                                                        file))
                                          ,(if current-prefix-arg
                                               '(icicle-make-file+date-candidate file)
                                               '(list file))))
    (icicle-transform-before-sort-p         t)
    ;; (icicle-sort-comparer                   'icicle-last-accessed-first-p)
    (icicle-sort-comparer                   'icicle-2nd-part-string-less-p)
    (icicle-abs-file-candidates
     (progn (unless (boundp 'recentf-list) (require 'recentf))
            (when (fboundp 'recentf-mode) (recentf-mode 99))
            (unless (consp recentf-list)
              (error "No recently accessed files"))
            (mapcar (lambda (file)      ; FREE here: CURRENT-PREFIX-ARG.
                      (if current-prefix-arg (icicle-make-file+date-candidate file) (list file)))
                    recentf-list)))
    (icicle-candidate-alt-action-fn         'icicle-remove-from-recentf-candidate-action)
    (icicle-use-candidates-only-once-alt-p  t)
    (icicle-candidate-properties-alist      (and current-prefix-arg  '((1 (face icicle-candidate-part)))))
    (icicle-multi-completing-p              current-prefix-arg)
    (icicle-list-use-nth-parts              (and current-prefix-arg  '(1)))
    (icicle-all-candidates-list-alt-action-fn ; M-|'
     (lambda (files) (let ((enable-recursive-minibuffers  t))
                       (dired-other-window (cons (read-string "Dired buffer name: ")
                                                 (mapcar #'icicle-transform-multi-completion files))))))))
  (progn                                ; First code
    (when current-prefix-arg (put-text-property 0 1 'icicle-fancy-candidates t prompt))
    (icicle-highlight-lighter)
    (message "Gathering files...")
    (icicle-bind-file-candidate-keys))
  nil                                   ; Undo code
  (icicle-unbind-file-candidate-keys))  ; Last code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(icicle-define-command my-icicle-recent-file-sort-by-mod-time ; Command name
  "Open a recently used file.
With a prefix argument, you can choose also by date: Completion
candidates include the last modification date.

Note that completion here matches candidates as ordinary strings.  It
knows nothing of file names per se.  In particular, you cannot use
remote file-name syntax.

Remember that you can use `C-x .' to hide the common match portion of
each candidate.  That can be particularly helpful for files that are
in a common directory.

During completion (`*' means this requires library `Bookmark+'):

 *You can use `C-x a +' or `C-x a -' to add or remove tags from the
   current-candidate file.  You are prompted for the tags.
 *You can use `C-x m' to access file bookmarks (not just autofiles).
  You can use `C-c +' to create a new directory.
  You can use `M-|' to open Dired on currently matching file names.
  You can use `S-delete' to delete a candidate file or (empty) dir.

You can use any of the alternative-action keys, such as `C-S-RET', to
remove a candidate file from the recent files list, `recentf-list'.
\(The file itself is not deleted.)

These options, when non-nil, control candidate matching and filtering:

 `icicle-file-extras'           - Extra absolute file names to display
 `icicle-file-match-regexp'     - Regexp that file names must match
 `icicle-file-no-match-regexp'  - Regexp file names must not match
 `icicle-file-predicate'        - Predicate file names must satisfy
 `icicle-file-sort'             - Sort function for candidates

For example, to show only names of files larger than 5000 bytes, set
`icicle-file-predicate' to:

  (lambda (file) (and (numberp (nth 7 (file-attributes file)))
                      (> (nth 7 (file-attributes file)) 5000)))

Option `icicle-file-require-match-flag' can be used to override
option `icicle-require-match-flag'.

Option `icicle-files-ido-like' non-nil gives this command a more
Ido-like behavior."                     ; Doc string
  (lambda (f) (find-file (icicle-transform-multi-completion f) 'WILDCARDS)) ; Action function
  prompt icicle-abs-file-candidates nil ; `completing-read' args
  (and (fboundp 'confirm-nonexistent-file-or-buffer)  (confirm-nonexistent-file-or-buffer)) ;Emacs 23.
  nil 'file-name-history (car recentf-list) nil
  (icicle-file-bindings                 ; Bindings
   ((prompt                                 "Recent file (absolute): ")
    (icicle-full-cand-fn                `(lambda (file)
                                          (setq file  (if (file-directory-p file)
                                                          (file-name-as-directory file)
                                                        file))
                                          ,(if current-prefix-arg
                                               '(icicle-make-file+date-candidate file)
                                               '(list file))))
    (icicle-transform-before-sort-p         t)
    ;; (icicle-sort-comparer                   'icicle-last-accessed-first-p)
    ;; (icicle-sort-comparer                   'icicle-2nd-part-string-less-p)
    (icicle-sort-comparer                   'icicle-last-modified-first-p)
    (icicle-abs-file-candidates
     (progn (unless (boundp 'recentf-list) (require 'recentf))
            (when (fboundp 'recentf-mode) (recentf-mode 99))
            (unless (consp recentf-list)
              (error "No recently accessed files"))
            (mapcar (lambda (file)      ; FREE here: CURRENT-PREFIX-ARG.
                      (if current-prefix-arg (icicle-make-file+date-candidate file) (list file)))
                    recentf-list)))
    (icicle-candidate-alt-action-fn         'icicle-remove-from-recentf-candidate-action)
    (icicle-use-candidates-only-once-alt-p  t)
    (icicle-candidate-properties-alist      (and current-prefix-arg  '((1 (face icicle-candidate-part)))))
    (icicle-multi-completing-p              current-prefix-arg)
    (icicle-list-use-nth-parts              (and current-prefix-arg  '(1)))
    (icicle-all-candidates-list-alt-action-fn ; M-|'
     (lambda (files) (let ((enable-recursive-minibuffers  t))
                       (dired-other-window (cons (read-string "Dired buffer name: ")
                                                 (mapcar #'icicle-transform-multi-completion files))))))))
  (progn                                ; First code
    (when current-prefix-arg (put-text-property 0 1 'icicle-fancy-candidates t prompt))
    (icicle-highlight-lighter)
    (message "Gathering files...")
    (icicle-bind-file-candidate-keys))
  nil                                   ; Undo code
  (icicle-unbind-file-candidate-keys))  ; Last code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(icicle-define-command
   sw-to-dired-buffer                      ; Command name
   "Switch to Dired buffer"                ; Doc string
   switch-to-buffer                            ; Function to perform the action
   "Switch to Dired buffer: "                  ; Prompt
   (mapcar (lambda (buf) (list (buffer-name buf))) (buffer-list)) ; Completions
   (lambda (bufcons) (save-excursion      ; Predicate: Dired mode?
                       (set-buffer (car bufcons))
                       (or 
                          (equal major-mode 'dired-mode)
                          ;
                          ;; (equal major-mode 'sr-mode) ;don't know if I like it
                              
                          ;
                          )))
   t)                                     ; Existing buffers only

(define-key ctl-x-map "D" 'sw-to-dired-buffer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; does not work at all
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-open-dired-on-candidate ()
;;    "Open dired on a directory candidate in an icicles minibuffer"
;;   (interactive)
;;   (let (setq icicle-find-file-expand-directory nil)
;;     (icicle-find-file-or-expand-dir)))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;info+
(when load-info+
(eval-after-load "info" '(require 'info+)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;info mode not really info+ but related topically
(add-hook 'Info-mode-hook
   (lambda ()
   (define-key Info-mode-map (kbd "M-n") 'nil)
   (scroll-bar-mode 0)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (message "reached before load-elisp-format")
(message "reached before buf-menu")
(when  load-buf-menu
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/buf-menu/")
    (require 'buf-menu+))
    ;
  (message "--Error in load-buf-menu")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; should not have to do this here, emacs24.4 & 25 seem to be over-riding the
; custimization.
(setq icicle-default-value  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end of my-icicle-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-icicle-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



