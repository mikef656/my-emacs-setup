(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(1on1-active-minibuffer-frame-background "#3f3f3f")
 '(1on1-active-mode-line-background "#1e2330")
 '(1on1-completions-frame-background "#3f3f3f")
 '(1on1-completions-frame-zoom-font-difference 2)
 '(1on1-default-frame-alist
   (quote
    ((foreground-color . "white")
     (background-color . "#3f3f3f")
     (font . "DejaVu Sans Mono 13")
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
     (fringe . 0)
     (vertical-scroll-bars))))
 '(1on1-default-frame-cursor-color "yellow")
 '(1on1-help-frame-background "#3f3f3f")
 '(1on1-inactive-minibuffer-frame-background "#3f3f3f")
 '(1on1-inactive-mode-line-background "#2e3330")
 '(1on1-isearch-minibuffer-frame-background "#3f3f3f")
 '(1on1-minibuffer-frame-alist
   (quote
    ((foreground-color . "white")
     (background-color . "#3f3f3f")
     (font . "DejaVu Sans Mono 13")
     (mouse-color . "#dcdccc")
     (cursor-color . "red")
     (menu-bar-lines . 0)
     (left . 0)
     (height . 2)
     (icon-type)
     (minibuffer . only)
     (user-position . t)
     (vertical-scroll-bars)
     (name . "Emacs Minibuffer")
     (desktop-dont-save . t))))
 '(1on1-minibuffer-frame-flag t)
 '(1on1-minibuffer-frame-width-percent 99)
 '(1on1-remap-other-frame-command-flag nil)
 '(1on1-special-display-frame-alist
   (quote
    ((font . "DejaVu Sans Mono 13")
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
     (user-position . t)
     (vertical-scroll-bars))))
 '(ack-and-a-half-prompt-for-directory t)
 '(ack-prompt-for-directory t)
 '(auto-revert-verbose nil)
 '(avy-all-windows t)
 '(avy-keys (quote (97 111 101 117 104 116 110 115 99 114 103 112 46)))
 '(avy-timeout-seconds 1.5)
 '(beacon-blink-when-point-moves-horizontally nil)
 '(beacon-blink-when-point-moves-vertically 3)
 '(beacon-lighter "")
 '(beacon-push-mark nil)
 '(bmkp-auto-light-when-jump (quote any-bookmark))
 '(bmkp-auto-light-when-set (quote any-bookmark))
 '(bmkp-default-handlers-for-file-types
   (quote
    (("\\.pdf$" . "AcroRd32.exe")
     ("\\.ps$" . "gsview32.exe")
     ("\\.vsd$" . w32-browser)
     ("\\.pptx" . w32-browser)
     ("\\.ppt$" . w32-browser)
     ("\\.doc$" . w32-browser)
     ("\\.docx" . w32-browser)
     ("\\.xls" . w32-browser)
     ("\\.xlsx" . w32-browser)
     ("\\.lnk" . w32-browser))))
 '(bmkp-last-as-first-bookmark-file "~/save/lethalotter.bmk")
 '(bmkp-light-left-fringe-bitmap (quote right-arrow))
 '(bmkp-light-style-autonamed (quote lfringe))
 '(bmkp-light-style-non-autonamed (quote lfringe))
 '(bmkp-tags-for-completion
   (quote
    (current
     (bmkfile . "~/save/bmk_current_project.bmk"))))
 '(bookmark-save-flag nil)
 '(browse-kill-ring-quit-action (quote save-and-restore))
 '(buffer-stack-frame-local t)
 '(buffer-stack-show-position (quote buffer-stack-show-position-buffers))
 '(buffer-stack-untracked
   (quote
    ("KILL" "*Compile-Log*" "*Compile-Log-Show*" "*Group*" "*Completions*" "*Messages*" "*GNU Emacs*")))
 '(clearcase-suppress-checkout-comments t)
 '(color-occur-kill-occur-buffer t)
 '(color-theme-history-max-length 64)
 '(column-number-mode t)
 '(company-idle-delay 2.5)
 '(compile-command "ncvlog -SV ")
 '(cua-delete-copy-to-register-0 nil)
 '(cua-mode t nil (cua-base))
 '(cua-rectangle-mark-key [C-f1])
 '(custom-safe-themes
   (quote
    ("d8cec8251169ccfe192aa87d69b9378bc81599330f31498f85deaef633721302" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(debug-on-error t)
 '(default-frame-alist
    (quote
     ((menu-bar-lines . 0)
      (foreground-color . "white")
      (background-color . "#3f3f3f")
      (mouse-color . "#dcdccc")
      (cursor-color . "yellow")
      (cursor-type . bar)
      (top . 10)
      (left . 10)
      (width . 110)
      (height . 33)
      (minibuffer)
      (user-position . t)
      (icon-type)
      (fringe . 0)
      (cursor-color . "yellow")
      (top . 10)
      (left . 10)
      (width . 180)
      (height . 45)
      (font . "DejaVu Sans Mono 13")
      (cursor-type . bar)
      (minibuffer)
      (user-position . t)
      (icon-type)
      (fringe . 0)
      (background-color . "#3f3f3f")
      (background-mode . dark)
      (border-color . "#3f3f3f")
      (foreground-color . "white")
      (mouse-color . "#dcdccc")
      (left-fringe . 0)
      (right-fringe . 0))))
 '(default-input-method "english-dvorak")
 '(diff-hl-margin-mode t)
 '(dired-details-invisible-lines
   (quote
    ("total used in directory" "^\\s-*$" "find finished" "find \\." "  wildcard " "Google" "HDI")))
 '(dired-listing-switches "-alogGh")
 '(dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|\\.svn")
 '(dired-sort-menu-saved-config
   (quote
    ((dired-actual-switches . "-lagGSh")
     (ls-lisp-ignore-case)
     (ls-lisp-dirs-first . t))))
 '(diredful-init-file "~/.emacs.d/diredful/diredful-conf.el")
 '(doremi-color-themes
   (quote
    (color-theme-aalto-light color-theme-aliceblue color-theme-arjen color-theme-beige-diff color-theme-bharadwaj color-theme-blippblopp color-theme-blue-erc color-theme-blue-gnus color-theme-calm-forest color-theme-charcoal-black color-theme-goldenrod color-theme-gray30 color-theme-late-night color-theme-midnight color-theme-sitaramv-nt color-theme-sitaramv-solaris color-theme-tango color-theme-xemacs color-theme-wheat color-theme-xp)))
 '(ediff-split-window-function (quote split-window-horizontally))
 '(electric-indent-mode nil)
 '(fill-column 100)
 '(fit-frame-crop-end-blank-flag t)
 '(fit-frame-max-height-percent 87)
 '(fit-frame-max-width 120)
 '(fit-frame-max-width-percent 100)
 '(font-lock-maximum-decoration (quote ((verilog-mode . 2) (t . 1))))
 '(frame-auto-hide-function (quote delete-frame))
 '(global-company-mode t)
 '(ibuffer-formats
   (quote
    ((mark modified read-only " "
	   (name 25 25 :left :elide)
	   " "
	   (size 9 -1 :right)
	   " "
	   (mode 16 16 :left :elide)
	   " " filename-and-process)
     (mark " "
	   (name 16 -1)
	   " " filename))))
 '(icicle-Completions-max-columns 1)
 '(icicle-apropos-complete-no-display-keys
   (quote
    ([C-M-S-tab]
     [C-M-S-iso-lefttab]
     [(control shift tab)])))
 '(icicle-default-thing-insertion (quote more-of-the-same))
 '(icicle-default-value t)
 '(icicle-download-dir "~/.emacs.d/icicles")
 '(icicle-expand-input-to-common-match 1)
 '(icicle-expand-input-to-common-match-alt 4)
 '(icicle-files-ido-like-flag nil)
 '(icicle-find-file-expand-directory-flag nil)
 '(icicle-incremental-completion t)
 '(icicle-incremental-completion-flag nil)
 '(icicle-input-string "~/")
 '(icicle-keep-Completions-for-sole-dir (quote update-if-showing))
 '(icicle-remove-Completions-when-sole-dir-flag nil)
 '(icicle-saved-completion-sets
   (quote
    (("my_set_experiment.txt" . "m:/VHDL/fpga_designs/mfitzgerald/my_working_copies/scst2va_fpga/ptst/trunk/my_set_experiment.txt.icy")
     ("my_icicle_set" . "c:/Users/mfitzgerald/AppData/Roaming/my_first_file_cache.txt")
     ("temp.txt" . "c:/Users/mfitzgerald/AppData/Roaming/temp.txt.icy"))))
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
     (" " icicle-command-abbrev t)
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
 '(ido-create-new-buffer (quote always))
 '(ido-read-file-name-non-ido
   (quote
    (dired-do-copy dired-create-directory dired-copy-file dired-do-create-files dired-rename-file dired-do-rename target-dir file-name-nondirectory expand-file-name dired-one-file dired-dwim-target-directory dired-make-relative dired-get-marked-files dired-do-create-files)))
 '(ido-ubiquitous-command-exceptions (quote (dired-do-copy dired-create-directory)))
 '(ido-ubiquitous-function-exceptions
   (quote
    (dired-do-create-files grep-read-files expand-file-name dired-create-files)))
 '(ido-use-filename-at-point nil)
 '(isearchp-deactivate-region-flag nil)
 '(isearchp-highlight-regexp-group-levels-flag nil)
 '(isearchp-initiate-edit-commands
   (quote
    (backward-delete-char-untabify backward-char left-char backward-sexp backward-word left-word previous-line next-line del-word-backwards-mike up)))
 '(isearchp-set-region-flag nil)
 '(iswitchb-default-method (quote maybe-frame))
 '(iswitchb-use-virtual-buffers t nil (recentf))
 '(max-lisp-eval-depth 600)
 '(menu-bar-mode nil)
 '(minibuffer-auto-raise t)
 '(moccur-grep-default-word-near-point t)
 '(moccur-split-word nil)
 '(mouse-1-click-follows-link t)
 '(mouse-drag-copy-region t)
 '(mouse-yank-at-point t)
 '(org-M-RET-may-split-line (quote ((default))))
 '(org-todo-keywords (quote ((sequence "TODO" "STARTED" "DONE"))))
 '(peep-dired-ignored-extensions
   (quote
    ("mkv" "iso" "mp4" "exe" "bin" "so" "dcp" "mcs" "bit")))
 '(projectile-completion-system (quote default))
 '(projectile-enable-caching t)
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" ".Xil")))
 '(projectile-indexing-method (quote alien))
 '(projectile-mode nil)
 '(reb-re-syntax (quote string))
 '(rebox-min-fill-column 80)
 '(saint/iswitchb-highlight-modes-alist
   (quote
    (("Dired" . 1)
     ("vhdl-mode" . 2)
     ("Fundamental" . 3)
     ("Completions" . 3))))
 '(save-interprogram-paste-before-kill t)
 '(savehist-additional-variables
   (quote
    (sr-history-registry urls-cached svn-ls-output-as-big-strings-list filesets-data)))
 '(savehist-file "~/.emacs.d/history_work.txt")
 '(search/replace-region-as-default-flag t)
 '(shell-file-name "/bin/tcsh")
 '(smart-tab-disabled-major-modes (quote (org-mode term-mode vhdl-mode)))
 '(sml/name-width (quote (12 . 40)))
 '(sml/shorten-directory t)
 '(sml/vc-mode-show-backend t)
 '(solarized-contrast (quote normal))
 '(sr-tabs-max-tabsize 20)
 '(tab-width 3)
 '(thing-types
   (quote
    ("word" "line" "paragraph" "sexp" "button" "char" "char-same-line" "comment" "decimal-number" "defun" "email" "filename" "hex-number" "line" "list" "non-nil-symbol-name" "number" "overlay" "page" "paragraph" "region-or-word" "sentence" "string" "symbol" "unquoted-list" "url" "whitespace" "whitespace-&-newlines" "word")))
 '(truncate-lines t)
 '(uniquify-min-dir-content 0)
 '(uniquify-separator ":")
 '(uniquify-strip-common-suffix nil)
 '(verilog-auto-indent-on-newline nil)
 '(verilog-auto-newline nil)
 '(verilog-compiler "ncvlog -SV")
 '(verilog-indent-begin-after-if t)
 '(verilog-indent-level 2)
 '(verilog-indent-level-behavioral 2)
 '(verilog-indent-level-declaration 2)
 '(verilog-indent-level-directive 2)
 '(verilog-indent-level-module 2)
 '(verilog-tab-always-indent nil)
 '(verilog-tab-always-indent nil)
 '(vhdl-basic-offset 3)
 '(window-min-height 8)
 '(winner-dont-bind-my-keys t)
 '(wrap-region-except-modes (quote (calc-mode dired-mode sr-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-jump-face-foreground ((t (:foreground "yellow" :weight ultra-bold))))
 '(aw-leading-char-face ((t (:background "white" :foreground "red"))))
 '(bmkp-heading ((t (:foreground "azure1"))))
 '(bmkp-local-directory ((t (:background "#4c7073" :foreground "#dcdccc"))))
 '(bmkp-local-file-without-region ((t (:foreground "#dcdccc"))))
 '(bmkp-non-file ((t (:background "dark green" :foreground "white"))))
 '(bmkp-t-mark ((t (:foreground "medium spring green"))))
 '(ediff-current-diff-B ((t (:background "#3f3f4d"))))
 '(ediff-fine-diff-B ((t (:background "#3f3fCA"))))
 '(lazy-highlight ((t (:inherit isearch))))
 '(mode-line ((t (:background "#1e2320" :foreground "#acbc90" :inverse-video nil :box (:line-width 2 :color "#1e2320") :height 1.0 :width normal))))
 '(replacep-msg-emphasis ((t (:foreground "yellow"))))
 '(replacep-msg-emphasis2 ((t (:foreground "green"))))
 '(sml/filename ((t (:inherit sml/global :foreground "gold" :weight bold))))
 '(sml/folder ((t (:inherit sml/global :background "gray20" :foreground "gold3" :weight normal))))
 '(sml/modes ((t (:foreground "light slate gray"))))
 '(sml/position-percentage ((t (:foreground "light slate gray"))))
 '(sml/vc ((t (:foreground "medium spring green"))))
 '(sml/vc-edited ((t (:foreground "indian red")))))
