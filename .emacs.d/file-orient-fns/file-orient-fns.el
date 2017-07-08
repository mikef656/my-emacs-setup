;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;  FUNCTIONS HERE
;; show-file-name-general ()
;; convert-cw-path-to-win (arg)
;; show-file-name-from-shell-modes ()
;; clean-up-dired-cap-first-line ()
;; clean-up-dired-cap-first-line-xsteve ()
;; get-first-line-of-dired-buf (&optional no-message)
;; get-first-line-of-dired-buf-flip ()
;; edit-dot-emacs ()
;; edit-cheat-dot-org ()
;; gimme-a-dir (blah)
;; buffers-visiting-2-fileset (my-fileset-name)
;; my-filesets-add-buffer (&optional name buffer)
;; uniquify-all-lines-region (start end)
;; uniquify-all-lines-buffer ()
;; copy-rectangle-to-clipboard (p1 p2)
;; my-open-tortise ()
;; my-open-console ()
;; my-open-cygwin ()
;; my-open-win-explorer()
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;07.03.2000
(defun xsteve-exchange-slash-and-backslash ()
  "Exchanges / with \ and in the current line or in the region 
   when a region-mark is active."
  (interactive)
  (save-match-data
    (save-excursion
      (let ((replace-count 0)
            (eol-pos (if mark-active (region-end) (progn (end-of-line) (point))))
            (bol-pos (if mark-active (region-beginning) (progn (beginning-of-line) (point)))))
        (goto-char bol-pos)
        (while (re-search-forward "/\\|\\\\" eol-pos t)
          (setq replace-count (+ replace-count 1))
          (cond ((string-equal (match-string 0) "/") (replace-match "\\\\" nil nil))
                ((string-equal (match-string 0) "\\") (replace-match "/" nil nil)))
          (message (format "%d changes made." replace-count)))))))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;07.03.2000
(defun xsteve-exchange-slash-and-backslash-4-minibuf ()
  "Exchanges / with \ and in the current line or in the region 
   when a region-mark is active."
  (interactive)
  (save-match-data
    (save-excursion
      (let ((replace-count 0)
            (eol-pos (if mark-active (region-end) (progn (end-of-line) (point))))
            (bol-pos (if mark-active (region-beginning) (progn (beginning-of-line) (point)))))
        (goto-char bol-pos)
        (while (re-search-forward "/\\|\\\\" eol-pos t)
          (setq replace-count (+ replace-count 1))
          (cond ((string-equal (match-string 0) "/") (replace-match "\\\\" nil nil))
                ((string-equal (match-string 0) "\\") (replace-match "/" nil nil)))
          )))))
          ;(message (format "%d changes made." replace-count)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;http://stackoverflow.com/questions/
; 3669511/the-function-to-show-current-files-full-path-in-mini-buffer
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun show-file-name-general-sr () 
"When visting a file show the full path file name in the minibuffer
save to kill ring. In sunrise do the same 4 the file or dir pointed to"
  (interactive "^")
  (let ((n (seq-times 'show-file-name-general-sr 8)))
    (cond
    ((= n 0)
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (progn
        (message (dired-copy-filename-as-kill))))
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;
    ((= n 1)
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (progn
        (message (dired-copy-filename-as-kill 0))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ((= n 2)
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (progn
        (kill-new (message
           (with-temp-buffer
             ;insert last kill which is the cmplete file name-path
             (insert (car kill-ring-yank-pointer))
             (mark-whole-buffer)
             (xsteve-exchange-slash-and-backslash)
             (mark-whole-buffer)
             (buffer-string))))));Rtn  contents of the current buffer as str
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ((= n 3)
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       (progn
       ;check for dired mode and sr-mode then do this, othrewise (buffer-file-name)
         (if  (or (equal major-mode 'dired-mode) (equal major-mode 'sr-mode))
          ;T
          (progn 
            (if (eq (dired-get-filename 'no-dir t)  nil)
              (setq this-buffer-name (get-first-line-of-dired-buf t))
              (setq this-buffer-name (dired-get-filename))))
          ;F
          (setq this-buffer-name (buffer-file-name)))
          (kill-new (message
            (with-temp-buffer
              (insert 
                (shell-command-to-string 
                  (format "svn info %s |gawk '/^URL: / { print $2 }'" this-buffer-name)))
                    (mark-whole-buffer)
                      (buffer-string)))))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun show-file-name-general ()
  "Show file info re the file visited or pointed to in direr
    1st press gives the filname/wo a path
    2nd press gives the filname/w a path (Nix style slashes)
    3rd press gives the filname/w a path (Windows style slashes)
    4th press gives the url"
   (interactive "^")
   ;
   ;handle the case where show-file-name-general was run from the minibuffer
   (when (string-equal (buffer-name) " *Minibuf-0*") 
     (other-window-or-frame 1))
   ;
   (let ((n (seq-times 'show-file-name-general 8)))
     (cond
     ((= n 0)
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (progn
        (if (string= major-mode "dired-mode") 
           ;dired
           (if (eq (dired-get-filename 'no-dir t)  nil)
              ;T -> nil not on a filename
              (get-first-line-of-dired-buf)
              ;
              ;F -> on a filename
              (kill-new (message  (dired-get-filename 'no-dir t))))  
        ;not dired mode
        (kill-new (message  (buffer-name)))
        )))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;
      ((= n 1)
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (progn
         (if (string= major-mode "dired-mode") 
            ;dired
            (if (eq (dired-get-filename nil t)  nil)
               ;T -> nil not on a filename
               (get-first-line-of-dired-buf-flip)
               ;
               ;F -> on a filename        
               (kill-new (message  (dired-get-filename nil t))))
         ;not dired mode
         (show-file-name))))
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ((= n 2)
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (progn
            (kill-new (message
               (with-temp-buffer
                  ;insert last kill which is the cmplete file name-path
                  (insert (car kill-ring-yank-pointer))
                  (mark-whole-buffer)
                  (xsteve-exchange-slash-and-backslash)
                  (mark-whole-buffer)
                  (buffer-string))))))  
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ((= n 3)
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (progn
           (setq this-buffer-name (buffer-file-name))
            (kill-new (message
               (with-temp-buffer
                 ;
                 (insert 
                  (shell-command-to-string 
                   (format "svn info %s | gawk '/^URL: / { print $2 }'"  this-buffer-name)))
                  (mark-whole-buffer)
                  (buffer-string))))))  
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;experiments
;; /cygdrive/c/Users/family/AppData/Roaming/.emacs.d

;; (s-match "\(cygdrive\)\(.*\)" "/cygdrive/c/Users/family/AppData/Roaming/.emacs.d")

;; (s-match "^/.*/\\([a-z]+\\)\\.\\([a-z]+\\)" "/some/weird/file.html")

;; (message (replace-regexp-in-string "/cygdrive/" "" "/cygdrive/c/Users/family/AppData/Roaming/.emacs.d"))

;; (message (replace-regexp-in-string "\(c/\)\(.*\)" \1 "c/Users/family/AppData/Roaming/.emacs.d")

;; (replace-regexp-in-string "\(bob\)" "\\\\\1" "bob mike")

;;  (setq temp_return (with-temp-buffer
;;    (insert "c/Users/family/AppData/Roaming/.emacs.d")
;;    (goto-char (point-min))
;;    (while (re-search-forward "^\\([a-z]\\)" nil t)
;;      (replace-match (concat (match-string 1) ":" )))
;;    (buffer-string)))
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun convert-cw-path-to-win (arg)
  "convert a path that looks like this
    /cygdrive/c/Users/family/AppData/Roaming/.emacs.d
  to a path that looks like this:
    c:/Users/family/AppData/Roaming/.emacs.d
   Pass it the cygwin style this def returns the win style
   If for some reason the path is not a cygwin style path then
   return what was passed"
  (interactive)
  (setq temp_return (with-temp-buffer
     ;; (insert "/cygdrive/d/Users/family/AppData/Roaming/.emacs.d")
     (insert arg)
     (goto-char (point-min))
     ;
     ;don't need the while loop??
     ;; (while (re-search-forward "^\\(/cygdrive/\\)\\([a-z]\\)" nil t)
     (if (re-search-forward "^\\(/cygdrive/\\)\\([a-z]\\)" nil t )
       (progn
         (replace-match (concat (match-string 2) ":" ))
         (buffer-string))
      ;(message "not a cygwin path"))
      (buffer-string))
     )))
;
;test it out!
;(convert-cw-path-to-win "/cygdrive/c/Users/family/AppData/Roaming/.emacs.d")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun show-file-name-from-shell-modes ()
  "Show file info re the file visited or pointed to in direr
    1st press gives the filname/wo a path
    2nd press gives the filname/w a path (Nix style slashes)
    3rd press gives the filname/w a path (Windows style slashes)
    4th press gives the url"
   (interactive "^")
   (let ((n (seq-times 'show-file-name-from-shell-modes 8)))
     (cond
     ((= n 0)
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (progn
        (if (or (string= major-mode "shell-mode") (string= major-mode "eshell-mode"))
          ;T is the mode
          (kill-new 
            (message  
              (convert-cw-path-to-win 
                (shell-command-to-string "pwd"))))  
          ;not the mode
          (kill-new (message  (buffer-name))))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ((= n 1)
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (progn
            (kill-new (message
               (with-temp-buffer
                  ;insert last kill which is the cmplete file name-path
                  (insert (car kill-ring-yank-pointer))
                  (mark-whole-buffer)
                  (xsteve-exchange-slash-and-backslash)
                  (mark-whole-buffer)
                  (buffer-string))))));matcheds outside of n 2  
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ((= n 2)
         (progn
            (kill-new (message
               (with-temp-buffer
                 ;
                 (insert (shell-command-to-string "svn info | gawk '/^URL: / { print $2 }'"))
                  (mark-whole-buffer)
                  (buffer-string))))))  
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
           (t (goto-char seq-start-point)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;for test only
;(global-set-key [f12] 'show-file-name-from-shell-modes )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clean-up-dired-cap-first-line ()
  "Copy the first line of a dired buffer to the kill ring, clean"
  (interactive)
  (setq mystrNew
     (with-temp-buffer
        (insert (car kill-ring-yank-pointer))
        ;
        (end-of-buffer)
        (re-search-backward ":" nil t)
        (replace-match "")
        ;
        (beginning-of-buffer)
        (re-search-forward "\n" nil t)
        (replace-match "")
        ;
        (beginning-of-buffer)
        (re-search-forward "^[ ]+" nil t)
        (replace-match "")
        ;
        (end-of-buffer)
        (insert "/")
        ;Return the contents of the current buffer as a string.
        (buffer-string))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clean-up-dired-cap-first-line-xsteve ()
  "Copy the first line of a dired buffer to the kill ring, clean, exchange \ /"
  (interactive)
  (setq mystrNew
     (with-temp-buffer
        (insert (car kill-ring-yank-pointer))
        ;
        (end-of-buffer)
        (re-search-backward ":" nil t)
        (replace-match "")
        ;
        (beginning-of-buffer)
        (re-search-forward "\n" nil t)
        (replace-match "")
        ;
        (beginning-of-buffer)
        (re-search-forward "^[ ]+" nil t)
        (replace-match "")
        ;
        (end-of-buffer)
        (insert "/")
        ;
        (xsteve-exchange-slash-and-backslash)
        ;Return the contents of the current buffer as a string.
        (buffer-string))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-first-line-of-dired-buf (&optional no-message)
  "Used by clean-up-dired-cap-first-line"
  (interactive)
  (beginning-of-buffer)                 
  (forward-word)                 
  (dired-details-toggle)
  (thing-copy-line)
  (dired-details-toggle)
  (clean-up-dired-cap-first-line)
  (unless no-message
    (message mystrNew))
  (kill-new mystrNew))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-first-line-of-dired-buf-flip ()
  "Used by clean-up-dired-cap-first-line-xsteve"
  (interactive)
  (beginning-of-buffer)                 
  (forward-word)                 
  (dired-details-toggle)
  (thing-copy-line)
  (dired-details-toggle)
  (clean-up-dired-cap-first-line-xsteve)
  (message mystrNew)
  (kill-new mystrNew))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Edit .emacs 
; code copied from XEmacs's Options\Edit Init File menu code
(defun edit-dot-emacs ()
  "Edits the user's .emacs file"
  (interactive)
  (progn
    (find-file (or user-init-file "~/.xemacs/custom.el"))
    (or (eq major-mode (quote emacs-lisp-mode)) (emacs-lisp-mode))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Edit cheat.org 
(defun edit-cheat-dot-org ()
  "Do what it says"
  (interactive)
  ;; (find-file  "~/cheat.org"))
  (find-file  "~/cheat.org"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq my-buffer-list (buffer-list))
;; (setq animals '(gazelle giraffe lion tiger))
;; ;
;; (defun get-buffers-visiting (list)
;;    "Using dolist, create a list of buffers currently visiting files."
;;    (interactive)
;;    (let (value)  ; make sure list starts empty
;;      ;
;;      ;-the CAR (first element)
;;      ;of each shorter version of the list is referred to using the symbol `element'
;;      ;-the list itself is called `list'
;;      ;-the value returned is called `value
;;      (dolist (element list value)
;;      ;`dolist' expression binds the CAR of each shorter version of the 
;;      ;list to `element'
;;        ;
;;        (if (not (string=(buffer-file-name element) nil) )
;;           ;
;;           ;cons appends element onto value
;; 	  ;newlist is value & old
;; 	   (my-filesets-add-buffer "blah-other-5" element  )
;;           (setq value (cons element value))
;;        )
;;      ) 
;;    )
;; )
;; ;
;; ;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;general example of how to read from the minibuffer using a defun
;see 
;   http://xahlee.org/emacs/elisp_idioms.html
;for more on 
; Prompting User for Input\Get User Input as Arguments
; including y or n and multiple args
;
(defun gimme-a-dir (blah)
  "Asking for it."
  (interactive "sWhere to? ")
  (message "You can go here: %s" blah))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun buffers-visiting-2-fileset (my-fileset-name)
   "Create a filset for buffers visiting files, 
   prompt each buffer, prompt fileset name."
   (interactive "sEnter Fileset Name ")
   (let (value)  ; make sure list starts empty
     ;
     (setq list (buffer-list) ) ;list of open buffers
     (dolist (element list value)
     ;`dolist' 
     ;1)Loops 1x for each element in the list
     ;2)Shortens the list each time it loops it `cdrs down the list'
     ;3)Binds CAR (first element) of each shorter version of the list to `element'
     ;4)After looping complete, return value (optional)
     ;
     ;EXAMPLE:(DOLIST (x '(1 2 3)) (insert (number-to-string x))) 
     ;returns 123
     ;note its missing the 3rd if
     ;
       (if (not (string=(buffer-file-name element) nil)  )        
          (progn
             (if (y-or-n-p (concat "Add: " (buffer-file-name element) " to filset " ))
                (progn
                   (message "adding to fileset")
                   ;(my-filesets-add-buffer my-fileset-name (buffer-file-name element)  )
                   (filesets-add-buffer my-fileset-name  element  )
                   ;
                   ;messages get temporaly bunched up, the wait helps
                   (sit-for 1)
                )
                (progn
                   (message "not adding to fileset")
                )
             )
          )
          ;             cons appends element onto value -> newlist is value & old
          ;(setq value (cons element value))
       )
     ) 
     ;now save the fileset, update the .emacs
     ;custom needs to get notified a change has been made
     (put 'filesets-data 'customized-value (list (custom-quote (eval 'filesets-data))))
     ;
     ;this opens the custom buffer bc the set and save fn's want it to be open
     (customize-variable 'filesets-data)
     ;
     (Custom-set)
     (Custom-save)
     ;don't want to see it
     (kill-buffer)
   )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
;
;(setq temp-buffers-visiting  (get-buffers-visiting (buffer-list) ) )
;; ;; (filesets-save-config)
;; ;; (customize-save-customized)
;
;; ;(icicle-bookmark-a-file (buffer-file-name ))
;
;; ;(eval filesets-data)
;
;
;; ;(icicle-add-file-to-fileset  nil scancntl )
;; ;(icicle-add-file-to-fileset &optional FILE NAME)
;
;; ;(car my-buffer-list )
;
;; (global-set-key [(shift f12)]
;;   '(lambda ()
;;    (interactive) 
;;    (progn
;;       ;(my-filesets-add-buffer "blah-other-5" (car temp-buffers-visiting )  )     
;;       (my-filesets-add-buffer "blah-other-5" (buffer-file-name )  )     
;;       ;(buffer-file-name ) returns the string
;;       ;  "c:/Users/family/AppData/Roaming/.emacs.d/file-orient-fns/file-orient-fns.el"
;;       (put 'filesets-data 'customized-value (list (custom-quote (eval 'filesets-data))))
;;       (customize-variable 'filesets-data)
;;       (Custom-set)
;;       (Custom-save)
;;       (kill-buffer)
;;    )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-filesets-add-buffer (&optional name buffer)
  "Add BUFFER (or current buffer) to the fileset called NAME.
yUser will be queried, if no fileset name is provided."
  (interactive)
  (let* ((buffer (or buffer
		     (current-buffer)))
	 (name (or name
		     (completing-read
		      (format "Add '%s' to fileset: " buffer)
		      filesets-data nil)))
         (entry  (or (assoc name filesets-data)
                     (when (y-or-n-p
                            (format "Fileset %s does not exist. Create it? "
                                    name))
                       (progn
      (add-to-list 'filesets-data (list name '(:files)))
      (message
       "Fileset %s created.  Call `M-x filesets-save-config' to save."
       name)
      (car filesets-data))))))
    (if entry
	(let* ((files  (filesets-entry-get-files entry))
	       ;
	       (this    buffer)
	       ;mtf (this   (buffer-file-name buffer))
	       ;
	       (inlist (filesets-member this files
					:test 'filesets-files-equalp)))
	  (cond
	   (inlist
	    (message "Filesets: '%s' is already in '%s'" this name))
	   ((and (equal (filesets-entry-mode entry) ':files)
		 this)
	    (filesets-entry-set-files entry (cons this files) t)
	    (filesets-set-config name 'filesets-data filesets-data))
	   (t
	    (message "Filesets: Can't add '%s' to fileset '%s'" this name)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://emacswiki.org/emacs/DuplicateLines
(defun uniquify-all-lines-region (start end)
    "Find duplicate lines in region START to END keeping first occurrence."
    (interactive "*r")
    (save-excursion
      (let ((end (copy-marker end)))
        (while
            (progn
              (goto-char start)
              (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
          (replace-match "\\1\n\\2")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun uniquify-all-lines-buffer ()
    "Delete duplicate lines in buffer and keep first occurrence."
    (interactive "*")
    (uniquify-all-lines-region (point-min) (point-max)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;allow emacs to create a dir during write file
  (add-hook 'before-save-hook
  (lambda ()
  (when buffer-file-name
  (let ((dir (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p dir))
               (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
      (make-directory dir t))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;gave up on this hook because it would not get executed when I wanted
;created binding C-c C-d to save bookmarks and .emacs manually
;; ;hook used to call batch file that saves bookmarks files
;; (add-hook 'bookmark-exit-hook-internal
;;  (lambda ()
;;   (shell-command "save_dot_bmk.bat")
;;   )
;; )
;; ;
;
;This was great before I had everything in svn, 
;Removing it bc it slows down emacs, for example it runs when emacs starts.
;A better idea might be to offer a svn ci when exiting emacs (.emacs file)
;hook used to call batch  ( .bat ) file that saves .emacs file
;(add-hook 'after-save-hook
; (lambda ()
; (if (string= (buffer-name) ".emacs")
;  (shell-command "save_dot_emacs.bat")
;  (message "Saving %s, NOT SAVING ~/.emacs" (buffer-name)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://ergoemacs.org/emacs/emacs_string-rectangle_ascii-art.htmlo
(defun copy-rectangle-to-clipboard (p1 p2)
  "Copy region as column (rectangle) to operating system's clipboard.
This command will also put the text in register 0.

See also: `kill-rectangle', `copy-to-register'."
  (interactive "r")
  (let ((x-select-enable-clipboard t))
    (copy-rectangle-to-register ?0 p1 p2)
    (kill-new
     (with-temp-buffer
       (insert-register ?0)
       (buffer-string) )) ) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-open-tortise ()
 "open tortice repo-browser pointing at the correct url"
 (interactive)
   (start-process-shell-command
    "my-process" "foo" "TortoiseProc.exe /command:repobrowser /path:."))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-open-console ()
 "open tortice repo-browser pointing at the correct url"
 (interactive)
   (start-process-shell-command
    "my-console-process" "foo-alt" "C:/Users/mfitzgerald/Downloads/Console-2.00b148-Beta_32bit/Console2/Console.exe -d ."))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  did not open cygwin the way i wanted it to, did not run my .bashrc
;; (defun my-open-cygwin ()
;;  "open tortice repo-browser pointing at the correct url"
;;  (interactive)
;;    (start-process-shell-command
;;     "my-cygwin-process" "foo-other" "mintty /bin/env  /bin/bash -l"))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-open-win-explorer()
 "open Win explorer pointing at the correct path"
 (interactive)
 (w32explore (file-name-directory  (buffer-file-name))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (defun unix-file ()
   "Change the current buffer to Latin 1 with Unix line-ends."
   (interactive)
   (set-buffer-file-coding-system 'iso-latin-1-unix t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (defun dos-file ()
   "Change the current buffer to Latin 1 with DOS line-ends."
   (interactive)
   (set-buffer-file-coding-system 'iso-latin-1-dos t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; buffer clean up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun xah-clean-empty-lines (&optional *begin *end *n)
  "Replace repeated blank lines to just 1.
Works on whole buffer or text selection, respects `narrow-to-region'.

*N is the number of newline chars to use in replacement.
If 0, it means lines will be joined.
By befault, *N is 2. It means, 1 visible blank line.

URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
Version 2016-10-07"
  (interactive
   (if (region-active-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (when (null *begin)
    (setq *begin (point-min) *end (point-max)))
  (save-excursion
    (save-restriction
      (narrow-to-region *begin *end)
      (progn
        (goto-char (point-min))
        (while (search-forward-regexp "\n\n\n+" nil "noerror")
          (replace-match (make-string (if (null *n) 2 *n ) 10)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; buffer clean up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun xah-clean-whitespace (&optional *begin *end)
  "Delete trailing whitespace, and replace repeated blank lines to just 1.
Only space and tab is considered whitespace here.
Works on whole buffer or text selection, respects `narrow-to-region'.

URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
Version 2016-10-15"
  (interactive
   (if (region-active-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (when (null *begin)
    (setq *begin (point-min)  *end (point-max)))
  (save-excursion
    (save-restriction
      (narrow-to-region *begin *end)
      (progn
        (goto-char (point-min))
        (while (search-forward-regexp "[ \t]+\n" nil "noerror")
          (replace-match "\n")))
      (xah-clean-empty-lines (point-min) (point-max))
      (progn
        (goto-char (point-max))
        (while (equal (char-before) 32) ; char 32 is space
          (delete-char -1))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end if file-orient-fns.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'file-orient-fns)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
