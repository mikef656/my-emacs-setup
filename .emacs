
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/icicles/")
(require 'icicles)
(icy-mode)
(require 'oneonone)
(1on1-emacs)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(1on1-minibuffer-frame-alist
   (quote
    ((foreground-color . "Red")
     (background-color . "LightBlue")
     (font . "-*-Lucida Console-normal-r-*-*-14-*-*-*-c-*-iso8859-1")
     (mouse-color . "Black")
     (cursor-color . "yellow")
     (menu-bar-lines . 0)
     (left . 0)
     (height . 2)
     (icon-type)
     (minibuffer . only)
     (user-position . t)
     (horizontal-scroll-bars)
     (vertical-scroll-bars)
     (name . "Emacs Minibuffer")
     (desktop-dont-save . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
