;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun eshell/emacs (&rest args)
  "Open a file in emacs using a wildcard; ex *.vhd"
  (if (null args)
      ;; If I just ran "emacs", I probably expect to be launching
      ;; Emacs, which is rather silly since I'm already in Emacs.
      ;; So just pretend to do what I ask.
      (bury-buffer)
    ;; We have to expand the file names or else naming a directory in an
    ;; argument causes later arguments to be looked for in that directory,
    ;; not the starting directory
    (mapc #'find-file (mapcar #'expand-file-name 
                              (eshell-flatten-list (reverse args))))))  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun tyler-eshell-view-file (file)
  "A version of `view-file' which properly respects the eshell prompt."
  (interactive "fView file: ")
  (unless (file-exists-p file) (error "%s does not exist" file))
  (let ((had-a-buf (get-file-buffer file))
        (buffer (find-file-noselect file)))
    (if (eq (with-current-buffer buffer (get major-mode 'mode-class))
            'special)
        (progn
          (switch-to-buffer buffer)
          (message "Not using View mode because the major mode is special"))
      (let ((undo-window (list (window-buffer) (window-start)
                               (+ (window-point)
                                  (length (funcall eshell-prompt-function))))))
        (switch-to-buffer buffer)
        (view-mode-enter (cons (selected-window) (cons nil undo-window))
                         'kill-buffer)))))


(defun eshell/less (&rest args)
"Invoke `view-file' on a file. \"less +42 foo\" will go to line 42 in
the buffer for foo, opens buffer in view mode."
(while args
  (if (string-match "\\`\\+\\([0-9]+\\)\\'" (car args))
      (let* ((line (string-to-number (match-string 1 (pop args))))
             (file (pop args)))
        (tyler-eshell-view-file file)
        (goto-line line))
    (tyler-eshell-view-file (pop args)))))


                                                                                                                       
(defalias 'eshell/more 'eshell/less)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; clear the buffer in eshell
(defun eshell/clear ()
  "clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;mode hook
(add-hook 'eshell-mode-hook
 (lambda ()
 ;
 (define-key eshell-mode-map [(control tab)]   'sr-ti-change-window)
 (define-key eshell-mode-map [(meta ?p)] 'eshell-previous-matching-input-from-input)
 (define-key eshell-mode-map [(meta ?P)] 'eshell-next-matching-input-from-input)

 ;
 (define-key eshell-mode-map [(control meta r)] 'my-hdl-right-syntax-or-subword) 
 (define-key eshell-mode-map [(control meta g)] 'my-hdl-left-syntax-or-subword) 
 ;
 (define-key eshell-mode-map (kbd "C-a") 'eshell-maybe-bol)
 (define-key eshell-mode-map (kbd "M-B") 'my-goto-eob-meaningful)
 ;
 (if (< emacs-major-version 24) 
   ;T
   (define-key eshell-mode-map   (kbd "M-b")	'backward-word)
   ;F
   (define-key eshell-mode-map  (kbd "M-b")	'my-left-word))
 ;
 (define-key eshell-mode-map (kbd "M-f") 'forward-word-dont-go-over-non-words)
 (define-key eshell-mode-map (kbd "M-n") nil)
 ;(define-key eshell-mode-map (kbd "M-.") nil)
 (define-key eshell-mode-map (kbd "M-r") nil)
 (define-key eshell-mode-map (kbd "C-c SPC") 'nil) 
 (define-key eshell-mode-map (kbd "C-.") 'show-file-name-from-shell-modes) 
 (define-key eshell-mode-map (kbd "<M-prior> ") 'eshell-previous-prompt)
 (define-key eshell-mode-map (kbd "<M-next> ") 'eshell-next-prompt)
 (define-key eshell-mode-map (kbd "M-\{") 'my-sr-enlarge-panes-eshell-dwim)
 (define-key eshell-mode-map (kbd "M-\}") 'my-sr-shrink-panes-eshell-dwim)
 ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-sr-shrink-panes-eshell-dwim (&optional arg) 
  "shrink the barrier when using SR and in the eshell window"
  (interactive)
      (if (> (window-total-height) 25)
        (progn
          (other-window 1)
          (my-sr-enlarge-panes 10))
        (progn
          (other-window 1)
          (my-sr-enlarge-panes 3)))
      (other-window 1)
      (other-window 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-sr-enlarge-panes-eshell-dwim (&optional arg) 
  "enlarge the barrier when using SR and in the eshell window"
  (interactive)
      (if (< (window-total-height) 40)
        (progn
          (other-window 1)
          (my-sr-shrink-panes 10))
        (progn
        (other-window 1)
        (my-sr-shrink-panes 3)))
      (other-window 1)
      (other-window 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;
  
;(global-set-key (kbd "<S-f6>") 'my-sr-shrink-panes-dwim)
;(global-set-key (kbd "<M-S-f6>") 'my-sr-enlarge-panes-dwim)
;
(defun my-sr-shrink-panes-dwim (&optional arg) 
  (interactive)
  (if (equal major-mode 'sr-mode)  
    ;T
    (progn
      (if (> (window-total-height) 20)
      (my-sr-shrink-panes 10)
      (my-sr-shrink-panes 3)))
      ;
    (progn (four-x-other-window-height))
  ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun eshell-maybe-bol ()
 "Go to the beginning of the command line, unless it is already there, in 
  which case it goes to the beginning of the line. So if you are at the end of 
  the command line and want to go to the real beginning of line, hit C-a twice"
  (interactive)
  (let ((p (point)))
    (eshell-bol)
    (if (= p (point))
        (beginning-of-line))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'em-rebind)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when nil
  (setq eshell-prompt-function
      (lambda ()
        (concat (eshell/pwd) "\n $ "))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when t
  (setq eshell-prompt-function
          (lambda ()
            (concat (eshell/pwd) "\n$"))
          eshell-prompt-regexp (concat "^" (regexp-quote "$"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; don't use this variation, it interfered with history key bindings 
; in wierd ways.
(when nil
  (setq eshell-prompt-function
        (lambda()
          (concat (getenv "USER") "@" (getenv "HOST") ":"
                  ((lambda (p-lst)
                     (if (> (length p-lst) 3)
                         (concat
                          (mapconcat (lambda (elm) (substring elm 0 1))
                                     (butlast p-lst (- (length p-lst) 3))
                                     "/")
                          "/"
                          (mapconcat (lambda (elm) elm)
                                     (last p-lst (- (length p-lst) 3))
                                     "/"))
                       (mapconcat (lambda (elm) elm)
                                  p-lst
                                  "/")))
                   (split-string (eshell/pwd) "/"))
                  (if (= (user-uid) 0) " # " " $ ")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when nil
(defun ted-eshell-prompt ()
  "An Eshell prompt that's just like my csh prompt."
  ;; from ~/.cshrc:
  ;; set prompt = "\n%n in %B%~%b on %B%m%b's %l at %t\n(h=%h, r=%?)%# "
  ;; set promptchars = ":#"
  (let ((user (or (getenv "USER") user-login-name "ted"))
        (wd (eshell/pwd))
        (host (car (split-string (or (getenv "HOST")
                                     system-name
                                     "unknown")
                                 "\\.")))
        (term (concat ted-emacs-name (format "/%d" (emacs-pid))))
        (time (let ((time-1 (downcase (format-time-string "%l:%M%p"))))
                (if (char-equal (aref time-1 0) ?\ )
                    (substring time-1 1)
                  time-1)))
        ;; based on `eshell-exit-success-p'
        (r (if (save-match-data
                 (string-match "#<\\(Lisp object\\|function .*\\)>"
                               (or eshell-last-command-name "")))
               (format "%s" eshell-last-command-result)
             (number-to-string eshell-last-command-status)))
        (h (number-to-string (+ 1 (ring-length eshell-history-ring))))
        (char (if (= (user-uid) 0) "#" ":")))
    (concat "\n" user
            " in " wd
            " on " host "'s " term
            " at " time
            "\n"
            "(h=" h ", "
            "r=" r ")"
            char " "))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mtf
(when nil
(defmacro with-face (str &rest properties)
   `(propertize ,str 'face (list ,@properties)))
; 
(defun shk-eshell-prompt ()
  (let ((header-bg "#fff"))
    (concat
     (with-face (concat (eshell/pwd) " ") :background header-bg)
     (with-face (format-time-string "(%Y-%m-%d %H:%M) " (current-time)) :background header-bg :foreground "#888")
     (with-face
      (or (ignore-errors (format "(%s)" (vc-responsible-backend default-directory))) "")
      :background header-bg)
     (with-face "\n" :background header-bg)
     (with-face user-login-name :foreground "blue")
     "@"
     (with-face "localhost" :foreground "green")
     (if (= (user-uid) 0)
         (with-face " #" :foreground "red")
       " $")
     " ")))
 
 (setq eshell-prompt-function 'shk-eshell-prompt)
 (setq eshell-highlight-prompt nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; from Xah Lee
; get eshell path from host computer
; by prepending new paths to existing paths
(setenv "PATH"
  (concat
   "~/mybin" ";"
   (getenv "PATH") ; inherited from OS
  ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "reached end of my-eshell setup")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-eshell-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
