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
                      ("opportunity" . ?p) 
                      ))
; If the tag is only relevant to the file you are working on, then you
; can instead set the TAGS option line as:
;      #+TAGS: @work(w)  @home(h)  @tennisclub(t)  laptop(l)  pc(p)


;; flyspell mode for spell checking everywhere
; irritating 4 tech work (add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'turn-on-auto-fill)



(add-to-list 'load-path (expand-file-name "~/.emacs.d/org-7.8.11/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/org-7.8.11/contrib/lisp"))

;; (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))

(setq org-fontify-emphasized-text t)

;a bunch of defuns and modes related to org are loaded
(require 'org-install)

;This may not be necessary
(require 'org-capture)


(define-key org-mode-map "\C-cl" 'org-store-link)
(define-key org-mode-map "\C-ca" 'org-agenda)
(define-key org-mode-map "\C-ct" 'org-set-tags-command)


(setq org-log-done t)

;Search Path
;Note no / at the end of the path
(setq org-agenda-files (quote (
			       "~/org"
                               "h:/surecom"
                                "c:/Users/mfitzgerald/Desktop/stuff/Subversion"
                                "c:/Users/mfitzgerald/Desktop/stuff/windows"
			       )))

;
;This is how to point to multiple folders
;; (setq org-agenda-files (quote ("~/git/org"
;;                                "~/git/org/client1"
;;                                "~/git/org/bzflag"
;;                                "~/git/client2")))


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
            "* %?\nEntered on %U\n  %i\n  %a")))


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


(define-key org-mode-map [(meta h)] 'nil)
(define-key org-mode-map [(meta c)] 'nil)
(define-key org-mode-map [(meta n)] 'nil)
(define-key org-mode-map [(meta t)] 'nil)
(define-key org-mode-map [(meta e)] 'nil)
(define-key org-mode-map [(control tab )] 'nil)
(define-key org-mode-map [(control z )] 'nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
(add-to-list 'load-path "~/.emacs.d/org-cua-dwim/")
(require 'org-cua-dwim)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(provide 'my-org-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
