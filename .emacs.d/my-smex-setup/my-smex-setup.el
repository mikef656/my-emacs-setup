;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;  FUNCTIONS HERE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;smex
;;Doc at:
;;https://github.com/nonsequitur/smex/blob/master/README.markdown
;; C-h f, while Smex is active, runs describe-function on  selected command.
;; M-. jumps to the definition of the selected command.
(add-to-list 'load-path "~/.emacs.d/smex/")
(require 'smex)
(smex-initialize)  
(setq smex-show-unbound-commands t)
(smex-auto-update 30)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://oremacs.com/2015/01/25/exploring-emacs-packages/
(defun smex-prepare-ido-bindings ()
  (interactive)
  (define-key ido-completion-map
      (kbd "C-w") 'smex-where-is)
  ;    
  (define-key ido-completion-map
      (kbd "C-a") 'move-beginning-of-line)
  ;
  (define-key ido-completion-map "\M-n" 'ido-next-match)
  (define-key ido-completion-map "\M-h" 'ido-prev-match))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  
;tried this did not like, just sort them how I type then by most recently used
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Filters ido-matches setting acronynm matches in front of the results
;; ;http://www.emacswiki.org/emacs/Smex
;; (defadvice ido-set-matches-1 (after ido-acronym-matches activate)
;;   (if (> (length ido-text) 1)
;;       (let ((regex (concat "^" (mapconcat 'char-to-string ido-text "[^-]*-")))
;;             (acronym-matches (list))
;;             (remove-regexes '("-menu-")))
;;         ;; Creating the list of the results to be set as first
;;         (dolist (item items)
;;           (if (string-match (concat regex "[^-]*$") item) ;; strict match
;;               (add-to-list 'acronym-matches item)
;;             (if (string-match regex item) ;; appending relaxed match
;;                 (add-to-list 'acronym-matches item t))))
;
;;         ;; Filtering ad-return-value
;;         (dolist (to_remove remove-regexes)
;;           (setq ad-return-value
;;                 (delete-if (lambda (item)
;;                              (string-match to_remove item))
;;                            ad-return-value)))
;
;;         ;; Creating resulting list
;;         (setq ad-return-value
;;               (append acronym-matches
;;                       ad-return-value))
;
;;         (delete-dups ad-return-value)
;;         (reverse ad-return-value))))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached the end of my-smex-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-smex-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

