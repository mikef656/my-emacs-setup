;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;  FUNCTIONS HERE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;bookmarks_plus stuff
(add-to-list 'load-path "~/.emacs.d/bookmarks_plus/")
(require 'bookmark+-lit)
(require 'bookmark+)
;
;;;   To make it easier to use, assign the commands to some keys.
;;     (global-set-key (kbd "<C-f2>") 'bm-toggle)
;;     (global-set-key (kbd "<M-f2>") 'bm-remove-all-current-buffer)
;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-bookmarks-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

