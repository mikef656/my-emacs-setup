;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
(setq custom-file "~/.emacs-custom.el")
(load custom-file 'noerror)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-home-work-pk t)
(setq load-my-dvorak-bindings t)
;
(setq load-special-searches t)
(setq load-my-smex-setup t)
(setq load-frame-win-setup t)
(setq load-color-theme-setup-early t)
(setq load-color-theme-setup-late nil)
(setq load-move-ins-sel-kill t)
(setq load-block-move t)
(setq load-insert-signal t)
(setq load-file-orient-fns t)
(setq load-shell-current-directory t)
(setq load-undo-tree t)
(setq load-highlight-symbol t)
(setq load-ibuffer t)
(setq load-vc-svn t)
(setq load-my-tinyeat-setup t)
(setq load-filesets t)
(setq load-drag-stuff t)
(setq load-my-vhdl-setup t)
(setq load-my-wm3-setup t)
(setq load-saveplace t)
(setq load-my-dvorak-mapped-bindings t)
(setq load-my-ibuffer-setup t)
(setq load-my-org-setup t)
;
(setq load-elisp-format nil);--
(setq load-fastnav nil);--
(setq load-smart-tab nil);--
(setq load-my-ido-setup t);--
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-my-icicle-setup nil)
;
(setq load-oneonone t)
;
;make this nil for light themes
(setq load-oneonone-params t);fix bad backgrounds in light themes
;
(setq load-icicles-iswitchb t);
(setq load-replace+ t);


(setq load-iswitchb-highlight t)
;
(setq load-icicles t)
(setq load-help-fns+ t)        
(setq load-facemenu+ t)    
(setq load-doremi-cmd t)
;
(setq load-fit-frame t)
(setq load-autofit-frame t)
(setq load-zoom-frm t)

(setq load-frame-cmds t)
;
(setq load-thing-edit t)
(setq load-thing-cmds t)
(setq load-thingatpt+ t)
;
(setq load-my-isearch-plus-setup t)
;
(setq load-my-dired-setup t)
;
(setq load-sunrise-commander t)
;
(setq load-my-bookmarks-setup t)
;
(setq load-cursor-chg t)
;
(setq load-browse-kill-ring+ nil);--
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;Always use the same bookmarks file at home
;; (when (eq home-work 'home)
;;   (setq bmkp-last-as-first-bookmark-file "~/my-emacs.bmk"))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;utility modes
(setq load-delete-selection-mode t)
(setq load-global-linum-mode t)
(setq load-savehist-mode t)
(setq load-recentf-mode t)
(cua-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Holds a single contstat, determines home or work
(add-to-list 'load-path "~/.emacs.d/home-work-pk/")
(when (eq load-home-work-pk t)
  (require 'home-work-pk))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/cursor-chg/")
(when (eq load-oneonone nil)
   ;
   (require 'cursor-chg)  ; Load this library
   (change-cursor-mode 1) ; on for overwrite/read-only/input mode
   (toggle-cursor-type-when-idle 1) ; on when idle
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bindings
(add-to-list 'load-path "~/.emacs.d/my-dvorak-bindings/")
(when (eq load-my-dvorak-bindings t)
  (require 'my-dvorak-bindings))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq make-backup-files nil) ; stop creating those backup~ files
(setq auto-save-default nil) ; stop creating those #autosave# files
(put 'narrow-to-region 'disabled nil)
(setq revert-without-query (quote (".*transcript")))
;
;isearch history
(setq history-length 90) ; emacs default is 30
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Needed for browse kill ring and icicle yank maybe completing
(when (eq load-delete-selection-mode t)
  (delete-selection-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Recent filets
;
(when (eq load-recentf-mode t)
  (recentf-mode 1)
  ;(archive-mode 1)
  (setq recentf-max-saved-items 256))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bindings
(add-to-list 'load-path "~/.emacs.d/my-dvorak-bindings/")
(require 'my-dvorak-bindings)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-savehist-mode t)
  (savehist-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  special-searchs package
(add-to-list 'load-path "~/.emacs.d/special-searches/")
(when (eq load-special-searches t)
  (require 'special-searches))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://emacswiki.org/emacs/elisp-format.el  
(add-to-list 'load-path "~/.emacs.d/elisp-format/")
(when (eq load-elisp-format t)
  (require 'elisp-format))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/my-smex-setup/")
(when (eq load-my-smex-setup t)
  (require 'my-smex-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/frame-win-setup/")
(when (eq load-frame-win-setup t)
  (require 'frame-win-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/my-color-theme-setup/")
(when (eq load-color-theme-setup-early t)
  (require 'my-color-theme-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  move insert package
(add-to-list 'load-path "~/.emacs.d/move-ins-sel-kill/")
(when (eq load-move-ins-sel-kill t)
  (require 'move-ins-sel-kill))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; block move packageock-move/")
(add-to-list 'load-path "~/.emacs.d/block-move/")
(when (eq load-block-move t)
  (require 'block-move))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/insert_signal/")
(when (eq load-insert-signal t)
  (require 'insert-signal))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/my-dired-setup/")
(when (eq load-my-dired-setup t)
  (require 'my-dired-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/file-orient-fns/")
(when (eq load-file-orient-fns t)
  (require 'file-orient-fns))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Fastnav jump to or zap to char (zap copies to kill ring)
(add-to-list 'load-path "~/.emacs.d/fastnav/")
(when (eq load-fastnav nil)
  (require 'fastnav))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;shell
  (add-to-list 'load-path "~/.emacs.d/shell-current-directory/")
(when (eq load-shell-current-directory t)
  (require 'shell-current-directory))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;undo
(add-to-list 'load-path "~/.emacs.d/undotree/")
(when (eq load-undo-tree t)
  (require 'undo-tree)
  (global-undo-tree-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Highlight Symbol
;http://nschum.de/src/emacs/highlight-symbol/
; MTF Consider binding highlight-symbol-query-replace
(add-to-list 'load-path "~/.emacs.d/highlight-symbol/")
(when (eq load-highlight-symbol t)
  (require 'highlight-symbol)
  (setq highlight-symbol-on-navigation-p t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ibuffer:
(when (eq load-ibuffer t)
  (require 'ibuffer)
  (setq ibuffer-default-sorting-mode 'file-name)
  (setq ibuffer-always-show-last-buffer t)
  (setq ibuffer-view-ibuffer t))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (add-to-list 'load-path "~/.emacs.d/my-bookmarks-setup/")
(when (eq load-my-bookmarks-setup t)
  (require 'my-bookmarks-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/thing_edit/")
(when (eq load-thing-edit t)
  (require 'thing-edit))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Subversion package DSVN
(add-to-list 'load-path "~/.emacs.d/dsvn/")
(when (eq load-vc-svn t)

  (autoload 'svn-status "dsvn" "Run `svn status'." t)
  (autoload 'svn-update "dsvn" "Run `svn update'." t)
  ;
  (require 'vc-svn)) ;this seemed to help give a svn status --verbose report
;rather than just svn status.
;; To get the status view, type
;;   M-x svn-status
;;Choose a dir
;;Type ? for help
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/my-tinyeat-setup/")
(when (eq load-my-tinyeat-setup t)
  (require 'my-tinyeat-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Filesets
;http://www.emacswiki.org/emacs/filesets%2b.el
(when (eq load-filesets t)
  (require 'filesets)
  (filesets-init))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/thingatpt_plus/")
(add-to-list 'load-path "~/.emacs.d/thing_cmds/")
(when (eq load-thing-cmds t)
 (require 'thing-cmds)
 (thgcmd-bind-keys) ; Only if you want the key bindings it defines
 (eval-after-load "thingatpt" '(require 'thingatpt+)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;only left and right are bound
(add-to-list 'load-path "~/.emacs.d/drag_stuff/")
(when (eq load-drag-stuff t)
  (require 'drag-stuff)
  (drag-stuff-global-mode t)
  (add-to-list 'drag-stuff-except-modes 'org-mode))
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
(add-to-list 'load-path "~/.emacs.d/my-vhdl-setup/")
(when (eq load-my-vhdl-setup t)
  (require 'my-vhdl-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Smart tab
;not sure if i like it want minibuf completion for isearch?
(add-to-list 'load-path "~/.emacs.d/smart-tab/")
(when (eq load-smart-tab nil)

  (require 'smart-tab)
  (global-smart-tab-mode 1))
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
(when (eq load-my-org-setup t)
  (add-to-list 'load-path "~/.emacs.d/my-org-setup/")
  (require 'my-org-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Icicles
(add-to-list 'load-path "~/.emacs.d/my-icicle-setup/")
(when (eq load-my-icicle-setup t)
  (require 'my-icicle-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Note that there is a dependancy on the load path associated with icicles
;for loading lib "highlight" in lib "replace+" in this file.  So do add
;the icicle load path before loading these libs
(add-to-list 'load-path "~/.emacs.d/my-isearch-plus-setup/")
(when (eq load-my-isearch-plus-setup t)
  (require 'my-isearch-plus-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  ;Ido
;  ;3-7-12 found a function online that makes ido work nice for bookmark junps
;  ;but the same package messes up +, C , R in dired. Not sucessful turning
;  ;it off for dired because the bookmark jump uses dired.
;  ;
(add-to-list 'load-path "~/.emacs.d/my-ido-setup/")
(when (eq load-my-ido-setup t)
  (require 'my-ido-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Browser
(add-to-list 'load-path "~/.emacs.d/my-wm3-setup/")
(when (eq load-my-wm3-setup t)
(when (eq home-work 'work)
   (require 'my-wm3-setup)
))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;save place
(when (eq load-saveplace t)
  (require 'saveplace)
  (setq-default save-place t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bindings
(add-to-list 'load-path "~/.emacs.d/my-dvorak-mapped-bindings/")
(when (eq load-my-dvorak-mapped-bindings t)
  (require 'my-dvorak-mapped-bindings))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/my-ibuffer-setup/")
(when (eq load-my-ibuffer-setup t)
  (require 'my-ibuffer-setup))
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
(when (eq load-global-linum-mode t)
  (global-linum-mode t))
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
(add-to-list 'load-path "~/.emacs.d/my-color-theme-setup/")
(when (eq load-color-theme-setup-late t)
  (require 'my-color-theme-setup))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;emacs wants this in the  late in the .emacs (otherwise somethin else turns
;toolbars back on. 
(tool-bar-mode -1)
(message "*** toolbars off ***")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


