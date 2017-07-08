;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;C-h to get help during isearch
; During isearch help:
;    Type <f1> b to display all Isearch key bindings. 
;    Type <f1> k to display documentation of Isearch key. (MTF like C-h-k)
;    Type <f1> m to display documentation of Isearch mode.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;enable the use of vertical scrolling during incremental search
(setq isearch-allow-scroll t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Isearch Plus 
;(add-to-list 'load-path "~/.emacs.d/isearch_plus/");moved to .emacs.d\icicles
(eval-after-load "isearch" '(require 'isearch+))
;
; rolls both query-replace and  query-replace-regexp into one command. 
; Prefix:
;   None  replace literal string matches
;   Non-negative  replace word matches
;   Negative  replace regexp matches
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Replace plus
;(add-to-list 'load-path "~/.emacs.d/replace_plus/") moved to .emacs.d\icicles

(when (eq load-replace+ t)
  (eval-after-load "replace"
      '(progn (require 'replace+)))
  ;
  (add-hook 'kill-buffer-hook 'occur-unhighlight-visited-hits)
)
;
(substitute-key-definition 'query-replace 'query-replace-w-options global-map)


;Hooks
;This should be on all the time for occur, maybe not
(add-hook 'occur-hook
  (lambda ()
    (next-error-follow-minor-mode 1)
    (define-key occur-mode-map "n" 'occur-next)
    (define-key occur-mode-map "p" 'occur-prev)
    (define-key occur-mode-map "\M-n" 'my-occur-next-file)
    (define-key occur-mode-map "\M-p" 'my-occur-previous-file)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; (defun my-occur-next-file ()
;;   (interactive)
;;   "MTF skip to the next file, do not open ANY FILES along the way"
;;   (if (re-search-forward "matches in buffer: " nil t)
;;            ;T -> search found
;;            (forward-line 1)
;;            ;F -> failed must be near the end of the Moccur buffer
;;            (message "No more next files"))) 


(defun my-occur-next-file ()
  (interactive)
  "MTF skip to the next file, do not open ANY FILES along the way"
  (if (re-search-forward "buffer: " nil t)
           ;T -> search found
           ;(forward-line 1)
           (re-search-forward "^\\s-+[0-9]+" nil t)
           ;F -> failed must be near the end of the Moccur buffer
           (message "No more next files"))) 

(defun my-occur-previous-file ()
  (interactive)
  "MTF skip to the previous file, do not open ANY FILES along the way"
  (if (re-search-backward "matches in buffer: " nil t 2);2x
     ;T-> search found
     (re-search-forward "^\\s-+[0-9]+" nil t)
     ;F-> search failed
     (message "No more previous files")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq load-grep+ t) (require 'grep+))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Isearch a region
;from http://stackoverflow.com/questions/1893795/
;   emacs-newbie-question-how-to-search-within-a-region
;Note the same thing could be done using the sequence
;; M-x narrow-to-region
;; isearch-forword
;; M-x widen
(defun isearch-forward-region-cleanup ()
  "turn off variable, widen"
  (if isearch-forward-region
      (widen))
  (setq isearch-forward-region nil))
(defvar isearch-forward-region nil
  "variable used to indicate we're in region search")
(add-hook 'isearch-mode-end-hook 'isearch-forward-region-cleanup)
(defun isearch-forward-region (&optional regexp-p no-recursive-edit)
  "Do an isearch-forward, but narrow to region first."
  (interactive "P\np")
  (narrow-to-region (point) (mark))
  (goto-char (point-min))
  (setq isearch-forward-region t)
  (isearch-mode t (not (null regexp-p)) nil (not no-recursive-edit)))
(global-set-key (kbd "C-S-f") 'isearch-forward-region)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Make C-y in Isearch act like M-y does in the default map
;Why? By default, C-y in Isearch does do what you might expect 
;Instead of yanking from the kill-ring to the search string 
;it acts on the current line
;MTF: Not exactly it does not circle thru the ring, just pops the most recent
;http://www.emacswiki.org/emacs/IncrementalSearch
; 6/15/2017
; 1) Drew created a C-y <something> map to yank various stuff
;(define-key isearch-mode-map (kbd "C-y") 'isearch-yank-kill)
; 2) Tried his
;
; make C-h show help from within IncrementalSearch
(define-key isearch-mode-map [(control h)] 'isearch-mode-help)
;read the help too you can allow scrolling 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;http://emacswiki.org/emacs/SearchAtPoint#toc6
(defun isearch-yank-symbol ()
  "*Put entire symbol stock EMACS cas yank a partial at current point
   into search string."
  (interactive)
  (let ((sym (symbol-at-point)))
    (if sym
        (progn
          (setq isearch-regexp t
                isearch-string (concat "\\_<" (regexp-quote (symbol-name sym)) "\\_>")
                isearch-message (mapconcat 'isearch-text-char-description isearch-string "")
                isearch-yank-flag t))
      ;; (ding))) mtf don't want the ding
      ))
  (isearch-search-and-update))
;
;(define-key isearch-mode-map "\C-\M-w" 'isearch-yank-symbol)
(define-key isearch-mode-map "\C-_" 'isearch-yank-symbol)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-isearch-plus-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

