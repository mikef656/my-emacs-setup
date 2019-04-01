;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(defun xah-insert-bracket-pair (@left-bracket @right-bracket &optional @wrap-method)
  "Insert brackets around selection, word, at point, and maybe move cursor in between.
  ;
 *left-bracket and *right-bracket are strings.
 *wrap-method must be either 'line or 'block. 'block means between empty lines.
 ;
 if there's a region, add brackets around region.
 If *wrap-method is 'line, wrap around line.
 If *wrap-method is 'block, wrap around block.
 if cursor is at beginning of line and its not empty line and contain at
   least 1 space, wrap around the line.
 If cursor is at end of a word or buffer, one of the following will happen:
 xyz! -> xyz(!)
 xyz! -> (xyz!)       if in one of the lisp modes.
 wrap brackets around word if any. e.g. xy!z -> (xyz!). Or just (!)
;
http://ergoemacs.org/emacs/elisp_insert_brackets_by_pair.html
Version 2017-01-17"
  (if (use-region-p)
      (progn ; there's active region
        (let (
              ($p1 (region-beginning))
              ($p2 (region-end)))
          (goto-char $p2)
          (insert @right-bracket)
          (goto-char $p1)
          (insert @left-bracket)
          (goto-char (+ $p2 2))))
    (progn ; no text selection
      (let ($p1 $p2)
        (cond
         ((eq @wrap-method 'line)
          (setq $p1 (line-beginning-position) $p2 (line-end-position))
          (goto-char $p2)
          (insert @right-bracket)
          (goto-char $p1)
          (insert @left-bracket)
          (goto-char (+ $p2 (length @left-bracket))))
         ((eq @wrap-method 'block)
          (save-excursion
            (progn
              (if (re-search-backward "\n[ \t]*\n" nil 'move)
                  (progn (re-search-forward "\n[ \t]*\n")
                         (setq $p1 (point)))
                (setq $p1 (point)))
              (if (re-search-forward "\n[ \t]*\n" nil 'move)
                  (progn (re-search-backward "\n[ \t]*\n")
                         (setq $p2 (point)))
                (setq $p2 (point))))
            (goto-char $p2)
            (insert @right-bracket)
            (goto-char $p1)
            (insert @left-bracket)
            (goto-char (+ $p2 (length @left-bracket)))))
         ( ;  do line. line must contain space
          (and
           (eq (point) (line-beginning-position))
           ;; (string-match " " (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
           (not (eq (line-beginning-position) (line-end-position))))
          (insert @left-bracket )
          (end-of-line)
          (insert  @right-bracket))
         ((and
           (or ; cursor is at end of word or buffer. i.e. xyz▮
            (looking-at "[^-_[:alnum:]]")
            (eq (point) (point-max)))
           (not (or
                 (string-equal major-mode "xah-elisp-mode")
                 (string-equal major-mode "emacs-lisp-mode")
                 (string-equal major-mode "lisp-mode")
                 (string-equal major-mode "lisp-interaction-mode")
                 (string-equal major-mode "common-lisp-mode")
                 (string-equal major-mode "clojure-mode")
                 (string-equal major-mode "xah-clojure-mode")
                 (string-equal major-mode "scheme-mode"))))
          (progn
            (setq $p1 (point) $p2 (point))
            (insert @left-bracket @right-bracket)
            (search-backward @right-bracket )))
         (t (progn
              ;
              ;;
              (skip-chars-backward "-_[:alnum:]")
              (setq $p1 (point))
              (skip-chars-forward "-_[:alnum:]")
              (setq $p2 (point))
              (goto-char $p2)
              (insert @right-bracket)
              (goto-char $p1)
              (insert @left-bracket)
              (goto-char (+ $p2 (length @left-bracket))))))))))
;
(defun insert-paren ()
  (interactive)
  (xah-insert-bracket-pair "(" ")") )
;
(defun insert-bracket ()
  (interactive)
  (xah-insert-bracket-pair "[" "]") )
;
(defun insert-brace ()
  (interactive)
  (xah-insert-bracket-pair "{" "}") )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'xah-insert)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
