;perhaps this needs a sunrise version
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun jump-up (&optional arg)
;;    "IN DIRED, use arrow keys like Win7."
;;    (interactive )
;;    (find-alternate-file"..")
;;    ;(sr-mode)
;; )
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (add-to-list 'load-path "~/.emacs.d/sunrise-commander/")
  (setq sr-show-file-attributes nil)
  ;(setq sr-kill-unused-buffers nil)
  (require 'sunrise-commander)
  ;(require 'sunrise-x-buttons)
  (require 'sunrise-x-modeline)
  (require 'sunrise-x-tree)
  ;(require 'sunrise-x-w32-addons)
  ;  
  (if (eq load-sunrise-x-tabs t)(require 'sunrise-x-tabs))
  ;
  (if (eq load-sunrise-popup-viewer t)(require 'sunrise-x-popviewer))
  ;
  (require 'sunrise-x-modeline)
  ;
  (add-to-list 'auto-mode-alist '("\\.srvm\\'" . sr-virtual-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq dired+-in-sunrise t)
  (add-to-list 'load-path "~/.emacs.d/icicles/")
  (require 'dired+))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dired-w32explore, dired-w32-browser, dired-mouse-w32-browser
(when (eq load-w32-browser-in-sunrise t)
  (add-to-list 'load-path "~/.emacs.d/dired_plus/")
  (require 'w32-browser ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq sr-listing-switches " --time-style=locale --group-directories-first -alDhgG")
;;
;This may fix the problem where the number of fields are not uniform
;  --time-style=long-iso
;
;(setq sr-listing-switches " --time-style=locale --group-directories-first -alDhgG")
;; (setq sr-listing-switches " --group-directories-first -alDhgG")
(setq sr-listing-switches " -al")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'sr-mode-hook
   (lambda ()
   ;(dired-details-show)
   ;(fit-frame)
   ;(dired-details-hide)
   ;(set (make-local-variable 'autofit-frames-flag) nil) 
   ;
   ;only worked for one size screen and it was irritating when othre sr defuns
   ;were run bc the frame size jumped.
   ;(set-frame-size sr-current-frame 180 30)  
   ;instead use something like x-display-pixel-width or another in or around
   ;(move-frame-to-screen-right)
   ;
   ; this does not work (smart-mode-line-mode)
   (define-key sr-mode-map (kbd "<f2>") 'sr-editable-pane)
   (define-key sr-mode-map (kbd "<f3>") 'nil)
   (define-key sr-mode-map (kbd "<f4>") 'nil)
   (define-key sr-mode-map (kbd "<f5>") 'nil)
   (define-key sr-mode-map (kbd "C-e") 'nil)
   (define-key sr-mode-map (kbd "/") 'nil)
   (define-key sr-mode-map (kbd "/") 'dired-sort-menu-toggle-dirs-first)
   ;
   (define-key sr-mode-map (kbd "<f4>") 'sr-goto-dir);like windows
   (define-key sr-mode-map (kbd "<f11>") 'sr-recent-directories)
   (define-key sr-mode-map (kbd "M-t") 'nil)
   (define-key sr-mode-map (kbd "M-B") 'nil)
   (define-key sr-mode-map (kbd "M-n") 'nil)
   (define-key sr-mode-map (kbd "C-.") 'nil)
   (define-key sr-mode-map (kbd "C-.") 'show-file-name-general-sr)
   ;
   (define-key sr-mode-map (kbd "C-n") 'sr-scroll-up)
   (define-key sr-mode-map (kbd "C-S-N") 'sr-scroll-down)
   ;
   (define-key sr-mode-map [(kp-up)] 'sr-prev-line-other)
   (define-key sr-mode-map [(kp-down)] 'sr-next-line-other)
   ;(define-key sr-mode-map "backspace" 'sr-scroll-quick-view-down)  
   (define-key sr-mode-map (kbd "M-b") 'nil)
   (define-key sr-mode-map (kbd "M-B") 'nil)
   (define-key sr-mode-map (kbd "M-B") 'sr-end-of-buffer)
   (define-key sr-mode-map (kbd "M-f") 'nil)
   (define-key sr-mode-map (kbd "M-F") 'sr-beginning-of-buffer)
   (define-key sr-mode-map (kbd "C-c r") 'sr-transpose-panes)
   (define-key sr-mode-map (kbd "C-c t") 'mike-sr-term)
   (define-key sr-mode-map (kbd "C-'") 'sr-reset-panes)
   (define-key sr-mode-map (kbd "C") 'dired-do-copy)
   (define-key sr-mode-map [(meta C)] 'sr-do-copy)
   (define-key sr-mode-map [(meta P)] 'eshell-next-matching-input-from-input)
   (define-key sr-mode-map (kbd "R") 'dired-do-rename) 
   (define-key sr-mode-map [(meta R)] 'sr-do-rename)
   (define-key sr-mode-map [(meta right)] 'sr-history-next)
   (define-key sr-mode-map [(meta left)] 'sr-history-prev)
   (define-key sr-mode-map [(meta up)] 'sr-dired-prev-subdir)
   (define-key sr-mode-map [(meta q)] 'smex);was sunrise cd
   (define-key sr-mode-map [(meta down)] 'sr-advertised-find-file)
   (define-key sr-mode-map [(meta \])] 'my-sr-enlarge-left-pane)
   (define-key sr-mode-map [(meta \[)] 'my-sr-enlarge-right-pane)
   ;; (define-key sr-mode-map [(meta \})] 'sr-enlarge-panes)
   (define-key sr-mode-map [(meta \})] 'my-sr-enlarge-panes-dwim)
   (define-key sr-mode-map [(meta \{)] 'my-sr-shrink-panes-dwim)
   ;(define-key sr-mode-map [(control  .)] 'dired-copy-filename-as-kill)
   ;(define-key dired-mode-map [(control  .)] 'dired-copy-filename-as-kill)
   (define-key dired-mode-map [(meta shift b)] 'diredp-do-bookmark)
   ;not sure why it's on the dired mode map here(define-key dired-mode-map [(meta up)] 'jump-up)
   (define-key dired-mode-map (kbd "h") 'nil);this is help is sunrise, hardlink in dired
   (linum-mode 0)
   ;(setq fit-frame-inhibit-fitting-flag t)
   ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun sr-reset-panes ()
      "Hard-reset SC panes."
      (interactive)
      (when sr-running (sr-setup-windows)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ZIP STUFF
;http://stackoverflow.com/questions/1431351/how-do-i-uncompress-unzip-within-emacs
;ZIP:To zip files (create new archive), 
;  1) Open the directory in dired. 
;  2) Mark the files you want to zip with m. 
;  3a)(if marked is top dir tree) type ! zip -r my-new.zip * <RET> ***NOT M-!***
;  3b)(if marked are files)       type ! zip my-new.zip * <RET>
;
;  3b)alt(if marked are files) Use "z" from the above defun
;  keystroke '!' runs the command:
;     dired-do-shell-command Run a shell command COMMAND on the marked files.
;;  
;UNZIP:To extract archive
;  from dired mark a file and run '&' ***NOT M-&***
;     keystroke '&' runs
;        dired-do-async-shell-command
;        Run a shell command COMMAND on the marked files asynchronously
;;
;zip-archive mode will allow you to browse zip files in a dired-like fashion. 
;  It should come with recent versions of GNU emacs and will be used by default when 
;  you visit a file with the .zip extension. From this mode you can 
;  extract individual files into a buffer, and from there save them with C-x C-s.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq sr-attributes-display-mask '(nil nil nil nil nil nil ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;something does not like this as a hook
(if (fboundp 'sr-scroll-quick-view-down)
  (define-key sr-mode-map [backspace]   'sr-scroll-quick-view-down))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mike/sunrise ()
  (interactive)
  (let (
   (fit-frame-inhibit-fitting-flag t)
   (window-min-width 10)
   (special-display-regexps nil)
   (pop-up-frames nil)
   (left-dir default-directory))
  ;
  (sunrise)
  ;
  (cond
    ((eq screen-size 'work-big)
         ;; (set-frame-size (selected-frame) 230 65)) ;
         ;W why did I have this huge # 185 fills the width of one monitor yes?
         ;
         ;; (set-frame-size (selected-frame) 185 40)) ;W
         ;; this is good for MSI Linux box 12/15/2016
         (set-frame-size (selected-frame) 170 40)) ;W
    ;
    ((eq screen-size 'work-small)
      (if (string-equal system-type "gnu/linux")
         (set-frame-size (selected-frame) 166 39) ;46 is the max for linux
         (set-frame-size (selected-frame) 165 40))) ;W??
    ;
    ((eq screen-size 'home)
         (set-frame-size (selected-frame) 140 40))
         (set-frame-size (selected-frame) 140 40))
  ;
  (sr-select-window 'left)
  (sr-goto-dir left-dir)
  ; both panes will be the same
  (sr-goto-dir-other left-dir)))
   
  ;; (sr-goto-dir-other path-to-desktop)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;SOME TOOLS TO HELP CHANGE FRAMES
;(select-frame-by name "my-sunrise")
;C-x 5 o runs the command icicle-select-frame
;(get-frame-name)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Did this because the frame Name "SUNRISE" is stickey after it is set
;even if the user changed buffers
;
;Has an issue, When you hit enter to get open a file the frame it would
;have been displayed in is deleted.
;; (defadvice sr-quit (around  my-sr-quit 0 nil activate)
;;   ad-do-it
;;   (delete-frame nil t); ARGS: frame FORCE
;;   ) 

;; (defadvice switch-to-buffer (around  my-switch-to-buffer-advice 0 nil activate)
;;   ad-do-it
;;   (set-frame-name (buffer-name)); ARGS: frame FORCE
;;   ) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(defun mike-sr-term ()
;"don't want the term to pop-up"
;  (interactive)
;  ;prevent the pop-up
;  (setq special-display-regexps nil)
;  (setq pop-up-frames nil)
;  ;open the term
;  (sr-term)
;  ;put back the environment
;  (setq pop-up-frames t) 
;  (setq special-display-regexps  '("[ ]?[*][^*]+[*]")))

  (defun mike-sr-term ()
    "don't want the term to pop-up"
      (interactive)
      (let ((special-display-regexps nil)
            (pop-up-frames nil))
        (sr-term)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq sr-traditional-other-window t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-ido-sunrise t)
(defun ido-sunrise ()
 "Call `sunrise' the ido way.
 The directory is selected interactively by typing a substring.
 For details on keybindings, see `ido-find-file'."
   (interactive)
   (let ((ido-report-no-match nil)
     (ido-auto-merge-work-directories-length -1))
     (ido-file-internal 'sr-dired 'sr-dired nil "Sunrise: " 'dir)))
;
 (define-key (cdr (assoc 'ido-mode minor-mode-map-alist)) [remap dired]
   'ido-sunrise))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mike/eshell ()
  (interactive)
  "Open an eshell buffer same window-frame"
  (let (
   (fit-frame-inhibit-fitting-flag t)
   (window-min-width 10)
   (special-display-regexps nil)
   (pop-up-frames nil)
   )  
  (eshell "mikes-eshell")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; desktop
; seems like a mess
(when nil
  (desktop-save-mode 1)
  (desktop-read "C:/Users/family/Desktop/.emacs.desktop"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end if my-sunrise-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-sunrise-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
