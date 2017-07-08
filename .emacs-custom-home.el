(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(1on1-completions-frame-zoom-font-difference 1)
 '(1on1-default-frame-alist
   (quote
    ((foreground-color . "#dcdccc")
     (background-color . "#3f3f3f")
     (font . "-*-Lucida Console-normal-r-*-*-14-112-96-96-c-*-iso8859-1")
     (mouse-color . "#dcdccc")
     (cursor-color . "yellow")
     (cursor-type . bar)
     (menu-bar-lines . 0)
     (top . 10)
     (left . 10)
     (width . 110)
     (height . 33)
     (minibuffer)
     (user-position . t)
     (icon-type)
     (tool-bar-lines . 0)
     (left-fringe . 0)
     (right-fringe . 0)
     (fringe . 0))))
 '(1on1-default-frame-cursor-color "yellow")
 '(1on1-minibuffer-frame-flag t)
 '(1on1-remap-other-frame-commaned-flag nil)
 '(1on1-special-display-frame-alist
   (quote
    ((font . "-*-Lucida Console-normal-r-*-*-14-112-96-96-c-*-iso8859-1")
     (width . 80)
     (height . 14)
     (mouse-color . "Yellow")
     (cursor-color . "Yellow")
     (menu-bar-lines . 0)
     (foreground-color . "white")
     (background-color . "#3f3f3f")
     (top . 0)
     (left . 0)
     (unsplittable . t)
     (user-position . t))))
 '(ack-and-a-half-executable "\"ack\"")
 '(ack-and-a-half-prompt-for-directory t)
 '(ack-executable "\"/cygdrive/c/Users/family/appdata/roaming/mybin/ack\"")
 '(avy-all-windows (quote all-frames))
 '(avy-keys (quote (97 111 101 117 104 116 110 115 45)))
 '(avy-keys-alist (quote ((avy-copy-line 0))))
 '(avy-style (quote at-full))
 '(avy-timeout-seconds 1)
 '(bmkp-auto-light-when-jump (quote any-bookmark))
 '(bmkp-auto-light-when-set (quote any-bookmark))
 '(bmkp-default-handlers-for-file-types
   (quote
    (("\\.pdf$" . "AcroRd32.exe")
     ("\\.ps$" . "gsview32.exe")
     ("\\.vsd$" . w32-browser)
     ("\\.ppt$" . w32-browser)
     ("\\.doc$" . w32-browser))))
 '(bmkp-last-as-first-bookmark-file "~/my-emacs.bmk")
 '(bmkp-light-left-fringe-bitmap (quote right-arrow))
 '(bmkp-light-style-autonamed (quote lfringe))
 '(bmkp-light-style-non-autonamed (quote lfringe))
 '(bmkp-tags-for-completion
   (quote
    (current
     (bmkfile . "c:/Users/mfitzgerald/AppData/Roaming/scancnrl_src.bmk"))))
 '(bookmark-save-flag nil)
 '(browse-kill-ring-quit-action (quote save-and-restore))
 '(buffer-stack-frame-local nil)
 '(buffer-stack-show-position (quote buffer-stack-show-position-buffers))
 '(buffer-stack-untracked
   (quote
    ("KILL" "*Compile-Log*" "*Compile-Log-Show*" "*Group*" "*Completions*" "*Messages*" "*GNU Emacs*" "*scratch*" "*shell*")))
 '(color-occur-kill-occur-buffer t)
 '(color-theme-history-max-length 64)
 '(column-number-mode t)
 '(cua-delete-copy-to-register-0 nil)
 '(cua-mode t nil (cua-base))
 '(cua-rectangle-mark-key [C-f1])
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "79a3f477ac0cb4a106f78b6109614e991564a5c2467c36e6e854d4bc1102e178" default)))
 '(default-input-method "english-dvorak")
 '(dired-details-invisible-lines
   (quote
    ("total used in directory" "^\\s-*$" "find finished" "find \\." "  wildcard " "Google" "HDI")))
 '(dired-listing-switches "-alogGh")
 '(dired-sort-menu-saved-config
   (quote
    ((dired-actual-switches . "-lagGSh")
     (ls-lisp-ignore-case)
     (ls-lisp-dirs-first . t))))
 '(diredful-init-file "~\\.emacs.d\\diredful\\diredful-conf.el")
 '(doremi-color-themes
   (quote
    (color-theme-aalto-light color-theme-aliceblue color-theme-arjen color-theme-beige-diff color-theme-bharadwaj color-theme-blippblopp color-theme-blue-erc color-theme-blue-gnus color-theme-calm-forest color-theme-charcoal-black color-theme-goldenrod color-theme-gray30 color-theme-late-night color-theme-midnight color-theme-sitaramv-nt color-theme-sitaramv-solaris color-theme-tango color-theme-xemacs color-theme-wheat color-theme-xp)))
 '(ediff-split-window-function (quote split-window-horizontally))
 '(electric-indent-mode nil)
 '(fill-column 80)
 '(fit-frame-crop-end-blank-flag nil)
 '(fit-frame-max-height-percent 82)
 '(fit-frame-max-width-percent 100)
 '(font-lock-maximum-decoration (quote ((verilog-mode . 2) (t . 1) (dired-mode . 1))))
 '(frame-auto-hide-function (quote delete-frame))
 '(icicle-archive-base "http://www.emacswiki.org/emacs/download/")
 '(icicle-default-thing-insertion (quote more-of-the-same))
 '(icicle-default-value (quote t))
 '(icicle-download-dir "~/.emacs.d/icicles")
 '(icicle-expand-input-to-common-match 1)
 '(icicle-files-ido-like-flag nil)
 '(icicle-find-file-expand-directory-flag nil)
 '(icicle-incremental-completion t)
 '(icicle-incremental-completion-flag nil)
 '(icicle-input-string "~/")
 '(icicle-keep-Completions-for-sole-dir (quote update-if-showing))
 '(icicle-minibuffer-key-bindings
   (quote
    (([134217791]
      icicle-minibuffer-help t)
     ([M-S-backspace]
      icicle-erase-minibuffer t)
     ([M-S-delete]
      icicle-erase-minibuffer t)
     ([134217774]
      icicle-insert-string-at-point t)
     ("" icicle-resolve-file-name t)
     ([67108925]
      icicle-insert-string-from-variable t)
     ([134217835]
      icicle-erase-minibuffer-or-history-element t)
     ([134217803]
      icicle-clear-current-history t)
     ([134217839]
      icicle-insert-history-element t)
     ([134217810]
      icicle-multi-inputs-act t)
     ([134217811]
      icicle-multi-inputs-save t)
     ([134217786]
      icicle-pp-eval-expression-in-minibuffer t)
     ("" icicle-beginning-of-line+ t)
     ("" icicle-end-of-line+ t)
     ("" icicle-abort-recursive-edit t)
     ([167772180]
      icicle-top-level t)
     ([134217750]
      icicle-scroll-forward t)
     ([167772182]
      icicle-scroll-backward t)
     ([C-M-pause]
      icicle-other-history t)
     ("
" icicle-insert-newline-in-minibuffer t)
     ([134217753]
      icicle-yank-secondary
      (fboundp
       (quote icicle-yank-secondary)))
     ([134217838]
      my-forward-char nil)
     ([134217746]
      my-hdl-right-syntax-or-subword nil))))
 '(icicle-remove-Completions-when-sole-completion-flag nil)
 '(icicle-remove-Completions-when-sole-dir-flag nil)
 '(icicle-show-Completions-initially-flag nil)
 '(icicle-top-level-key-bindings
   (quote
    (([pause]
      icicle-switch-to/from-minibuffer t)
     ("`" icicle-search-generic t)
     ("$" icicle-search-word t)
     ("^" icicle-search-keywords t)
     ("'" icicle-occur t)
     ("=" icicle-imenu t)
     ("\"" icicle-search-text-property t)
     ([24 134217829]
      icicle-execute-named-keyboard-macro t)
     ("5o" icicle-select-frame t)
     ("" icicle-describe-option-of-type t)
     ([S-f4]
      icicle-kmacro t)
     (abort-recursive-edit icicle-abort-recursive-edit t)
     (bookmark-jump icicle-bookmark t)
     (bookmark-jump-other-window icicle-bookmark-other-window t)
     (bookmark-set icicle-bookmark-cmd t)
     (minibuffer-keyboard-quit icicle-abort-recursive-edit
                               (fboundp
                                (quote minibuffer-keyboard-quit)))
     (delete-window icicle-delete-window t)
     (delete-windows-for icicle-delete-window t)
     (dired icicle-dired t)
     (dired-other-window icicle-dired-other-window t)
     (exchange-point-and-mark icicle-exchange-point-and-mark t)
     (execute-extended-command icicle-execute-extended-command t)
     (find-file icicle-file t)
     (find-file-other-window icicle-file-other-window t)
     (find-file-read-only icicle-find-file-read-only t)
     (find-file-read-only-other-window icicle-find-file-read-only-other-window t)
     (insert-buffer icicle-insert-buffer t)
     (kill-buffer icicle-kill-buffer t)
     (kill-buffer-and-its-windows icicle-kill-buffer t)
     (other-window icicle-other-window-or-frame t)
     (other-window-or-frame icicle-other-window-or-frame t)
     (pop-global-mark icicle-goto-global-marker-or-pop-global-mark t)
     (set-mark-command icicle-goto-marker-or-set-mark-command t)
     (switch-to-buffer icicle-buffer t)
     (switch-to-buffer-other-window icicle-buffer-other-window t)
     (where-is icicle-where-is t)
     (yank icicle-yank-maybe-completing t)
     (yank-pop icicle-yank-pop-commands
               (featurep
                (quote second-sel)))
     (yank-pop-commands icicle-yank-pop-commands
                        (featurep
                         (quote second-sel)))
     ("jtaa" icicle-find-file-tagged
      (featurep
       (quote bookmark+)))
     ("4jtaa" icicle-find-file-tagged-other-window
      (featurep
       (quote bookmark+)))
     (bmkp-autofile-set icicle-bookmark-a-file
                        (fboundp
                         (quote bmkp-bookmark-a-file)))
     (bmkp-tag-a-file icicle-tag-a-file
                      (fboundp
                       (quote bmkp-tag-a-file)))
     (bmkp-untag-a-file icicle-untag-a-file
                        (fboundp
                         (quote bmkp-untag-a-file)))
     (bmkp-find-file-all-tags icicle-find-file-all-tags
                              (fboundp
                               (quote bmkp-find-file-all-tags)))
     (bmkp-find-file-all-tags-other-window icicle-find-file-all-tags-other-window
                                           (fboundp
                                            (quote bmkp-find-file-all-tags)))
     (bmkp-find-file-all-tags-regexp icicle-find-file-all-tags-regexp
                                     (fboundp
                                      (quote bmkp-find-file-all-tags-regexp)))
     (bmkp-find-file-all-tags-regexp-other-window icicle-find-file-all-tags-regexp-other-window
                                                  (fboundp
                                                   (quote bmkp-find-file-all-tags-regexp-other-window)))
     (bmkp-find-file-some-tags icicle-find-file-some-tags
                               (fboundp
                                (quote bmkp-find-file-some-tags)))
     (bmkp-find-file-some-tags-other-window icicle-find-file-some-tags-other-window
                                            (fboundp
                                             (quote bmkp-find-file-some-tags-other-window)))
     (bmkp-find-file-some-tags-regexp icicle-find-file-some-tags-regexp
                                      (fboundp
                                       (quote bmkp-find-file-some-tags-regexp)))
     (bmkp-find-file-some-tags-regexp-other-window icicle-find-file-some-tags-regexp-other-window
                                                   (fboundp
                                                    (quote bmkp-find-file-some-tags-regexp-other-window)))
     (bmkp-autofile-jump icicle-bookmark-autofile
                         (fboundp
                          (quote bmkp-autofile-jump)))
     (bmkp-autofile-jump-other-window icicle-bookmark-autofile-other-window
                                      (fboundp
                                       (quote bmkp-autofile-jump)))
     (bmkp-autonamed-jump icicle-bookmark-autonamed
                          (fboundp
                           (quote bmkp-autonamed-jump)))
     (bmkp-autonamed-jump-other-window icicle-bookmark-autonamed-other-window
                                       (fboundp
                                        (quote bmkp-autonamed-jump)))
     (bmkp-autonamed-this-buffer-jump icicle-bookmark-autonamed-this-buffer
                                      (fboundp
                                       (quote bmkp-autonamed-this-buffer-jump)))
     (bmkp-autonamed-jump-this-buffer-other-window icicle-bookmark-autonamed-this-buffer-other-window
                                                   (fboundp
                                                    (quote bmkp-autonamed-jump-this-buffer-other-window)))
     (bmkp-bookmark-file-jump icicle-bookmark-bookmark-file
                              (fboundp
                               (quote bmkp-bookmark-file-jump)))
     (bmkp-bookmark-list-jump icicle-bookmark-bookmark-list
                              (fboundp
                               (quote bmkp-bookmark-list-jump)))
     (bmkp-desktop-jump icicle-bookmark-desktop
                        (fboundp
                         (quote bmkp-desktop-jump)))
     (bmkp-dired-jump icicle-bookmark-dired
                      (fboundp
                       (quote bmkp-dired-jump)))
     (bmkp-dired-jump-other-window icicle-bookmark-dired-other-window
                                   (fboundp
                                    (quote bmkp-dired-jump)))
     (bmkp-file-jump icicle-bookmark-file
                     (fboundp
                      (quote bmkp-file-jump)))
     (bmkp-file-jump-other-window icicle-bookmark-file-other-window
                                  (fboundp
                                   (quote bmkp-file-jump)))
     (bmkp-file-this-dir-jump icicle-bookmark-file-this-dir
                              (fboundp
                               (quote bmkp-file-this-dir-jump)))
     (bmkp-file-this-dir-jump-other-window icicle-bookmark-file-this-dir-other-window
                                           (fboundp
                                            (quote bmkp-file-this-dir-jump)))
     (bmkp-gnus-jump icicle-bookmark-gnus
                     (fboundp
                      (quote bmkp-gnus-jump)))
     (bmkp-gnus-jump-other-window icicle-bookmark-gnus-other-window
                                  (fboundp
                                   (quote bmkp-gnus-jump)))
     (bmkp-image-jump icicle-bookmark-image
                      (fboundp
                       (quote bmkp-image-jump)))
     (bmkp-image-jump-other-window icicle-bookmark-image-other-window
                                   (fboundp
                                    (quote bmkp-image-jump)))
     (bmkp-info-jump icicle-bookmark-info
                     (fboundp
                      (quote bmkp-info-jump)))
     (bmkp-info-jump-other-window icicle-bookmark-info-other-window
                                  (fboundp
                                   (quote bmkp-info-jump)))
     (bmkp-local-file-jump icicle-bookmark-local-file
                           (fboundp
                            (quote bmkp-local-file-jump)))
     (bmkp-local-file-jump-other-window icicle-bookmark-local-file-other-window
                                        (fboundp
                                         (quote bmkp-local-file-jump)))
     (bmkp-man-jump icicle-bookmark-man
                    (fboundp
                     (quote bmkp-man-jump)))
     (bmkp-man-jump-other-window icicle-bookmark-man-other-window
                                 (fboundp
                                  (quote bmkp-man-jump)))
     (bmkp-non-file-jump icicle-bookmark-non-file
                         (fboundp
                          (quote bmkp-non-file-jump)))
     (bmkp-non-file-jump-other-window icicle-bookmark-non-file-other-window
                                      (fboundp
                                       (quote bmkp-non-file-jump)))
     (bmkp-region-jump icicle-bookmark-region
                       (fboundp
                        (quote bmkp-region-jump)))
     (bmkp-region-jump-other-window icicle-bookmark-region-other-window
                                    (fboundp
                                     (quote bmkp-region-jump)))
     (bmkp-remote-file-jump icicle-bookmark-remote-file
                            (fboundp
                             (quote bmkp-remote-file-jump)))
     (bmkp-remote-file-jump-other-window icicle-bookmark-remote-file-other-window
                                         (fboundp
                                          (quote bmkp-remote-file-jump)))
     (bmkp-specific-buffers-jump icicle-bookmark-specific-buffers
                                 (fboundp
                                  (quote bmkp-specific-buffers-jump)))
     (bmkp-specific-buffers-jump-other-window icicle-bookmark-specific-buffers-other-window
                                              (fboundp
                                               (quote bmkp-specific-buffers-jump)))
     (bmkp-specific-files-jump icicle-bookmark-specific-files
                               (fboundp
                                (quote bmkp-specific-files-jump)))
     (bmkp-specific-files-jump-other-window icicle-bookmark-specific-files-other-window
                                            (fboundp
                                             (quote bmkp-specific-files-jump)))
     (bmkp-temporary-jump icicle-bookmark-temporary
                          (fboundp
                           (quote bmkp-temporary-jump)))
     (bmkp-temporary-jump-other-window icicle-bookmark-temporary-other-window
                                       (fboundp
                                        (quote bmkp-temporary-jump)))
     (bmkp-this-buffer-jump icicle-bookmark-this-buffer
                            (fboundp
                             (quote bmkp-this-buffer-jump)))
     (bmkp-this-buffer-jump-other-window icicle-bookmark-this-buffer-other-window
                                         (fboundp
                                          (quote bmkp-this-buffer-jump)))
     (bmkp-url-jump icicle-bookmark-url
                    (fboundp
                     (quote bmkp-url-jump)))
     (bmkp-url-jump-other-window icicle-bookmark-url-other-window
                                 (fboundp
                                  (quote bmkp-url-jump)))
     (bmkp-w3m-jump icicle-bookmark-w3m
                    (fboundp
                     (quote bmkp-w3m-jump)))
     (bmkp-w3m-jump-other-window icicle-bookmark-w3m-other-window
                                 (fboundp
                                  (quote bmkp-w3m-jump)))
     (bmkp-all-tags-jump icicle-bookmark-all-tags
                         (fboundp
                          (quote bmkp-all-tags-jump)))
     (bmkp-all-tags-jump-other-window icicle-bookmark-all-tags-other-window
                                      (fboundp
                                       (quote bmkp-all-tags-jump)))
     (bmkp-all-tags-regexp-jump icicle-bookmark-all-tags-regexp
                                (fboundp
                                 (quote bmkp-all-tags-regexp-jump)))
     (bmkp-all-tags-regexp-jump-other-window icicle-bookmark-all-tags-regexp-other-window
                                             (fboundp
                                              (quote bmkp-all-tags-regexp-jump)))
     (bmkp-some-tags-jump icicle-bookmark-some-tags
                          (fboundp
                           (quote bmkp-some-tags-jump)))
     (bmkp-some-tags-jump-other-window icicle-bookmark-some-tags-other-window
                                       (fboundp
                                        (quote bmkp-some-tags-jump)))
     (bmkp-some-tags-regexp-jump icicle-bookmark-some-tags-regexp
                                 (fboundp
                                  (quote bmkp-some-tags-regexp-jump)))
     (bmkp-some-tags-regexp-jump-other-window icicle-bookmark-some-tags-regexp-other-window
                                              (fboundp
                                               (quote bmkp-some-tags-regexp-jump)))
     (bmkp-file-all-tags-jump icicle-bookmark-file-all-tags
                              (fboundp
                               (quote bmkp-file-all-tags-jump)))
     (bmkp-file-all-tags-jump-other-window icicle-bookmark-file-all-tags-other-window
                                           (fboundp
                                            (quote bmkp-file-all-tags-jump)))
     (bmkp-file-all-tags-regexp-jump icicle-bookmark-file-all-tags-regexp
                                     (fboundp
                                      (quote bmkp-file-all-tags-regexp-jump)))
     (bmkp-file-all-tags-regexp-jump-other-window icicle-bookmark-file-all-tags-regexp-other-window
                                                  (fboundp
                                                   (quote bmkp-file-all-tags-regexp-jump)))
     (bmkp-file-some-tags-jump icicle-bookmark-file-some-tags
                               (fboundp
                                (quote bmkp-file-some-tags-jump)))
     (bmkp-file-some-tags-jump-other-window icicle-bookmark-file-some-tags-other-window
                                            (fboundp
                                             (quote bmkp-file-some-tags-jump)))
     (bmkp-file-some-tags-regexp-jump icicle-bookmark-file-some-tags-regexp
                                      (fboundp
                                       (quote bmkp-file-some-tags-regexp-jump)))
     (bmkp-file-some-tags-regexp-jump-other-window icicle-bookmark-file-some-tags-regexp-other-window
                                                   (fboundp
                                                    (quote bmkp-file-some-tags-regexp-jump)))
     (bmkp-file-this-dir-all-tags-jump icicle-bookmark-file-this-dir-all-tags
                                       (fboundp
                                        (quote bmkp-file-this-dir-all-tags-jump)))
     (bmkp-file-this-dir-all-tags-jump-other-window icicle-bookmark-file-this-dir-all-tags-other-window
                                                    (fboundp
                                                     (quote bmkp-file-this-dir-all-tags-jump)))
     (bmkp-file-this-dir-all-tags-regexp-jump icicle-bookmark-file-this-dir-all-tags-regexp
                                              (fboundp
                                               (quote bmkp-file-this-dir-all-tags-regexp-jump)))
     (bmkp-file-this-dir-all-tags-regexp-jump-other-window icicle-bookmark-file-this-dir-all-tags-regexp-other-window
                                                           (fboundp
                                                            (quote bmkp-file-this-dir-all-tags-regexp-jump)))
     (bmkp-file-this-dir-some-tags-jump icicle-bookmark-file-this-dir-some-tags
                                        (fboundp
                                         (quote bmkp-file-this-dir-some-tags-jump)))
     (bmkp-file-this-dir-some-tags-jump-other-window icicle-bookmark-file-this-dir-some-tags-other-window
                                                     (fboundp
                                                      (quote bmkp-file-this-dir-some-tags-jump)))
     (bmkp-file-this-dir-some-tags-regexp-jump icicle-bookmark-file-this-dir-some-tags-regexp
                                               (fboundp
                                                (quote bmkp-file-this-dir-some-tags-regexp-jump)))
     (bmkp-file-this-dir-some-tags-regexp-jump-other-window icicle-bookmark-file-this-dir-some-tags-regexp-other-window
                                                            (fboundp
                                                             (quote bmkp-file-this-dir-some-tags-regexp-jump)))
     (find-tag icicle-find-tag
               (fboundp
                (quote command-remapping)))
     (find-tag-other-window icicle-find-first-tag-other-window t)
     (pop-tag-mark icicle-pop-tag-mark
                   (fboundp
                    (quote command-remapping)))
     (eval-expression icicle-pp-eval-expression
                      (fboundp
                       (quote command-remapping)))
     (pp-eval-expression icicle-pp-eval-expression
                         (fboundp
                          (quote command-remapping)))
     ([27 134217848]
      lacarte-execute-command
      (fboundp
       (quote lacarte-execute-command)))
     ([134217824]
      lacarte-execute-menu-command
      (fboundp
       (quote lacarte-execute-menu-command)))
     ([f10]
      lacarte-execute-menu-command
      (fboundp
       (quote lacarte-execute-menu-command))))))
 '(icicle-top-level-when-sole-completion-delay 1.0)
 '(icicle-top-level-when-sole-completion-flag nil)
 '(ido-auto-merge-work-directories-length -1)
 '(ido-create-new-buffer (quote always))
 '(ido-max-prospects 10)
 '(ido-read-file-name-non-ido
   (quote
    (dired-do-copy dired-create-directory dired-copy-file dired-do-create-files dired-rename-file dired-do-rename target-dir file-name-nondirectory expand-file-name dired-one-file dired-dwim-target-directory dired-make-relative dired-get-marked-files dired-do-create-files)))
 '(ido-ubiquitous-command-exceptions (quote (dired-do-copy dired-create-directory)))
 '(ido-ubiquitous-function-exceptions
   (quote
    (dired-do-create-files grep-read-files expand-file-name dired-create-files)))
 '(ido-use-filename-at-point nil)
 '(iedit-toggle-key-default nil)
 '(inhibit-startup-screen t)
 '(isearchp-initiate-edit-commands
   (quote
    (backward-delete-char-untabify backward-char left-char backward-sexp backward-word left-word previous-line next-line del-word-backwards-mike)))
 '(iswitchb-default-method (quote maybe-frame))
 '(iswitchb-use-virtual-buffers t nil (recentf))
 '(log-edit-hook
   (quote
    (log-edit-insert-cvs-template log-edit-insert-changelog)))
 '(minibuffer-auto-raise t)
 '(moccur-grep-default-word-near-point t)
 '(moccur-split-word nil)
 '(mouse-1-click-follows-link t)
 '(org-M-RET-may-split-line (quote ((default))))
 '(org-agenda-files
   (quote
    ("c:/Users/family/Documents/org/Klinghart_video_notes.org" "c:/Users/family/Documents/org/diswasher.org" "c:/Users/family/Documents/org/email.org" "c:/Users/family/Documents/org/home_note.org" "c:/Users/family/Documents/org/insurance-bulit-points.org" "c:/Users/family/Documents/org/insurance-email.org" "c:/Users/family/Documents/org/my-health.org" "c:/Users/family/Documents/org/refile.org" "c:/Users/family/Documents/org/refile_home.org" "c:/Users/family/Documents/org/storm.org" "c:/Users/family/Documents/life/life.org" "c:/Users/family/Desktop/stuff/Subversion/svn_status_codes.org" "c:/Users/family/Desktop/stuff/Subversion/svn_tortice_stuff.org" "c:/Users/family/Desktop/stuff/Subversion/vc-menu.org" "c:/Users/family/Desktop/stuff/emacs/emacs.org" "c:/Users/family/Desktop/stuff/emacs/emacs_master_list.org" "c:/Users/family/Desktop/stuff/emacs/eshell.org" "c:/Users/family/Desktop/stuff/emacs/org.org" "c:/Users/family/Desktop/stuff/emacs/sunrise-stuff.org" "c:/Users/family/Desktop/stuff/emacs/sunrise.org" "c:/Users/family/Desktop/stuff/linux/awk.org" "c:/Users/family/Desktop/stuff/linux/linux.org" "c:/Users/family/Desktop/stuff/linux/zip.org" "c:/Users/family/Desktop/stuff/windows/windows_stuff.org" "c:/Users/family/downloads/email.org")))
 '(org-todo-keywords (quote ((sequence "TODO" "STARTED" "DONE"))))
 '(projectile-completion-system (quote default))
 '(projectile-enable-caching t)
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" ".Xil")))
 '(projectile-indexing-method (quote alien))
 '(projectile-mode t)
 '(reb-re-syntax (quote string))
 '(rebox-min-fill-column 80)
 '(safe-local-variable-values
   (quote
    ((key-port/name-val-cmp/name-dir-type-alist)
     (myvar . "aoeu")
     (eval font-lock-add-keywords nil
           (\`
            (((\,
               (concat "("
                       (regexp-opt
                        (quote
                         ("sp-do-move-op" "sp-do-move-cl" "sp-do-put-op" "sp-do-put-cl" "sp-do-del-op" "sp-do-del-cl"))
                        t)
                       "\\_>"))
              1
              (quote font-lock-variable-name-face)))))
     (require-final-newline . t)
     (mangle-whitespace . t))))
 '(saint/iswitchb-highlight-modes-alist
   (quote
    (("Dired" . 1)
     ("vhdl-mode" . 2)
     ("Fundamental" . 3)
     ("Completions" . 3))))
 '(save-interprogram-paste-before-kill t)
 '(savehist-additional-variables
   (quote
    (sr-history-registry svn-ls-output-as-big-strings-list)))
 '(savehist-file "~\\.emacs.d\\history-home")
 '(search/replace-region-as-default-flag t)
 '(smart-tab-disabled-major-modes (quote (org-mode term-mode vhdl-mode)))
 '(sml/name-width (quote (8 . 32)))
 '(sml/show-frame-identification t)
 '(sml/vc-mode-show-backend t)
 '(solarized-contrast (quote normal))
 '(speedbar-directory-unshown-regexp "^\\(\\..\\)\\'")
 '(tab-width 2)
 '(thing-types
   (quote
    ("word" "line" "paragraph" "sexp" "button" "char" "char-same-line" "comment" "decimal-number" "defun" "email" "filename" "hex-number" "line" "list" "non-nil-symbol-name" "number" "overlay" "page" "paragraph" "region-or-word" "sentence" "string" "symbol" "unquoted-list" "url" "whitespace" "whitespace-&-newlines" "word")))
 '(truncate-lines t)
 '(verilog-indent-level 2)
 '(verilog-indent-level-behavioral 2)
 '(verilog-indent-level-declaration 2)
 '(verilog-indent-level-directive 2)
 '(verilog-indent-level-module 2)
 '(verilog-tab-always-indent nil)
 '(vhdl-basic-offset 3)
 '(vhdl-compiler-alist
   (quote
    (("Cadence Leapfrog" "cv" "-work \\1 -file" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "leapfrog"
      ("duluth: \\*E,[0-9]+ (\\(.+\\),\\([0-9]+\\)):" 1 2 0)
      ("" 0)
      ("\\1/entity" "\\2/\\1" "\\1/configuration" "\\1/package" "\\1/body" downcase))
     ("Cadence NC" "ncvhdl" "-work \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "ncvhdl"
      ("ncvhdl_p: \\*E,\\w+ (\\(.+\\),\\([0-9]+\\)|\\([0-9]+\\)):" 1 2 3)
      ("" 0)
      ("\\1/entity/pc.db" "\\2/\\1/pc.db" "\\1/configuration/pc.db" "\\1/package/pc.db" "\\1/body/pc.db" downcase))
     ("Ikos" "analyze" "-l \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "ikos"
      ("E L\\([0-9]+\\)/C\\([0-9]+\\):" 0 1 2)
      ("^analyze +\\(.+ +\\)*\\(.+\\)$" 2)
      nil)
     ("ModelSim" "vcom" "-93 -work \\1" "make" "-f \\1" nil "vlib \\1; vmap \\2 \\1" "m:/VHDL/fpga_designs/mfitzgerald/my_working_copies/svcont/trunk/sim/" "work/" "Makefile" "modelsim"
      ("\\(ERROR\\|WARNING\\|\\*\\* Error\\|\\*\\* Warning\\)[^:]*: \\(.+\\)(\\([0-9]+\\)):" 2 3 0)
      ("" 0)
      ("\\1/_primary.dat" "\\2/\\1.dat" "\\1/_primary.dat" "\\1/_primary.dat" "\\1/body.dat" downcase))
     ("LEDA ProVHDL" "provhdl" "-w \\1 -f" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "provhdl"
      ("\\([^ 	
]+\\):\\([0-9]+\\): " 1 2 0)
      ("" 0)
      ("ENTI/\\1.vif" "ARCH/\\1-\\2.vif" "CONF/\\1.vif" "PACK/\\1.vif" "BODY/BODY-\\1.vif" upcase))
     ("QuickHDL" "qvhcom" "-work \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "quickhdl"
      ("\\(ERROR\\|WARNING\\)[^:]*: \\(.+\\)(\\([0-9]+\\)):" 2 3 0)
      ("" 0)
      ("\\1/_primary.dat" "\\2/\\1.dat" "\\1/_primary.dat" "\\1/_primary.dat" "\\1/body.dat" downcase))
     ("Savant" "scram" "-publish-cc -design-library-name \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work._savant_lib/" "Makefile" "savant"
      ("\\([^ 	
]+\\):\\([0-9]+\\): " 1 2 0)
      ("" 0)
      ("\\1_entity.vhdl" "\\2_secondary_units._savant_lib/\\2_\\1.vhdl" "\\1_config.vhdl" "\\1_package.vhdl" "\\1_secondary_units._savant_lib/\\1_package_body.vhdl" downcase))
     ("Simili" "vhdlp" "-work \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "simili"
      ("\\(Error\\|Warning\\): \\w+: \\(.+\\): (line \\([0-9]+\\)): " 2 3 0)
      ("" 0)
      ("\\1/prim.var" "\\2/_\\1.var" "\\1/prim.var" "\\1/prim.var" "\\1/_body.var" downcase))
     ("Speedwave" "analyze" "-libfile vsslib.ini -src" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "speedwave"
      ("^ *ERROR[[0-9]+]::File \\(.+\\) Line \\([0-9]+\\):" 1 2 0)
      ("" 0)
      nil)
     ("Synopsys" "vhdlan" "-nc -work \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "synopsys"
      ("\\*\\*Error: vhdlan,[0-9]+ \\(.+\\)(\\([0-9]+\\)):" 1 2 0)
      ("" 0)
      ("\\1.sim" "\\2__\\1.sim" "\\1.sim" "\\1.sim" "\\1__.sim" upcase))
     ("Synopsys Design Compiler" "vhdlan" "-nc -spc -work \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "synopsys_dc"
      ("\\*\\*Error: vhdlan,[0-9]+ \\(.+\\)(\\([0-9]+\\)):" 1 2 0)
      ("" 0)
      ("\\1.syn" "\\2__\\1.syn" "\\1.syn" "\\1.syn" "\\1__.syn" upcase))
     ("Synplify" "n/a" "n/a" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "synplify"
      ("@[EWN]:\"\\(.+\\)\":\\([0-9]+\\):\\([0-9]+\\):" 1 2 3)
      ("" 0)
      nil)
     ("Vantage" "analyze" "-libfile vsslib.ini -src" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "vantage"
      ("\\*\\*Error: LINE \\([0-9]+\\) \\*\\*\\*" 0 1 0)
      ("^ *Compiling \"\\(.+\\)\" " 1)
      nil)
     ("VeriBest" "vc" "vhdl" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "veribest"
      ("^ +\\([0-9]+\\): +[^ ]" 0 1 0)
      ("" 0)
      nil)
     ("Viewlogic" "analyze" "-libfile vsslib.ini -src" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "viewlogic"
      ("\\*\\*Error: LINE \\([0-9]+\\) \\*\\*\\*" 0 1 0)
      ("^ *Compiling \"\\(.+\\)\" " 1)
      nil))))
 '(vhdl-end-comment-column 120)
 '(vhdl-indent-tabs-mode nil)
 '(vhdl-index-menu t)
 '(vhdl-project-auto-load nil)
 '(vhdl-project-file-name (quote ("\\1.my_prj")))
 '(vhdl-source-file-menu t)
 '(vhdl-underscore-is-part-of-word t)
 '(window-min-height 8)
 '(window-min-width 40)
 '(winner-dont-bind-my-keys t)
 '(wrap-region-except-modes (quote (calc-mode dired-mode sr-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(replacep-msg-emphasis ((t (:foreground "hot pink"))))
 '(replacep-msg-emphasis2 ((t (:foreground "light sky blue")))))
