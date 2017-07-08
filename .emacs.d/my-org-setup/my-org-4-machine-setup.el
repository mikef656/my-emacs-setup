;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;; ;Org mode
; This file shourd be unique between home and work machines


;Search Path
;Note no / at the end of the path
;work
(if(eq home-work 'work ) 
(setq org-agenda-files (quote (
			       "~/org"
                               "h:/surecom"
                                "c:/Users/mfitzgerald/Desktop/stuff"
                                "c:/Users/mfitzgerald/Desktop/stuff/Subversion"
                                "c:/Users/mfitzgerald/Desktop/stuff/windows"
			       ))))


;home
(if(eq home-work 'home ) 
(setq org-agenda-files (quote (
			       "~/org"
                                "c:/Users/family/Desktop/stuff/Subversion"
                                "c:/Users/family/Desktop/stuff/windows"
			       ))))


(if(eq home-work 'work ) 
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
       ;
       ("mc"  "Complex" entry (file+headline "~/org/muffins.org" "Logins")
            ;; "* Account Name\: %?\n** Login\:\n** Pass\:\n %i\n** Created On\: %u\n ")
            "* Account Name\: %?\n** Login\:\n** Pass\:\n** PIN:\n** Website: \[\[paste link here]]\n** Comment:\n** Created On\: %u\n\n ")
       ;
       ("j" "Journal" entry (file+datetree "~/org/refile.org")
            "* %?\nEntered on %U\n  %i\n  %a"))))


(if(eq home-work 'home ) 
(setq org-capture-templates
     '(
       ("t" "Todo" entry (file+headline "~/org/refile.org" "Tasks")
            "* TODO %?\n  %i\n  %a")
       ("f" "For Tomarrow" entry (file+headline "~/org/refile.org" "For Tomarrow")
            "* Start this\:%?\nFinish this\:\n  ")
       ;; ("s"  "Surecom Note" entry (file+headline "~/org/refile.org" "Surecom Note")
       ;;      ;; "* Account Name\: %?\n** Login\:\n** Pass\:\n %i\n** Created On\: %u\n ")
       ;;      "* Topic\: %?\n** FPGA\:\n** Other\:\n** Created On\: %u\n\n ")
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
       ;
       ("mc"  "Complex" entry (file+headline "~/org/muffins.org" "Logins")
            ;; "* Account Name\: %?\n** Login\:\n** Pass\:\n %i\n** Created On\: %u\n ")
            "* Account Name\: %?\n** Login\:\n** Pass\:\n** PIN:\n** Website: \[\[paste link here]]\n** Comment:\n** Created On\: %u\n\n ")
       ;
       ("j" "Journal" entry (file+datetree "~/org/refile.org")
            "* %?\nEntered on %U\n  %i\n  %a"))))


;
(provide 'my-org-4-machine-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
