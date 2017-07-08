;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; keep for interest, but don't want it now
;; ;Similar to browse-kill-ring access and yank text from the kill ring: 
;; ;http://emacswiki.org/emacs/BrowseKillRing
;; (global-set-key "\C-cy" '(lambda ()
;;                                  (interactive)
;;                                  (popup-menu 'yank-menu)))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;don't want the ido version
(put 'write-file 'ido 'ignore)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IDO parameters
(setq ido-enable-flex-matching t)
;this is for the icicles .emacs configutation
;hoping that buffer switching only works with Icicles
(setq ido-everywhere t)
(ido-everywhere 1)
;set in custom (setq ido-use-filename-at-point 'guess)
;set in custom (setq ido-create-new-buffer 'always)
(require 'ido)
(ido-mode 1)
;
;don't automatically switch dirs during ido-find-file, when the current
;file name input does not match any candidate.
;
;This is how to use ido-find-file to chonge dir, then create a new 
;buffer in that folder
;use ido-mode up until you get to the correct directory,
;then hit C-f again to get out of ido-mode as you type the new filename.
(setq ido-auto-merge-work-directories-length -1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;https://github.com/gempesaw/ido-vertical-mode.el/blob/master/ido-vertical-mode.el
;; Display ido results vertically, rather than horizontally
;
(if load-ido-vertical-mode
  (progn
    (add-to-list 'load-path "~/.emacs.d/ido-vertical-mode")
    (require 'ido-vertical-mode)
    (ido-mode 1)
    (ido-vertical-mode 1))
  (progn 
    (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))  
    (defun ido-disable-line-trucation () 
    (set (make-local-variable 'truncate-lines) nil))
    (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)
    ;set global option minibuffer-auto-raise to t instead
    ;; (show-frame (selected-frame))))  
    ))
;
 (setq ido-ignore-buffers '("\\` " "^\*Mess" "^\*Back" ".*Completion" 
"^\*Ido" "^\*trace" "^\*compilation" "^\*GTAGS" "^\*Help" "^session\.*" "^\*"))
;
;use IDO for more things
(setq recentf-max-saved-items 100)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun steve-ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (find-file (ido-completing-read "Open file: " recentf-list nil t)))
;
; (global-set-key [(meta f11)] 'steve-ido-choose-from-recentf)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/imenu/")
(autoload 'idomenu "idomenu" nil t)
(require 'imenu)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key
    "\M-x"
    (lambda ()
      (interactive)
      (call-interactively
       (intern
        (ido-completing-read
         "M-x "
         (all-completions "" obarray 'commandp))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Browse kill ring
;pulled source from:
;  https://github.com/todesschaf/browse-kill-ring/blob/master/browse-kill-ring.el
(add-to-list 'load-path "~/.emacs.d/browse-kill-ring/")
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
;
(add-to-list 'load-path "~/.emacs.d/browse_kill_ring_plus/")
(require 'browse-kill-ring+)
;
(put 'browse-kill-ring-mouse-insert 'delete-selection 'yank)
(put 'browse-kill-ring-insert       'delete-selection 'yank)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-unset-key (kbd "C-x m"))
(global-set-key (kbd "C-x f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x M-b") 'ido-switch-buffer-other-window)
(global-set-key (kbd "C-x i") 'idomenu)

;(global-set-key [f12] 'ido-write-file)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

           
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defvar ido-enable-replace-completing-read t
;;       "If t, use ido-completing-read instead of completing-read if possible.
;;     Set it to nil using let in around-advice for functions where the
;;     original completing-read is required.  For example, if a function
;;     foo absolutely must use the original completing-read, define some
;;     advice like this:
;;     (defadvice foo (around original-completing-read-only activate)
;;       (let (ido-enable-replace-completing-read) ad-do-it))")
;;     ;; Replace completing-read wherever possible, unless directed otherwise
;;     (defadvice completing-read
;;       (around use-ido-when-possible activate)
;;       (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
;;               (and (boundp 'ido-cur-list)
;;                    ido-cur-list)) ; Avoid infinite loop from ido calling this
;;           ad-do-it
;;         (let ((allcomp (all-completions "" collection predicate)))
;;           (if allcomp
;;               (setq ad-return-value
;;                     (ido-completing-read prompt
;;                                    allcomp
;;                                    nil require-match initial-input hist def))
;;             ad-do-it))))
;; ;
;; ;http://www.emacswiki.org/emacs/InteractivelyDoThings#InvokeBookmarks
;; ;I found ido-completing-read to interfere when using dired mode buffers 
;; ;(e.g., renaming files). 
;; ;To turn it off:
;;  (add-hook 'dired-mode-hook
;;                '(lambda () (setq ido-enable-replace-completing-read nil)))
;; ;mtf this works for the above issue, but it stops bookmark completion.
;; ;Instead use C-k to remove input in the ido minibuf.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ;; (setq ido-enable-replace-completing-read nil)
;; ;; ;; (setq ido-enable-replace-completing-read t)
;; (if t
;; (defun repeat-clr-insert-minib-ido () 
;;  "Erase what appears in the minibuffer and replace with 
;;  something more interesting"
;;  (interactive "^")
;;     (let ((n (seq-times 'repeat-clr-insert-minib-ido 8)))
;;       (cond
;;        ((= n 0)
;;        ;; (progn
;;        ;;   (ido-edit-input)
;;        ;;   (delete-minibuffer-contents)
;;        ;;   (insert "")))
;;        (progn 
;;            ;(exit-minibuffer)
;;          (setq ido-text-init "")
;;          ;; (let ((default-directory "C:/users/family"))
;;          (let ((default-directory my-insert-string-1))
;;          (call-interactively 'ido-find-file)) (ido-edit-input)))
;;             ;
;;             ;; ((= n 1) (delete-minibuffer-contents) (insert "~/.emacs.d/"))
;;             ;; ((= n 2) (delete-minibuffer-contents) (insert "c:/users/FAMILY/documents/"))
;;             ;; ((= n 3) (delete-minibuffer-contents) (insert "c:/users/FAMILY/documents/life/"))
;;             ;; ((= n 4) (delete-minibuffer-contents) (insert "c:/users/family/desktop/"))
;;             ;; (T (GOTO-CHAR SEQ-START-POINT))))))
;;        ;; ((= n 1) 
;;        ;;        (ido-exit-minibuffer) (let ((default-directory "c:/users/FAMILY/Appdata/Roaming"))
;;        ;;   (call-interactively 'ido-find-file)))

;;        ((= n 1)
;;          (progn
;;          (exit-minibuffer)
;;          (let ((default-directory "C:/users/family/documents/"))
;;          (call-interactively 'ido-find-file)) 
;;         ))

       
;;             ((= n 2) (delete-minibuffer-contents) (insert "c:/users/FAMILY/documents/life/"))
;;             ((= n 3) (delete-minibuffer-contents) (insert "c:/users/family/desktop/"))
;;             (T (GOTO-CHAR SEQ-START-POINT))))))
;; ;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; (setq ido-enable-replace-completing-read nil)
;; ;; (setq ido-enable-replace-completing-read t)

(defun tempdef () 
 "Erase what appears in the minibuffer and replace with 
 something more interesting, this version is used with ido"
 (interactive)
 (call-interactively 'ido-edit-input)
 (call-interactively 'beginning-of-line)
 (call-interactively 'delete-minibuffer-contents))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; (setq ido-enable-replace-completing-read nil)
;; ;; (setq ido-enable-replace-completing-read t)
(if t
(defun repeat-clr-insert-minib-ido () 
 "Erase what appears in the minibuffer and replace with 
 something more interesting, this version is used with ido"
 (interactive "^")
    (let ((n (seq-times 'repeat-clr-insert-minib-ido 8)))
      (cond
       ((= n 0)
       (progn 
         (call-interactively 'ido-edit-input) (call-interactively 'beginning-of-line) (call-interactively 'delete-minibuffer-contents)))
       ((= n 1)
        (progn
          (call-interactively 'delete-minibuffer-contents)
          (insert my-insert-string-1 )))
       ;
       ((= n 2)
        (progn
          (call-interactively 'delete-minibuffer-contents)
          (insert my-insert-string-2 )))
       ;
       ((= n 3)
        (progn
          (call-interactively 'delete-minibuffer-contents)
          (insert my-insert-string-3)))
       ;
       ((= n 4)
        (progn
          (call-interactively 'delete-minibuffer-contents)
          (insert my-insert-string-4)))
       ;
            (T (GOTO-CHAR SEQ-START-POINT))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq my-insert-string-1 "~/.emacs.d/")
  (setq my-insert-string-2 "c:/users/MFITZGERALD/documents/")
  (setq my-insert-string-3 "c:/users/MFITZGERALD/documents/life/")
  (setq my-insert-string-4 "c:/users/mfitzgerald/desktop/")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (eq home-work 'home)
  (progn
    (setq list-to-start-from 
    (list "~/.emacs.d/"
          "c:/users/FAMILY/documents/"
          "c:/users/FAMILY/documents/life/"
          "c:/users/family/desktop/")))
  (progn
    (setq list-to-start-from 
    (list "~/.emacs.d/"
          "c:/users/mfitzgerald/documents/"
          "c:/users/mfitzgerald/documents/life/"
          "c:/users/mfitzgerald/desktop/"
          "m:/VHDL/fpga_designs/mfitzgerald/my_working_copies/surecom/fpgas/ptst_fpga/ptss_fpga/trunk/"          
          "m:/VHDL/fpga_designs/mfitzgerald/my_working_copies/surecom/fpgas/ptst_fpga/ptss_fpga/branches/mike/proteus0_eq_r12950/"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-ido-find-file (arg)
  (interactive "p")
  (setq tempvar1 arg)
  (if (not (equal arg  1))
         (progn
         (message "eq 1")
         (choose-dir-to-start-find-file-from))
         (ido-find-file)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(defun choose-dir-to-start-ido-find-file-from ()
  "Pre select a dir to start a find-file experience from"
  (interactive)
  (setq default-directory
    (ido-completing-read "Choose a path: " list-to-start-from))
  (ido-find-file))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mytest ()
  (interactive)
  ;(call-interactively 'ido-edit-input)
  (select-window (active-minibuffer-window))
  (call-interactively 'delete-minibuffer-contents)
  (insert "C:/users/family/" ))
;
(defun mytest ()
  (interactive)
  (message "Reached Before")
  (message "Before frame: %s" (get-frame-name))
  (message "After frame: %s" (get-frame-name))
  (ido-edit-input)
  (message "Reached after 1")
  (delete-minibuffer-contents)
  (message "Reached after 1.5")
  (insert "C:/users/family/" )
  (message "Reached Afte 2"))
;  
;; (defun ido-edit-input ()
;;   "Edit absolute file name entered so far with Ido; terminate by RET.
;; If cursor is not at the end of the user input,fam move to end of input."
;;   (interactive)
;;   (if (not (eobp))
;;       (end-of-line)
;;     (setq ido-text-init (if ido-matches (ido-name (car ido-matches)) ido-text))
;;     (setq ido-exit 'edit)
;;     (exit-minibuffer)))
;
;       
;(global-set-key [f10] 'mytest)
;
;(global-set-key [f11] 'delete-minibuffer-contents)
;(global-set-key [f12] (lambda () (interactive) (insert "C:/users/family")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-ido-ubiquitous t)
  (add-to-list 'load-path "~/.emacs.d/ido-ubiquitous/")
  (require 'ido-ubiquitous)
  (ido-ubiquitous 1))
;
;put this in the ido keymap
;(global-set-key [f12] 'repeat-clr-insert-minib-ido)
;; (define-key ido-file-completion-map "\M-t" 'repeat-clr-insert-minib-define)
;
;
;
;( ido-init-completion-maps [f12] 'repeat-clr-insert-minib-ido)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this should be in the custom file, however the custom file is giving
; me trouble now
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'ido-setup-hook 'ido-my-keys)
;
(defun ido-my-keys ()
  "Add my keybindings for ido."                     ;repeat-clr-insert-minib-ido
  (define-key ido-common-completion-map (kbd "M-t") 'repeat-clr-insert-minib-ido))
  ;(define-key ido-file-completion-map   (kbd "M-t") 'repeat-clr-insert-minib-ido))
  ;(define-key ido-completion-map (kbd "M-t") 'repeat-clr-insert-minib-ido)
  ;(define-key ido-file-completion-map  (kbd "M-t") 'repeat-clr-insert-minib-ido))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; do this to accomodate ido-vertical
(setq fit-frame-max-height-percent 75)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end of my-ido-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-ido-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
