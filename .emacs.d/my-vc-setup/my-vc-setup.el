;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Mike Fitzgerald TMRU
;
;Libs needed by this file
(require 'cl)
(require 'dash)
(require 'string-utils)
;
;commands in this file
; my-stat ()
; svn-co-y-or-n-p (prompt)
; my-svn-find-url (&optional arg)
; my-svn-find-cached-url (&optional arg)
; my-svn-co-atom (arg &optional which-find)
; my-svn-co-no-cache (arg)
; my-svn-co-use-cache (arg)
; manage-svn-co-args (arg)
; my-svn-cache-urls ()
; my-svn-ls-grep-4-dir (url)
; my-svn-co-im (arg)
; my-svn-update-marked (arg)
; my-svn-update-immediates (arg)
; my-svn-update-infinity (arg)
; my-while-test ()
; ff (&optional arg)
; base-name-pwd ()
; base-name-of-path-or-url (arg)
; two-path-or-urls-same-p (arg1 arg2)
; run-cdm ()
; create-dir-maybe (arg)
; mf-subdirs ()
; mf-subdirs ()



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; log-edit-done runs when keying C-c C-c in the log edit buffer.
; Wait for a bit, then kill the *vc-log* buffer, after comitt.
; Otherwise the buffer and new frame it poped up sticks around, and affects
; general frame awareness, because there is a un-needed frame. 
 (defadvice log-edit-done (around log-edit-done-after activate)
  "Close the window"
  (sleep-for .5)
  ad-do-it
  (kill-buffer "*vc-log*"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-vc-svn nil)
(setq load-psvn t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'log-edit-mode-hook
   (lambda ()
   (scroll-bar-mode 0)
   ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'vc-svn-log-view-mode-hook
   (lambda ()
   (scroll-bar-mode 0)
   ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Subversion package DSVN
(add-to-list 'load-path "~/.emacs.d/dsvn/")
(when load-vc-svn
  ;
  (autoload 'svn-status "dsvn" "Run `svn status'." t)
  (autoload 'svn-update "dsvn" "Run `svn update'." t)
  ;
  (require 'vc-svn)
  ;
  ;Want to see the results
  (defadvice svn-status (around  my-svn-status-advice 0 nil activate)
    ad-do-it
    (fit-frame))
  ;
  ) ;this seemed to help give a svn status --verbose report
;rather than just svn status.
;; To get the status view, type
;;   M-x svn-status
;;Choose a dir
;;Type ? for help
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;does not work with svn 1.7
;horibally slow when doing some things ie switching away from the status buffer
(when load-psvn 
  (add-to-list 'load-path "~/.emacs.d/psvn/")
  (require 'psvn)
  (add-hook 'vc-checkin-hook 'svn-status-update-modeline)
  (add-hook 'after-revert-hook 'svn-status-update-modeline)
  (setq svn-status-verbose t)
;
 (add-hook 'svn-status-mode-hook
    (lambda ()
    ;
    (define-key svn-status-mode-map (kbd "M-c") 'nil)
    (define-key svn-status-mode-map (kbd "M-c") 'previous-line)
    )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;idea from
;www.jakemccrary.com/blog/2013/08/10/
;  emacs-capture-shell-command-output-in-temporary-buffer/
(defun my-stat ()
  "Run a ruby to create a pop-up SVN Status buffer"
  (interactive)
  (with-output-to-temp-buffer "*SVN-STATUS-NO-ADDS-ONLY*"
    (shell-command "my-stat.rb"
                   "*SVN-STATUS-NO-ADDS-ONLY*"
                   "*Messages*")
    (pop-to-buffer "*SVN-STATUS-NO-ADDS-ONLY*")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Strange key syntax http://ergoemacs.org/emacs/keystroke_rep.html
(defun svn-co-y-or-n-p (prompt)
  "Copy of `y-or-n-p', as an example use of `read-char-spec'.
PROMPT is as for `y-or-n-p'."
  (interactive)
  (read-char-spec prompt '(
                           (?y t "Answer in the affirmative")
                           (?y t "Answer in the affirmative")
                           (?n nil "Answer in the negative")
                           (?r  "rec" "Recursive")
                           (?R  "rec" "Recursive")
                           (?\C-m nil "Finalize")
                           (?\q nil "Recursive")
                           )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq myvar (propertize "foo" 'face '(:foreground "red")))
;; (setq foovar (propertize "foovar" 'face '(:foreground "green")))
;; ;
;; ;how to call it from lisp
;; (setq my-svn-co-prompt-response
;;   (svn-co-y-or-n-p 
;;   (format 
;;    "\"y\" to decend, \"r\" decend and list recursevly, Ret to accept %s %s" 
;;    myvar foovar)))
;
;; (setq my-svn-co-prompt-response
;;   (svn-co-y-or-n-p 
;;    (format "Checkout \"y\" or RET \"n\" to quit %s %s" myvar foovar)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcustom my-url-base-list
 '(
  ;don't really need these defaults, just a reminder of how to do it.
  "https://subversion.assembla.com/svn/mtf_assembla_url/trunk/mfitzgerald/AppData/Roaming/.emacs.d/"
  "https://github.com/magnars/dash.el.git/trunk/"
   )
 "* List of potential urls to checkout"
 :group 'my
 :type '(repeat string)
 )
; docstring for compositite types
;.../manual/html_node/elisp/Composite-Types.html#Composite-Types
; (repeat element-type)
;     The value must be a list and each element of the list must fit the 
;     type element-type. This appears in the customization buffer as a list 
;     of elements, with [INS] and [DEL] buttons for adding more elements 
;     or removing elements. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;.;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;This has been replaced by the use of custom, keep here to recall the orig ideas
;based on home-work option
;(cond
; ((eq home-work 'work) (setq my-url-base-list my-url-base-work-list))
; ;
; ((eq home-work 'home) (setq my-url-base-list my-url-base-home-list))
;  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-svn-find-url (&optional arg)
  "Start with a url selected using M-p M-n at the first prompt, 
   then help user choose the tree branches to decend.
   At each step the user chooses to run svn ls single level or recursively."
  ;
  (interactive
    (list
      (read-string "SVN CO\\w STARTING URL:" nil nil my-url-base-list)) )
  ;
  (setq my-url arg)
  ;
  (setq my-read-string "junk")
  (while my-read-string
    ;---------------------------------------------------------------------------
    ;svn ls
    ;runs > svn ls|grep "/$", shell hockey bc double quoetes need to be escaped
    ;bc the result of svn ls contains files and folders, only want the folders
    ;Folders have a / at the end
    (if (string-equal my-read-string "rec")
      ;
      (setq my-url-canditates-string
        ;-R can give a very large number of files.
        (shell-command-to-string (format "svn ls -R %s \|grep  \"/$\"" my-url)))
      ;
      (setq my-url-canditates-string
        (shell-command-to-string (format "svn ls %s \|grep \"/$\"" my-url)))
      )
    ;
    ;---------------------------------------------------------------------------
    ;
    (setq my-url-canditates-list (split-string my-url-canditates-string "\n"))
    ;
    ;--completing read--
    (setq cmpltng-rd-str "CHOOSE NEXT LEVEL :" )
    (setq my-url-end
    (completing-read
     (format "URL So Far \"%s\" ,%s"
       (string-utils-squeeze-url my-url 60) cmpltng-rd-str)
     my-url-canditates-list))
    ;--completing read--
    ;
    ;concat
    (setq my-url-temp (concat my-url my-url-end))
    (setq my-url my-url-temp)
    ;
    (setq my-read-string
      (svn-co-y-or-n-p 
       "y-List Single Level, r-List Recursevly, RET-Finalize URL:"))
  )
  ;
  my-url)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  This was all developmental and test.
;; ;parlis is commaon lisp
;; (setq mykeys '(1 2))
;; (setq myvals '(one two))
;; (setq myalist (pairlis mykeys myvals ))
;; ;return the pair
;; (assoc 1 myalist)
;; (assoc 1 myalist)
;; ;
;; (setq myarg 2)
;; (cdr (assoc myarg myalist))
;; ;
;; (setq my-url-svn-ls-output-list `(,other-urls-cached ,urls-cached))
;; ;
;; (setq my-url-alist
;;   (pairlis my-url-base-list  svn-ls-output-as-big-strings-list))
;
;; (setq my-alist-of-urls-key (car my-url-base-list))
;
;; ;remember the cdr of a list is a list.
;; (setq my-alist-of-urls-key (car (cdr my-url-base-list)))
;; (setq my-alist-of-urls-key 
;; "https://subversion.assembla.com/
;;  svn/mtf_assembla_url/trunk/mfitzgerald/AppData/Roaming/.emacs.d/")
;; (setq my-alist-of-urls-key 
;; "https://github.com/magnars/dash.el.git/trunk")
;; ;
;; (string-equal my-alist-of-urls-key "https://github.com/magnars/dash.el.git/trunk")
;
;; (listp      my-alist-of-urls-key)
;; (stringp    my-alist-of-urls-key)
;; (symbolp    my-alist-of-urls-key)
;
;; (setq chosen-svn-ls-out-as-big-str (cdr (assoc my-alist-of-urls-key my-url-alist)))
;; (setq chosen-svn-ls-out-as-big-str (cdr (assoc my-alist-of-urls-key my-url-alist)))
;
;; (length svn-ls-output-as-big-strings-list)
;; (length my-url-base-list)
;; (car my-url-base-list)
;; (car svn-ls-output-as-big-strings-list)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-svn-find-cached-url (&optional arg)
  "Start with a url then help user choose the tree branches to decent
   use a cached list of child urls"
   ;---------------------------------------------------------------------------
   ;reads from the minibuf with defaults and hist, results returned as arg
   (interactive
   (list
     (read-string "SVN CO\\w STARTING URL:" nil nil my-url-base-list)) )
   ;reads from the minibuf with defaults and hist, results returned as arg
   ;---------------------------------------------------------------------------
   ;
   (setq my-url-from-minibuf arg)
   ;
   ;the alist holds data of the form ( url1  result of svn ls on url1)
   ;                                 ( url2  result of svn ls on url2)
   ;Make the alist
   ;pairlis from cl takes two lists as args and creates an alist.
   (setq my-url-alist
     (pairlis my-url-base-list  svn-ls-output-as-big-strings-list))
   ;
   (setq chosen-svn-ls-out-as-big-str
     (cdr
       (assoc my-url-from-minibuf my-url-alist)))
   ;
   (setq my-url-canditates-list (split-string chosen-svn-ls-out-as-big-str "\n"))
   ;
   ;--completing read--
   (setq cmpltng-rd-str "CHOOSE NEXT SVN LEVEL :" )
   (setq my-url-end
   (completing-read
    (format "URL Taill: \"%s\" ,%s"
      (string-utils-squeeze-url my-url-from-minibuf 60) cmpltng-rd-str)
    my-url-canditates-list))
   ;--completing read--
   ;
   ;concat
   (setq my-url-concat (concat my-url-from-minibuf my-url-end))
   ;
   (message "my url is %s, my url end is %s" my-url-from-minibuf my-url-end)
   ;
   ;return url built in this defun.
   my-url-concat)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-svn-co-atom (arg &optional which-find)
  "EMACS svn co
   C-u  runs svn co --depth immediates
   C-u C-u prompts for revision
   C-u C-u C-u prompts for revision, and runs svn co --depth immediates
   ;
   This atom is designed to be called two different ways, and replaces
   two defuns that were nearly identical"
  (interactive "P")
  (let ((co-type) 
        (co-revision) 
        (co-url) 
        (arg-to-svn-co)
        (starting-dir default-directory)        
        ;
        ;set vars used by this defun, returned as a list
        (proc-args-list (manage-svn-co-args arg))
        ;
        ;determine url to checkout        
        ;; (co-url (call-interactively 'my-svn-find-url))
        (co-url (call-interactively which-find))
        )
  ;
  ;----------------------------------------------------------------------------  
  (if (svn-co-y-or-n-p 
       (format "Checkout %s %s (y/ret or n/q)"  
               (string-utils-squeeze-url co-url 70) (nth 0 proc-args-list)))
    ;-----    
    ;True
    (progn
      ;create the base dir if it does not exist, cd to it
      (create-dir-maybe co-url)    
      ;
      (shell-command-to-string 
       (format "svn co %s %s ."  (nth 1 proc-args-list) co-url ))
       ;
      (message "Done Running Check Out")
      ;
      (if (or (string-equal major-mode "dired-mode")
              (string-equal major-mode "sr-mode"))
        (revert-buffer)))
  ;-----    
  ;False
  (message "No check out, quiting now"))
  ;----------------------------------------------------------------------------  
  ;
  ;user is back where he started after this defun is done
  (cd starting-dir)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-svn-co-no-cache (arg)
  "EMACS svn co, do not use cached URL's
   Create a new dir named for last part of the url if not currently 
   in a dir named as such.   
   C-u  runs svn co --depth immediates
   C-u C-u prompts for revision
   C-u C-u C-u prompts for revision, and runs svn co --depth immediates"
  (interactive "P")
  (my-svn-co-atom arg  'my-svn-find-url))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-svn-co-use-cache (arg)
  "EMACS svn co, use cached URL's
   Create a new dir named for last part of the url if not currently 
   in a dir named as such.
   C-u  runs svn co --depth immediates
   C-u C-u prompts for revision
   C-u C-u C-u prompts for revision, and runs svn co --depth immediates"
  (interactive "P")
  (my-svn-co-atom arg  'my-svn-find-cached-url))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-svn-co-atom (arg &optional other)
;;   "EMACS svn co
;;    C-u  runs svn co --depth immediates
;;    C-u C-u prompts for revision
;;    C-u C-u C-u prompts for revision, and runs svn co --depth immediates"
;;   (interactive "P")
;;   (message "THis is it %s %s" arg other))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun manage-svn-co-args (arg)
 "Take this code out of the svn-co.. makes that defuns body more clean"
 (interactive "P")
 (cond
   ;note that eq does not work here
   ;eq checks that lists are the same object
   ((equal arg nil)  
    (setq arg-to-svn-co "-r HEAD") 
    (message "arg is nil") 
    (setq co-type  (propertize "infinity" 'face '(:foreground "red")) ))
   ;
   ((equal arg '(4))
     (progn
       (setq arg-to-svn-co (format "--depth immediates" ))
       (setq co-type  (propertize "immediates" 'face '(:foreground "green")) ))
       (message "arg is 16"))
   ;
   ((equal arg '(16))
     (progn
       (setq co-revision (read-string "Revision: "))
       (setq arg-to-svn-co (format "-r %s" co-revision))
       ;(setq temp-co-type 
       (setq co-type  
             (propertize 
              (s-concat "Revision: " co-revision) 'face '(:foreground "cyan")) ))
       (message "arg is 16"))
   ;
   ((equal arg '(64))
     (progn
       (setq co-revision (read-string "Revision: "))
       (setq arg-to-svn-co (format "-r %s --depth immediates" co-revision))
       (setq co-type  
             (propertize 
              (s-concat "Revision: " co-revision "--depth immediates") 
              'face '(:foreground "yellow")) ))
       (message "arg is 64")))
   ;
   ;Return this list
   (list 
      co-type 
      arg-to-svn-co)
   )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-svn-cache-urls ()
 (interactive)
 "Take a list of url's and return the svn listing greped for dirs only"
  (setq svn-ls-output-as-big-strings-list 
        (-map 'my-svn-ls-grep-4-dir  my-url-base-list)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-svn-ls-grep-4-dir (url)
 "fn name says it all, Arg url is not a list"
 (shell-command-to-string (format "svn ls -R %s \|grep  \"/$\"" url)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-svn-cache-urls ()
;;   "EMACS svn up shallow"
;;   (interactive)
;;   ;
;;   (setq temp-arg "--set-depth immediates")
;;   ;
;;   (setq urls-cached
;;     (shell-command-to-string 
;;       (format "svn ls -R %s \|grep  \"/$\"" (car my-url-base-list))))
;;    (setq other-urls-cached
;;        (shell-command-to-string 
;;        (format "svn ls -R %s \|grep  \"/$\"" (car (cdr my-url-base-list)))))
;;   )
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;this is junk as of SVN rev 924 leave it here as an experimental defun
(defun my-svn-co-im (arg)
  "EMACS svn co shallow"
  (interactive)
  (let (temp-arg "--depth immediates")
  (shell-command (format "svn co %s %s"  temp-arg arg))
  ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;add an arg to set depth infinity or immediates.
(defun my-svn-update-marked (arg)
  "Update folders marked in dired,
   - cd into the marked folder
   - update it
   - cd back up.
   With any prefix arg (non-nil) run\w --set depth immediates, else infinity.
   - If no folder is marked use the one under point"
  (interactive "P")
  (if (or (string-equal major-mode "dired-mode")
      (string-equal major-mode "sr-mode"))
    (progn
      (setq marked-list  (dired-get-marked-files))
      (if arg
        (-map 'my-svn-update-immediates marked-list)
        (-map 'my-svn-update-infinity   marked-list)))
    ;
    (message "not dired mode")
  ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;add a check-skip for directory, use (file-directory-p "~rms")
(defun my-svn-update-immediates (arg)
  "EMACS svn up shallow"
  (interactive)
  ;
  (cd arg)
  ;
  (let ((this-depth "--set-depth immediates"))
  ;
  (shell-command (format "svn up %s . "  this-depth))
  (cd "..")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;add a check-skip for directory, use (file-directory-p "~rms")
(defun my-svn-update-infinity (arg)
  "EMACS svn up deep"
  (interactive)
  ;
  (cd arg)
  ;
  (let ((this-depth "--set-depth infinity"))
  ;
  (async-shell-command (format "svn up %s . "  this-depth))
  (cd "..")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-while-test ()
  "While loop test"
  (interactive)
  (setq my-read-string "init-junk")
  (while (not (string-equal my-read-string ""))
    ;; (setq my-read-string (read-string "enter some text: "))
    ;
    (message "My read string %s " my-read-string)
    (if (y-or-n-p (message "Y or N Test" ))
        (message "empty")
        (progn (setq my-read-string "") (message "not empty")))
    (message "done")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;reference only
  ;(setq my-defaults '("third" "fourth"))
;Ref
;http://ergoemacs.org/emacs/elisp_idioms_prompting_input.html
(defun ff (&optional arg)
  "Prompt user to enter a string, with input history support."
  ;make the 4th arg a list to get multiple defaults.
  (interactive (list (read-string "Your name is:" nil nil my-url-base)) )
  (message "String is %s." arg)
  arg)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun base-name-pwd ()
 "Return the name of the current dir with no slashes and no full path,
 for example when buffer is .emacs return the string 'roaming' "
 (interactive)
 ;; (-last-item (s-split "/" (s-chop-suffixes '("/") (pwd)))))
 (-last-item (s-split "/" (s-chop-suffixes '("/") default-directory))))
;
;use case (setq mytemp (base-name-pwd))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun base-name-of-path-or-url (arg)
 "Return the name of the current dir with no slashes and no full path,
 for example when buffer is .emacs return the string 'roaming' "
 (interactive)
 (-last-item (s-split "/" (s-chop-suffixes '("/") arg))))
;
;use case (setq mytemp (base-name-pwd))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-test-two-urls ()
;;   "Returt t if the two argee, else nil"
;;   (interactive)
;;   (string-equal 
;;   (base-name-of-path-or-url my-test-url)
;;   (base-name-of-path-or-url (pwd))
;;   ))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun two-path-or-urls-same-p (arg1 arg2)
  "Return t if the two paths or urls basenames argee , else nil"
  (interactive)
  (string-equal 
  (base-name-of-path-or-url arg1)
  (base-name-of-path-or-url arg2)
  ))
  ;use case
  ;(two-path-or-urls-same-p my-test-url (pwd))
  ;setq my-test-url
  ;https://AppData/Roaming/.emacs.d/color-theme-6.6.0/themes/")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun run-cdm ()
 "exmaple use case"
 (interactive)
 (create-dir-maybe "https://color-theme-6.6.0/themes/"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun create-dir-maybe (arg)
  "Create a new dir with the base name of the url that was passed as an arg
  unless the basename of the url passed is the same as the pwd 
  variable name default-directory.  cd to the new dir"
  (interactive)
  (let (( base (base-name-of-path-or-url arg) ))
    (unless (two-path-or-urls-same-p arg default-directory)
     ;; (mkdir (base-name-of-path-or-url arg))
     (mkdir base)
     (message "Making directory \"%s\"" base)
     (cd base)
    )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;(directory-files "." nil "svn")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mf-subdirs ()
  "Hi Drew,
  Do you know of a lisp defun I can use like directory-files but returns
  a list filtered for directories only?
  Thanks
  Mike
  --
  You want a function that returns the subdirectories of 
  the current directory - is that it? If so, I don't know of a function, 
  but you can easily write one.  E.g.,"
  (interactive)
  (setq my-temp-list 
        (icicle-remove-if-not #'file-directory-p (directory-files "."))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mf-subdirs ()
  "Hi Drew,
  Do you know of a lisp defun I can use like directory-files but returns
  a list filtered for directories only?
  Thanks
  Mike
  --
  You want a function that returns the subdirectories of 
  the current directory - is that it? If so, I don't know of a function, 
  but you can easily write one.  E.g.,"
  (interactive)
  (setq my-temp (let ((subs  ()))
    (dolist (file  (directory-files "."))
       (when (file-directory-p file) (push file subs)))
    subs)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-svn-update-for-vc-map ()
 "Not great but it works"
 (interactive)
 (shell-command "svn update ."))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-create-tags-old ()
  (interactive)
  (let (my-read-string)
  ;
  (save-excursion
  (with-output-to-temp-buffer "*create-tags*"
    ;
    ;call to show tags (early)
    ;
    ;
    ;; (shell-command (format "shell_test.rb %s" my-read-string) 
    (shell-command (format "mylisttags.rb %s" my-read-string) 
      "*create-tags*" 
      "*-errors-*" )
    ;
    ;(select-window (active-minibuffer-window))
    ))
    (setq my-read-string (read-string "tag to release:"))
    ;(setq my-read-string (call-interactively 'query-name))
    ;(switch-to-minibuffer)
    ;
    ;call to show tags (after)
    ;
    (pop-to-buffer "*create-tags*")
    (end-of-buffer)
    (insert "OK will create %s" my-read-string)
    ;    
    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-create-tag-wizard ()
  "list tags, prompt for new tag, make the new, list them again to verify"
  (interactive)
  (let ((temp_create_buf_name "*create-tags*")
        (verbose nil)
        (my-early-listing))
    ;
    ;remember that wottb does not make the temp buffer the current buffer
    ;it just displays it!!!!
    (with-output-to-temp-buffer temp_create_buf_name
      (pop-to-buffer temp_create_buf_name)
      ;
      ;; (shell-command (format "mylisttags.rb") temp_create_buf_name "*-errors-*" )
      (setq my-early-listing (shell-command-to-string (format "mylisttags.rb")) )
      (insert my-early-listing)
      ;
      (insert "\nPRIOR TO SVN COPY\n")
    ;
    (fit-frame)
    ;
    (when verbose
      (insert "\nCurrent buffer is:\n  " (buffer-name (current-buffer)) "\n"))
    ;
    ;Query user for tag to release
    (select-frame-set-input-focus 1on1-minibuffer-frame)
    ;
    (setq my-read-string (read-string "tag to release:"))
    ;
    ;* Run the shell command that creates the tag
    ;* Remember that shell command erases the it's target buffer, prior to
    ;filling it with the std out stream.
    (shell-command 
      (format "mycreatetag.rb  %s" my-read-string) "*create-tags*" "*-errors-*" )
    ;
    (princ "\nAFTER RUNNING CREATE TAG\n")
    ;
    ;; (switch-to-buffer-other-frame "*create-tags*"))
    (pop-to-buffer "*create-tags*")
    ;
    ;consider insert-buffer
    ;
    (setq tmpstring 
      (shell-command-to-string (format "mylisttags.rb") ))
    ;
    (insert tmpstring)
    ;
    (fit-frame)
    )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;here is an example of how to havndle errors.
;ref http://steve-yegge.blogspot.com/2008/01/emergency-elisp.html
(condition-case nil
  ;defun (error ) asserts an error
  (when t 
    (error "Aoeu"))
  ;
  (error
   (message "oh no!")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; note that this needed to be run from a dired buffer showing
;c:/Users/mfitzgerald/mydata/dpifpta/trunk/
; when I ran it from a .vhd buffer in the design folder the created tag
; contained just the .vhd files from the design folder.  I thought my original
; intent was to have the flexability to run this from anywhere in the tree
; MTF 1-20-2014
;
; use this to create tags
; alias in my-dvorak-bindings
; (defalias 'ct 'my-create-tag-wizard-mult-frames-wrapped-4-error)
(defun my-create-tag-wizard-mult-frames-wrapped-4-error ()
  "Wrap the defun in an error handeler that stops the origanal defun from 
  running, closes the pop up window and gives a relevent message"
  (interactive)
      (condition-case nil
        ;
        ;this is the wrapped defun.
        (my-create-tag-wizard-mult-frames)
        ;
        (message "got here")
        ;
        (error
          (message "No SVN controlled dir \"trunk\" found in the current path")
           (quit-window))))      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-create-tag-wizard-mult-frames ()
 "List tags, prompt for new tag, create the new using url->url copy. 
  List tags again to verify the one you wanted was creted.
  Remember to check in important files BEFORE running this. 
  User has the opportunity to abort using C-g when prompted for the tag revision"
  (interactive)
  (let (
        (temp_list_buf_name "*list-tags*")
        (temp_list_buf_name_after "*list-tags-after*")
        (temp_create_buf_name "*create-tags*")
        (verbose nil)
        (my-early-listing))
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;remember that wottb does not make the temp buffer the current buffer
    ;it just displays it!!!!
    (with-output-to-temp-buffer temp_list_buf_name
      (pop-to-buffer temp_list_buf_name)
      (move-frame-top-left 1 1)
      ;
      (insert "--Create a tag using url->url copy.--\n")
      (insert "--Commit important files BEFORE running this (C-g to quit this now).--\n\n")
      ;
      (setq my-early-listing (shell-command-to-string (format "mylisttags.rb")) )
      ;
      ;The string ABORT is produced by the called Ruby
      (if (string-match ".*ABORT.*" my-early-listing)
        (error "Aoeu"))
      ;
      (insert my-early-listing)
      ;
      (insert "\nPRIOR TO SVN COPY\n")
    ;
      (fit-frame)
      ;
      (when verbose
        (insert "\nCurrent buffer is:\n  " (buffer-name (current-buffer)) "\n")))
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;Query user for tag to release
    (select-frame-set-input-focus 1on1-minibuffer-frame)
    ;
    (setq my-read-string (read-string "tag to release:"))
    ;
    ;* Run the shell command that creates the tag
    ;* Remember that shell command erases the it's target buffer, prior to
    ;filling it with the std out stream.
    (with-output-to-temp-buffer temp_create_buf_name    
      (shell-command 
        (format "mycreatetag.rb  %s" my-read-string) "*create-tags*" "*-errors-*" )
      ;
      (princ "\nAFTER RUNNING CREATE TAG\n")
      ;
      ;; (switch-to-buffer-other-frame "*create-tags*"))
      (pop-to-buffer "*create-tags*")
      (move-frame-top-left 80 160))
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (with-output-to-temp-buffer temp_list_buf_name_after
      (pop-to-buffer temp_list_buf_name_after)
      (move-frame-top-left 200 270)
      ;
      (setq tmpstring 
        (shell-command-to-string (format "mylisttags.rb") ))
      ;
      (insert tmpstring)
      ;
      (fit-frame))
    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-create-tag ()
  "Prompt for new tag, make the new, show the output from the svn cp command"
  (interactive)
  (let ((temp_create_buf_name "*CREATE-TAG*")
        (verbose nil)
        (my-early-listing))
    ;
    ;remember that wottb does not make the temp buffer the current buffer
    ;it just displays it!!!!
    (with-output-to-temp-buffer temp_create_buf_name
      ;
    ;
    (when verbose
      (pop-to-buffer temp_create_buf_name)
      (insert "\nCurrent buffer is:\n  " (buffer-name (current-buffer)) "\n"))
    ;
    ;Query user for tag to release
    (select-frame-set-input-focus 1on1-minibuffer-frame)
    ;
    (setq my-read-string (read-string "tag to release:"))
    ;
    ;* Run the shell command that creates the tag
    ;* Remember that shell command erases the it's target buffer, prior to
    ;filling it with the std out stream.
    (shell-command 
      (format "mycreatetag.rb  %s" my-read-string) temp_create_buf_name "*-errors-*" )
    ;
    (princ "\nAFTER RUNNING CREATE TAG\n")
    ;
    ;; (switch-to-buffer-other-frame "*create-tags*"))
    (pop-to-buffer temp_create_buf_name)
    ;
    (fit-frame)
    )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-list-tags ()
  "list tags"
  (interactive)
  (let ((temp_create_buf_name "*LIST-TAGS*")
        (verbose nil)
        (my-early-listing))
    ;
    ;remember that wottb does not make the temp buffer the current buffer
    ;it just displays it!!!!
    (with-output-to-temp-buffer temp_create_buf_name
      (pop-to-buffer temp_create_buf_name)
      ;
      ;; (shell-command (format "mylisttags.rb") temp_create_buf_name "*-errors-*" )
      (setq my-early-listing (shell-command-to-string (format "mylisttags.rb")) )
      (insert my-early-listing)
      ;
    ;
    (fit-frame)
    ;
    (when verbose
      (insert "\nCurrent buffer is:\n  " (buffer-name (current-buffer)) "\n"))
    ;
    (fit-frame)
    )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (frame-list)

;;   (select-frame-set-input-focus "*create-tags*")

;; (framep "*create-tags*")
;; (switch-to-buffer "*create-tags*")
;; (switch-to-buffer ".emacs")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-list-tags-old ()
  (interactive)
  ;
  (let ((temp_buf_name "*list-tags*"))
  ;
  (with-output-to-temp-buffer temp_buf_name
  (shell-command (format "mylisttags.rb") temp_buf_name "*-errors-*" )
  ;
  (pop-to-buffer temp_buf_name)
  ;
  ;move to end of buffer
  (end-of-buffer)
  ;(insert "aoeu\n")
  ;
  )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-shell-test ()
  "Prompt for a string, then pass that string to a shell command"
  (interactive)
  (setq my-read-string (read-string "tag to release:"))
  (shell-command 
   (format "shell_test.rb %s" my-read-string) "*my-buffer*" "*-errors-*" ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;; (defun my-test ()
;;   (interactive)
;;   (setq my-read-string (read-string "enter some text:"))
;;   (shell-command 
;;    "shell_test.rb test" "*my-buffer*" "*-errors-*" ))
;
;; ;; (shell-command-to-string "shell_test.rb aoeu $x-")
;; (setq my-string (shell-command-to-string "shell_test.rb aoeu $x-"))
;; (shell-command "shell_test.rb aoeu" (current-buffer) (current-buffer) )
;; (shell-command "shell_test.rb aoeu" "*my-buffer*" "*-errors-*" )
;
;; ;elimitate extra \n
;; (setq my-string
;;   (substring (shell-command-to-string "shell_test.rb aoeu $x-") 0 -1))
;; (message my-string)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(setq tempvar (substring (shell-command-to-string "pwd") 0 -1))
;; (setq tempvar (substring (shell-command-to-string "dir") 0 -1))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; git helper
; http://snarfed.org/emacs-vc-git-tweaks
;; In vc-git and vc-dir for git buffers, make 
; C-x v a run git add  
;       u run git reset
;       r run git reset and checkout from head.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-vc-git-command (verb fn)
  (let* ((fileset-arg (or vc-fileset (vc-deduce-fileset nil t)))
         (backend (car fileset-arg))
         (files (nth 1 fileset-arg)))
    (if (eq backend 'Git)
        (progn (funcall fn files)
               (message (concat verb " " (number-to-string (length files))
                                " file(s).")))
      (message "Not in a vc git buffer."))))

(defun my-vc-git-add (&optional revision vc-fileset comment)
  (interactive "P")
  (my-vc-git-command "Staged" 'vc-git-register))

(defun my-vc-git-reset (&optional revision vc-fileset comment)
  (interactive "P")
  (my-vc-git-command "Unstaged"
    (lambda (files) (vc-git-command nil 0 files "reset" "-q" "--"))))

(define-key vc-prefix-map [(r)] 'vc-revert-buffer)
;(define-key vc-dir-mode-map [(r)] 'vc-revert-buffer)
(define-key vc-prefix-map [(a)] 'my-vc-git-add)
;(define-key vc-dir-mode-map [(a)] 'my-vc-git-add)
(define-key vc-prefix-map [(u)] 'my-vc-git-reset)
;(define-key vc-dir-mode-map [(u)] 'my-vc-git-reset)

;; hide up to date files after refreshing in vc-dir
(define-key vc-dir-mode-map [(g)]
  (lambda () (interactive) (vc-dir-refresh) (vc-dir-hide-up-to-date)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-vc-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
