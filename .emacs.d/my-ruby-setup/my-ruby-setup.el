;rdebug cheat
;https://gist.github.com/mcrmfc/962462
;http://pivotallabs.com/ruby-debug-in-30-seconds-we-don-t-need-no-stinkin-gui/
;http://bashdb.sourceforge.net/ruby-debug.html
;
;Note some useful programs;
;c:/xxx/AppData/Roaming/mybin/my_conv_to_hex.rb
;take file std in, call them from emacs shell-command-on-region.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;get rid if this binding C-M-f runs the command ruby-forward-sexp,
;(message "reached before load-ruby-helpers")
(when  load-ruby-helpers
  (add-to-list 'load-path "~/.emacs.d/inf-ruby")
  (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
  (autoload 'inf-ruby-setup-keybindings "inf-ruby" "" t)
  (eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook 'inf-ruby-setup-keybindings))
  ;
  (add-hook 'ruby-mode-hook
   (lambda ()
   (scroll-bar-mode -1)
   (company-mode 1)
   ;add @ to the definition of a word in Ruby mode.
   (modify-syntax-entry ?@ "w")
   (modify-syntax-entry ?@ "_")
   (define-key ruby-mode-map (kbd "C-M-f") 'nil)
   (define-key ruby-mode-map (kbd "C-M-b") 'nil)
   (define-key ruby-mode-map [(control meta r)] 'my-hdl-right-syntax-or-subword)
   (define-key ruby-mode-map [(control meta g)] 'my-hdl-left-syntax-or-subword))
   ;this is an experiment using ethan-wspace
   (when load-ethan-wspace
     (setq require-final-newline nil)
     (setq mode-require-final-newline nil)))
  ;
  (add-hook 'inf-ruby-mode-hook
   (lambda ()
   (define-key inf-ruby-mode-map (kbd "M-t") 'nil)
   (define-key inf-ruby-mode-map (kbd "M-n") 'nil)
   (define-key inf-ruby-mode-map (kbd "M-h") 'nil)
   (define-key inf-ruby-mode-map (kbd "M-c") 'nil)
   (define-key inf-ruby-mode-map (kbd "M-r") 'nil)
   (define-key inf-ruby-mode-map (kbd "M-g") 'nil))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;attempt at getting enh-ruby going
;ran into several issues
;- It needs the ./ruby folder with a couple of files
;- Forward subexpression goes to the end of the file and trys to go fwd forever
;- With full .emacs config gives errors when opening a .rb file
(when load-enh-ruby
  (add-to-list 'load-path "~/.emacs.d/erm")
  (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
  (add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
  (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode)))
  ;; (setq enh-ruby-program "C:/Ruby193/bin/ruby.exe"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;have issues with the emacs interface to ruby-debug hanging or not responding.
(when load-ruby-debug
  (add-to-list 'load-path "~/.emacs.d/rdebug/emacs/")
  (add-to-list 'load-path "~/.emacs.d/ruby-debug-extra")
  ;these look redundant
  (require 'rdebug)
  (autoload 'rdebug "rdebug" "ruby-debug interface" t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when load-hrb-mode
(add-to-list 'load-path "~/emacs.d/hrb-mode")
(require 'hrb-mode)

;; show region immediately
(setq hrb-delay 0)

;; set different face for highlighting keywords
(setq hrb-highlight-keyword-face 'show-paren-match-face)

;; set different face for highlighting block
(setq hrb-highlight-block-face 'highlight)

;; highlight only keywords
(setq hrb-highlight-mode 'keywords)

;; highlight complete block
(setq hrb-highlight-mode 'complete)

;; highlight keywords if both are visible, highlight complete block otherwise
(setq hrb-highlight-mode 'mixed)

;; enable hrb-mode
(hrb-mode t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached the end of my-ruby-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-ruby-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
