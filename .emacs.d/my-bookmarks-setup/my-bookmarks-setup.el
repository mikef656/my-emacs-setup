;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'bookmark+-lit)
(require 'bookmark+)
;
;http://www.emacswiki.org/emacs/VisibleBookmarks
;added arg (point) to bmkp-toggle-autonamed-bookmark-set/delete
;Note I am using this with Bookmarks+ NOT bm
(global-set-key (kbd "<left-fringe> <mouse-1>") 
 #'(lambda(event)
   (interactive "e")
   (save-excursion
   (mouse-set-point event)
   (bmkp-toggle-autonamed-bookmark-set/delete (point)))))
;

(add-to-list 'load-path "~/.emacs.d/bookmarks-install/")
(load "~/.emacs.d/bookmarks-install/bookmarks-install")
;
;
(when (eq force-bookmarks-bmenu-on-off t)
  (bookmark-bmenu-list)
  (kill-buffer "*Bookmark List*"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key bmkp-jump-map "w" 'bmkp-w32-browser-jump) ; `C-x j w'
(define-key bmkp-jump-map "c" 'sr-checkpoint-restore) ; `C-x j c'
;I have modified this from the regular bookmarks+ binding
;(define-key bmkp-jump-map "a" 'bmkp-non-dir-file-jump) ; `C-x j a' 
(define-key bmkp-jump-map "a" 'bmkp-file-jump) ; `C-x j a' 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-after-load "bookmark+"
 '(progn
    (define-key bookmark-bmenu-mode-map (kbd "M-n") 'nil)
    (define-key bookmark-bmenu-mode-map (kbd "M-r") 'nil)
    (define-key bookmark-bmenu-mode-map (kbd "M-c") 'nil)
    (define-key bookmark-bmenu-mode-map (kbd "M-h") 'nil)
    (define-key bookmark-bmenu-mode-map (kbd "M-g") 'nil)
    (define-key bookmark-bmenu-mode-map (kbd "M-t") 'nil)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-bookmarks-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

