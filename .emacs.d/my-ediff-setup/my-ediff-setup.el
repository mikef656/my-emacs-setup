;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;defuns in this file:
;
;  MTF author
;    my-name-new-buffer 
;    my-show-repo-head 
;    my-ediff-cur-buf-against-repo-head 
;    my-get-buffer-repo-head 
;
;  ediff-diff-to-diff 
;  ediff-copy-D-to-C 
;  ediff-copy-diff 
;  add-d-to-ediff-mode-map 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar REPO_INDICATION_STRING ".~REPO-HEAD~" 
  "string used to mark the buffer as associated with the repositery head")

(defvar EDIFF-RESTORE-ORIG-WIN-CONFIG t
  "Run a hook that attemps to restore the original window config after
   ediff exits")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;https://groups.google.com/
;                 forum/?fromgroups#!topic/gnu.emacs.help/hZ8vbjz9UMQ%5B1-25%5D
(setq-default ediff-ignore-similar-regions t);ignore whitespace
;
;tried this to stop highlighting of whitespace, did not work
;(setq ediff-diff-options "-w")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://www.emacswiki.org/emacs/EdiffMode
;this will restore the original window config after ediff exits.
;Does not seem interfere with the ediff run in Sunrise commander.
;
(when EDIFF-RESTORE-ORIG-WIN-CONFIG
  (add-hook 'ediff-load-hook
    (lambda ()
    ;
    (add-hook 'ediff-before-setup-hook
      (lambda ()
        (setq ediff-saved-window-configuration (current-window-configuration))))
    ;             
    (let ((restore-window-configuration
           (lambda ()
             (set-window-configuration ediff-saved-window-configuration))))
             ;mtf added this line to what was on the net seems to work
             ;for the purpose of having a nice trim window/frame
             ;(fit-frame))))
      (add-hook 'ediff-quit-hook restore-window-configuration 'append)
      (add-hook 'ediff-suspend-hook restore-window-configuration 'append)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;did not work against repo, just against wc base
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;http://stackoverflow.com/
;; ;questions/3712834/getting-vc-diff-to-use-ediff-in-emacs-23-2
;; (defun ediff-current-buffer-revision ()
;;   "Run Ediff to diff current buffer's file against VC depot.
;; Uses `vc.el' or `rcs.el' depending on `ediff-version-control-package'."
;;   (interactive)
;;   (require 'ediff);mtf added this one based on a follow up comment on SO
;;   (let ((file (or (buffer-file-name)
;;           (error "Current buffer is not visiting a file"))))
;; (if (and (buffer-modified-p)
;;      (y-or-n-p (message "Buffer %s is modified. Save buffer? "
;;                 (buffer-name))))
;;     (save-buffer (current-buffer)))
;; (ediff-load-version-control)
;; (funcall
;;  (intern (format "ediff-%S-internal" ediff-version-control-package))
;;  "" "" nil)))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;www.opensource.apple.com/source/emacs/emacs-51/emacs/lisp/ediff-vers.el
;; (defun ediff-vc-internal (rev1 rev2 &optional startup-hooks)
;; ;; Run Ediff on versions of the current buffer.
;; ;; If REV2 is "" then compare current buffer with REV1.
;; ;; If the current buffer is named `F', the version is named `F.~REV~'.
;; ;; If `F.~REV~' already exists, it is used instead of being re-created.
;;   (let (file1 file2 rev1buf rev2buf)
;;     (save-window-excursion
;;       (save-excursion
;; 	(vc-version-other-window rev1)
;; 	(setq rev1buf (current-buffer)
;; 	      file1 (buffer-file-name)))
;;       (save-excursion
;; 	(or (string= rev2 "") 		; use current buffer
;; 	    (vc-version-other-window rev2))
;; 	(setq rev2buf (current-buffer)
;; 	      file2 (buffer-file-name)))
;;       (setq startup-hooks
;; 	    (cons `(lambda ()
;; 		     (delete-file ,file1)
;; 		     (or ,(string= rev2 "") (delete-file ,file2)))
;; 		  startup-hooks)))
;;     (ediff-buffers
;;      rev1buf rev2buf
;;      startup-hooks
;;      'ediff-revision)))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-name-new-buffer (buffer-arg)
  "Form a good name for the new buffer
   take a buffer name as a string for arg, return a new buffer name"
  (interactive)
  (concat buffer-arg REPO_INDICATION_STRING))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-show-repo-head ()
  "Display the corresponding repo head of the current buffer
  Run svn cat on the current buffer, this gets the lateest from the repo, 
  create a new buffer with it then swtitch to that buffer"
  (interactive)
  (let 
      ((fake_data nil)
      (string-to-place-in-created-buffer nil)
      (orig-buffer-position nil)
      (orig-file-name-split-list nil)
      (orig-file-name-base nil)
      (orig-file-name-ext nil)
      (created-buffer-name nil)
        );fake data allows testing wo the shell command
  ;
  (if fake_data
    (setq string-to-place-in-created-buffer "  some stuff \n  some more stuff")
    ;
    ;run shell command get it's output as a string
    (progn
      (setq string-to-place-in-created-buffer 
        (substring 
          (shell-command-to-string 
            (format "svn cat %s" (buffer-file-name))) 0 -1))))
    ;
    (setq orig-buffer-position (point))
    ;
    ;Form a good name for the new buffer
    (setq created-buffer-name (my-name-new-buffer (buffer-name)))
    ;
    ;create a new buffer
    (generate-new-buffer created-buffer-name)
    (set-buffer created-buffer-name)
    ;
    ;put some text in the new buffer
    (insert string-to-place-in-created-buffer)
    ;
    ;switch to the new buffer
    (write-file created-buffer-name)
    (switch-to-buffer created-buffer-name)
    ;
    ;try to put the cursor in the ball park
    (when (< orig-buffer-position  (point-max))
      (goto-char orig-buffer-position))
    ;
    ;wresteling with emacs to get it to set the mode 
    ;this is sort of a forced way, could probably write something better
    ;using the auto-mode-alist
    (when (s-matches? "^\\.emacs" (buffer-name))
      (emacs-lisp-mode))
    (when (s-matches? "^\\.bashrc" (buffer-name))
      (sh-mode))
    ;
    ;don't want a file
    (delete-file created-buffer-name)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;scratch
;dot anythig dot
(s-matches? "\\..*\\." ".emacs-custom-work.el")
;
;dot at beginning
(s-matches? "^\\..*\\." ".emacs-custom-work.el")
;
;; (car (last (list 'a 'b 'c)))
;; (-last-item '(1 2 3))
;; (-last-item (split-string "aoeu.htns.1234" "\\."))
;
;return a symbol
;(intern "aoeu")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-ediff-cur-buf-against-repo-head ()
  "Do what it says"
  (interactive)
  (ediff-buffers (current-buffer) (my-get-buffer-repo-head) nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-get-buffer-repo-head ()
  "Return a buffer corresponding repo head of the current buffer.
  Run svn cat on the current buffer, this gets the lateest from the repo, 
  create a new buffer with it."
  (interactive)
  (let 
      ((fake_data nil)
      (string-to-place-in-created-buffer nil)
      (orig-buffer-position nil)
      (orig-file-name-split-list nil)
      (orig-file-name-base nil)
      (orig-file-name-ext nil)
      (created-buffer-name nil)
        );fake data allows testing wo the shell command
  ;
  (if fake_data
    (setq string-to-place-in-created-buffer "  some stuff \n  some more stuff")
    ;
    ;run shell command get it's output as a string
    (progn
      (setq string-to-place-in-created-buffer 
        (substring 
          (shell-command-to-string 
            (format "svn cat %s" (buffer-file-name))) 0 -1))))
    ;
    (setq orig-buffer-position (point))
    ;
    ;Form a good name for the new buffer
    (setq created-buffer-name (my-name-new-buffer (buffer-name)))
    ;
    ;create a new buffer
    (generate-new-buffer created-buffer-name)
    (set-buffer created-buffer-name)
    ;
    ;put some text in the new buffer
    (insert string-to-place-in-created-buffer)
    ;
    (write-file created-buffer-name)
    ;wresteling with emacs to get it to set the mode 
    ;this is sort of a forced way
    (when (s-matches? "^\\.emacs" (buffer-name))
      (emacs-lisp-mode))
    (when (s-matches? "^\\.bashrc" (buffer-name))
      (sh-mode))
    ;
    (delete-file created-buffer-name)
    ;
    ;return the new buffer
    (get-buffer (current-buffer))
    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://stackoverflow.com/questions/9656311/
;;  conflict-resolution-with-emacs-ediff-
;;        how-can-i-take-the-changes-of-both-version
;
;; Yes, I totally want to do this! With the following chunk of code you can get
;; both by typing d - which will get the code from both buffer A and buffer B
;; (in that order) in the merge buffer.
;
;; The only real difficulty in this code is the fact that ediff uses a macro
;; in one ;; place, and the compiled version of the function needs to be
;; re-evaluated with ;; the new macro. Anyway, try the code out.
;; Tested with Emacs 23.2.;
;; http://stackoverflow.com/questions/9656311/
;; conflict-resolution-with-emacs-ediff-how-can-
;;   i-take-the-changes-of-both-version
;
(when  load-ediff-experiment 
   (require 'ediff-init)     ;ensure the macro is defined, so we can override it
                                        ;
   (defmacro ediff-char-to-buftype (arg)
     `(cond ((memq ,arg '(?a ?A)) 'A)
        ((memq ,arg '(?b ?B)) 'B)
        ((memq ,arg '(?c ?C)) 'C)
        ((memq ,arg '(?d ?D)) 'D)
        ))
   (require 'ediff)
   ;; Literally copied from ediff-util
   ;; need to re-evaluate because it uses the macro defined above
   ;; and the compiled version needs to be re-compiled with the new definition
   ;; why a macro????
   (defun ediff-diff-to-diff (arg &optional keys)
     "Copy buffer-X'th difference region to buffer Y \(X,Y are A, B, or C\).
   If numerical prefix argument, copy the difference specified in the arg.
   Otherwise, copy the difference given by `ediff-current-difference'.
   This command assumes it is bound to a 2-character key sequence, `ab', `ba',
   `ac', etc., which is used to determine the types of buffers to be used for
   copying difference regions.  The first character in the sequence specifies
   the source buffer and the second specifies the target.
   ;
   If the second optional argument, a 2-character string, is given, use it to
   determine the source and the target buffers instead of the command keys."
     (interactive "P")
     (ediff-barf-if-not-control-buffer)
     (or keys (setq keys (this-command-keys)))
     (if (eq arg '-) (setq arg -1)) ; translate neg arg to -1
     (if (numberp arg) (ediff-jump-to-difference arg))
     ;
     (let* ((key1 (aref keys 0))
        (key2 (aref keys 1))
        (char1 (ediff-event-key key1))
        (char2 (ediff-event-key key2))
        ediff-verbose-p)
   (ediff-copy-diff ediff-current-difference
            (ediff-char-to-buftype char1)
            (ediff-char-to-buftype char2))
   ;; recenter with rehighlighting, but no messages
   (ediff-recenter)))
   ;
   (defun ediff-copy-D-to-C (arg)
     "Copy ARGth difference region from both buffers A and B to C.
   ARG is a prefix argument.  If nil, copy the current difference region."
     (interactive "P")
     (ediff-diff-to-diff arg "dc"))
   ;
   (defun ediff-copy-diff (n from-buf-type to-buf-type
                 &optional batch-invocation reg-to-copy)
     (let* ((to-buf (ediff-get-buffer to-buf-type))
        ;;(from-buf (if (not reg-to-copy) (ediff-get-buffer from-buf-type)))
        (ctrl-buf ediff-control-buffer)
        (saved-p t)
        (three-way ediff-3way-job)
        messg
        ediff-verbose-p
        reg-to-delete reg-to-delete-beg reg-to-delete-end)
   ;
   (setq reg-to-delete-beg
         (ediff-get-diff-posn to-buf-type 'beg n ctrl-buf))
   (setq reg-to-delete-end
         (ediff-get-diff-posn to-buf-type 'end n ctrl-buf))
   ;
   (if (eq from-buf-type 'D)
       ;; want to copy *both* A and B
       (if reg-to-copy
       (setq from-buf-type nil)
         (setq reg-to-copy (concat (ediff-get-region-contents n 'A ctrl-buf)
                   (ediff-get-region-contents n 'B ctrl-buf))))
     ;; regular code
     (if reg-to-copy
         (setq from-buf-type nil)
       (setq reg-to-copy (ediff-get-region-contents n from-buf-type ctrl-buf))))
   ;
   (setq reg-to-delete (ediff-get-region-contents
                n to-buf-type ctrl-buf
                reg-to-delete-beg reg-to-delete-end))
   ;
   (if (string= reg-to-delete reg-to-copy)
       (setq saved-p nil) ; don't copy identical buffers
     ;; seems ok to copy
     (if (or batch-invocation (ediff-test-save-region n to-buf-type))
         (condition-case conds
         (progn
           (ediff-with-current-buffer to-buf
             ;; to prevent flags from interfering if buffer is writable
             (let ((inhibit-read-only (null buffer-read-only)))
               ;
           (goto-char reg-to-delete-end)
           (insert reg-to-copy)
           ;
           (if (> reg-to-delete-end reg-to-delete-beg)
               (kill-region reg-to-delete-beg reg-to-delete-end))
           ))
           (or batch-invocation
           (setq
            messg
            (ediff-save-diff-region n to-buf-type reg-to-delete))))
       (error (message "ediff-copy-diff: %s %s"
               (car conds)
               (mapconcat 'prin1-to-string (cdr conds) " "))
              (beep 1)
              (sit-for 2) ; let the user see the error msg
              (setq saved-p nil)
              )))
     )
   ;
   ;; adjust state of difference in case 3-way and diff was copied ok
   (if (and saved-p three-way)
       (ediff-set-state-of-diff-in-all-buffers n ctrl-buf))
   ;
   (if batch-invocation
       (ediff-clear-fine-differences n)
     ;; If diff3 job, we should recompute fine diffs so we clear them
     ;; before reinserting flags (and thus before ediff-recenter).
     (if (and saved-p three-way)
         (ediff-clear-fine-differences n))
     ;
     (ediff-refresh-mode-lines)
     ;
     ;; For diff2 jobs, don't recompute fine diffs, since we know there
     ;; aren't any.  So we clear diffs after ediff-recenter.
     (if (and saved-p (not three-way))
         (ediff-clear-fine-differences n))
     ;; Make sure that the message about saving and how to restore is seen
     ;; by the user
     (message "%s" messg))
   ))
   ;
   ;; add keybinding in a hook b/c the keymap isn't defined bf the hook is run
   (add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)
   ;
   (defun add-d-to-ediff-mode-map ()
     (define-key ediff-mode-map "d" 'ediff-copy-D-to-C))
   )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end of my-ediff-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-ediff-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
