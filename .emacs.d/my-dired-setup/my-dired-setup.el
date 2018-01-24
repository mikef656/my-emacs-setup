;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'string-utils)
(require 'dash)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;DIRED
;; allow dired to be able to delete or copy a whole dir.
;; always means no asking. top means ask once.
;;Any other symbol means ask each and every time for a dir and subdir.
(setq dired-recursive-copies (quote always))
(setq dired-recursive-deletes (quote top))
;
;when you have dired of different dir in 2 panes, and when you press
;C to copy, the other dir in the split pane will be default destination.
(setq dired-dwim-target t)
;
;1/26/2012 seem to be causing some wierd stuff where two dired buffers open
;at the same time would interact in underisable ways
;; ;;If you want Enter and ^ (parent dir) to use the same buffer,
;; ;;put the following in your emacs init file:
;; ;ALSO:In dired, you can press a instead of Enter to open the dir.
;; ;This way, the previous dir will be automatically closed.
;; (add-hook 'dired-mode-hook
;;  (lambda ()
;;   (define-key dired-mode-map (kbd "<rejturn>")
;;     'dired-find-alternate-file) ; was dired-advertised-find-file
;;   (define-key dired-mode-map (kbd "^")
;;     (lambda () (interactive) (find-alternate-file "..")))
;;   ; was dired-up-directory
;;  ))
;
(put 'dired-find-alternate-file 'disabled nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-dired+ t)
   (add-to-list 'load-path "~/.emacs.d/icicles/")
   (require 'dired+))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/icicles/")

; Note that the extra dired-details package is not needed as of 24.4
; hovever what is in 24.4 does not properly hide details in sunrise-commander

; and this is wrong it puts in dired-details when the rev is less than or =
; to 24.4.  Leave it for now because of the issue with SR.
(when
  ;; (and (eq load-dired-details t) (>= emacs-major-version 24) (<= emacs-minor-version 3))
  (and (eq load-dired-details t) (>= emacs-major-version 24) (>= emacs-minor-version 3))
     ;
     (progn
       (add-to-list 'load-path "~/.emacs.d/dired-details/")
       (require 'dired-details+)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Some of the functionality associated with dired-sort-menu+ and dired-sort-menu
; is for Windows only.  The key binding "/" to toggle dirs first does not work
; on linux systems by design.  This can be discovered by looking in
; dired-sort-menu+  where the binding is made and this check is performed
; (ls-lisp-var-p 'ls-lisp-dirs-first).  The varibale doc string for
; ls-lisp-dirs-first says it depends on Windows Explorer.  This is irritating
; bc it's not stated on the emacs Wiki that it is for Windows only.
(add-to-list 'load-path "~/.emacs.d/dired-sort-menu/")
(when (eq load-dired-sort-menu+ t)
   (require 'dired-sort-menu+))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-diredful")
(when  load-diredful;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/diredful/")
    (require 'diredful)
    t)
    ;
  ;
  (message "--Error in load-diredful")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-dired-hacks")
(when  (and load-dired-hacks); ace-window requires avy
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/dired-hacks-utils")
    (add-to-list 'load-path "~/.emacs.d/dired-narrow")
    (add-to-list 'load-path "~/.emacs.d/dired-subtree")
    (require 'dired-hacks-utils)
    (require 'dired-narrow)
    (require 'dired-subtree)
    t)
    ;
  (message "--Error in load-dired-hacks")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;BEGIN DiredSortBySizeAndExtension
;;http://www.emacswiki.org/emacs/DiredSortBySizeAndExtension This code extends
;;Dired to allow it to sort by file name, file time, file extension,;;or file
;;size, instead of only name and time as is the default.  Just press s in a
;;dired buffer to cycle through these sort modes.
  (require 'ls-lisp)
;;
;; redefine this function, to fix the formatting of file sizes in dired mode
(defun ls-lisp-format-file-size (file-size human-readable)
 (if (or (not human-readable)
         (< file-size 1024))
     (format (if (floatp file-size) " %11.0f" " %11d") file-size)
   (do ((file-size (/ file-size 1024.0) (/ file-size 1024.0))
        ;; kilo, mega, giga, tera, peta, exa
        (post-fixes (list "k" "M" "G" "T" "P" "E") (cdr post-fixes)))
       ((< file-size 1024) (format " %10.0f%s"  file-size (car post-fixes))))))
   ;;
   ;; Redefine the sorting in dired to flip between sorting on name, size,
   ;; time, and extension, rather than simply on name and time.
   ;;
(defun dired-sort-toggle ()
     ;; Toggle between sort by date/name.  Reverts the buffer.
     (setq dired-actual-switches
           (let (case-fold-search)
            ;;
             (cond
              ;;
              ((string-match " " dired-actual-switches) ;; contains a space
               ;; New toggle scheme: add/remove a trailing " -t" " -S",
               ;; or " -U"
               ;; -t = sort by time (date)
               ;; -S = sort by size
               ;; -X = sort by extension
               ;;
               (cond
               ;;
                ((string-match " -t\\'" dired-actual-switches)
                 (concat
                  (substring dired-actual-switches 0 (match-beginning 0))
                  " -X"))
              ;;
                ((string-match " -X\\'" dired-actual-switches)
                 (concat
                  (substring dired-actual-switches 0 (match-beginning 0))
                  " -S"))
              ;;
                ((string-match " -S\\'" dired-actual-switches)
                 (substring dired-actual-switches 0 (match-beginning 0)))
              ;;
                (t
                 (concat dired-actual-switches " -t"))))
              ;;
              (t
               ;; old toggle scheme: look for a sorting switch, one of [tUXS]
               ;; and switch between them. Assume there is only ONE present.
               (let* ((old-sorting-switch
                       (if (string-match
			           (concat "[t" dired-ls-sorting-switches "]")
                                         dired-actual-switches)
                           (substring dired-actual-switches (match-beginning 0)
                                      (match-end 0))
                         ""))
                      ;;
                      (new-sorting-switch
                       (cond
                        ((string= old-sorting-switch "t")
                         "X")
                        ((string= old-sorting-switch "X")
                         "S")
                        ((string= old-sorting-switch "S")
                         "")
                        (t
                         "t"))))
                 (concat
                  "-l"
                  ;; strip -l and any sorting switches
                  (dired-replace-in-string (concat "[-lt"
                                             dired-ls-sorting-switches "]")
                                           ""
                                           dired-actual-switches)
                  new-sorting-switch))))))
      ;;
     (dired-sort-set-modeline)
     (revert-buffer))
     ;;
   ;; redefine this fn, to properly provide the modeline in dired mode,
   ;; supporting the new search modes I defined above.
(defun dired-sort-set-modeline ()
     ;; Set modeline display according to dired-actual-switches.
     ;; Modeline display of "by name" or "by date" guarantees the user a
     ;; match with the corresponding regexps.  Non-matching switches are
     ;; shown literally.
     (when (eq major-mode 'dired-mode)
       (setq mode-name
             (let (case-fold-search)
               (cond ((string-match "^-[^t]*t[^t]*$" dired-actual-switches)
                      "Dired by date" (message "Dired by date"))
                     ((string-match "^-[^X]*X[^X]*$" dired-actual-switches)
                      "Dired by ext"   (message "Dired by ext"))
                     ((string-match "^-[^S]*S[^S]*$" dired-actual-switches)
                      "Dired by sz"   (message "Dired by sz"))
                     ((string-match "^-[^SXUt]*$" dired-actual-switches)
                      "Dired by name" (message "Dired by name"))
                     (t
                      (concat "Dired " dired-actual-switches)))))
       (force-mode-line-update)))
   ;;END DiredSortBySizeAndExtension
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;default value is the empty list
(defvar my-dired-his-var-list () "History of folders visited in dired")
(defvar his-msg-lim 20 "Max length of message")
;
(defun jump-up-manage-history (&optional arg)
   "Wrap jump up in adds for current directory to the history list
    fit the frame to the cwd lenght if its a 1-window frame"
   (interactive )
   ;nil means allow fitting
   (let ((fit-frame-inhibit-fitting-flag nil))
   ;
   ;push before dir unless it' already at the beginning of the list
   (unless (equal (car my-dired-his-var-list) default-directory)
     (setq my-dired-his-var-list
           (cons default-directory my-dired-his-var-list)))
   ;
   (find-alternate-file"..")
   ;
   ;push after dir unless it' already at the beginning of the list
   (unless (equal (car my-dired-his-var-list) default-directory)
     (setq my-dired-his-var-list
           (cons default-directory my-dired-his-var-list)))
   ;
   ; In the case where a dired window is a sidebar, then
   ; don't do the fitting to match the cwd lenght
   (if (equal 1 (length (window-list)) )
       (progn
         (setq my_default_directory_lenght  (length default-directory))
         (fit-frame  nil (+ 3 my_default_directory_lenght) nil)))
   ;
   (message
    ;; (string-utils-squeeze-filename default-directory his-msg-lim))
    (string-utils-squeeze-url default-directory his-msg-lim))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;in dired call this with M-left
(defun my-dired-go-to-prev-his-folder (&optional arg)
   "Go to previous dir in history list, "
   (interactive )
   ;
   ;rotate the list if its car is the pwd, don't want to cd to pwd
   (if (equal (car my-dired-his-var-list) default-directory)
     (setq my-dired-his-var-list (-rotate -1 my-dired-his-var-list)))
   ;
   (find-alternate-file (car my-dired-his-var-list))
   ;
   ;rotate the list so the first item becomes the second
   (setq my-dired-his-var-list (-rotate -1 my-dired-his-var-list))
   ;
   (if (equal 1 (length (window-list)) )
       (progn
         (setq my_default_directory_lenght  (length default-directory))
         (fit-frame  nil (+ 3 my_default_directory_lenght) nil)))
   ;
   (message
    (string-utils-squeeze-url default-directory his-msg-lim)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;in dired call this with M-right
(defun my-dired-go-to-next-his-folder (&optional arg)
   "IN DIRED, use arrow keys line Win7."
   (interactive )
   ;
   ;rotate the list if its last item is the pwd, don't want to cd to pwd
   (if (equal (-last-item my-dired-his-var-list) default-directory)
     (setq my-dired-his-var-list (-rotate 1 my-dired-his-var-list)))
   ;
   ;rotate list so the last becomes the first
   (setq my-dired-his-var-list (-rotate 1 my-dired-his-var-list))
   ;
   (find-alternate-file (car my-dired-his-var-list))
   ;
   (if (equal 1 (length (window-list)) )
       (progn
         (setq my_default_directory_lenght  (length default-directory))
         (fit-frame  nil (+ 3 my_default_directory_lenght) nil)))
   ;
   (message
    (string-utils-squeeze-url default-directory his-msg-lim)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-dired-drill-down-dir (&optional arg)
  "Wrap dired-find-file with pushes to the history list"
  (interactive )
  ;
  ;push before dir unless it' already at the beginning of the list
    (unless (equal (car my-dired-his-var-list) default-directory)
      (setq my-dired-his-var-list
            (cons default-directory my-dired-his-var-list)))
  ;
  (dired-find-file)
  ;
   (unless (equal (car my-dired-his-var-list) default-directory)
     (setq my-dired-his-var-list
           (cons default-directory my-dired-his-var-list))))
;
; iterate a list into string-match
;; (let ((result  ()))
;;    (dolist (word  '("fight" "foo" "for" "food!"))
;;      (when (string-match "o" word) (push word result)))
;;    (nreverse result))
;;  ==> ("foo" "for" "food!")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-dired-find-file (&optional arg)
  "Runs dired-find-file on a file, my-dired-drill-down-dir on a dir"
  (interactive )
  ;
  (if (file-directory-p (setq tempfile  (dired-get-filename nil t)))
  ;T
  (my-dired-drill-down-dir)
  ;F
  (progn ;match 0 or 1 anything at the end
    (if  (s-match "doc.?$" tempfile)
        (message "its a word doc")
        (dired-find-file)))))
;
;perhaps add a message showing the new directory changed to by
;  jump up
;  my-dired-find-file
;
;perhaps add a check then message for nil history
;
;perhaps add a completing read jump based on the history
;(use an extended history including other dir history, SR??)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun diredp-or-sr-do-bookmark (&optional arg)
   "IN DIRED, use arrow keys line Win7."
   (interactive )
   (find-alternate-file".."))
   ;

(defun my-dired-mode-line ()
  (setq mode-line-format '("%17b")))

;(add-hook 'dired-mode-hook #'peep-dired-mode)
  ;(peep-dired-mode 1)

(add-hook 'dired-mode-hook
 (lambda ()
  (add-hook ' dired-mode-hook #'my-dired-mode-line 'append)
  ;(peep-dired)
  (linum-mode 0)
  ;(menu-bar mode 0)
  (define-key dired-mode-map "v"    'peep-dired)
  (define-key dired-mode-map "*"    'dired-narrow)
  (define-key dired-mode-map "F"    'my-dired-do-find-marked-files)
  (define-key dired-mode-map "\M-G"    'diredp-do-grep)
  (define-key dired-mode-map [(control shift s )] 'isearch-backward)
  (define-key dired-mode-map [(control shift return)] 'my-launch-tortoise)
  (define-key dired-mode-map "o" 'nil)
  (define-key dired-mode-map "\r" 'nil)
  (define-key dired-mode-map "\r" 'my-dired-find-file)
  ;; (define-key dired-mode-map "o" 'my-dired-find-file-other-window-same-frame)
  (define-key dired-mode-map "o" 'my-dired-ff-other-win-same-frm-maybe-replace)
  (define-key dired-mode-map "r" 'nil)
  (define-key dired-mode-map "r" 'dired-sort-menu-toggle-reverse)
  (define-key dired-mode-map [(control  n)] 'nil)
  (define-key dired-mode-map [(control  o)] 'find-file)
  (define-key dired-mode-map [(meta  q)] 'nil)
  (define-key dired-mode-map [(meta  q)] 'smex)
  (define-key dired-mode-map [(meta b)] 'nil)
  (define-key dired-mode-map [(meta B)] 'nil)
  (define-key dired-mode-map [(meta  c)] 'nil)
  (define-key dired-mode-map [(meta  g)] 'nil)
  (define-key dired-mode-map [(meta  G)] 'diredp-do-grep)
  (define-key dired-mode-map [(control meta shift b)] 'diredp-do-bookmark)
  (define-key dired-mode-map [f2] 'dired-toggle-read-only)
  (define-key dired-mode-map [(meta up)] 'jump-up-manage-history)
  (define-key dired-mode-map [(meta left)] 'my-dired-go-to-prev-his-folder)
  ;(define-key dired-mode-map "u" 'jump-up-manage-history)
  (define-key dired-mode-map [(control meta v )] 'dired-w32explore);ahk
  (define-key dired-mode-map [(meta right)] 'my-dired-go-to-next-his-folder)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;compare files marked in dired
;http://www.emacswiki.org/emacs/DavidBoon
(defun dired-ediff-marked-files ()
  "Run ediff on marked ediff files."
  (interactive)
  (set 'marked-files (dired-get-marked-files))
  (when (= (safe-length marked-files) 2)
    (ediff-files (nth 0 marked-files) (nth 1 marked-files)))
  (when (= (safe-length marked-files) 3)
    (ediff3 (buffer-file-name (nth 0 marked-files))
            (buffer-file-name (nth 1 marked-files))
            (buffer-file-name (nth 2 marked-files)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Note: Files (zip.exe and unzip.exe )downloaded put in this path, did not work
;Then copied them to C:/cygwin/bin
;and it worked?? 4-3-2012
(add-to-list 'exec-path "C:/Users/mfitzgerald/Downloads/unzip")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;stackoverflow.com/questions/1431351/how-do-i-uncompress-unzip-within-emacs
;makes a binding for "z" 'dired-zip-files
(eval-after-load "dired"
  '(progn
  (define-key dired-mode-map "z" 'dired-zip-files)))
;
(defun dired-zip-files (zip-file)
  "Create an archive containing the marked files."
  (interactive "sEnter name of zip file: ")
  ;; create the zip file
  (let ((zip-file
  (if (string-match ".zip$" zip-file) zip-file (concat zip-file ".zip"))))
    (shell-command
     (concat "zip "
             zip-file
             " "
             (concat-string-list
              (mapcar
               '(lambda (filename)
                  (file-name-nondirectory filename))
               (dired-get-marked-files))))))
  (revert-buffer))
;
(defun concat-string-list (list)
   "Return a string which is a concatenation of all elements
   of the list separated by spaces"
    (mapconcat '(lambda (obj) (format "%s" obj)) list " "))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://stackoverflow.com/questions/4471835/emacs-dired-mode-and-isearch
;;end isearch with a single ret and end up in the file or next dir you wanted
;; (add-hook 'isearch-mode-end-hook
;;   (lambda ()
;;     (when (and (eq major-mode 'dired-mode)
;;            (not isearch-mode-end-hook-quit))
;;       ;(dired-w32-browser)))) 		;
;;       (dired-find-file ))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://stackoverflow.com/questions/4471835/emacs-dired-mode-and-isearch
;;end isearch with a single ret and end up in the file or next dir you wanted
;(add-hook  'isearch-mode-hook
 ;     )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-isearch-finish ()
   "IN DIRED, use arrow keys line Win7."
   (interactive )
   (isearch-exit)
   (when
       (or (string-equal major-mode "dired-mode")
           (string-equal major-mode "sr-mode"))
       (dired-find-alternate-file)))
;
(defun my-isearch-finish-2-w32 ()
   "IN DIRED, use arrow keys line Win7."
   (interactive )
   (isearch-exit)
   (dired-w32-browser))
;
(defun my-isearch-finish-2-w32exp ()
 "IN DIRED, use arrow keys line Win7."
 (interactive )
 (isearch-exit)
 (dired-w32explore))
;
 (eval-after-load "isearch+"
  '(progn
   ;ret->finish or dired-find-alternate-file in dired
   (define-key isearch-mode-map (kbd "<return>") 'my-isearch-finish)
   ;
   ;M ret ->run the windows exe
   (define-key isearch-mode-map (kbd "M-<return>") 'my-isearch-finish-2-w32)
   ;
   ;C-ret ->open win explorer
   (define-key isearch-mode-map (kbd "C-<return>") 'my-isearch-finish-2-w32exp)
   ;
   ;C-M-ret -> leave point at the destination, nothing else
   (define-key isearch-mode-map (kbd "C-M-<return>") 'isearch-exit)
   (define-key isearch-mode-map (kbd "S-<return>") 'isearchp-act-on-demand)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;always show dirs first
(setq ls-lisp-dirs-first t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun dired-sort-extension ()
  "Dired sort by extension."
  (interactive)
  (dired-sort-other (concat dired-listing-switches "X")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun dired-sort-name ()
  "Dired sort by name."
  (interactive)
  (dired-sort-other (concat dired-listing-switches "")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun dired-find-file-other-frame ()
    "In Dired, visit this file or directory in another window."
    (interactive)
    (find-file-other-frame (dired-get-file-for-visit)))

  (eval-after-load "dired"
    '(define-key dired-mode-map "O" 'dired-find-file-other-frame))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-dired-do-find-marked-files ()
    "Wrap dired-do-find-marked-files so that when visiting files each
     file does NOT open on a new frame, rather the current window is split
     into equal size #w/n for n windows"
    (interactive)
    (let ((pop-up-frames nil))
      (dired-do-find-marked-files)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defadvice dired-mark-read-file-name
 (after rv:dired-create-dir-when-needed
        (prompt dir op-symbol arg files &optional default) activate)
 (when (member op-symbol '(copy move))
  (let ((directory-name (if (< 1 (length files))
                            ad-return-value
                            (file-name-directory ad-return-value))))
    (when (and (not (file-directory-p directory-name))
      (y-or-n-p
       (format "directory %s doesn't exist, create it?" directory-name)))
      (make-directory directory-name t)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ZIP STUFF
;http://stackoverflow.com/questions/1431351/
;                                how-do-i-uncompress-unzip-within-emacs
;ZIP:To zip files (create new archive),
;  1) Open the directory in dired.
;  2) Mark the files to zip using dired command 'm'.
;  3a) If marked is top dir tree run dired command '!' ,
;      then at minibuffer prompt 'zip -r my-new.zip * <RET>'
;  ---Note *NOT M-!*---
;
;  3b) If marked are files       type ! zip my-new.zip * <RET>
;
;  3b)alt(if marked are files) Use "z" from the above defun
;  keystroke '!' runs the command:
;     dired-do-shell-command Run a shell command COMMAND on the marked files.
;;
;UNZIP:To extract archive
;  from dired mark a file and run '&' ***NOT M-&***
;     keystroke '&' runs
;        dired-do-async-shell-command
;        Run a shell command COMMAND on the marked files asynchronously
;;
;zip-archive mode will allow you to browse zip files in a dired-like fashion.
;  should come with recent versions of  emacs and will be used by default when
;  you visit a file with the .zip extension. From this mode you can
;  extract individual files into a buffer, then save them with C-x C-s.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://jungels.net/articles/diff-patch-ten-minutes.html
;To apply a patch run the following command in a shell:
;$ patch < /path/to/file
;From dired mark the patch file then
;  "! patch < *"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Set up AUTO-mode-alist for dired virtual
(setq auto-mode-alist (cons '("[^/]\\.dired$" . dired-virtual-mode)
                                   auto-mode-alist))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end of my-dired-setup")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-dired-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

