;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(add-to-list 'load-path "~/.emacs.d/iswitchb/")
(add-to-list 'load-path "~/.emacs.d/icicles/")    
(when (eq load-icicles-iswitchb t)
  (require 'icicles-iswitchb))
;
(iswitchb-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    '(
      ("<right>" . iswitchb-next-match)
      ( "M-n" . iswitchb-next-match)
      ( "M-h" . iswitchb-prev-match)
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end of my-iswitchb-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-iswitchb-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



