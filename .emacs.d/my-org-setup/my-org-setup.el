;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;; ;Org mode
; good Reference
; http://doc.norang.ca/org-mode.html#AgendaSetup
;
;MTF To update org mode download the zip to .emacs.d and extract there
;No compiling nocessary for basic operation
;To make sure all your variables work you should not use (require 'org). 
;Instead use the following setting:
;
;  (require 'org-install)
;(require 'org-install)
;From http://orgmode.org/worg/org-faq.html
;  You should also make sure that you do not require any other org-... files 
;  in your .emacs file before you have set your org variables, 
;  since these will also cause org.el to be loaded. 
;  To be safe, load org files after you have set your variables. (require 'org-install)
;
;Set this var early in the org setup file
(setq org-replace-disputed-keys t)


(setq org-tag-alist '(
                      (:startgroup . nil)
                      ("urgent" . ?u) ("not_urgent" . ?n)
                      (:endgroup . nil)
                      ;
                      (:startgroup . nil)
                      ("important" . ?i) ("not_important" . ?o)
                      (:endgroup . nil)
                      ("opportunity" . ?p)                      ))
; If the tag is only relevant to the file you are working on, then you
; can instead set the TAGS option line as:
;      #+TAGS: @work(w)  @home(h)  @tennisclub(t)  laptop(l)  pc(p)


;; flyspell mode for spell checking everywhere
; irritating 4 tech work (add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'turn-on-auto-fill)



;(add-to-list 'load-path (expand-file-name "~/.emacs.d/org-7.8.11/lisp"))
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/org-7.8.11/contrib/lisp"))

;; (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))

(setq org-fontify-emphasized-text t)

;a bunch of defuns and modes related to org are loaded
(require 'org-install)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;This may not be necessary
;on 2-19-2013 this started giving errors on load wanting to create folders.
(require 'org-capture)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;Machine Specific setup between work and home 4 org mode
;(require 'my-org-4-machine-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-log-done t)
;for the recursive find
(load-library "find-lisp")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (eq home-work 'work)
;Search Path
;Note no / at the end of the path
;(add-hook 'org-mode-hook (lambda () 
  ;; (setq org-agenda-files 
  ;;       (find-lisp-find-files
  ;;                             "h:/surecom"
  ;;                             "c:/Users/mfitzgerald/Desktop/stuff"
  ;;  			    ))
 ; ))
;
  (setq org-agenda-files (quote (
                                "~/org"
                                "h:/surecom"
                                "c:/Users/mfitzgerald/Desktop/stuff"
                                "c:/Users/mfitzgerald/Desktop/stuff/Subversion"
                                "c:/Users/mfitzgerald/Desktop/stuff/emacs"
                                "c:/Users/mfitzgerald/Desktop/stuff/linux"
                                "c:/Users/mfitzgerald/Desktop/stuff/windows"
				))) 
;
  (setq org-agenda-files (quote (
                                "c:/Users/family/Documents/org"
                                "c:/Users/family/Documents/life"
                                "c:/Users/family/Desktop/stuff/Subversion"
                                "c:/Users/family/Desktop/stuff/emacs"
                                "c:/Users/family/Desktop/stuff/linux"
                                "c:/Users/family/Desktop/stuff/windows"
                                "c:/Users/family/Documents/muffins"
                                "c:/Users/family/downloads"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;these ended up it the home .emacs-custom assigned to org-agenda-files
  ;"c:/Users/family/Documents/org/Klinghart_video_notes.org"
  ;"c:/Users/family/Documents/org/diswasher.org"
  ;"c:/Users/family/Documents/org/emacs.org"
  ;"c:/Users/family/Documents/org/email.org"
  ;"c:/Users/family/Documents/org/find_stuff.org"
  ;"c:/Users/family/Documents/org/home_note.org"
  ;"c:/Users/family/Documents/org/insurance-bulit-points.org"
  ;"c:/Users/family/Documents/org/insurance-email.org"
  ;"c:/Users/family/Documents/org/my-health.org"
  ;"c:/Users/family/Documents/org/refile.org"
  ;"c:/Users/family/Documents/org/refile_home.org"
  ;"c:/Users/family/Documents/org/storm.org"
  ;"c:/Users/family/Documents/life/life.org"
  ;"c:/Users/family/downloads/email.org"
  ;"c:/Users/family/downloads/storm.org")))
;
;
;This is how to point to multiple folders
;; (setq org-agenda-files (quote ("~/git/org"
;;                                "~/git/org/client1"
;;                                "~/git/org/bzflag"
;;                                "~/git/client2")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (eq home-work 'work ) 
  (setq org-capture-templates
     '(
       ("t" "Todo" entry (file+headline "~/org/refile.org" "Tasks")
            "* TODO %?\n  %i\n  %a")
       ("f" "For Tomarrow" entry (file+headline "~/org/refile.org" "For Tomarrow")
            "* Start this\:%?\nFinish this\:\n  ")
       ("s"  "Surecom Note" entry (file+headline "~/org/refile.org" "Surecom Note")
            ;; "* Account Name\: %?\n** Login\:\n** Pass\:\n %i\n** Created On\: %u\n ")
            "* Topic\: %?\n** FPGA\:\n** Other\:\n** Created On\: %u\n\n ")
       ;
       ("h"  "Home Note" entry (file+headline "~/org/refile.org" "Home Note")
            "* %?Topic\: \n** Room\:\n** Other\:\n** Created On\: %u\n\n ")
       ;
       ("T"  "Think About" entry (file+headline "~/org/refile.org" "Think About")
            "* Topic\: %?\n* EMACS\:\n* Health\:\n** Website: \[\[paste link here]]\n** Created On\: %u\n\n ")
       ;
       ("e"  "Think About EMACS" entry (file+headline "~/org/refile.org" "EMACS")
            "*** Topic\: %?\n**** Created On\: %u\n\n ")
       ;
       ("p"  "Spelling" entry (file+headline "~/my-org-storage/spelling.org" "SPELLING")
            "*** Correct spelling of Word I Mispell\: %?  How I spell it\:\n\n ")
       ;       
       ;
       ("m"  "Muffins")
       ("ms"  "Simple" entry (file+headline "~/org/muffins.org" "Logins")
            ;; "* Account Name\: %?\n** Login\:\n** Pass\:\n %i\n** Created On\: %u\n ")
            "* Account Name\: %?\n** Login\:\n** Pass\:\n** Created On\: %u\n\n ")
       ("mc"  "Complex" entry (file+headline "~/org/muffins.org" "Logins")
            ;; "* Account Name\: %?\n** Login\:\n** Pass\:\n %i\n** Created On\: %u\n ")
            "* Account Name\: %?\n** Login\:\n** Pass\:\n** PIN:\n** Website: \[\[paste link here]]\n** Comment:\n** Created On\: %u\n\n ")
       ;
       ("j" "Journal" entry (file+datetree "~/org/refile.org")
            "* %?\nEntered on %U\n  %i\n  %a"))))
;
(if (eq home-work 'home ) 
  (setq org-capture-templates
     '(
       ("t" "Todo" entry (file+headline "c:/Users/family/AppData/Roaming/my-org-storage/refile.org" "Tasks")
            "* TODO %?\n  %i\n  %a")
       ("f" "For Tomarrow" entry (file+headline "c:/Users/family/AppData/Roaming/my-org-storage/refile.org" "For Tomarrow")
            "* Start this\:%?\nFinish this\:\n  ")
       ;; ("s"  "Surecom Note" entry (file+headline "~/org/refile_home.org" "Surecom Note")
       ;;      ;; "* Account Name\: %?\n** Login\:\n** Pass\:\n %i\n** Created On\: %u\n ")
       ;;      "* Topic\: %?\n** FPGA\:\n** Other\:\n** Created On\: %u\n\n ")
       ;
       ("h"  "Home Note" entry (file+headline "c:/Users/family/Documents/org/refile_home.org" "Home Note")
            "* %?Topic\: \n** Room\:\n** Other\:\n** Created On\: %u\n\n ")
       ;
       ("T"  "Think About" entry (file+headline "c:/Users/family/Documents/org/refile_home.org" "Think About")
            "* Topic\: %?\n* EMACS\:\n* Health\:\n** Website: \[\[paste link here]]\n** Created On\: %u\n\n ")
       ;
       ("e"  "Think About EMACS" entry (file+headline "c:/Users/family/AppData/Roaming/my-org-storage/refile.org" "EMACS")
            "*** Topic\: %?\n**** Created On\: %u\n\n ")
       ;
       ("p"  "Spelling" entry (file+headline "~/my-org-storage/spelling.org" "SPELLING")
            "*** Correct spelling of Word I Mispell\: %?  How I spell it\:\n\n ")
       ;
       ("m"  "Muffins")
       ("ms"  "Simple" entry (file+headline "c:/Users/family/Documents/muffins/muffins.org" "Logins")
            ;; "* Account Name\: %?\n** Login\:\n** Pass\:\n %i\n** Created On\: %u\n ")
            "* Account Name\: %?\n** Login\:\n** Pass\:\n** Created On\: %u\n\n ")
       ;
       ("mc"  "Complex" entry (file+headline "c:/Users/family/Documents/muffins/muffins.org" "Logins")
            ;; "* Account Name\: %?\n** Login\:\n** Pass\:\n %i\n** Created On\: %u\n ")
            "* Account Name\: %?\n** Login\:\n** Pass\:\n** PIN:\n** Website: \[\[paste link here]]\n** Comment:\n** Created On\: %u\n\n "))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;; Info directory
(add-to-list 'Info-default-directory-list
             (expand-file-name "~/.emacs.d/org-7.8.11/doc"))


;org-capture binding 
;(global-set-key "\C-c-c" 'org-capture)
(global-set-key [(control c) (c)] 'org-capture)


; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))


; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)


; Targets complete directly with IDO
 (setq org-outline-path-complete-in-steps nil)
;(setq org-outline-path-complete-in-steps 'file)


; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'org-mode-hook
  (lambda ()
    (define-key org-mode-map [(shift up)] 'org-shiftup)
    (define-key org-mode-map [(shift down)] 'org-shiftdown)
    (define-key org-mode-map "\C-cl" nil) ;was org store link, this does not seem to be working
    ;(define-key org-mode-map "\C-cl" 'org-store-link)
    (define-key org-mode-map (kbd "C-c SPC") nil) ;was org blank table field
    (define-key org-mode-map (kbd "C-'") nil)
    (define-key org-mode-map [(meta c)] 'nil)
    (define-key org-mode-map "\C-\M-t"	'forward-paragraph)
    (define-key org-mode-map "\C-\M-c"	'backward-paragraph)
    (define-key org-mode-map [(meta })] 'nil) 
    (define-key org-mode-map [(meta {)] 'nil) 
    (define-key org-mode-map [(meta n)] 'nil)
    (define-key org-mode-map [(meta h)] 'nil)
    (define-key org-mode-map [(meta t)] 'nil)
    (define-key org-mode-map [(meta d)] 'org-mark-subtree)
    (define-key org-mode-map [(meta e)] 'nil)
    (define-key org-mode-map [(control tab )] 'nil)
    (define-key org-mode-map [(control z )] 'nil)
    (define-key org-mode-map (kbd "C-,") 'nil)
    (define-key org-mode-map (kbd "<C-return>") 'my-org-control-return)
    ;; (define-key org-mode-map (kbd "<M-return>") 'my-org-meta-return)
    (define-key org-mode-map (kbd "<M-return>") 'org-meta-return)
    ;(define-key org-mode-map "\C-cA" 'org-agenda);there is a global of the same
    (define-key org-mode-map "\C-ct" 'org-set-tags-command)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun my-org-meta-return (&optional arg)
;;  "better than what was there, with C-u arg do the original behavior"
;;  (interactive "P")
;;  (if (equal arg '(4))
;;    ;T
;;    (org-meta-return)
;;    ;
;;    (progn
;;      (end-of-line)
;;      (org-insert-heading))))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This blog post is helpful in understanding variable org-M-RET-may-split-line
; http://irreal.org/blog/?p=6297
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-org-meta-return (&optional arg)
  "Insert a new heading/item with the same level as the one at point.
  If the command is used at the beginning of a line, and if there is a heading or
  a plain list item (see Plain lists) at point, the new heading/item is created
  before the current line. When used at the beginning of a regular line of text,
  turn that line into a heading.
   
  When this command is used in the middle of a line, the line is split and the
  rest of the line becomes the new item or headline. If you do not want the line
  to be split, customize org-M-RET-may-split-line.
   
  Calling the command with a C-u prefix unconditionally inserts a new heading at
  the end of the current subtree, thus preserving its contents. With a double C-u
  C-u prefix, the new heading is created at the end of the parent subtree instead."
   (org-meta-return))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-org-control-return (&optional arg)
 "better than what was there, with C-u arg do the original behavior" 
 (interactive "P")
 (if (equal arg '(4))
   ;T
   (org-meta-return)
   ;
   (progn
     (beginning-of-line)
     (org-insert-heading))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-todo-keywords
           '((sequence "TODO" "STARTED" "|" "DONE")
             (sequence "QUESTION-PENDING" "|" "QUESTION-ANSWERED")
             (sequence  "|" "CANCELED")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
(add-to-list 'load-path "~/.emacs.d/org-cua-dwim/")
(require 'org-cua-dwim)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "---REACHED END OF %s ---" (buffer-name))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ; Might be a better hotkey does not work in emacs 24.4
;; ; its missing (org-end-of-meta-data)
;; ; 6/23/2017
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun ap/org-return (&optional ignore)
;;   "Add new list item, heading or table row with RET.
;; A double return on an empty element deletes it. Use a prefix arg 
;; to get regular RET. "
;;   ;; See https://gist.github.com/alphapapa/61c1015f7d1f0d446bc7fd652b7ec4fe and
;;   ;; http://kitchingroup.cheme.cmu.edu/blog/2017/04/09/A-better-return-in-org-mode/
;;   (interactive "P")
;;   (if ignore
;;       (org-return)
;;     (cond ((eq 'link (car (org-element-context)))
;;            ;; Open links like usual
;;            (org-open-at-point-global))
;;           ((and (fboundp 'org-inlinetask-in-task-p) (org-inlinetask-in-task-p))
;;            ;; It doesn't make sense to add headings in inline tasks. Thanks Anders
;;            ;; Johansson!
;;            (org-return))
;;           ((org-at-item-checkbox-p)
;;            ;; Add checkboxes
;;            (org-insert-todo-heading nil))
;;           ((and (org-in-item-p) (not (bolp)))
;;            ;; Lists end with two blank lines, so we need to make sure we are also not
;;            ;; at the beginning of a line to avoid a loop where a new entry gets
;;            ;; created with only one blank line.
;;            (if (org-element-property :contents-begin (org-element-context))
;;                (org-insert-heading)
;;              (beginning-of-line)
;;              (delete-region (line-beginning-position) (line-end-position))
;;              (org-return)))
;;           ((org-at-heading-p)
;;            (if (s-present? (org-element-property :title (org-element-context)))
;;                (progn
;;                  (org-end-of-meta-data)
;;                  (org-insert-heading))
;;              (beginning-of-line)
;;              (delete-region (line-beginning-position) (line-end-position))))
;;           ((org-at-table-p)
;;            (if (--any? (string-empty-p it)
;;                        (nth (- (org-table-current-dline) 1) (org-table-to-lisp)))
;;                (org-return)
;;              ;; Empty row
;;              (beginning-of-line)
;;              (delete-region (line-beginning-position) (line-end-position))
;;              (org-return)))
;;           (t
;;            (org-return)))))

;; (define-key org-mode-map (kbd "RET")   'ap/org-return)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(provide 'my-org-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
