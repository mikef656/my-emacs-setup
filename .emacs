;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; global minor mode or bindkey for keymap
;https://emacs.stackexchange.com/
;questions/352/how-to-override-major-mode-bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Sidebar integrates with projectile and GIT                                                          
;  https://github.com/sebastiencs/sidebar.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Project Explorer integrates with projectile                                                          
;  https://github.com/sabof/project-explorer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Control of poped up frames                                                          
;  https://github.com/wasamasa/shackle                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Looks interesting, 5/8/2017
;   Going to the end of special buffers
;      http://irreal.org/blog/?p=6194
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; hydra for navigation
; http://kitchingroup.cheme.cmu.edu/blog/2015/09/27/Upping-my-Emacs-navigation-game/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ----- GLOBAL MAP -----
; C-M-S-v runs the command scroll-other-window-down
; C-M-v runs the command scroll-other-window
; ----- PEEP-DIRED -----
; <SPC>          'peep-dired-scroll-page-down
; C-<SPC>        'peep-dired-scroll-page-up
; <backspace>    'peep-dired-scroll-page-up
; ----- DIRED+ -----
; space       currently move cursor down 
; shift space currently move cursor down 
; backspace   currently move cursor up
; ----- SR -----
; Space       sr-scroll-quick-view)
; Shift space sr-scroll-quick-view-down
; Meta        sr-scroll-quick-view-down
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a workspaces library, interesting
; https://github.com/seudut/perspeen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this looks neat for showing the remaining of a key bind sequence
;https://github.com/justbur/emacs-which-key
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Load clearcase after emacs startup, it running some anoying thing that
; takes 10 sec or so.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First frame knowledge
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; reddit.com/r/emacs/comments/5hldn5/identifying_the_initial_frame/?st=iwpbw5p9&sh=f64c7ab4
; this might help in the case where I was trying to get SR launch at startup.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;This is cool to repeat somethintg, then auto cancel!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (setq insert-here-keymap
;       (let ((map (make-sparse-keymap)))
;         (define-key map (kbd "h") #'insert-here)
;         map) )
;
; (defun insert-here ()
;   (interactive)
;   (insert "here")
;   (set-transient-map
;    insert-here-keymap))
;
; (global-set-key (kbd "C-c h") #'insert-here)
;
; # Now, after activating #'insert-here, we can repeat it by pressing h. But if anything else is
; # pressed, the keymap disables. Further presses of h will insert the letter; the keymap is no longer
; # used. So we've accomplished our goal of easily repeating this command with a single keypress.
;
; hereherehereherehereherehere
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; maybe use this for nuumbers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; https://elpa.gnu.org/packages/tiny.html
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This is useful looking up the file tree for a file and built into emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; http://mbork.pl/?action=browse;oldid=Homepage;id=Strona_domowa
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Use this https://melpa.org/#/eshell-up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;This is neat, self canceling key binding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://irreal.org/blog/?p=5543
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; tried out https://github.com/dgutov/diff-hl, interesting mabe make perm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Modes to make dired have bindings like the far file manager
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;https://github.com/fourier/txm-emacs-scripts/blob/master/configs/txm-dired.el
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This is cool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  https://github.com/asok/peep-dired
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; consider using a better narrow: https://github.com/Bruce-Connor/fancy-narrow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; /Bruce-Connor/fancy-narrow/master/fancy-narrow.el
;fix C-.      /eshell/inf-ruby
;
;CHECK
;(insert (shell-command-to-string "myshowtags.rb"))
;produces
;; Found these tags:
;; rev_0000/
;; rev_0001/
;; rev_0002/
;; rev_test/
;
;consider using
;http://nschum.de/src/emacs/idle-require/
;https://github.com/nex3/perspective-el
;think about find-ls-option for find issues
;think about
  ;create project file in Ruby\wlist filtered list of names
  ;open file in emacs, put lines in list do completing read.
  ;open a buffer that has the path
  ;Xah Lee has some ideas that might help
  ;http://ergoemacs.org/emacs/elisp_process_lines.html
  ;http://ergoemacs.org/emacs/elisp_idioms_batch.html
  ;given a signag name, create a list or array of the instances it connects to
  ;a better Ruby mode? https://github.com/zenspider/enhanced-ruby-mode
  ;More possible Ruby improvements https://github.com/dgutov/robe
;
;think about writing a defun that would call a Ruby that calls the
;shell command "find . -iname ".svn"|xargs rm -rf"
;
;this link gives instructions on having a shortcut start emacsclient
;www.emacswiki.org/emacs/?action=browse;diff=1;id=EmacsMsWindowsIntegration
;
;Comparing (difference) lists
;stackoverflow.com/questions/10939855/
;how-to-calculate-difference-between-two-sets-in-emacs-lisp-the-sets-should-be-li
;
;here is another way using a fn from dash.el
  ;-difference (list list2)
  ;Return new list\w only the members of list that are not in list2. The test
  ;for equality is done with equal, or with -compare-fn if that's non-nil.
;
;Alist helper KV means "key value"
;https://github.com/nicferrier/emacs-kv
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacs and perl regex compared
;http://www.lemoda.net/emacs/perl-emacs-regex/index.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Discussion of variable scope across emacs
;//yoo2080.wordpress.com/2013/08/14/invasion-of-special-variables-in-emacs-lisp/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Lisp book online
;http://psg.com/~dlamkins/sl/contents.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;toward a iswitchb dired mode switch
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Kin Cho also suggested the following defun.  Once you have a subset of
;; matching buffers matching your current prompt, you can then press
;; e.g. C-o to restrict matching to those buffers and clearing the prompt:
;; (defun iswitchb-exclude-nonmatching()
;;    "Make iswitchb work on only the currently matching names."
;;    (interactive)
;;    (setq iswitchb-buflist iswitchb-matches)
;;    (setq iswitchb-rescan t)
;;    (delete-minibuffer-contents))
;;
;; (add-hook 'iswitchb-define-mode-map-hook
;;           (lambda () (define-key
;;                      iswitchb-mode-map "\C-o"
;;                      'iswitchb-exclude-nonmatching)))
;
;how to get the mode of a buffer
;stackoverflow.com/questions/2238418/emacs-lisp-how-to-get-buffer-major-mode
;(buffer-local-value 'major-mode (get-buffer "design"))
;
;A way to get a list of buffers in the mode
;(buffer-utils-all-in-mode)
;from lib
;buffer-utils.el
;http://www.emacswiki.org/emacs/buffer-utils.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;This looks interesting
;https://github.com/lewang/volatile-highlights.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ; Contstant, determines home or work
;; (setq load-home-work-pk t)
;;   (add-to-list 'load-path "~/.emacs.d/home-work-pk/")
;;   (when  load-home-work-pk
;;     (require 'home-work-pk))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;consider playing with https://github.com/zk-phi/indent-guide
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Turn off some wierd stuff in emacs 24
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; customize to off, will the customization work? (electric-indent-mode -1)

;MASTER CONTROL
;
;these two work together
(setq load-custom-file t)
(setq load-essentials_1 t)
;
(setq load-essentials_2 t)
(setq load-essentials_3 t)
(setq load-essentials_4 t)
(setq load-essentials_5 t)
(setq load-colors t)
(setq experiments_1 nil)
(setq my-depricated nil)
(setq exp_did_not_work_out nil)
;
(setq load-ido nil)
;
(setq load-icicles  t)
(setq load-icy-mode t)
(setq load-icicles_helpers_1 t)
(setq load-icicles_helpers_2 t)
(setq load-icicles_helpers_3 t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;.;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;set custom file based on home-work option
;set custom file based on env var
(unless
  (ignore-errors ;if an error occurs return nil
    ;
    (cond
      ;home pc
      ((equal "home_pc" (getenv "myenv"))
       (setq custom-file "~/.emacs-custom-home.el")
       ;(setq custom-file "~/.emacs-custom-work-linux.el")
       (setq home-work 'home)
       (setq bmkp-last-as-first-bookmark-file "~/my-emacs.bmk")
       (setq path-to-desktop "c:/Users/family/Desktop/"))
      ;
      ;work pc
      ((equal "work_pc" (getenv "myenv"))
       (setq home-work 'work)
       (setq custom-file "~/.emacs-custom-work.el")
       (setq bmkp-last-as-first-bookmark-file "~/my-emacs.bmk")
       (setq path-to-desktop "c:/users/mfitzgerald/desktop/"))
      ;
      ;work linux
      ((equal "work_linux" (getenv "myenv"))
       (setq home-work 'work)
       (setq custom-file "~/.emacs-custom-work-linux.el")
       (setq path-to-desktop "~/")
       ;this allows paste into Linux and is always set to t in windows
       (setq x-select-enable-clipboard t)))
       ;(setq bmkp-last-as-first-bookmark-file "~/my-emacs.bmk")))
       ;
    (when ( and load-essentials_1 load-custom-file)
      (load custom-file 'noerror) ))
    ;
  (message "--Error trouble loading custom file"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-home-work-pk             (and nil load-essentials_1))
(setq load-my-dvorak-bindings-early (and nil load-essentials_1))
(setq load-my-dvorak-bindings-late  (and t   load-essentials_1))
;
(setq load-frame-win-setup          (and t   load-essentials_1));needs to be early
(setq load-special-searches         (and t   load-essentials_2))
(setq load-my-smex-setup            (and t   load-essentials_2))
(setq load-color-theme-setup-early  (and t   load-colors))
(setq load-color-theme-setup-late   (and nil load-colors))
;
(setq load-move-ins-sel-kill         (and t   load-essentials_1))
(setq load-block-move                (and t   load-essentials_2))
(setq load-insert-signal             (and t   load-essentials_5))
(setq load-file-orient-fns           (and t   load-essentials_1))
(setq load-shell-current-directory   (and t   load-essentials_5))
(setq load-undo-tree                 (and t   load-essentials_2))
(setq load-highlight-symbol          (and t   load-essentials_2))
;
(setq load-my-vc-setup               (and t   load-essentials_3))
(setq load-my-tinyeat-setup          (and t   load-essentials_3))
(setq load-filesets                  (and t   load-essentials_5))
(setq load-drag-stuff                (and nil load-essentials_5))
(setq load-my-vhdl-setup             (and t   load-essentials_2))
(setq load-my-wm3-setup              (and nil load-essentials_3))
(setq load-saveplace                 (and t   load-essentials_3))
(setq load-my-dvorak-mapped-bindings (and t   load-essentials_1))
(setq load-my-ibuffer-setup          (and t   load-essentials_4))
(setq load-my-iedit-setup            (and t   load-essentials_2))
(setq load-my-org-setup              (and t   load-essentials_3))
;
(setq load-elisp-format                  (and nil experiments_1));--
(setq load-fastnav                       (and nil my-depricated));--
(setq load-smart-tab                     (and nil my-depricated));--
(setq load-several-string-and-list-utils (and t   load-essentials_3))
;
(setq load-ido-vertical-mode           (and t   load-ido))
(setq load-my-ido-setup                (and t   load-ido))
(setq load-browse-kill-ring+           (and nil   load-ido));--mq
(setq load-ido-ubiquitous              (and t   load-ido))
(setq load-ido-sunrise                 (and nil    load-ido))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-iswitchb                  (or load-essentials_1
                                       ( and (>= emacs-major-version 24 )
                                             (> emacs-minor-version 3))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(message "THE VALUE: %S in dot emacs" 1on1-minibuffer-frame-flag)
(setq load-my-icicle-setup              (and t load-icicles))
;
(setq load-icomplete+                   (and t load-icicles_helpers_2))
(setq load-oneonone                     (and t load-icicles_helpers_1))
;
;make this nil for light themes
(setq load-oneonone-params              (and t load-icicles_helpers_1));fix bad backgrounds in light themes
;
(setq load-icicles-iswitchb             (and t load-icicles_helpers_2));
(setq load-replace+                     (and t load-icicles_helpers_3));
;
(setq load-iswitchb-highlight           (and t load-icicles_helpers_3))
;
;(setq load-icy-mode                     (and t load-icicles))
(setq load-help-fns+                    (and t load-icicles_helpers_3))
(setq load-facemenu+                    (and t load-icicles_helpers_3))
(setq load-doremi-cmd                   (and t load-icicles_helpers_3))
;
(setq load-fit-frame                    (and t load-icicles_helpers_1))
  (setq load-cascading-frames           (and nil load-icicles_helpers_3));does not play well with fit-frame
(setq load-autofit-frame                (and t load-icicles_helpers_2))
(setq load-zoom-frm t)
;
(setq load-frame-cmds                   (and t load-icicles_helpers_2))
(setq load-fisheye                      (and t load-icicles_helpers_3));
(setq load-thing-edit                   (and t load-icicles_helpers_3))
(setq load-thing-cmds                   (and t load-icicles_helpers_3))
(setq load-thingatpt+                   (and t load-icicles_helpers_3))
(setq load-info+                        (and t load-icicles_helpers_3))
;recall that buf-menu+ is compatabli with emacs up to 24.1
;Need to obtain and load an older version of buf-menu.el if I
;want to run buf-menu+
(setq load-buf-menu                     (and nil load-icicles_helpers_3))
;
(setq load-my-isearch-plus-setup        (and t load-icicles_helpers_3))
(setq load-grep+                        (and t load-icicles_helpers_3))
(setq load-hl-line+                     (and t load-icicles_helpers_2))
(setq load-ace-jump-mode                (and t load-essentials_2))
(setq load-ace-jump-zap                 (and t load-essentials_2))
(setq load-ace-window                   (and t load-essentials_2)) ;using avy-jump for now
;
(setq load-my-dired-setup               (and t load-essentials_2))
   (setq load-dired-details             (and t load-essentials_2));works with sunrise
   (setq load-dired-sort-menu+          (and t load-essentials_2))
   (setq load-dired+                    (and t load-essentials_2))
   (setq load-diredful                  (and t load-essentials_2))
   (setq load-dired-hacks               (and t load-essentials_2))
;
(setq load-my-sunrise-setup             (and t load-essentials_2))
   (setq load-sunrise-x-tabs            (and t load-essentials_2));my bindings:sr-scroll are whacked by this
   (setq load-sunrise-popup-viewer      (and t load-essentials_2))
   (setq load-w32-browser-in-sunrise    (and t load-essentials_2))
   (setq dired+-in-sunrise              (and t load-essentials_2))
;
(setq load-my-bookmarks-setup           (and t load-icicles_helpers_2))
(setq force-bookmarks-bmenu-on-off      (and t load-icicles_helpers_2))
;
(setq run-my-startup-hook               (and t   load-essentials_2))
(setq load-ediff-experiment             (and nil exp_did_not_work_out))
(setq load-context-menu-experiment      (and t   load-essentials_2))
(setq load-expand-region                (and t   load-essentials_2))
(setq load-my-ediff-setup               (and t   load-essentials_2))
(setq load-key-chord                    (and nil load-essentials_2))
(setq load-elisp-slime-nav              (and t   load-essentials_2))
(setq load-diminish                     (and t   load-essentials_2))
(setq load-buffer-sw-experiment         (and t   load-essentials_2))
(setq load-macro-math                   (and t   load-essentials_2))
;
(setq load-eshell-setup                 (and t   load-essentials_2))
(setq load-ack-full                     (and nil load-essentials_3))
(setq load-column-marker                (and t   load-essentials_2))
;
(setq load-my-ruby-setup                (and t   load-essentials_2))
  (setq load-ruby-helpers               (and t   load-essentials_2))
  (setq load-enh-ruby                   (and nil exp_did_not_work_out))
  (setq load-ruby-debug                 (and nil exp_did_not_work_out))
;
(setq load-filenamecache                (and nil exp_did_not_work_out))
(setq load-evil-numbers                 (and t   load-essentials_2))
(setq load-my-rectangles                (and t   load-essentials_2))
(setq load-dos-mode                     (and t   load-essentials_2))
(setq load-ucf-mode                     (and t   load-essentials_2))
(setq load-viper-4-word-movement        (and nil load-essentials_4))
;
(setq load-awk-it                       (and nil exp_did_not_work_out))
  ;awk it does not work with cmd.exe, perhaps I can fix it, don't know
  ;loads yas which I find irritating, even when not using it
  ;  -it produces messages, it appears in the mode line
;
(setq load-cygwin-helper                (and nil exp_did_not_work_out))
;
;FFIP at work seems to want this bad.
;Not any more fixed it branched it to my own my-find-file-in-project
(setq load-setup-cygwin                 (and nil exp_did_not_work_out));
;; (setq load-find-file-in-project nil)
(setq load-my-find-file-in-project      (and t   load-essentials_2))
;
(setq load-nav                          (and nil exp_did_not_work_out))
(setq load-inferior-shell-force-windows (and t   load-essentials_2))
(setq load-find-file-in-repository      (and nil exp_did_not_work_out))
(setq load-simp                         (and nil exp_did_not_work_out))
;
(if  (>= emacs-major-version 24 )
  (setq load-projectile                   (and nil   load-essentials_2))
  (setq load-projectile                   (and nil   load-essentials_2)))
;
(setq load-fuzzy-find-in-project        (and nil exp_did_not_work_out))
(setq load-ifind                        (and nil exp_did_not_work_out))
(setq load-read-char-spec               (and t   load-essentials_3))
(setq load-imenu-tree                   (and nil exp_did_not_work_out))
(setq load-sr-speedbar                  (and nil exp_did_not_work_out))
(setq load-per-window-point             (and t   load-essentials_2))
(setq load-winpoint                     (and nil exp_did_not_work_out))
(setq load-workgroups                   (and nil exp_did_not_work_out))
(setq load-hl-defined                   (and nil exp_did_not_work_out))
;
(setq load-smartparens                  (and nil exp_did_not_work_out))
(setq load-hrb-mode                     (and nil exp_did_not_work_out))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (>= emacs-major-version 24)
      (setq load-melpa-packages       (and t load-essentials_2))
      (setq load-melpa-packages       (and nil load-essentials_2)))
;
(setq load-rainbow-delimiters   (and t   load-essentials_2))
; Magit troubles over TRAMP, can't run git-status
(setq load-magit                (and nil   load-essentials_2))
(setq modify-rainbow-colors     (and t   load-essentials_2))
(setq load-rebox                (and t   load-essentials_3))
(setq load-my-paren-setup       (and t   load-essentials_3))
(setq load-mic-paren            (and t   load-essentials_3));change for 24.4
(setq load-advise-show-paren-fn (and nil load-essentials_3))
(setq load-my-utils             (and t   load-essentials_3))
(setq load-my-math-lib          (and t   load-essentials_3))
(setq load-ethan-wspace         (and nil exp_did_not_work_out))
(setq load-syntax-subword       (and t   load-essentials_3))
(setq load-wrap-region          (and t   load-essentials_3))
(setq load-neotree              (and t   load-essentials_5))
(setq load-fancy-narrow         (and t   load-essentials_5))
(setq load-auto-complete        (and nil load-essentials_5))
(setq load-sequential-command   (and t   load-essentials_5))
(setq load-my-project           (and t   load-essentials_3))
;
(if  (>= emacs-major-version 24 )
  (setq load-company-mode         (and t   load-essentials_3))
  (setq load-company-mode         (and nil   load-essentials_3)) )
;  
(setq load-avy-jump-mode        (and nil load-essentials_3))
(setq load-avy-mode             (and t   load-essentials_3))
(setq load-multiple-cursors     (and t   exp_did_not_work_out))
(setq load-scratch              (and t   load-essentials_5))
(setq load-powerline            (and nil   load-essentials_5))
(setq load-smart-mode-line      (and t   load-essentials_5))
(setq load-beacon               (and t   load-essentials_5))
(setq load-hydra                (and t   load-essentials_5))
(setq load-ibuffer              (and t   load-essentials_2))
;
(if  (>= emacs-major-version 24 )
     (setq load-clearcase            (and nil   load-essentials_5))
     (setq load-clearcase            (and nil   load-essentials_5)))
;
(setq load-start-emacs-server   (and t   load-essentials_5))
(setq load-peep-dired           (and t   load-essentials_5))
(setq load-zygospore            (and t   load-essentials_5))
;
;(setq load-settings-tramp      (and t   load-essentials_5))
(setq load-tramp-settings       (and t load-essentials_5))
;  
(setq load-my-mode              (and t   load-essentials_5))
(setq load-ack-and-a-half       (and t   load-essentials_5))
(setq load-start-menu-at-init   (and nil load-essentials_5))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;PACKAGE STUFF
;; ;note the backquote and , inside needed to have a var in the list
;; ;the info pages just showed a simple quoted list
;; ;  use the word all to get all other packages not specified
;; ; `((delimiters-load ,rainbow-delimiters-version-all) and)
;; ;
  ;(when (emacs (>= major-version-24 load) rainbow-melpa-packages load-essentials_3)
  ;
  ;; (
  ;; (require 'package)
  ;
  ;; (when nil
  ;; (setq package-load-list
  ;;   `((rainbow-delimiters ,load-rainbow-delimiters-version) )))
  ;; ;
  ;; (package-initialize)
  ;; (add-to-list
  ;;  'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;; (setq package-user-dir "~\\.emacs.d")
  ;; )
;;
;; MTF I don't always want this stuff, its usually more trouble than it's worth
(when nil
  (require 'package) ;; You might already have this line
   ; 
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; mtf use one of these two, gnu is the new, stable is stable
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; 1
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
    ;; 2
    (add-to-list 'package-archives
               '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  )
  ;
  ;;;;http://cachestocaches.com/2015/8/getting-started-use-package/
  ;(setq package-enable-at-startup nil)
  ;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  ;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  ;
  ;
  ;(package-refresh-contents)
  ;(package-install 'use-package)
  ;(package-initialize)
  )
  ;
;(unless (package-installed-p 'use-package)
 ; (package-refresh-contents)
  ;(package-install 'use-package))
  ;
  ;(global-set-key (kbd "C-x g") 'magit-status)
  ;(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; my custom-set-faces go missing found this bug, maybe fix? 7/26/2017
 ;https://debbugs.gnu.org/cgi/bugreport.cgi?bug=25228#152
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (define-key special-event-map [config-changed-event] 'ignore)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Elpa/Melpa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before Melpa/Elpa")
(when  load-melpa-packages;
    (unless
      (ignore-errors ;if an error occurs return nil
    (require 'package)
    (setq package-enable-at-startup nil)
    ; 
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
    ;
    ; seems to be an error contacting this computer when running package-refresh-contents
    ;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
    ;
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
    ; 
    (package-initialize)
    ;
    (unless (package-installed-p 'use-package)
      (package-refresh-contents)
      (package-install 'use-package))
    ;
    (when (>= emacs-major-version 24 )
      (eval-when-compile
        (require 'use-package))
    ;
      (require 'diminish)
      (require 'bind-key))
        t)
      (message "--Error in load-melpa-packages")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;fix
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;; (use-package projectile
 ;;   :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; don't wrap lines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default truncate-lines t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacs 24.4 had this disabled, no idea why they believe it's confusing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when t
  (put 'upcase-region 'disabled nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; from Xah Lee http://ergoemacs.org/emacs/mpblog.html
; About 1 or 2 years ago, Hippie Expand started to have annoying behavior of
; expanding a word into a line or a blob of long text.
;
; Here's how to fix. Put this in your init. 
; Note maybe this should be controlled on/of? How where?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when t
(setq hippie-expand-try-functions-list
      '(
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        ;; try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        try-complete-file-name-partially
        try-complete-file-name
        ;; try-expand-all-abbrevs
        ;; try-expand-list
        ;; try-expand-line
        )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; magit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before loading magit")
(when  load-magit;
    (unless
      (ignore-errors ;if an error occurs return nil
      ;  
      (use-package magit
        :ensure t
        :bind(( "C-x g"   . magit-status)
              ( "C-x M-g" . magit-dispatch-popup)))
        t)
      (global-set-key (kbd "C-x g") 'magit-status)
      (global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
      ;
      (message "--Reached before loading magit")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Only load dash this way if magit is not used, bc Magit uses the elpa version
;of dash.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-dash")
(when (not load-magit)
  (unless
    (ignore-errors ;if an error occurs return nil
      (add-to-list 'load-path "~/.emacs.d/dash")
      (require 'dash)
      t)
    ;
  (message "--Error in load-dash")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rainbow-delimiters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before rainbow delimiters")
(when  load-rainbow-delimiters;
    (unless
      (ignore-errors ;if an error occurs return nil
        (add-to-list 'load-path "~/.emacs.d/rainbow-delimiters/")
        (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
        (add-hook 'verilog-mode-hook #'rainbow-delimiters-mode)
        (add-hook 'vhdl-mode-hook #'rainbow-delimiters-mode)
        (add-hook 'ruby-mode-hook #'rainbow-delimiters-mode)
        (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
        (require 'rainbow-delimiters)
        t)
      (message "--Error in load-rainbow-delimiters")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;only for very old versions of emacs
;(load-file "~/.emacs.d/cua/cua.el")
;(require 'cua)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;many packages in this folder
(add-to-list 'load-path "~/.emacs.d/icicles/")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;utility modes
(unless
  (ignore-errors ;if an error occurs return nil
    ;
    (setq load-delete-selection-mode (and t   load-essentials_1))
    (setq load-global-linum-mode (and t   load-essentials_2))
    (setq load-savehist-mode (and t   load-essentials_2))
    ;
    (setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
    (setq load-recentf-mode (and t   load-essentials_1))
    ;
    (cua-mode (and t   load-essentials_1))
    (setq delete-by-moving-to-trash (and t   load-essentials_2))
    (winner-mode (and t   load-essentials_3)))
  ;
  (message "--Error loading utility modes"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;"based on all modes inheret from fundamental-mode"
  (add-hook 'fundamental-mode-hook
     (lambda ()
     (define-key fundamental-mode-map [(control meta r)] 'my-hdl-right-syntax-or-subword)
     (define-key fundamental-mode-map [(control meta g)] 'my-hdl-left-syntax-or-subword)
     (scroll-bar-mode -1)))

 ;(add-hook 'log-edit-done-hook 'my-kill-buffer-and-its-windows)

;(add-hook 'log-edit-done-hook
;   (lambda ()
;   (kill-buffer-and-its-windows (current-buffer))))

;
  (add-hook 'help-mode-hook
     (lambda ()
       (scroll-bar-mode -1)))
;
  (add-hook 'tcl-mode-hook
     (lambda ()
     (modify-syntax-entry ?\$ "." tcl-mode-syntax-table)
     (define-key tcl-mode-map [(control meta r)] 'my-hdl-right-syntax-or-subword)
     (define-key tcl-mode-map [(control meta g)] 'my-hdl-left-syntax-or-subword)
     (scroll-bar-mode -1)
     ;; not shure why I wanted this??(let ((fit-frame-inhibit-fitting-flag  t)))))
     ))

  (add-hook 'sh-mode-hook
     (lambda ()
     (define-key sh-mode-map [(control meta r)] 'my-hdl-right-syntax-or-subword)
     (define-key sh-mode-map [(control meta g)] 'my-hdl-left-syntax-or-subword)
     ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; trying to make this work at the minibuffer prompt you get after running
; M-& (async shell command)
; does not work still getting (next-history-element)
(add-hook 'minibuffer-inactive-mode-hook
  (lambda ()
  (define-key minibuffer-inactive-mode-map [(meta r)] 'smart-end-of-line)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;maybe time to move the .emacs shell to its own file my-shell-setup.el??
;clear the shell buffer, works like dos cls
;www.emacswiki.org/emacs/ShellMode
(defun cls ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))
;
;make shell mode work like everything else
(add-hook 'shell-mode-hook
  (lambda ()
  (define-key comint-mode-map [(control meta r)] 'my-hdl-right-syntax-or-subword)
  (define-key comint-mode-map [(control meta g)] 'my-hdl-left-syntax-or-subword)
  (define-key comint-mode-map (kbd "C-c SPC") 'nil)
  (define-key comint-mode-map (kbd "M-t") 'nil)
  (define-key comint-mode-map (kbd "M-t") 'nil)
  (define-key comint-mode-map (kbd "M-n") 'nil)
  (define-key comint-mode-map (kbd "\en") 'nil)
  (define-key comint-mode-map (kbd "M-h") 'nil)
  (define-key comint-mode-map (kbd "M-c") 'nil)
  (define-key comint-mode-map (kbd "M-r") 'nil)
  (define-key comint-mode-map (kbd "C-.") 'show-file-name-from-shell-modes)
  (define-key comint-mode-map (kbd "M-g") 'nil)))
;
(defun mike/shell ()
  "start a shell in the current window (no pop up)"
  (interactive)
  (let ((fit-frame-inhibit-fitting-flag t)
        (window-min-width 10)
        (special-display-regexps nil)
        (pop-up-frames nil))
          ;
          (shell)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; calc mode bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'calc-mode-hook
  (lambda ()
  (define-key calc-mode-map [(control meta r)] 'my-hdl-right-syntax-or-subword)
  (define-key calc-mode-map [(control meta g)] 'my-hdl-left-syntax-or-subword)
  (define-key calc-mode-map (kbd "M-n") 'nil)
  (define-key calc-mode-map (kbd "M-h") 'nil)
  ;These should not be necessary bc I have them as global keybindings
  ;Put them in anyway while I debug why they are not doing what I want.
  (define-key calc-mode-map (kbd "M-n") 'my-backward-char)
  (define-key calc-mode-map (kbd "M-h") 'my-forward-char)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use spaces, not tabs.
(add-hook 'emacs-lisp-mode-hook
  (lambda ()
   ;goal is to "diminish" the mode line, other side othre side affects are
   ;un-intended.
   ; don't like it (which-function-mode)
   (define-key emacs-lisp-mode-map (kbd "<M-prior> ") 'beginning-of-defun)
   (define-key emacs-lisp-mode-map (kbd "<M-next> ") 'end-of-defun)
   (define-key emacs-lisp-mode-map  [(control meta r)] 'my-hdl-right-syntax-or-subword)
   (define-key emacs-lisp-mode-map [(control meta g)] 'my-hdl-left-syntax-or-subword)
   (setq mode-name "ELISP")
   (when  (>= emacs-major-version 24 )
     (company-mode 1))
   (setq indent-tabs-mode nil)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;TEXT MODE-
(add-to-list 'auto-mode-alist '("\\.\\(txt\\)$" . text-mode))
(add-to-list 'auto-mode-alist '("\\.\\(xdc\\)$" . tcl-mode))
;; Use spaces, not tabs.
(add-hook 'text-mode-hook
  (lambda ()
   (setq indent-tabs-mode nil)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;startup hook
(when run-my-startup-hook
  (add-hook  'emacs-startup-hook 'my-startup-hook-fns)

(defun my-startup-hook-fns ()
  (interactive)
  ""
  (menu-bar-mode 0)))

;the final init hook?
;; (add-hook 'window-setup-hook
;;        '(lambda ()
;;              (rename-frame nil "PRIMARY")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Holds a single contstant, determines home or work
(message "reached before load-home-work-pk")
(add-to-list 'load-path "~/.emacs.d/home-work-pk/")
(when  load-home-work-pk
  (require 'home-work-pk))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;set color theme based on home-work option
(cond
  ((eq home-work 'home) (setq my-color-theme 'zenburn));home
  ((eq home-work 'work) (setq my-color-theme 'zenburn))  ;work
  (t (setq my-color-theme 'zenburn) (message "no home or work specified")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;String and list utilities
(message "reached before load-several-string-and-list-utils")
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/string-utils")
    (add-to-list 'load-path "~/.emacs.d/s")
    (add-to-list 'load-path "~/.emacs.d/f")
    ;(add-to-list 'load-path "~/.emacs.d/dash")
    (add-to-list 'load-path "~/.emacs.d/f")
    ;
    (when load-several-string-and-list-utils
      (require 'string-utils)
      ;(require 'dash)
      (require 's)
      (require 'f)))
    ;
  (message "--Error loading String and list utils"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before unless load-oneonone")
(add-to-list 'load-path "~/.emacs.d/cursor-chg/")
(unless load-oneonone
   ;
   (require 'cursor-chg)  ; Load this library
   (change-cursor-mode 1) ; on for overwrite/read-only/input mode
   (toggle-cursor-type-when-idle 1)) ; on when idle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bindings
(message "reached before load-my-dvorak-bindings-early")
(when  load-my-dvorak-bindings-early
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-dvorak-bindings/")
    (require 'my-dvorak-bindings)
    t)
    ;
    (message "--Error in load-my-dvorak-bindings-early")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(Setq make-backup-files nil) ; stop creating those backup~ files
;
;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

(setq auto-save-default nil) ; stop creating those #autosave# files
(put 'narrow-to-region 'disabled nil)
(setq revert-without-query (quote (".*transcript")))
;
;isearch history
(setq history-length 90) ; emacs default is 30
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Needed for browse kill ring and icicle yank maybe completing
(message "reached before load-delete-selection-mode")
(when  load-delete-selection-mode
  (delete-selection-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when  load-recentf-mode
  (unless
    (ignore-errors ;if an error occurs return nil
    (recentf-mode 1)
    ;(archive-mode 1)
    (setq recentf-max-saved-items 512)
    (run-at-time nil (* (* 60 7) 60) 'recentf-save-list)
    t)
    ;
  (message "--Error loading recentf-mode")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-savehist-mode")
(when  load-savehist-mode
  (unless
    (ignore-errors ;if an error occurs return nil
    (savehist-mode 1))
  (message "--Error loading savehist mode")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-elisp-format")
(when  load-elisp-format
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/elisp-format/")
    (require 'elisp-format))
    ;
  (message "--Error in load-elisp-format")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-my-smex-setup")
(when  load-my-smex-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-smex-setup/")
    (require 'my-smex-setup))
    ;
  (message "--Error in load-my-smex-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-frame-win-setup")
(when  load-frame-win-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/frame-win-setup/")
    (require 'frame-win-setup))
    ;
  (message "--Error in load-frame-win-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  special-searchs package
(message "reached before load-special-searches")
(when  load-special-searches
    (unless
      (ignore-errors ;if an error occurs return nil
      ;
      (add-to-list 'load-path "~/.emacs.d/special-searches/")
      (require 'special-searches))
      ;
    (message "--Error in load-special-searches")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-color-theme-setup-early")
(when  load-color-theme-setup-early
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-color-theme-setup/")
    (require 'my-color-theme-setup))
    ;
  (message "--Error in load-color-theme-setup-early")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-move-ins-sel-kill")
(when  load-move-ins-sel-kill
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/move-ins-sel-kill/")
    (require 'move-ins-sel-kill))
    ;
    (message "--Error in load-move-ins-sel-kill")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-block-move")
(when  load-block-move
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/block-move/")
    (require 'block-move))
    ;
  (message "--Error in load-block-move")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-insert-signal")
(when  load-insert-signal
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/insert_signal/")
    (require 'insert-signal))
    ;
  (message "--Error in load-insert-signal")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-my-dired-setup")
(when  load-my-dired-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-dired-setup/")
    (require 'my-dired-setup))
    ;
  (message "--Error in load-my-dired-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-my-sunrise-setup")
(when  load-my-sunrise-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-sunrise-setup/")
    (require 'my-sunrise-setup))
    ;
    (message "--Error in load-my-sunrise-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-file-orient-fns")
(when  load-file-orient-fns
  (unless
    (ignore-errors ;if an error occurs return nil
    ;

    (add-to-list 'load-path "~/.emacs.d/file-orient-fns/")
    (require 'file-orient-fns))
    ;
  (message "--Error in load-file-orient-fns")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Fastnav jump to or zap to char (zap copies to kill ring)
(message "reached before load-fastnav")
(when load-fastnav
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/fastnav/")
    (require 'fastnav))
    ;
  (message "--Error in load-fastnav")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;shell
(message "reached before load-shell-current-directory")
(when  load-shell-current-directory
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/shell-current-directory/")
    (require 'shell-current-directory))
    ;
  (message "--Error in load-shell-current-directory")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;undo tree
;note that when this is re-downloaded the bindings for
  ;(define-key map (kbd "C-/") 'undo-tree-undo)
  ;(define-key map "\C-_" 'undo-tree-undo)
;must be manually removed from the source
;What a pain.
;
(message "reached before load undo-tree")
(when load-undo-tree
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-undo-tree-setup/")
    (require 'my-undo-tree-setup))
    ;
  (message "--Error in load-undo-tree")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;HighlighSymbol
;http://nschum.de/src/emacs/highlight-symbol/
; MTF Consider binding highlight-symbol-query-replace
(message "reached before load highlight-symbol")
(when  load-highlight-symbol
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/highlight-symbol/")
    (require 'highlight-symbol)
    (setq highlight-symbol-on-navigation-p t))
    ;
  (message "--Error in load-highlight-symbol")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ibuffer:
;; (message "reached before load ibuffer")
;; (when  nil
;;   (unless
;;     (ignore-errors ;if an error occurs return nil
;;     ;
;;     (require 'ibuffer)
;;     (setq ibuffer-default-sorting-mode 'file-name)
;;     (setq ibuffer-always-show-last-buffer t)
;;     (setq ibuffer-view-ibuffer t))
;;     ;
;;   (message "--Error in load-ibuffer")))
;; ;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load bookmarks setup")
(when  load-my-bookmarks-setup
  (unless
  (ignore-errors ;if an error occurs return nil
  ;
    (add-to-list 'load-path "~/.emacs.d/my-bookmarks-setup/")
    (require 'my-bookmarks-setup))
  ;
  (message "--Error in load-my-bookmarks-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load thing edit")
(when  load-thing-edit
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/thing_edit/")
    (require 'thing-edit))
    ;
  (message "--Error in load-thing-edit")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load tineyeat-setup")
(when  load-my-tinyeat-setup
  (unless
    (ignore-errors ;if an error occurs return nil
      (add-to-list 'load-path "~/.emacs.d/my-tinyeat-setup/")
      (require 'my-tinyeat-setup))
    ;
    (message "--Error in load-my-tinyeat-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load my-vc-setup")
(when  load-my-vc-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-vc-setup/")
    (require 'my-vc-setup))
    ;
  (message "--Error in load-my-vc-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Filesets
;http://www.emacswiki.org/emacs/filesets%2b.el
(message "reached before load filesets")
(when  load-filesets
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (require 'filesets)
    ; (filesets-init) Adds a filsets menu to the menus, produces an error
    ; probably because I don't have menu's
    ; (filesets-init)
    ;
    t) ;don't know why this is necessary.
    ;
  (message "--Error in load-filesets")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load thing-cmds")
(when load-thing-cmds
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (require 'thing-cmds)
    (thgcmd-bind-keys) ; Only if you want the key bindings it defines
    (eval-after-load "thingatpt" '(require 'thingatpt+)))
    ;
  (message "--Error in load-thing-cmds")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;only left and right are bound
;note this crashed emacs hard when anything went a bit wrong, don't use it.
(message "reached before load drag-stuff")
(when  load-drag-stuff
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/drag_stuff/")
    (require 'drag-stuff)
    (drag-stuff-global-mode t)
    (add-to-list 'drag-stuff-except-modes 'org-mode)
    (add-to-list 'drag-stuff-except-modes 'sr-mode))
    ;
  (message "--Error in load drag-stuff")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Spelling
; stackoverflow.com/
; questions/2012361/emacs-windows-spellcheck-aspell-or-hunspell/2012470#2012470
; Aspell can be easily installed on windows using cygwin. In the cygwin setup,
; search for aspell in the search bar and select it for installation.
; Remember to also select the dictionary you want to install
; (for the english language - aspell-en). A.dd the cygwin/bin directory to the
; load-path in emacs, so that emacs can find the executable when it needs it.
; Finally, add the following line to your .emacs file:
;
; Installed aspell using cygwin, cygwin/bin was already in the machine's path
; seems to work now.  MTF
(setq-default ispell-program-name "aspell")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before my-vhdl-setup")
(when  load-my-vhdl-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-vhdl-setup/")
    (require 'my-vhdl-setup))
    ;
  (message "--Error in load-my-vhdl-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Smart tab
;not sure if i like it want minibuf completion for isearch?
(add-to-list 'load-path "~/.emacs.d/smart-tab/")
(message "reached before load-smart-tab")
(when  load-smart-tab
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (require 'smart-tab)
    (global-smart-tab-mode 1))
    ;
  (message "--Error in load-smart-tab")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;To search for instance name when you know you are on a port map:
;C-r back to 'map'
;C-r back to ';'
;forward word
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ORG
(message "reached before my-org-setup")
(when  load-my-org-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-org-setup/")
    (require 'my-org-setup))
    ;
  (message "--Error in load-my-org-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Icicles
(message "reached before my-icicle-setup")
(when  load-my-icicle-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-icicle-setup/")
    (require 'my-icicle-setup))
    ;
    (message "--Error in load-my-icicle-setup")))
    ;
    (unless
      (ignore-errors ;if an error occurs return nil
    ;always want this for cases where icicles is not working
    (add-to-list 'load-path "~/.emacs.d/icicles-install/")
    (require 'icicles-install))
    ;
  (message "--Error loading icicles-install"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Note that there is a dependancy on the load path associated with icicles
;for loading lib "highlight" in lib "replace+" in this file.  So do add
;the icicle load path before loading these libs
(message "reached before my-isearch-plus-setup")
(when  load-my-isearch-plus-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-isearch-plus-setup/")
    (require 'my-isearch-plus-setup))
    ;
  (message "--Error in load-my-isearch-plus-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  ;Ido
;  ;3-7-12 found a function online that makes ido work nice for bookmark junps
;  ;but the same package messes up +, C , R in dired. Not sucessful turning
;  ;it off for dired because the bookmark jump uses dired.
;  ;
(message "reached before my-ido-setup")
(when  load-my-ido-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-ido-setup/")
    (require 'my-ido-setup))
    ;
  (message "--Error in load-my-ido-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before my-iswitchb-setup")
(when  load-iswitchb
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-iswitchb-setup/")
    (require 'my-iswitchb-setup))
    ;
  (message "--Error in load-iswitchb")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Browser
(message "reached before my-wm3-setup")
;; Has issues, don't have time to explore, maybe emacs must be compiled
;; with the proper support.
;; (when  (and load-my-wm3-setup (eq home-work 'work)) 
(when  (and load-my-wm3-setup (eq home-work 'work))
    (unless
      (ignore-errors ;if an error occurs return nil
      ;
      (add-to-list 'load-path "~/.emacs.d/my-wm3-setup/")
      (require 'my-wm3-setup))
      ;
    (message "--Error in load-my-wm3-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;save place
(message "reached before load-saveplace")
(when  load-saveplace
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (require 'saveplace)
    (setq-default save-place t))
    ; this is interesting, but some error occurs at startup for me;
    ;
    ;If emacs is slow to exit after enabling saveplace, you may be running afoul
    ;of save-place-forget-unreadable-files. On exit, it checks that every loaded
    ;file is readable before saving its buffer position - potentially very slow
    ;if you use NFS.
    ;; (setq save-place-forget-unreadable-files nil))
    ;
  (message "--Error in load-saveplace")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bindings
(message "reached before my-dvorak-mapped-bindings")
(when  load-my-dvorak-mapped-bindings
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-dvorak-mapped-bindings/")
    (require 'my-dvorak-mapped-bindings))
    ;
  (message "--Error in load-my-dvorak-mapped-bindings")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before my-iedit-setup")
(when  load-my-iedit-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-iedit-setup/")
    (require 'my-iedit-setup))
    ;
    (message "--Error in load-my-iedit-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;A couple of sol's to messy line numbers from stack overflow
; ;1
; (linum-mode +1)
; (setq linum-format "%d ")
;
;2
;I had the same problem and I figured out a solution and while it's not the
;prettiest, due to an extra space to the left of the line number, it's much more
;elegant than changing the linum.el.  Here is the pertinent part of my ~/.emacs:
;This removes the fringe overlay issue and does not have any other impact other
;than offsetting the line number.
;; Linum mode
 (when  load-global-linum-mode
  ;(global-linum-mode t)
;
;;Try this instead
;;from Sven Mangars
;;http://whattheemacsd.com/
 (global-set-key [remap goto-line] 'goto-line-with-feedback)
;
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1))))

;; OFFSET the number by two spaces to work around some weird fringe glitch
;(setq linum-format "  %d ")
;
;link this bettor, line numbers are left just, no extra space. MTF 7-24-2012
;made the mod to linum.el and re-byte compiled it as decribed.
   ;
   ;http://www.emacswiki.org/emacs/LineNumbers
   ; Linum: Separating line numbers from text
   ;
   ; I wanted a one-space separation between the line number display and
   ; the buffer contents. Couldn't find a way through the customisation
   ; settings. Perhaps it can only be done in Emacs in X, but I don't use
   ; X-based. I've found a simple way to do it, however:
   ;
   ;     On line 157 (in version 0.9wza) of linum.el, change
   ;
   ; (setq width (max width (length str))) to
   ;
   ; (setq width (max width (+ (length str) 1)))
;
;Changed c:\Users\mfitzgerald\Downloads\EMACS\emacs-23.4\lisp\linum.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before my-color-theme-setup")
(add-to-list 'load-path "~/.emacs.d/my-color-theme-setup/")
(when  load-color-theme-setup-late
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (require 'my-color-theme-setup))
    ;
    (message "--Error in load-color-theme-setup-late")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;oneone-default-frame-alist is set in custom and turns these off.
; Don't fight with it let the custom have control.
(unless load-oneonone-params
  (tool-bar-mode -1))
  ; Tool bars came back an some point, even with the oneone-default-frame-alist
  (tool-bar-mode -1)

(scroll-bar-mode -1)
(fringe-mode 0)
(message "*** toolbars off ***")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-hl-line+")
(when load-hl-line+
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (require 'hl-line) ;
    (require 'hl-line+) ; Load this file (it will load `hl-line.el')
    (toggle-hl-line-when-idle 1) ; Highlight only when idle
    (setq global-hl-line-mode nil)
    (hl-line-when-idle-interval 2))
    ;
    (message "--Error in load-hl-line+")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-ace-jump-mode")
(when  load-ace-jump-mode
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/ace-jump-mode")
    (autoload
      'ace-jump-mode
      "ace-jump-mode"
      "Emacs quick move minor mode"
      t)
    ;
    (autoload
      'ace-jump-mode-pop-mark
      "ace-jump-mode"
      "Ace jump back:-)"
      t)
    (eval-after-load "ace-jump-mode"
      '(ace-jump-mode-enable-mark-sync))
    ;
    (setq ace-jump-mode-move-keys
      (list ?a ?o ?e ?u ?h ?t ?n ?s ?g ?A ?O ?E ?U ?H ?T ?N ?S ?G ?c ?r ?, ?. ?p))

    ;
    ;icicles in gobbeling up this binding
    ;(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
    ;(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)) ;this paren matched ignore-errors
    ;(define-key esc-map "~" 'ace-jump-mode-pop-mark))
    ;
    )
  (message "--Error in load-ace-jump-mode")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-ace-jump-zap")
(when  load-ace-jump-zap
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/ace-jump-zap")
    (require 'ace-jump-zap))
    ;
  (message "--Error in load-ace-jump-mode")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;From Reto Zimmerman
;this is the original
;; (defun electric-d (count)
;;    "'dd' -> kill line"
;;    (interactive "p")
;;    (if (= (preceding-char) last-input-event)
;;        (progn
;;      (beginning-of-line)
;;      (kill-line 1))
;;      (self-insert-command count)))
;
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key "d" 'electric-d)
             ))
;
;
;this has a time aspect
(defvar last-input-time 0)
(defun electric-d (count)
   "'dd' -> kill line"
   (interactive "p")
   (if (and (= (preceding-char) last-input-event)
           (> 1 (- (nth 1 (current-time)) (nth 1 last-input-time))))
       (progn
        (beginning-of-line)
        (kill-line 1))
     (self-insert-command count)
     (message "%s" (current-time))
     (setq last-input-time (current-time))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IDE Skel
;probably have most of this functionality else-wise
(message "reached before ide-skel")
(when nil
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/ide-skel/")
    (require 'ide-skel))
    ;
    (message "--Error in load-ide-skel")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Double Char
;this does not run commands
(message "reached before double-char")
(when nil
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/double-char/")
    (require 'double-char))
    ;
    (message "--Error in load-double-char")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-context-menu-experiment")
(when  load-context-menu-experiment
(defun w32-context-menu (filename)
    (start-process-shell-command "context" "*context*" "context" filename))
;
(defun w32-context-menu-dired-get-filename (event)
    (interactive "e")
    ;; moves point to clicked row
    (mouse-set-point event)
    (w32-context-menu (concat "\"" (dired-get-filename) "\"")))
;
(defun w32-context-menu-current-buffer ()
    (interactive)
    (w32-context-menu (concat "\"" buffer-file-name "\"")))
;
  ;(global-set-key "\C-cc" 'w32-context-menu-current-buffer)
;
(defun external-command-context-menu()
      "runs external command ShellContextMenu on the current file"
      (interactive)
      (shell-command
        (format "bash -c \"ShellContextMenu %s \""
          '0 (shell-quote-argument (buffer-file-name)))))
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-my-ediff-setup")
(when   load-my-ediff-setup
  (add-to-list 'load-path "~/.emacs.d/my-ediff-setup//")
  (require 'my-ediff-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-expand-region")
;Sven Mangars
(when   load-expand-region
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/expand-region/")
    ;(global-set-key (kbd "C-=") 'er/expand-region)
    (require 'expand-region)
    (add-to-list 'load-path "~/.emacs.d/smart-forward/")
    (require 'smart-forward))
    ;
    (message "--Error in load-expand-region")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Key chord multiple presses run defun etc
(message "reached before load-key-chord")
(when  load-key-chord
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/key-chord/")
      (require 'key-chord)
      (key-chord-mode 1)
      (setq key-chord-two-keys-delay 0.1)     ; 0.05 or 0.1
      (key-chord-define-global "gg" 'smart-beginning-of-line)
      (key-chord-define-global "rr" 'smart-end-of-line)
      (key-chord-define-global "qq" 'whole-line-with-end))
      ;
      (message "--Error in load-key-chord")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;elisp-mode navigation
;M-, jumps to def, M-. jumps back
(message "reached before load-elisp-slime-nav")
(when  load-elisp-slime-nav
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/elisp-slime-nav/")
     (require 'elisp-slime-nav)
     (add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode))
     ;
     (message "--Error in load-elisp-slime-nav")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;buffer switching
(message "reached before load-buffer-sw-experiment")
(when  load-buffer-sw-experiment
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/buffer-stack/")
    (require 'buffer-stack))
    ;
    (message "--Error in load-buffer-sw-experiment")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; related stuff
      ;(global-set-key [(f9)] 'buffer-stack-bury)
      ;(global-set-key [(control f9)] 'buffer-stack-bury-and-kill)
      ;(global-set-key [(f6)] 'buffer-stack-up)
      ;(global-set-key [(f7)] 'buffer-stack-down)
      ;(global-set-key [(f12)] 'buffer-stack-track)
      ;(global-set-key [(control f12)] 'buffer-stack-untrack)

    ;
    ;
    ;
    ;
;(add-to-list 'load-path "~/.emacs.d/tinyeat/emacs-tiny-tools-devel/lisp/tiny/")
;   (autoload 'tinybuffer-iswitch-to-buffer     "tinybuffer.el" "" t)
;   (autoload 'tinybuffer-previous-buffer       "tinybuffer.el" "" t)
;   (autoload 'tinybuffer-next-buffer           "tinybuffer.el" "" t)
;   (autoload 'tinybuffer-sort-mode-toggle      "tinybuffer.el" "" t)
   ;
;   (global-set-key [(f6)]         'tinybuffer-previous-buffer)
;   (global-set-key [(f7)]         'tinybuffer-next-buffer)
;   (global-set-key [(control f6)]    'tinybuffer-iswitch-to-buffer)
;   (global-set-key [(alt <)]             'tinybuffer-sort-mode-toggle)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ack interface
(message "reached before load-ack-full")
(when  load-ack-full
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/full-ack/")
    (autoload 'ack-same "full-ack" nil t)
    (autoload 'ack "full-ack" nil t)
    (autoload 'ack-find-same-file "full-ack" nil t)
    (autoload 'ack-find-file "full-ack" nil t))
  ;
  (message "--Error in load full-ack")))
    ;(setq ack-executable "ackl"))
    ;has troulble calling the executable, perhaps try on LINUX when we get emacs
    ;on linux at work.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eshell
(message "reached before load-eshell-setup")
(when  load-eshell-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-eshell-setup/")
    (require 'my-eshell-setup)
    (message "Loaded my-eshell-setup"))
    ;
    (message "--Error in load-eshell-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;stickey:does not move with the cursor
;M-x column-marker-1,2,3
;C-u C-u column-marker-1,2,3 removes all
(message "reached before load-column-marker")
(when  load-column-marker
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/column-marker/")
    (require 'column-marker))
    ;
  (message "--Error in load-column-marker")))
    ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-my-ruby-setup")
(when load-my-ruby-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-ruby-setup")
    (require 'my-ruby-setup))
    ;
    (message "--Error in load-my-ruby-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; file cache stuff based on http://www.emacswiki.org/emacs/FileNameCache
(message "reached before load-filenamecache")
(when  load-filenamecache
(require 'filecache))
;
(when (and load-filenamecache (eq home-work 'work)
  (file-cache-read-cache-from-file "~/my_first_file_cache.txt")))
;
(defun file-cache-save-cache-to-file (file)
  "Save contents of `file-cache-alist to FILE.
   For later retrieval using `file-cache-read-cache-from-file"
  (interactive "FFile: ")
  (with-temp-file (expand-file-name file)
    (prin1 file-cache-alist (current-buffer))))

(defun file-cache-read-cache-from-file (file)
    "Clear `file-cache-alist' and read cache from FILE.
  The file cache can be saved to a file using
  `file-cache-save-cache-to-file'."
    (interactive "fFile: ")
    (file-cache-clear-cache)
    (save-excursion
      (set-buffer (find-file-noselect file))
      (beginning-of-buffer)
      (setq file-cache-alist (read (current-buffer)))))
;
  ;did not like the way the iswitchb interface worked, play with icicles
  ;
  ;; (defun file-cache-iswitchb-file ()
  ;;   "Using iswitchb, interactively open file from file cache.
  ;; First select a file, matched using iswitchb against the contents
  ;; in `file-cache-alist'. If the file exist in more than one
  ;; directory, select directory. Lastly the file is opened."
  ;;   (interactive)
  ;;   (let* ((file (file-cache-iswitchb-read "File: "
  ;;                                    (mapcar
  ;;                                     (lambda (x)
  ;;                                       (car x))
  ;;                                     file-cache-alist)))
  ;;          (record (assoc file file-cache-alist)))
  ;;     (find-file
  ;;      (concat
  ;;       (if (= (length record) 2)
  ;;           (car (cdr record))
  ;;         (file-cache-iswitchb-read
  ;;          (format "Find %s in dir: " file) (cdr record))) file))))
  ;
  ;; (defun file-cache-iswitchb-read (prompt choices)
  ;;   (let ((iswitchb-make-buflist-hook
  ;;     (lambda ()
  ;;       (setq iswitchb-temp-buflist choices))))
  ;;     (iswitchb-read-buffer prompt)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;increment numbers at point using evil package
(message "reached before load-evil-numbers")
(when  load-evil-numbers
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/evil-numbers")
    (require 'evil-numbers)
    (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
    (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt))
    ;
    (message "--Error in load-evil-numbers")))
;X000021
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Rectangles
(message "reached before load-my-rectangles")
(when  load-my-rectangles
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-rectangles")
    (require 'my-rectangles)
     (message "Loaded my-rectangles"))
    ;
    (message "--Error in load-my-rectangles")))
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;dos mode
(message "reached before load-dos-mode")
(when  load-dos-mode
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/dos")
    (require 'dos)
    (add-to-list 'auto-mode-alist '("\\.bat$" . dos-mode))
    ;
    ;binding
    (add-hook 'dos-mode-hook
    (lambda ()
     (define-key dos-mode-map (kbd "<f12>") 'write-file))))
    ;
    (message "--Error in load-dos-mode")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Xilinx UCF mode, cool!
(message "reached before load-ucf-mode")
(when  load-ucf-mode
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/ucf-mode")
    (setq auto-mode-alist (cons  '("\\.ucf\\'" . ucf-mode) auto-mode-alist))
    (setq auto-mode-alist (cons  '("\\.ncf\\'" . ucf-mode) auto-mode-alist))
    (add-hook 'ucf-mode-hook '(lambda () (font-lock-mode 1)))
    (autoload 'ucf-mode "ucf-mode")
    (message "Loaded ucf-mode"))
    (message "--Error in load-ucf-mode")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Awk it
(message "reached before load-awk-it")
(when  load-awk-it
  (add-to-list 'load-path "~/.emacs.d/yasnippet")
  (require 'yasnippet)
  (yas-global-mode 1)
  (add-to-list 'load-path "~/.emacs.d/awk-it")
  (require 'awk-it)
;
 ;; maybe make this depend on home/work
 ;; not really using awk it
 ; (defadvice
 ; "Special shell for awk-it!"
 ; (let ((shell-file-name "c:/cygwin/bin/bash.exe"))
 ;   ad-do-it))
;
 (defadvice awk-it-file (around awk-it-file-around)
  "Special shell for awk-it!"
  (let ((shell-file-name "c:/cygwin/bin/bash.exe"))
    ad-do-it))
;
 (defadvice awk-it (around awk-it-around)
  "Special shell for awk-it!"
  (let ((shell-file-name "c:/cygwin/bin/bash.exe"))
    ad-do-it))
;
 (defadvice awk-it-process (around awk-it-process-around)
  "Special shell for awk-it!"
  (let ((shell-file-name "c:/cygwin/bin/bash.exe"))
    ad-do-it))

;; awk-it
;; awk-it-with-separator
;; awk-it-single
;; awk-it-single-with-separator
;; awk-it-raw
;; awk-it-file
;; awk-it-with-file
;; awk-it-to-file
;; awk-it-to-kill-ring
;; awk-it-version
;; awk-it-fs
;; awk-it-full
;; awk-it-process
;; awk-it-yas-completed
;; awk-it-update-yas-field
;; awk-it-next-type
;; awk-it-previous-type
;; awk-it-simple-2-single
;; awk-it-single-2-raw
;; awk-it-raw-2-single
;; awk-it-single-2-simple
;; awk-it-flat-clean-awk
;; awk-it-extract-awk-matches
;; awk-it-find-single
;; awk-it-extract-strings
;; awk-it-return-strings
;; awk-it-get-line-with-max-separators
;; awk-it-n-regex-replace
 (message "reached load awk-it"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;awk-it and find-file-in project want the cygwin interpreter, this made
;shell-command and async-shell-command stop working for Windows oriented
;stuff.
(message "reached before load-inferior-shell-force-windows")
(when  load-inferior-shell-force-windows
;
 (when (eq home-work 'home)
   (setq my-exe-path
      (if (equal emacs-minor-version 3)
      "C:/Users/family/Downloads/emacs/emacs-24.3/bin/cmdproxy.exe"
      ;interesting the path has moved in a relative way
      "C:/Users/family/Downloads/emacs/emacs-24.4/libexec/emacs/24.4/i686-pc-mingw32/cmdproxy.exe")))
                                        ;

  ;; (when (eq home-work 'work)
  ;;   (setq my-exe-path
  ;;      (if (equal emacs-minor-version 3)
  ;;      "C:/Users/mfitzgerald/downloads/emacs/emacs-24.3/bin/cmdproxy.exe"
  ;;      ;interesting the path has moved in a relative way
  ;;      "C:/Users/mfitzgerald/downloads/emacs/emacs-24.4/libexec/emacs/24.4/i686-pc-mingw32/cmdproxy.exe")))
  )

;
(defun my-shell-command ()
  (interactive)
  "Wrap shell command to use the Windows cmd interpreter"
  (let ((shell-file-name my-exe-path))
         (call-interactively 'shell-command)))
;
  (global-set-key (kbd "M-!") 'my-shell-command)
                                        ;

                                        ; --fix me--
; think about this for Linux and windows
;; (defun my-async-shell-command ()
;;   (interactive)
;;   "Wrap async shell command to use the Windows cmd interpreter"
;;   (let ((shell-file-name my-exe-path))
;;          (call-interactively 'async-shell-command)))
;;   ;
;; (global-set-key (kbd "M-&") 'my-async-shell-command)

;
(defun my-shell-command-on-region ()
  (interactive)
  "Wrap async shell command to use the Windows cmd interpreter"
  (let ((shell-file-name my-exe-path))
         (call-interactively 'shell-command-on-region)))
  ;
  (global-set-key (kbd "M-|") 'my-shell-command-on-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;helper for cygwin appeared in context of getting awk-it running.
(message "reached before load-cygwin-helper")
(when  load-cygwin-helper
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (setq shell-file-name "c:/cygwin/bin/bash.exe"))
    ;
    (message "--Error in load-cygwin-helper")))
;
; home
;; (setq shell-file-name
;;    "C:/Users/family/Downloads/emacs/emacs-24.3/bin/cmdproxy.exe")
;
; work
;; (setq shell-file-name
;;   "C:/Users/mfitzgerald/Downloads/EMACS/emacs-24.3/bin/cmdproxy.exe")
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Cygwin
;seems like known issues:
;stackoverflow.com/
;  questions/9670209/cygwin-bash-does-not-display-correctly-in-emacs-shell
(message "reached before load-setup-cygwin")
(when load-setup-cygwin
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/setup-cygwin")
    (require 'setup-cygwin))
    ;
    (message "--Error in load-setup-cygwin")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;FFIP
;see
;http://flooose.github.io/2012/10/20/emacs-comfortable-for-pair-programming.html
;Note for my-find-file-in-project to work, the user needs to complete
;the filename to match rather than entering a hard filename.  See
;my-find-file-in-project.el comments for more explanation.
(message "reached before load-my-find-file-in-project")
(when load-my-find-file-in-project
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-find-file-in-project")
    (require 'my-find-file-in-project)
    ;
    ;not picking on icicles just an example
    (setq ffip-find-options'
       "-not -regex \".*icicles.*\" -not -regex \".*svn.*\"")
    ;recomended
    (setq ffip-limit 1000)
    ;
    (setq ffip-project-file ".projectile")
    (setq ffip-full-paths t)
    (message "reached load find-file-in-project"))
    ;
    (message "--Error in load-my-find-file-in-project")))
;
;; (setq ffip-patterns
;;   '("*.vhd " "*.org" "*.txt" "*.v " "*.el" "*.py" "*.rb"  "*.pl"
;;     "*.sh" "*.do"))
;
;;(defun ffip-project-root ()
;;  "return the folder name trunk, expected use case subversion 1.6 or earlier."
;;  (interactive)
;;  'trunk))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;what is the advantage of this over dired?, has some internet hype, draws me in.
(message "reached before load-nav")
(when load-nav
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/nav")
    (require 'nav)
    (nav-disable-overeager-window-splitting)
    (setq nav-filtered-p nil))
    ;
    (message "--Error in load-nav")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;forward does not jump as much and puts point at the beg of word not the end.
(message "reached before load-viper-4-word-movement")
(when load-viper-4-word-movement
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (setq viper-mode nil)
    (require 'viper)
    (global-set-key [(control meta r)] 'viper-forward-word)
    (global-set-key [(control meta g)] 'viper-backward-word))
    ;
  (message "--Error in load-viper-4-word-movement")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;find-file-in-repository
;Tried this program as a find-file-in-project alternative.
;Issue where it's suposted to fall back into
;regular find-file when not in a version controlled dir.
;Two possibilities
;  -it uses ido in the code alot
;  -it may see some .git files scattered thru my design tree from ffip
;     * Another reason to change the name of the .git file to something else
;       for ffip.
(when load-find-file-in-repository
  (add-to-list 'load-path "~/.emacs.d/find-file-in-repository")
  (require 'find-file-in-repository))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;simp
;simp-project-find-files-generate-find-command generates invalid sed invocation
;https://github.com/re5et/simp/issues/9
;calls sed -E, don't think my sed handles this option
;wierd stuff happens when trying to complete a filename, no filenames appear
;just errors.
;
(message "reached before load-simp")
(when load-simp
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/simp")
    (require 'simp)
    (simp-project-define
     '(:has (.git)
       :ignore (.git))))
    ;
    (message "--Error in load-simp")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;projectile
;  MTF this is the doc string for projectile-maybe-invalidate-cache
;"Invalidate cache if FORCE or project's dirconfig newer than cache."
; which is called first in projectile-find-file.  FORCE means that p-ff
; was called with an arg.
;
; "Remove the current project's files from `projectile-projects-cache'.
; With a prefix argument ARG prompts for the name of the project whose cache
; to invalidate."
;
; This discusses using projectile with git submodules
; https://www.bountysource.com/issues/11208594-use-only-topmost-git-as-project
; In particular the comment by jgkamat ("My final adjustments to solve...")
(message "reached before load-projectile")
(when load-projectile                   ;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/projectile")
    (require 'projectile)
    (setq projectile-use-native-indexing nil)
    ;(setq projectile-use-native-indexing t);slow
    (projectile-global-mode)
    ;
    ;setting to nil bc it takes a long time
    ;
    ;when t seems to automatically create the cache on a find-file hook
    ;when opening files in trees without a .projectile file.
    ;this takes a long time and is distracting.
    (setq projectile-enable-caching nil) ;
    ;(setq projectile-enable-caching t)
    ;
    (setq projectile-completion-system 'default)
    (add-to-list 'projectile-globally-ignored-directories ".svn"))
    ;
  (message "--Error in load-projectile")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;fuzzy-find-in-project
;This project search uses a Ruby,
; fails after completions buffer opens, yes I installed the gem.
(message "reached before load-fuzzy-find-in-project")
(when load-fuzzy-find-in-project
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/fuzzy-find-in-project")
    (require 'fuzzy-find-in-project)
    (fuzzy-find-project-root "~/.emacs.d"))
    ;
  (messege "--Error in load-fuzzy-find-in-project")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ifind
;Works with setup-cygwin t
;does not work with setup-cygwin nil and cygwin helper nil.
;disadvantage is that it has one hard path to a project.
(message "reached before load-ifind")
(when load-ifind
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/ifind/")
    (defvar workspace-dir "~/.emacs.d")
    (load "~/.emacs.d/ifind/ifind-mode.el"))
    ;
  (message "--Error in load-ifind--")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;useful for creating interisting 3-way prompts
;Got it here:http://edward.oconnor.cx/elisp/
(message "reached before load-read-char-spec")
(when load-read-char-spec
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/read-char-spec/")
    (require 'read-char-spec))
    ;
  (message "--Error in load-read-char-spec")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-sr-speedbar")
(when load-sr-speedbar
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/sr-speedbar/")
    ;don't use the icons, they seem to make the user experience of moving cursor
    ;to expand/contract (bound to + and -) more difficult.
    (setq speedbar-use-images nil)
    (require 'sr-speedbar))
    ;
  (message "--Error in load-sr-speedbar")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(message "reached before ")
;A mode to view imenu using tree-widget
;works with .el files, errors out with .vhd
(when load-imenu-tree
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/windata/")
    (add-to-list 'load-path "~/.emacs.d/tree-mode/")
    (add-to-list 'load-path "~/.emacs.d/tree-widget/")
    (add-to-list 'load-path "~/.emacs.d/imenu-tree/")
    (require 'windata)
    (require 'tree-mode)
    (require 'imenu-tree))
    ;
  (message "--Error in load-imenu-tree")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached before load-rebox")
;
(when load-rebox
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    ;
    (add-to-list 'load-path "~/.emacs.d/rebox-2/")
    (setq rebox-style-loop '(20 21 23 25 26 111))
    (require 'rebox2)
    ;
    ; Cycle does not fill
    (global-set-key [(meta f1)] 'rebox-cycle)
    ; dwim fills
    ;;(global-set-key [(shift meta f1)] 'rebox-dwim)
    ;
    ;also alias rc for rebox-cycle
    ;
    ;;; setup rebox for emacs-lisp
    ;(add-hook 'emacs-lisp-mode-hook (lambda ()
    ;                    (set (make-local-variable 'rebox-style-loop) '(25 17 21))
    ;                    (set (make-local-variable 'rebox-min-fill-column) 40)
    ;                    ;; (rebox-mode 1)))
    ;                    ))
;   ;
    ;(add-hook 'vhdl-mode-hook (lambda ()
    ;                    (set (make-local-variable 'rebox-style-loop) '(25 17 21))
    ;                    (set (make-local-variable 'rebox-min-fill-column) 40)
    ;                    ;; (rebox-mode 1)))
    ;                    ))
   )
    ;
  (message "--Error in load-rebox")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;these 2 packages offer similar functionality
;In a split window frame, maintain point after one side switches buffers
;then back.
;pwp uses hooks rather than advice, but has a comment about not being tested
;with emacs24.  Look for any strange behavior associated with buffer switching.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;to toggle on and off per buffer don't set it in the .emacs
;and use M-x pwp-mode
(message "reached before per-window-point")
(when load-per-window-point
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
      (add-to-list 'load-path "~/.emacs.d/per-window-point/")
      (require 'per-window-point)
      (pwp-mode 1)
      (message "After turning on pwp mode"));without this message the sequence of
                                            ;commonds errors, why?
    ;
    (message "--Error in load-per-window-point")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;to toggle on and off per buffer don't set it in the .emacs
;and use M-x window-point-remember-mode
(message "reached before winpoint")
(when load-winpoint
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/winpoint/")
    (require 'winpoint)
    (window-point-remember-mode 1))
    ;
    (message "--Error is load-winpoint")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before workgroups")
;This trys to manage, buffers associated with frames, but wg-create-workgroup
;seems to assign he wrong buffers.  Turn it off for now.
(when load-workgroups
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/workgroups/")
    (require 'workgroups))
    ;this seemed to want to be set in custom and it is presented a little wierd
    ;in custom it looks like ^Cz
    ;(setq wg-prefix-key [(control c z)]) ;did not like trying this to set
    ;
    (message "--Error in load-workgroups")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-hl-defined")
(when load-hl-defined
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    ;; (add-to-list 'load-path "~/.emacs.d/hl-defined/")
    (require 'hl-defined)
    (add-hook 'emacs-lisp-mode-hook 'hdefd-highlight-mode 'APPEND))
    ;
  (message "--Error in load-hl-defined")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-my-utils")
(when load-my-utils
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-utils/")
    (require 'my-utils))
    ;
  (message "--Error is load-my-utils")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before my-paren-setup")
(when load-my-paren-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-paren-setup/")
    (require 'my-paren-setup))
    ;
  (message "--Error in load-my-paren-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when nil
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/voltile-highlights/")
    (require 'volatile-highlights))
    ;
  (message "--Error in load-voltile-highlights")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before my-math-lib")
(when load-my-math-lib
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-math-lib/")
    (require 'my-math-lib))
    ;
  (message "Error in load-my-math-lib")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;this was interesting, had a hard time getting it to stop poping up frames
;with messages about require-final-newline and mode-require-final-newlines
;even when I set them in a mode hook.  It also did some analysis when a file
;opens which seemed to take a long tame sometimes.
(message "reached before ethan-wspace")
(when load-ethan-wspace
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/ethan-wspace/")
    (setq require-final-newlines nil)
    (setq mode-require-final-newlines nil)
    (require 'ethan-wspace)
    (global-ethan-wspace-mode 1)
    (add-hook 'emacs-lisp-mode-hook
      (lambda ()
         (setq require-final-newline nil)
         (setq mode-require-final-newline nil))))
    ;
  (message "--Error in load-ethan-wspace")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;trying out wrap region
;mark a region then type a delimiter to enclose it.
(when load-wrap-region
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/wrap-region/")
    (require 'wrap-region)
    (wrap-region-global-mode t)
    (wrap-region-add-wrapper "{" "}" nil 'ruby-mode))
    ;
  (message "Error in load-wrap-region")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;syntax subword
;; (when load-syntax-subword
(when load-syntax-subword
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/syntax-subword/")
    (require 'syntax-subword)
    (global-syntax-subword-mode))
    ;
  (message "--Error in load-syntax-subword")))
;
;(defun test ()
;  (interactive)
;  ;; (let ((vhdl-underscore-is-part-of-word nil))
;  (setq vhdl-underscore-is-part-of-word nil)
;  (modify-syntax-entry ?_ "w" vhdl-mode-syntax-table)
;  (right-syntax-or-subword 1) )
;  ;
;  (global-set-key [(control meta r)] 'test)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;make a new syntax table, that adds . to a word definition to tempororily
;search for VHDL identifiers that are record types first_part.second_part
;note that I needed to have the _ char here, so this did not add to what
;was already there, but rather over-wrote what was there
; . and _ are parts of words as defined here
(defvar search-for-vhdl-record-types-words-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?. "w" table)
    (modify-syntax-entry ?_ "w" table)
    table))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;syntax-subword performance
;how many press is to get to the end of the "REACHED THE END" LINE
; --WITH SYNTAX-SUBWORD ENABLED--
;   fwd word 12
;   VIM 19
;   syntax 31
; --WITHOUT--
;   fwd word 12
;   vim 19
;   na
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
;test
;something new

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;project
(message "reached before my-project")
(when  load-my-project
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-project/")
    (require 'my-project))
    ;
  (message "--Error in reached before my-project--")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;neotree
; just for opening files, does not copy, move
(message "reached before load-neotree")
(when  load-neotree
  (unless
    (ignore-errors
    ;
    (add-to-list 'load-path "~/.emacs.d/neotree/")
    (message "AOEU")
    (require 'neotree))
    ;
    (message "--Error in load-neotree--")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Fancy narrow
(message "reached before load fancy narrow")
(when  load-fancy-narrow
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/fancy-narrow/")
    (require 'fancy-narrow))
    ;
  (message "--Error is load fancy-narrow--")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bindings
(message "reached before load-my-dvorak-bindings-late")
(when  load-my-dvorak-bindings-late
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-dvorak-bindings/")
    (require 'my-dvorak-bindings)
    t)
    ;
  (message "--Error in load-my-dvorak-bindings-late--")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;autocomplete
; does not work for VHDL mode?
; must turn
(message "reached before auto-complete")
;
  (when  load-auto-complete
  (unless
    (ignore-errors ;if an error occurs return nil

    (add-to-list 'load-path "~/.emacs.d/popup/")
    (require 'popup)
    ;
    (add-to-list 'load-path "~/.emacs.d/auto-complete/")
    (add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-compete")
    (require 'auto-complete-config)
    (ac-config-default))
    ;
    (message "--Error in load-my-dvorak-bindings-early--")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;experiments capturing errors for use in the .emacs
;
; (ignore-errors &rest BODY)
; For more information check the manuals.
; Execute BODY; if an error occurs, return nil.
; Otherwise, return result of last form in BODY.

; Stevev Yegge Emergency Lisp
; If yovu want an empty catch block (just squelch the error), you can use ignore-errors:
;
; (ignore-errors
;   (do-something)
;   (do-something-else))
;
; It's  vvvsometimes a good idea to slap an ignore-errors around bits of elisp code in
; your  vvvstartup file that may not always work, so you can still at least start your
; Emacs vvv up if the code is failing.

  ;; (unless
  ;;  (ignore-errors

  ;; ;begin content
  ;; (progn
  ;;   (message "aoeu")
  ;;   (message "aoeu"))
  ;;   ;end content

  ;;   (message "error"))

;
;(with-demoted-errors "Error: %S" (setp aoeu "aouu"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(message "aoeu")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; want to add some keywords to tcl mode
; this did not work
; http://emacswiki.org/emacs/AddKeywords
; (font-lock-add-keywords 'tcl-mode
;     '("\\.*-work" . font-lock-keyword-face))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bindings
(message "reached before load-company-mode")
(when  load-company-mode
  (unless
    (ignore-errors ;if an error occurs return nil
      ;
      (add-to-list 'load-path "~/.emacs.d/company/")
      ;is this return of nil causing ignore-errores to assert?
      (autoload 'company-mode "company" nil t)
      (eval-after-load 'company
        '(progn
           (define-key company-active-map (kbd "M-t") 'company-select-next)
           (define-key company-active-map (kbd "M-c") 'company-select-previous)
           (diminish 'company-mode)))
        ; ignore-errors returns nil if an error occurs, otherwise return the last
        ; form in the body.
        t)

      ;customized global-company-mode to t, so that it is on everywhere
      ;but I still seem to need the mode hook?
      ;
      ;customized company-idle-delay to (nil), so that in never auto-triggers.
      ;
  (message "--Error in load-company-mode")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;avy jump
(when load-avy-jump-mode
    (unless
      (ignore-errors ;if an error occurs return nil
        (add-to-list 'load-path "~/.emacs.d/avy-jump")
        (require 'avy-jump)
        t)
        (message "--Error in load-avy-jump")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; avy-jump was depricated in favor of avy
(when load-avy-mode
    (unless
      (ignore-errors ;if an error occurs return nil
        (add-to-list 'load-path "~/.emacs.d/avy")
        (require 'avy)
        t)
        (message "--Error in load-avy")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-ace-window")
(when  (and load-ace-window load-avy-mode); ace-window requires avy
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/ace-window")
    (setq aw-keys '(?h ?t ?n ?s ?a ?o ?e ?u ))
    (require 'ace-window)
    t)
    ;
  (message "--Error in load-ace-window")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-multiple-cursors")
;; (when  nil;
(when  load-multiple-cursors;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/multiple-cursors/")
    (require 'multiple-cursors)
    t)
    ;
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key [(control c) (o)]   'mc/edit-linesmyoccur)
  (message "--Error in load-multiple-cursors")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-scratch")
(when  load-scratch;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/scratch/")
    ;(require 'scratch)
    (autoload 'scratch "scratch" nil t)
    t)
    ;
  (message "--Error in load-scratch")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-persp-mode")
; lots of problems with basic operation
(when  nil;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    ;/.emacs.d/persp-mode.el
    (add-to-list 'load-path "~/.emacs.d/persp-mode/")
    ;(require 'scratch)
    (require 'persp-mode)
    (persp-mode 1)
    t)
    ;
  (message "--Error in load-persp-mode")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-persp-mode")
(when  nil;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    ;/.emacs.d/persp-mode.el
    (add-to-list 'load-path "~/.emacs.d/perspective/")
    ;(require 'scratch)
    (require 'perspective)
    ;(perspective t)
    t)
    ;
  (message "--Error in load-persp-mode")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-frame-bufs")
(when  nil;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/frame-bufs/")
    (require 'frame-bufs)
    (frame-bufs-mode t)
    t)
    ;
  (message "--Error in load-scratch")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-powerline")
(when  load-powerline;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/powerline/")
    (require 'powerline)
    (powerline-default-theme)
    ; try removing (powerline-default-theme)
    t)
    ;
  (message "--Error in load-powerline")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-smart-mode-line")
;; (when  load-smart-mode-line;
(when  load-smart-mode-line
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/smart-mode-line/")
    (require 'smart-mode-line)
    (if nil
      (setq sml/theme 'powerline)
      (setq sml/theme 'dark))
    (setq sml/theme 'dark)
    (sml/setup)
    t)
    ;
  (message "--Error in load-smart-mode-line")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before beacon")

(when  (and load-beacon   (>= emacs-major-version 24 ));
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    ;lib seq currently only used by beacon
    (add-to-list 'load-path "~/.emacs.d/seq/")
    (add-to-list 'load-path "~/.emacs.d/beacon/")
    (require 'beacon)
    (beacon-mode 1)
    t)
    ;
  (message "--Error in load-beacon")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-hydra")
(when  load-hydra;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/hydra/")
    (require 'hydra)
    (require 'my-hydras)
    t)
    ;
  (message "--Error in load-hydra")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before my-ibuffer-setup")
(when  load-my-ibuffer-setup
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/my-ibuffer-setup/")
    (require 'my-ibuffer-setup))
    ;
  (message "--Error in load-my-ibuffer-setup")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load-clearcase")
(when  load-clearcase;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/clearcase/")
    (load "clearcase")
    t)
    ;
  (message "--Error in load-clearcase")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; https://kb.iu.edu/d/abun
; # csh commands:
; setenv EDITOR emacsclient
; setenv EDITOR /usr/local/emacs/etc/emacsclient  # using full pathname
(message "reached before start emacs server")
(when  load-start-emacs-server
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (server-start)
    t)
    ;
  (message "--Error in starting emacs server")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; put this on some sort of  after .emacs hook
;
;Use library diminish to clean up the mode line -> do not show minor mode names
;diminish wants to know about minor modes being registered so load last.
(message "reached before load-diminish")
(when load-diminish
  ;
  (unless
    (ignore-errors ;if an error occurs return nil
      (add-to-list 'load-path "~/.emacs.d/diminish/")
      (require 'diminish) t)
      ;
      (message "--Error in load-diminish"))
  ;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (when  load-smart-tab
      (diminish 'smart-tab-mode)) t)
    ;
    (message "--Error in diminish smart tab"))
  ;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (when  load-drag-stuff
       (diminish 'drag-stuff-mode)) t)
    ;
    (message "--Error in diminised drag-stuff"))
  ;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (when  load-awk-it
      (diminish 'yas-minor-mode)) t)
    (message "--Error in diminish awk-it"))
  ;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (when load-wrap-region
     (diminish 'wrap-region-mode)) t)
    ;
    (message "--Error in diminish wrap-region"))
  ;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (when load-undo-tree
      (diminish 'undo-tree-mode)) t)
    ;
    (message "--Error in diminish undo-tree"))
  ;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (when load-elisp-slime-nav
      (diminish 'elisp-slime-nav-mode)) t)
    ;
    (message "--Error in diminish slime-nav"))
  ;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (when load-my-mode
      (diminish 'my-mode)) t)
    ;
    (message "--Error in diminish slime-nav"))
  ;
  ; Moved the diminish of company to where it gets autoloaded in this file
  ; the autoload seemed trickey to work with diminish.
  ; I was trying the code below, but it always errored triggering the message.
  ;
  ; (eval-after-load 'company
  ;   (unless
  ;     (ignore-errors ;if an error occurs return nil
  ;     ;
  ;     (message "got here inside diminish company")
  ;     (when load-company-mode
  ;       (diminish 'company-mode)) t)
  ;     ;
  ;     (message "--Error in diminish company mode")))
  ;
    ) ;matches when load-diminish
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before peep dired")
(when  load-peep-dired;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (add-to-list 'load-path "~/.emacs.d/peep-dired/")
    (require 'peep-dired)
    ; Note it can't be run from a mode hook bc it wants a file name at point
    ; at the time runs.  When the hook is runnintg there is no filename at
    ; point so it errors.
    ;(peep-dired 1)
    t)
    ;
  (message "--Error in load-peep-dired")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load zygospore.")
(when  load-zygospore
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    ;(add-to-list 'load-path "~/.emacs.d/peep-dired/")
    (add-to-list 'load-path "~/.emacs.d/zygospore/")
    (require 'zygospore)
    t)
  (message "--Error in load-zygospore")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this promets for remote's (based on flies in history) password at emacs start
; maybe a defun which contains the (setq tramp-default-method "ssh") line
(message "reached before load tramp")
;; (when  load-tramp-settings
; MTF 8/3/2017, setting (setq tramp-default-method "ssh") causes tramp to
; fail to connect, saying "cant' find ls"
; Also this started with emacs 24.3
; I uninstalled all emacs then re-installed 25
; Was able to get to the point where tramp was workintg as long as I don's set
; the variable.
; Then I re-instaled emacs24.4, and I was not longer able to get tramp to
; connect at all (can't find ls issue).
; To recover after this I removed all emacs and re-installed emacs25 and
; removed the .emacs.d/tramp file which is some kind of buffered settings
; for tramp to remember connections.  It seems as if it can rember bad settings
; then those bad settings prevent future connections.
(when load-tramp-settings
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (setq tramp-verbose 6)
    (setq tramp-default-method "ssh")
    t)
  (message "--Error in load-tramp-settings")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load my-mode")
(when  load-my-mode
  (unless 
    (ignore-errors ;if an error occurs return nil
    (add-to-list 'load-path "~/.emacs.d/my-mode/")
    (require 'my-mode)
    t)
  (message "--Error in load-my-mode")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load ack-and-a-half")
(when  load-ack-and-a-half
  (unless 
    (ignore-errors ;if an error occurs return nil
    (add-to-list 'load-path "~/.emacs.d/ack-and-a-half/")
    (require 'ack-and-a-half)
    (defalias 'ack 'ack-and-a-half)
    (defalias 'ack-same 'ack-and-a-half-same)
    (defalias 'ack-find-file 'ack-and-a-half-find-file)
    (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
    t)
  (message "--Error in load-ack-an-a-half")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached before load bookmarks bmenu at init")
(when  load-start-menu-at-init;
  (unless
    (ignore-errors ;if an error occurs return nil
    ;
    (defun my-start-bookmarks-at-init ()
      (interactive)
      (let ((pop-up-frames nil))
      (bookmark-bmenu-list)
      (switch-to-buffer "*Bookmark List*")))
    ;
    (defun my-start-sr-at-init-fn ()
      (interactive)
      (make-frame-command)
      (message "%s" (selected-frame))
      (call-interactively 'mike/sunrise))
    ;
    (defun my-foo-fn ()
          (interactive)
          (message "foo"))
    ;
    (add-hook  'emacs-startup-hook 'my-start-bookmarks-at-init)
    ; this is trouble fix someday
    (add-hook  'emacs-startup-hook 'my-start-sr-at-init-fn)
    (add-hook  'emacs-startup-hook 'my-foo-fn)
    ;
    t)
  (message "--Error in load bookmarks at init")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; final message
(message "---REACHED END OF THE %s for %s system---" (buffer-name) home-work)
; add a line here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
