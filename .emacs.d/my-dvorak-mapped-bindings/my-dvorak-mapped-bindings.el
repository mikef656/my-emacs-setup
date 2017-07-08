; ; experiment don't like so far, giving up for now on replacement during isearch.
; (setq isearch-allow-prefix t)
; (setq isearch-allow-scroll t)


(define-key isearch-mode-map (kbd "C-M-S-<return>") 'isearchp-act-on-demand)

;Drew reversed these, but I like them the original way.
; not this (define-key isearch-mode-map "\M-sw" 'isearchp-kill-ring-save)
(define-key isearch-mode-map "\M-w"  'isearch-toggle-word)


;enable rt hand navigation in mini-buffer during isearch
(define-key isearch-mode-map "\M-R"  'isearch-toggle-regexp)
(define-key isearch-mode-map [(meta g)] 'backward-word)
(define-key isearch-mode-map [(meta r)] 'forward-word)
(define-key isearch-mode-map [(meta n)] 'forward-char)
(define-key isearch-mode-map [(meta h)] 'backward-char)        
(define-key isearch-mode-map "\C-?" 'avy-isearch)

(define-key isearch-mode-map "\C-v" 'isearch-yank-kill)
(define-key isearch-mode-map (kbd "C-S-v") 'isearch-yank-pop)
;
(define-key isearch-mode-map "\C-s" 'isearch-repeat-forward)
(define-key isearch-mode-map "\C-n" 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-S-n") 'isearch-repeat-backward)
(define-key isearch-mode-map [(control shift s )] 'isearch-repeat-backward)
(define-key minibuffer-local-isearch-map [(control shift l )]  'isearch-reverse-exit-minibuffer)
;(define-key isearch-mode-map "\M-t" 'isearch-edit-string)
;; (define-key isearch-mode-map (kbd "C-'") 'isearch-abort)
;; (define-key minibuffer-local-isearch-map "\M-t" 'delete-minibuffer-contents)
(define-key minibuffer-local-isearch-map "\M-t" 'repeat-clr-insert-minib-is)
;(define-key esc-map "\M-t" 'repeat-clr-insert-minib-is)
;; (define-key minibuffer-local-isearch-map "\M-t" 'my-erase-is)
(define-key isearch-mode-map "\M-t" 'my-erase-is)
;;           isearch-message (mapconcat 'isearch-text-char-description
;; (define-key minibuffer-local-isearch-map "\C-n" 'isearch-forward-exit-minibuffer)
(define-key minibuffer-local-isearch-map "\C-s" 'isearch-forward-exit-minibuffer)
(define-key cua--cua-keys-keymap (kbd "M-v") 'nil)
(define-key emacs-lisp-mode-map [(f1)] 'describe-foo-at-point)
(define-key emacs-lisp-mode-map [(control f1)] 'describe-function)
(define-key emacs-lisp-mode-map [(shift f1)] 'describe-variable)
;(define-key minibuffer-local-map (kbd "M-n") 'nil)
;; (define-key dired-mode-map  (kbd "C-g") 'nil)
;; (define-key dired-mode-map  (kbd "C-g") 'isearch-forward)
;http://xahlee.org/emacs/emacs_key-translation-map.html
(define-key key-translation-map (kbd "C-S-k") (kbd "C-S-v"))
;(define-key minibuffer-local-map (kbd "M-n") 'nil)

(when load-my-bookmarks-setup
  (define-key bookmark-bmenu-mode-map (kbd "<f12>") 'bookmark-write)
  (define-key bookmark-bmenu-mode-map "\M-q" 'nil)
  (define-key bookmark-bmenu-mode-map "\M-t" 'nil)
  (define-key bookmark-bmenu-mode-map "\M-c" 'nil)
  (define-key bookmark-bmenu-mode-map "\M-q" 'smex))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(message "Reached the end of my-dvorak-mapped-bindings.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-dvorak-mapped-bindings)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

