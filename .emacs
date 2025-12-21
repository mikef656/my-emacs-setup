;; ----------------------------------------
;; Package management setup (MELPA + NonGNU)
;; ----------------------------------------
(require 'package)
(setq package-archives
      '(("melpa"  . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("gnu"    . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Refresh package contents if not already done
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; ----------------------------------------
;; Enable CUA mode for standard cut/copy/paste
;; ----------------------------------------
(cua-mode t)

;; ----------------------------------------
;; Vertico: Vertical completion interface
;; ----------------------------------------
(use-package vertico
  :init
  (vertico-mode))

;; ----------------------------------------
;; Orderless: Flexible matching style
;; ----------------------------------------
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; ----------------------------------------
;; Marginalia: Adds annotations in the minibuffer
;; ----------------------------------------
(use-package marginalia
  :init
  (marginalia-mode))

;; ----------------------------------------
;; Consult: Enhance completion, search, and navigation
;; ----------------------------------------
(use-package consult
  :bind
  (("C-s" . consult-line)         ;; Search within the current buffer
   ("C-x b" . consult-buffer)     ;; Switch buffers with enhanced UI
   ("C-x C-b" . consult-buffer)   ;; Enhanced buffer list
   ("M-g M-g" . consult-goto-line) ;; Go to line
   ("M-g M-r" . consult-recent-file) ;; Recent file search
   ))

;; ----------------------------------------
;; Modus Themes: Install and configure
;; ----------------------------------------
(use-package modus-themes
  :init
  ;; Load the theme based on your preference (dark or light)
  (load-theme 'modus-operandi t)  ;; Light theme (or use 'modus-vivendi for dark)
  :config
  ;; Customize the theme for better accessibility or personal preferences
  (setq modus-themes-italic-constructs t)  ;; Use italics for constructs like keywords
  (setq modus-themes-bold-constructs t)    ;; Use bold for constructs like functions
  (setq modus-themes-region '(bg-only))    ;; Set region highlight style
  (setq modus-themes-prompts '(bold intense))
  (setq modus-themes-completions 'opposite) ;; Opposite style completions for better contrast
  )

;; ----------------------------------------
;; Save minibuffer history (optional)
;; ----------------

(use-package doom-themes :ensure t)
(use-package dracula-theme :ensure t)
(use-package gruvbox-theme :ensure t)
(use-package zenburn-theme :ensure t)
(use-package solarized-theme :ensure t)
(use-package monokai-theme :ensure t)
(use-package nord-theme :ensure t)
(use-package spacemacs-theme :ensure t)
(setq modus-themes-completions
      '((matches . (intense background))
        (selection . (accented intense))
        (popup . (accented))))

;; ----------------------------------------
;; Theme list to cycle through
;; ----------------------------------------
(defvar my/theme-list
  '(
    ;; Built-in
    modus-operandi
    modus-vivendi
    tango-dark
    tango
    wombat
    leuven

    ;; Doom themes (require doom-themes)
    doom-one
    doom-dracula
    doom-nord
    doom-solarized-dark
    doom-opera-light

    ;; Other popular themes (require install)
    dracula
    gruvbox
    gruvbox-dark-medium
    zenburn
    solarized-dark
    solarized-light
    monokai
    nord
    spacemacs-dark
    spacemacs-light
    )
  "Themes to cycle through.")

(defvar my/current-theme-index 0
  "Current index into `my/theme-list`.")

(defun my/load-theme (theme)
  "Disable all themes and load THEME."
  (interactive)
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t)
  (message "Loaded theme: %s" theme))

(defun my/cycle-theme ()
  "Cycle to the next theme in `my/theme-list`."
  (interactive)
  (setq my/current-theme-index (% (1+ my/current-theme-index) (length my/theme-list)))
  (my/load-theme (nth my/current-theme-index my/theme-list)))

(global-set-key (kbd "C-c t") 'my/cycle-theme)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(spacemacs-theme nord-theme monokai-theme solarized-theme zenburn-theme gruvbox-theme vertico use-package orderless modus-themes marginalia dracula-theme doom-themes consult)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
