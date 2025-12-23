(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

;; What does
;; (setq use-package-always-ensure t)
;; do?
;; (setq use-package-always-ensure t) tells use-package to automatically
;; install packages for you if they are not already installed.
;; When I say “install” in the context of
;; (setq use-package-always-ensure t)
;; I mean something very specific and concrete in Emacs terms.
;; What “install” means in Emacs
;; Installing a package means:
;; Emacs downloads the package from a package archive
;; (GNU ELPA, MELPA, etc.)
;; Emacs unpacks it into your local package directory
;; Emacs registers it so it can be loaded later
;; (setq use-package-always-ensure t)

(cua-mode 1)
(electric-indent-mode -1)

;; Magit
(use-package magit
  :commands (magit-status magit-dispatch)
  :bind (("C-x g" . magit-status))
  :config
  ;; Use a full-frame status buffer
  (setq magit-display-buffer-function
        #'magit-display-buffer-fullframe-status-v1)
  ;; Automatically refresh Magit buffers
  (setq magit-refresh-status-buffer t))

;; What this tells Emacs
;; “The user has explicitly chosen the packages magit and zygospore.”
;; This variable is maintained automatically by Emacs’s Customize / package system.
;; What package-selected-packages is used for
;; Emacs uses this list to:
;; Track which packages you intentionally installed
;; Know which packages are dependencies only
;; Decide what can be removed by:
;; M-x package-autoremove
;; So:
;; magit → explicitly selected
;; zygospore → explicitly selected
;; Any dependencies of those packages are not listed here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit zygospore)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
