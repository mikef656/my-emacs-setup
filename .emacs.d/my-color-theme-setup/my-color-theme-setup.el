;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;choose your color-theme theme by issuing M-x color-theme-<TAB> RET
;Add a new theme by copying my-theme-name.el file to the 
;   "~/.emacs.d/color-theme-6.6.0/themes folder
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   "~/.emacs.d/color-theme-6.6.0/themes folder
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/themes/emacs-color-theme-solarized/")
;(require 'color-theme-solarized)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;add some new colors to emecs standard colors
;zenburn-bg "#3f3f3f


;remove for linux?
  ;(setq w32-color-map   (cons '("my-zenburn-bgd" . 4144959) w32-color-map))
  ;;          this number is the dec equivelint of 2e3436
  ;(setq w32-color-map   (cons '("my-tango-bgd" . 3028022) w32-color-map))


;
;my-background is used by 
;   1on1-isearch-minibuffer-frame-background
;   1on1-completions-frame-background
;   1on1-active-minibuffer-frame-background
;   1on1-help-frame-background
;
;default-frame-alist
(cond 
   ((eq my-color-theme 'zenburn)
      (add-to-list 'default-frame-alist '(background-color . "#3f3f3f"))
      (setq my-background "#3f3f3f")
   )
   ((eq  my-color-theme 'tango)
      (add-to-list 'default-frame-alist '(background-color . "my-tango-bgd"))
      (setq my-background "#2e3436")
   )
   (t message "background-color non specified"))
;(add-to-list 'default-frame-alist '(foreground-color . "white"))
;decimate(add-to-list 'default-frame-alist '(background-mode . "dark"))
;
;
;minibuffer-frame-alist
(cond 
   ((eq my-color-theme 'zenburn)
      (add-to-list 'minibuffer-frame-alist '(background-color . "#3f3f3f"))
   )
   ((eq  my-color-theme 'tango)
   (add-to-list 'minibuffer-frame-alist '(background-color . "my-tango-bgd"))
   )
   (t message "minibuffer background-color non specified"))
;4-4-2014 rev 1748 (add-to-list 'minibuffer-frame-alist '(foreground-color . "white"))
;4-4-2014 rev 1748 decimate (add-to-list 'minibuffer-frame-alist '(background-mode . "dark"))
;
;
;special-display-frame-alist
;Used for frames nomed by special-display-regexps like *occur*
(cond 
   ((eq my-color-theme 'zenburn)
      (add-to-list 'special-display-frame-alist '(background-color . "#3f3f3f"))
   )
   ((eq  my-color-theme 'tango)
      (add-to-list 'special-display-frame-alist '(background-color . "my-tango-bgd"))
   )
   (t message "minibuffer background-color non specified"))
;decimate 4-4-2014 rev 1748 (add-to-list 'special-display-frame-alist '(foreground-color . "white"))
;decimate 4-4-2014 rev 1748 (add-to-list 'special-display-frame-alist '(background-mode . "dark"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (cond 
        ((eq my-color-theme 'zenburn) (color-theme-zenburn))
        ((eq my-color-theme 'tango) (color-theme-tango))
        ((eq my-color-theme 'blackboard) (color-theme-blackboard))
        ((eq my-color-theme 'calm-forest) (color-theme-calm-forest))
        ((eq my-color-theme 'solarized-light) (color-theme-solarized-light))
        ((eq my-color-theme 'alto-light) (color-theme-alto-light))
        (t (color-theme-tango) (message "no color theme specified"))q )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
;(color-theme-clarity)
;(color-theme-calm-forest)
;;
;for darker backgroungs
;(progn
   ;;  I hacked the color theme file for this one (set-face-foreground 'minibuffer-prompt "white"))
;
;for light backgrounds
;; (progn 
;
;
;; (progn
;;   (color-theme-zenburn) 
;(set-background-color "#ffffff")
;
;; ))
    ;;I hacked the color theme lib file for this one (set-face-foreground 'minibuffer-prompt "blue")
     ;(add-to-list 'minibuffer-frame-alist '(background-color . "#3f3f3f"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-color-theme-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
