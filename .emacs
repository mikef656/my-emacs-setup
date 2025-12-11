;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

; load custom file
(setq custom-file "~/.emacs-custom-icicles-only.el")
(load-file custom-file)

(add-to-list 'load-path "~/.emacs.d/icicles/")
(require 'icicles nil t)
(when (fboundp 'icicle-mode) (icicle-mode 1)) ; Defined in `icicles.el'.

