;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;  FUNCTIONS HERE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Browser!
;install cygwin wm3
;download the emacs-w3m from tar.gz to C:/Users/mfitzgerald/Downloads/w3m
;from a dos prompt it there run
   ;C:\Users\mfitzgerald\Downloads
;\w3m\emacs-w3m-1.4.4>
;C:\Users\mfitzgerald\Downloads\EMACS\emacs-23.4\bin\emacs.exe
; -batch -q -no-site-file -l w3mhack.el //c/share/apel://c/share/flim 
; -f w3mhack-nonunix-install
;
;
 (add-to-list 'load-path "C:/Users/mfitzgerald/Downloads/w3m/emacs-w3m-1.4.4/")
 (require 'w3m-load)
 ;these two seem to fix issues with emacs 23
 (require 'w3m-e21)
 (provide 'w3m-e23)
 ;gmail needs this
 (setq w3m-use-cookies t)

;https://mail.google.com/mail/?nocheckbrowser&shva=1#inbox
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-wm3-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

