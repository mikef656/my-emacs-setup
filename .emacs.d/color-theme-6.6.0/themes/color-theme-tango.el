;;; Color theme based on Tango Palette. Created by danranx@gmail.com
(defun color-theme-tango ()
  "A color theme based on Tango Palette."
  (interactive)
  (color-theme-install
   '(color-theme-tango
     ((background-color . "#2e3436")
      (background-mode . dark)
      ;; (border-color . "#888a85")
      (border-color . "black")
      (cursor-color . "#fce94f")
      (foreground-color . "#eeeeec")
      (mouse-color . "#8ae234"))
     ;
     ((help-highlight-face . underline)
      (ibuffer-dired-buffer-face . font-lock-function-name-face)
      (ibuffer-help-buffer-face . font-lock-comment-face)
      (ibuffer-hidden-buffer-face . font-lock-warning-face)
      (ibuffer-occur-match-face . font-lock-warning-face)
      (ibuffer-read-only-buffer-face . font-lock-type-face)
      (ibuffer-special-buffer-face . font-lock-keyword-face)
      (ibuffer-title-face . font-lock-type-face))
     ;
     ;default seems to determine if onenonone can detirmine dark correctly
     (default ((t (:background "#2e3436" :foreground "#F8F8F8")))) 
     ;
     (border ((t (:background "#888a85"))))
     ;
     (border-glyph ((t (nil))))
     ;
     (fringe ((t (:background "grey10"))))
     ;; (highlight ((t (:background "RoyalBlue1"))))     
     (highlight ((t (:background "#69D40A460000"))))     ;redish brown
     (mode-line ((t (:background "grey75" :foreground "black"))))     
     ;(mode-line ((t (:foreground "#eeeeec" :background "#555753"))))
     (region ((t (:background "#555753"))))
     (font-lock-builtin-face ((t (:foreground "#729fcf"))))
     (font-lock-comment-face ((t (:foreground "#888a85"))))
     (font-lock-constant-face ((t (:foreground "#8ae234"))))
     (font-lock-doc-face ((t (:foreground "#888a85"))))
     (font-lock-keyword-face ((t (:foreground "#729fcf" :bold t))))
     (font-lock-string-face ((t (:foreground "#ad7fa8" :italic t))))
     (font-lock-type-face ((t (:foreground "#8ae234" :bold t))))
     (font-lock-variable-name-face ((t (:foreground "#eeeeec"))))
     (font-lock-warning-face ((t (:bold t :foreground "#f57900"))))
     (font-lock-function-name-face ((t (:foreground "#edd400" :bold t :italic t))))
     (comint-highlight-input ((t (:italic t :bold t))))
     (comint-highlight-prompt ((t (:foreground "#8ae234"))))
     (isearch ((t (:background "#f57900" :foreground "#2e3436"))))
     (isearch-lazy-highlight-face ((t (:foreground "#2e3436" :background "#e9b96e"))))
     (link ((t (:foreground "gold1" :underline t :weight bold))))
     (show-paren-match-face ((t (:foreground "#2e3436" :background "#73d216"))))
     (show-paren-mismatch-face ((t (:background "#ad7fa8" :foreground "#2e3436"))))
     (minibuffer-prompt ((t (:foreground "#729fcf" :bold t))))
     (info-xref ((t (:foreground "#729fcf"))))
     (info-xref-visited ((t (:foreground "#ad7fa8"))))

    
 ))

     (setq 1on1-*Help*-frame-flag t);black text on black background when t
     ;(setq 1on1-*Completions*-frame-flag nil);goofy blue background went nil
     ;
     (setq 1on1-help-frame-background "#2e3436")
     (setq set-oneonone-faces-myself t)
     ; 
     (setq 1on1-default-special-frame-foreground "white")
     ;   
     (setq 1on1-active-minibuffer-frame-background "#2e3436")
     ;
     (setq 1on1-active-mode-line-background "gray80")
     (setq 1on1-inactive-mode-line-background "Gray50")
     ;(setq 1on1-inactive-mode-line-background "blue")
     ; 
     (setq 1on1-completions-frame-background "#2e3436")
     (setq 1on1-isearch-minibuffer-frame-background "#2e3436")
     ;; (setq 1on1-default-frame-cursor-color "yellow")
     (setq 1on1-default-frame-cursor-color "red")

)

(provide 'color-theme-tango)
