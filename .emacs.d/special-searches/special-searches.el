;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  defuns in this file:
;; myoccur ()
;; get-buffers-matching-mode (mode)
;; multi-occur-in-this-mode ()
;; my-find-def-moc ()
;; my-find-def-mgf ()
;; my-find-def-inst-fwd (arg)
;; build-up-regex-for-find-inst-back ()
;; my-find-def-inst-back (arg)
;; my-temp-buffer-back (arg)
;; slurp-all-components-this-file (&optional arg)
;; look-up-actual-info (&optional arg)
;; get-port-name ()
;; insert-dir-at-eol (&optional arg)
;; my-iterate-alist ()
;; list-vhdl-files (&optional verbose)
;; search-for-regex-in-file (filename-arg)
;; slurp-all-entities-as-components-prompt-4-start-dir (&optional arg)
;; slurp-one-entity/component (regex-arg)
;; slurp-one-entity/component-using-locals (regex-arg)
;; get-formal-actual (arg-verbose arg-this-line-only &optional arg-actual)
;; look-up-actual-fan-out ()
;; look-up-ports-direction (alist-arg port-arg component-arg)
;; slurp-actual/formal-one-instance ()
;; my-find-def ()
;; findget-and-insert-signal ()
;; describe-foo-at-point ()
;
;might come in handy some day
;stackoverflow.com/questions/19774603/convert-alist-to-from-regular-list-in-elisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cl)
(require 's)
(require 'dash)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;note that you can't cons onto an empty list, defvar takes care of this bc
;you can cons onto an empty list ().
;empty list in the same as nil.
(defvar vlogp-find-inst-back-defun-start-global "99999" "foo")
(defvar vlogp-find-beg-of-inst-back-str "\\(\\_<\\)" "foo")
(defvar vlogp-inst-rev-main-regex-global "^\\s-*\\([a-zA-Z0-9_]\\)+\\s-*(" "foo")

(defvar vlogp-inst-rev-main-or-regex-global "\\([a-zA-Z0-9_]\\)+\\s-*(\\|^\\s-*\\(\\w+\\)\\s-*$" "foo")
;(setq vlogp-inst-rev-main-or-regex-global "^\\s-*[a-z]+\\s-+\\([a-zA-Z0-9_]\\)+\\s-*")
(defvar vlogp-inst-rev-main-or-regex-global "\\([a-zA-Z0-9_]\\)+\\s-*(\\|^\\s-*\\(\\w+\\)\\s-*$" "foo")
;this one works (setq vlogp-inst-rev-main-or-regex-global "\\([a-zA-Z0-9_]\\)+\\s-*(\\|^\\s-*\\(\\w+\\)\\s-*$")
;(setq vlogp-inst-rev-main-or-regex-global "\\([a-zA-Z0-9_]\\)+\\s-*(\\|^\\s-*\\(\\w+\\)\\s-*$" )

(defvar vlogp-find-inst-fwd-finish 9999 "start here")
(defvar vlogp-find-inst-back-finish-global 9999 "start here")
(defvar vhdlp-current-look-up-fanout-list () "aoeu")
(defvar vhdlp-this-line-only t "Doc purposes")
(defvar vhdlp-no-actual nil "Doc purposes")
(defvar vhdlp-verbose t "Doc purposes")
(defvar vhdlp-cmpnnt-stmnt-elements-list () "aoeu")
(defvar vhdlp-inst-elements-list () "aoeu")
(defvar vhdlp-cmpnnt-stmnt-name-list () "aoeu")
(defvar vhdlp-master-ent/comp-nm-drction/type-lst () "aoeu")
(defvar vhdlp-master-comp-name-drction/only-list () "aoeu")
(defvar vhdlp-master-formal-actual-pair-list () "aoeu")
(defvar vhdlp-cmnnt-stmnt-drctn/type-list () "aoeu")
(defvar vhdlp-cmnnt-stmnt-drctn-only-list () "aoeu")
(defvar vhdlp-inst-actual-list () "aoeu")
(defvar vhdlp-ent/cmpnt-stmnt-port-nm-lst () "aoeu")
;(defvar vhdlp-master-drction-list () "aoeu")
(defvar vhdlp-inst-formal-list () "aoeu")
(defvar vhdlp-myset () "aoeu")
(defvar vhdlp-master-look-up-fanout-list () "aoeu")
(defvar no-error-just-ret-nil t "use to document re-search-forword")
(defvar search-is-unbounded nil "use to document re-search-forword")
(defvar my-limit nil "")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar search-for-verilog-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?. "_" table)
    (modify-syntax-entry ?$ "_" table)
    table))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;grep plus
(add-to-list 'load-path "~/.emacs.d/grep_plus/")
(require 'grep+)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Occur stuff
(add-to-list 'load-path "~/.emacs.d/color-moccur/")
(require 'color-moccur)
;;
;(add-to-list 'load-path "~/.emacs.d/color-occur/")
;(require 'color-occur);broke emacs 24
;;
(defun myoccur ()
  "Run Occur"
  (interactive)
  (occur (thing-at-point 'word)5) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;http://www.masteringemacs.org/articles/2011/07/20/searching-buffers-occur-mode/
(eval-when-compile
  (require 'cl))
(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
   (dolist (buf (buffer-list))
     (with-current-buffer buf
       (if (eq mode major-mode)
           (add-to-list 'buffer-mode-matches buf))))
   buffer-mode-matches))
;
(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))5)  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Moccur Loads;
(add-to-list 'load-path "~/.emacs.d/color_moccur/")
(add-to-list 'load-path "~/.emacs.d/moccur_edit/")
(require 'color-moccur)
(require 'moccur-edit)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Acme Search
;http://www.emacswiki.org/emacs/acme-search.el
;right-clicking on a word finds the next occurrence
;of that word, and moves the mouse to the new occurrence. In this way,
;you can search through all occurrences of a word by repeatedly
;right-clicking.
;note acme-search package needs its own folder
(add-to-list 'load-path "~/.emacs.d/acme-search/")
;not using it why load it? (require 'acme-search)
;(global-set-key [(mouse-4)] 'acme-search-forward)
;Thanks(global-set-key [(shift mouse-4)] 'acme-search-backward)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-find-def-moc ()
  "Find Definition using moccur"
   (interactive)
   (push-mark)
   (setq myStr (thing-at-point 'word))
   ;Build up the search string
   (setq sig_type_regex_var "\\(type[ ]+\\|subtype[ ]+\\)")
   (setq sig_con_regex_var "\\(signal[ ]+\\|constant[ ]+\\)")
   (setq io_regex_var "\\([ ]+:[ ]+in\\|[ ]+:[ ]+out\\)")
   (setq first_part_var(concat (regexp-quote myStr) io_regex_var))
   (setq second_part_var(concat sig_con_regex_var (regexp-quote myStr))) 
   (setq tot_var (concat first_part_var "\\|" second_part_var )) 
   (setq tot_var (concat first_part_var "\\|" second_part_var "\\|" third_part_var ))
   ;
   ;(goto-char (point-min))
   (moccur tot_var nil) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-find-def-mgf ()
  "Find Definition using moccur"
   (interactive)
   (push-mark)
   (setq myStr (thing-at-point 'word))
   ;Build up the search string
   (setq sig_type_regex_var "\\(type[ ]+\\|subtype[ ]+\\)")   
   (setq sig_con_regex_var "\\(signal[ ]+\\|constant[ ]+\\)")
   (setq io_regex_var "\\([ ]+:[ ]+in\\|[ ]+:[ ]+out\\)")
   (setq first_part_var(concat (regexp-quote myStr) io_regex_var))
   (setq second_part_var(concat sig_con_regex_var (regexp-quote myStr))) 
   (setq tot_var (concat first_part_var "\\|" second_part_var )) 
   (setq tot_var (concat first_part_var "\\|" second_part_var "\\|" third_part_var ))
   ;
   ;what did this do?
   ;(goto-char (point-min))
   ;I must have removed my-moccur-grep-find from color-moccur,
   ;should go looking for it and bring it back.
   (call-interactively 'my-moccur-grep-find))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-find-comp-entity-back (arg)
  "Message the component name or entity name from component of entity body 
  while searching backward.  Return the component or entity name"
  (interactive "P")
  (push-mark)
  (let (tempmatch mystr)
    ;
    ;When already looking at a component statement move off it to facilitate
    ;searching to the next.
    (setq mystr (thing-at-point 'line))
    (when  (s-match "component" mystr)
      (forward-line -1))
    ;
    ;locate component or entity
    (re-search-backward 
      "^\\s-*component\\s-+\\(\\w+\\)\\|^\\s-*entity\\s-+\\(\\w+\\)" nil t)
    ;
    (if (match-string 1)
      (setq tempmatch (match-string 1))
      (setq tempmatch (match-string 2)))
    ;; 
    (message (s-trim-right (s-trim-left (match-string 0))))
    ;
    ;put point at the beginning of the interesting word
    (re-search-forward "\\w+\\s-+\\w+" nil t)
    (re-search-backward "\\b\\w+" nil t)
    ;
    (if (equal arg '-) ;the symbol -,don't evaluate
      (jump-to-mark))
    ;  
    tempmatch))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-find-comp-entity-fwd (arg)
  "Message the component name or entity name from component of entity body 
  while searching forward.  Return the component or entity name"
  (interactive "P")
  (push-mark)
  (let (tempmatch)
    ;
    ;When already looking at a component statement move off it to facilitate
    ;searching to the next.
    (setq mystr (thing-at-point 'line))
    (when  (s-match "component\\|^\\s-*entity" mystr)
      (forward-line 1))
    ;
    ;locate component or entity
    (re-search-forward 
      "^\\s-*component\\s-+\\(\\w+\\)\\|^\\s-*entity\\s-+\\(\\w+\\)" nil t)
    ;
    (if (match-string 1)
      (setq tempmatch (match-string 1))
      (setq tempmatch (match-string 2)))
    ;; 
    (message (s-trim-right (s-trim-left (match-string 0))))
    ;
    ;put point at the beginning of the interesting word
    (re-search-backward "\\b\\w+" nil t)
    ;
    (if (equal arg '-) ;the symbol -,don't evaluate
      (jump-to-mark))
    ;  
    tempmatch))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-find-comp-entity-inst-back (arg)
  "Message the component name or entity name from component or entity body
   Determine the context then call the appropriate defun to handle port map
   or component or entity.  Move off lines that contain 
     :in 
     :out 
     entity
     component 
   backwards so that you get the previous instance.
   Do not move off when matching the regex entity work.compname as in the 
   case of direct entity instantion"
  (interactive "P")
  (push-mark)
  (let (temp mystr)
    ;
    (setq mystr (thing-at-point 'line))
    ;
    (if (and
         (s-match ":\\s-*in\\|:\\s-*out\\|component\\|entity" mystr)
         ;the not checks for the direct entity instace case
         (not (s-match "entity.*\\."mystr)))
      ;
      ;T
      (my-find-comp-entity-back arg)
      ;F
      (my-find-def-inst-back arg)
      )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-find-comp-entity-inst-fwd (arg)
  "Message the component name or entity name from component or entity body
   Determine the context then call the appropriate defun to handle port map
   or component or entity.  
  --IF YOU SEEM TO HAVE POINT STUCK IN A COMPONENT--
     Move off lines that contain 
     :in 
     :out 
     entity
     component
  to jump to the next instance
  one idea might be to jump to the beginning of the file then do M-next
  to jump to the instatce rather than the component
  Note: Might want to change this so that C-u passed to this defun moves off"
  (interactive "P")
  (push-mark)
  (let (temp mystr)
    ;
    (setq mystr (thing-at-point 'line))
    ;
    (if (and
         (s-match ":\\s-*in\\|:\\s-*out\\|component\\|entity" mystr)
         ;the not checks for the direct entity instace case
         (not (s-match "entity.*\\."mystr)))

      ;T
      (my-find-comp-entity-fwd arg)
      ;F
      (my-find-def-inst-fwd arg))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;todo create another defun that calls this in a while loop
;todo clean this up the way that back is done.
(defun my-find-def-inst-fwd (arg)
 "Message the instatce name and component name from a port map body
  Return just the component name
  Move point to next (forward) intsance
  With - arg don' move point, but still message"
   (interactive "P")
   ;;Might want to come back
   (push-mark)
   ;
   ;Build up the search string
   (setq sig_con_regex_var "^\\s-*\\(\\(\\w\\|\\s_\\)+\\s-*:\\(\\s-\\|\n\\)*\\(\\w\\|\\s_\\)+\\)\\(\\s-\\|\n\\)+\\(generic\\|port\\)\\s-+map\\>")
   (setq io_regex_var "entity[ ]+\\w+\\.\\(\\<.*\\>\\)(?")
   (setq tot_var (concat sig_con_regex_var "\\|" io_regex_var))
   (end-of-line);don't understand why,but this helps with as strange
   (setq vhdlp-myset nil)
   ;
   (if (re-search-forward tot_var nil t)
      ;T
      (progn (message "Found an instance")
          ;
          ;match added to a list
          (setq vhdlp-myset (cons (match-string 0) vhdlp-myset))
          ;
          ;match will be unes by the temp buffer 
          (setq mytempstr (match-string 0))
          ;
          ;improve the position of point
          (forward-line)
          (re-search-backward tot_var nil t)
          (re-search-forward "\\:\\|\\." nil) 
          (re-search-forward "\\<" nil t)
          ;
          ;|----temp buffer manipulations start----|
          (setq mystrNew
             (with-temp-buffer
                (insert mytempstr)
                ;
                ;clean up instance copyed into temp buffer
                (setq my-limit (point))
                (beginning-of-buffer)
                ;
                ;remove the "generic map" and "port map" stuff
                (while (re-search-forward "\\s-+generic map\\s-*" my-limit t)
                  (replace-match " "))
                  (beginning-of-buffer)
                (while (re-search-forward "\\s-+port map\\s-*" my-limit  t)
                  (replace-match " "))
                  (beginning-of-buffer)
                ;these next two are for direct instances
                (while (re-search-forward ".*\\.\\s-*" my-limit  t)
                  (replace-match ""))
                  (beginning-of-buffer)
                (while (re-search-forward "(.*" my-limit  t)
                  (replace-match ""))
                  (beginning-of-buffer)
                ;
                ;put everything on one line
                (while (re-search-forward "\n"my-limit  t)
                  (replace-match ""))
                  (beginning-of-buffer)
                ;done manipulating                   
                (buffer-string))) ; get result of temp buffer, pass it back
          ;|----temp buffer manipulations end----|
      ;
      ;-------------------------------------------------------------------------
      (setq forward-just-the-comp-name
        (substring-no-properties (replace-regexp-in-string "^.*:\\s-*" "" mystrNew)))
      ;-------------------------------------------------------------------------
      ;
      (message "Next instance:%s"mystrNew)
      ;
      ;www.gnu.org/software/emacs/manual/html_node/elisp/Prefix-Command-Arguments.html
      ;M-- keeps point where it was before running the defun
      (if (equal arg '-) ;the symbol -,don't evaluate
          ;go back where you were before the outside defun moved point
          (jump-to-mark))
      ;  
      ;(setq my-ret-val t)  ;last statement in defun, cause the defun to return t
      (setq my-ret-val forward-just-the-comp-name);last statement in defun, cause the defun to return t
      )
      ;F
      (progn
         (jump-to-mark)
         (message "Instance Not Found searching forward")
         (setq my-ret-val nil);last statement in defun, cause the defun to return nil
      )
))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun build-up-regex-for-find-inst-back ()
 ;Build up the search string
 (let (sig_con_regex_var 
       io_regex_var 
       tot_var)
   (setq sig_con_regex_var 
    "^\\s-*\\(\\(\\w\\|\\s_\\)+\\s-*:\\(\\s-\\|\n\\)*\\(\\w\\|\\s_\\)+\\)\\(\\s-\\|\n\\)+\\(generic\\|port\\)\\s-+map\\>")
   (setq io_regex_var "entity[ ]+\\w+\\.\\(\\<.*\\>\\)(?")
   (setq tot_var (concat sig_con_regex_var "\\|" io_regex_var))
   tot_var))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-find-def-inst-back (arg &optional quiet)
 "Message the instance name and component name, 
  Return list (component-name instance-name/component-name) when search succeeds
  Return nil when no instance found searching backwards.
  With - arg don' move point, but still message
  Move point to previous (back) intsance 
  Designed for both direct and non-direct instances"
   (interactive "P")
   (push-mark)
   (end-of-line);don't understand why,but this helps with as strange
   ;case where point is one line below a target.
   (setq my-ln (current-line))
   ;
   ;create the var if it does not exist
   (setq vhdlp-myset nil)
   ;
   (if (re-search-backward (build-up-regex-for-find-inst-back) nil t)
      ;T
      (progn 
         (unless quiet (message "Found an instance"))
         (handle-same-instance)
         ;------------------------------------------------------------------
         ;temp buffer manipulations Leave just a clean instance:componentname
         (setq my-instance-compname
           (s-trim (substring-no-properties 
              (my-temp-buffer-back (match-string 0)))))
         ;
         ;Remove the instance name and colon, leaving just the component name
         (setq back-just-the-comp-name (remove-whitespace-from-beg-end))
         ;
         (unless quiet (message "Previous Instance:%s"my-instance-compname))
         ;further change of temp buffer Leave just componentname
         ;-------------------------------------------------------------------------
         ;
         (kill-new  my-instance-compname)
         ;   
         ;Leave point on the component name
         (re-search-forward "\\:\\|\\." nil)
         (re-search-forward "\\<" nil t)
         ;
         ;this is a hack, don't like it under all cases
         ;in the direct instance case same line,
         ;but you matched the re-search backwards
         (when (equal my-ln (current-line))
           (jump-to-mark)
            (message "Not found searching backwards"))
         ;
         ;M-- do not move point from the users perspective
         (if (equal arg '-) (jump-to-mark) )
         ;
         ;retun this if search succeeds
         (list back-just-the-comp-name my-instance-compname))
      ;F
      (progn
        (jump-to-mark)
        (unless quiet (message "Instance Not Found searching backwards"))
         ;return nil if the search backwards fails
         nil)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun remove-whitespace-from-beg-end ()
  "remove whitespace from beg and end"
  (interactive)
  (s-trim (substring-no-properties 
     (replace-regexp-in-string "^.*:\\s-*" "" my-instance-compname))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun handle-same-instance ()
  (interactive)             
  ;special case where you did not move lines
  (when (equal my-ln (current-line))
          (message "Same Instance")
          (forward-line -1)
          (re-search-backward (build-up-regex-for-find-inst-back) nil t)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-temp-buffer-back (arg)
  "process the partial port map."
  (with-temp-buffer (insert arg)
    ;
    ;clean up instance copyed into temp buffer
    (setq my-temp-buffer-limit (point))
    (beginning-of-buffer)
    ;
    ;remove the "generic map" and "port map" stuff
    (while (re-search-forward "\\s-+generic map\\s-*" my-temp-buffer-limit t)
      (replace-match " "))
      (beginning-of-buffer)
    (while (re-search-forward "\\s-+port map\\s-*" my-temp-buffer-limit  t)
      (replace-match " "))
      (beginning-of-buffer)
    ;            
    ;these next two are for direct instances
    (while (re-search-forward ".*\\.\\s-*" my-limit  t)
      (replace-match ""))
      (beginning-of-buffer)
    (while (re-search-forward "(.*" my-limit  t)
      (replace-match ""))
      (beginning-of-buffer)
    ;
    ;put everything on one line
    (while (re-search-forward "\n"my-temp-buffer-limit  t)
      (replace-match ""))
      (beginning-of-buffer)
    ;done manipulating                   
    (buffer-string))) ; get result of temp buffer, pass it back
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun slurp-all-components-this-file-test (&optional arg)
(defun slurp-all-components-this-file (&optional arg)
 "Move to beg of buffer, run  slurp-one-entity/component in loop until it returns nil"
  (interactive "P")
  (let (
        (found-cmpnnt (list t t)) 
        (component-count 0) 
        (remember-this-place (point)) 
        )
    (setq vhdlp-cmpnnt-stmnt-name-list nil)
    (setq vhdlp-cmpnnt-stmnt-elements-list nil)
    (push-mark)
    (goto-char (point-min))
    (setq temp-first nil)
    (setq temp-second nil)
    (setq temp-third nil)
    (setq tmp-mstr-1-comp/name-dir-type nil)
    (setq tmp-mstr-2-comp/name-dir nil)
    (setq tmp-mstr-3-port/name nil)
    ;---------------------------------------------------------------------------
    (while (car found-cmpnnt)
      (setq found-cmpnnt 
        (slurp-one-entity/component-using-locals "^\\s-*component\\s-+\\(\\w+\\)"))
      ;
      (setq temp-ent/comp-nm-drction/type-lst (car found-cmpnnt))      
      ;; (setq temp-comp-name-drction/only-list  (car (cdr found-cmpnnt)))      
      (setq temp-comp-name-drction/only-list  (cadr found-cmpnnt))      
      (setq temp-ent/cmpnt-stmnt-port-nm-lst  (caddr found-cmpnnt))      
      ;
      ;the return values are lists of lists, we want the sub-lists to
      ;use dolist to extract the sublist and pust on to the accmmulated list.
      (dolist (x temp-ent/comp-nm-drction/type-lst)
        (push x  tmp-mstr-1-comp/name-dir-type))
      ;
      (dolist (x temp-comp-name-drction/only-list)
        (push x tmp-mstr-2-comp/name-dir))
      ; 
      (dolist (x temp-ent/cmpnt-stmnt-port-nm-lst)
        (push x tmp-mstr-3-port/name))
      ;
      (setq component-count (+ component-count 1)));end of while
    ;---------------------------------------------------------------------------
    (message "Found %s Components, %s Elements" 
      component-count (length tmp-mstr-3-port/name))
    ;
    (goto-char remember-this-place)
    ;
    (setq temp-master-3-name-inst   tmp-mstr-3-port/name)
    (setq temp-master-1-dir-type-inst   tmp-mstr-1-comp/name-dir-type)
    
    (setq key-port/name-val-cmp/name-dir-type-alist 
      (pairlis 
        tmp-mstr-3-port/name   tmp-mstr-1-comp/name-dir-type))
    ;
    (setq key-port-nm-val-cmpnt-stmnt-drctn-only-alist
     (pairlis 
       ;---key------         ----value------
       tmp-mstr-3-port/name   tmp-mstr-2-comp/name-dir))
    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;replace:key-port/name-val-dir-only-alist
;with:key-port-nm-val-cmpnt-stmnt-drctn-only-alist

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;The alist is structured like this
;  ----KEY----  --------VALUE------------
;  port_name => component_name . direction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ToDo: Add a C-u C-u C-u option to use ffip to locate more VHDL files, going
;up the directory tree.
(defun look-up-actual-info (&optional arg)
 "First look up actual at point, then --MESSAGE THE DIRECTION--, possibly other info. 

  WITH 0 ARG:
    Clear relevant variables, then look up.
  WITH - ARG: 
    ADD a comment at eol indicating direction of actual.
  WITH C-u ARG: 
    Slurp components this file, then message the direction.
  WITH C-u C-u ARG: 
    Slurp entities, prompt for starting dir.

The slurp needs to be done at least 1x, for look up to find anything."
  (interactive "P")
  (let ((remember-this-place (point))
        (actual-port-name)
        (port-name)
        (actual-port-name (get-port-name))
        (current-instance-of-component (car (my-find-def-inst-back '-)))
        (dir-type))
  ;
  (when (equal arg 0) (slurp-all-entities-as-components-prompt-4-start-dir 0))
  (when (equal arg '(4)) (slurp-all-components-this-file))
  (when (equal arg '(16)) (slurp-all-entities-as-components-prompt-4-start-dir))
  ;
  (dolist (x-alist-entry key-port/name-val-cmp/name-dir-type-alist) 
    ;
    (when (equal (car x-alist-entry) actual-port-name) 
      (when 
        ;
        (equal (second x-alist-entry) current-instance-of-component) 
        ;(edebug)
        (message "Direction of port %s is:%s"  
          ;Cnvrt all adjcnt whtspc to 1 spc, removed leading and trailing wsp.
          (setq port-name (s-trim (s-collapse-whitespace (car x-alist-entry))))
          (setq dir-type 
            ;
            (s-trim (s-collapse-whitespace (third x-alist-entry))))
        )
      )
    )
  )
  ;(edebug)
  (if (equal arg '-) (insert-dir-at-eol dir-type))
  (goto-char remember-this-place)
  dir-type))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-port-name ()
  ;locate, grab, return the port name
  (beginning-of-line)
  (re-search-forward "^\\s-*\\(\\w+\\)\\s-*=>" (line-end-position) t)
  (match-string 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;todo, create a cnd that would insert-dir-at-eol for each line in a port map
(defun insert-dir-at-eol (&optional arg)
  (interactive)
  (let ((local-dir-type) 
        (remember-this-place))
  (if arg 
      (setq local-dir-type arg)
      (setq local-dir-type (look-up-actual-info)))
  (setq remember-this-place (point))
  (end-of-line)
  (insert "--" local-dir-type)
  (goto-char remember-this-place)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(dolist (x '(1 2 3)) (insert (number-to-string x)))
(defun my-iterate-alist ()
 (interactive)
 (dolist (x key-port/name-val-cmp/name-dir-type-alist) 
   (message "Cars of alist %s" (car x))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun list-vhdl-files (&optional verbose)
 "Return a list of .vhd files"
 (interactive)
 ;
 (let ((my-directory-files nil))
 ;
 (setq my-directory-files (directory-files default-directory nil ".*vhd$") )
 ;
 (if verbose
   (dolist (file-place-holder my-directory-files)
   (message file-place-holder)))
 ;
 my-directory-files))
;consider using find-file-noselect in a loop (not sure how to do this)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun search-for-regex-in-file (filename-arg)
  "Visit a file, temp buffer, then search for a regex.
  Return the matched value.
  Return nil if no match."
  (interactive)
  ;
  ;worth remembering, however much slower than the technique used
  ;(with-current-buffer (find-file-noselect filename-arg)
  (with-temp-buffer
    (insert-file-contents filename-arg)
    ;
    (beginning-of-buffer)
    ;
    (setq found-cmpnnt (slurp-one-entity/component "^\\s-*entity\\s-+\\(\\w+\\)"))
    (message (buffer-string)))
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun slurp-all-entities-as-components-prompt-4-start-dir (&optional arg)
  (interactive "P")
  (let ((num-files 0) 
        (found-cmpnnt (list t t))         
        ;
        tmp-mstr-3-port/name
        tmp-mstr-2-comp/name-dir
        tmp-mstr-1-comp/name-dir-type
        temp-ent/cmpnt-stmnt-port-nm-lst
        temp-comp-name-drction/only-list
        temp-ent/comp-nm-drction/type-lst
        ;
        (num-entities-counted 0))
    ;
    ;initialize some variables here
    (when (eq arg 0) 
      (setq vhdlp-ent/cmpnt-stmnt-port-nm-lst nil)
      (setq vhdlp-cmnnt-stmnt-drctn/type-list nil)
      (setq vhdlp-cmnnt-stmnt-drctn-only-list nil)
      (setq vhdlp-cmpnnt-stmnt-name-list nil)
      (setq vhdlp-cmpnnt-stmnt-elements-list nil)
      (setq vhdlp-master-ent/comp-nm-drction/type-lst nil))
    ;
    ;; (dolist (file-place-holder (directory-files default-directory nil ".*vhd$"))
    (dolist    (file-place-holder (call-interactively 'files-in-below-directory))
    ;----------------------------------------------------------------------------
      ;each time thru processing a new file in temp buffer
      (with-temp-buffer
        (vhdl-mode)
        (message "major mode is %s" major-mode)
        (insert-file-contents file-place-holder)
        ;
        ;fix with the case where there could be more than one entity\file
        (goto-char 1)
        (when 
          (setq found-cmpnnt 
            (slurp-one-entity/component-using-locals "^\\s-*entity\\s-+\\(\\w+\\)"))
          ;instrumentation experiment
          (setq found-temp found-cmpnnt)
          ;
          (setq temp-ent/comp-nm-drction/type-lst (car found-cmpnnt))      
          ;
          (message "aoeu")
          ;
          (setq temp-comp-name-drction/only-list  (cadr found-cmpnnt))      
          ;
          (setq temp-ent/cmpnt-stmnt-port-nm-lst  (caddr found-cmpnnt))      
          ;
          (dolist (x temp-ent/comp-nm-drction/type-lst)
            (push x  tmp-mstr-1-comp/name-dir-type))
          ;
          (dolist (x temp-comp-name-drction/only-list)
            (push x tmp-mstr-2-comp/name-dir))
          ; 
          (dolist (x temp-ent/cmpnt-stmnt-port-nm-lst)
            (push x tmp-mstr-3-port/name))
          ;
            (setq num-entities-counted (1+ num-entities-counted)));if end
        ;
        (setq num-files (1+ num-files))
        ;
      );wtb end
    ;---------------------------------------------------------------------------
    );dolist end
    ;
    ;----------------------------------------------------------------------------
    ;make an alist
    (setq key-port/name-val-cmp/name-dir-type-alist 
      (pairlis 
      ;-----1st-------    -------2nd---------------
      tmp-mstr-3-port/name  tmp-mstr-1-comp/name-dir-type))
    ;--------------------------------------------------------------------------------
    ;
    ;----------------------------------------------------------------------------
    ;make similar alist, this one direction only
    (setq key-port-nm-val-cmpnt-stmnt-drctn-only-alist 
      (pairlis 
      ;-----1st-------    -------2nd---------------
      tmp-mstr-3-port/name  tmp-mstr-2-comp/name-dir))
    ;
    ;instrumentation
    ;Make an alist out of tmp-mstr-1-comp/name-dir-type
    ;  - Is it easier to take this apart or to build something else
    ;    at the same time this is built?
    (setq tmp-tmp-mstr-1-dir-type tmp-mstr-1-comp/name-dir-type)
    ;
    (setq tmp-tmp-mstr-3-port/name tmp-mstr-3-port/name)
    (setq tmp-tmp-mstr-2-direction tmp-mstr-2-comp/name-dir)
    ;--------------------------------------------------------------------------------    ;
    ;
    (message
     "Files in pwd processed: %s, Entities processed: %s, Elements: %s"
             num-files 
             num-entities-counted 
             ;(length vhdlp-cmpnnt-stmnt-elements-list)
             (length key-port/name-val-cmp/name-dir-type-alist))
  );let end
  (create-then-write-dir-locals-dot-el)
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun slurp-one-entity/component (regex-arg)
 "Move point to 1 component statement, slurp it's lines (elements)
  return t if a component is found, nil otherwise
  An expected regex-arg's would describe a component statement name."
   (interactive)
   (let (cur_cmpnnt_name 
         temp_element
         temp_port_name
         temp_direct/type
         temp_direct-only) 
   ;
     ;(match-string 0) behaves badly, when a match is not found, thus the if
     (if (re-search-forward regex-arg (point-max) t)
       (progn
         (setq cur_cmpnnt_name (match-string-no-properties 1))
         ;
         (re-search-forward "port" (point-max) t)
         ;
         (setq port-position (point))
         ;
         (setq port-statement-end (re-search-forward "end.*;" (point-max) t))
         ;
         (goto-char port-position)
         ;
         (while 
           (re-search-forward 
              "\\s-+\\(\\w+\\)\\s-*:\\(\\s-*\\(\\w+\\)\\s-+\\w+\\)" port-statement-end t)
           ;
           (setq temp_element     (match-string-no-properties 0))
           (setq temp_port_name   (match-string-no-properties 1))
           (setq temp_direct/type (match-string-no-properties 2))
           (setq temp_direct-only (match-string-no-properties 3))
           ;
           ;---------------------------------------------------------------------
           (push temp_element vhdlp-cmpnnt-stmnt-elements-list)
           ;
           (push temp_port_name vhdlp-ent/cmpnt-stmnt-port-nm-lst)
           ;
           (push temp_direct/type vhdlp-cmnnt-stmnt-drctn/type-list)
           ;
           (push temp_direct-only vhdlp-cmnnt-stmnt-drctn-only-list)
           ;
           (push cur_cmpnnt_name vhdlp-cmpnnt-stmnt-name-list)
           ;
           ;New list(s)
           (setq comp-name-drction/type-list (list cur_cmpnnt_name temp_direct/type))
           (setq comp-name-drction/only-list (list cur_cmpnnt_name temp_direct-only))
           ;  
           ;list of pairs where each pair has the form:
           ;((comp-name port-dir/type-1)  (comp-name port-dir/type-2) ...)
           (push  comp-name-drction/type-list vhdlp-master-ent/comp-nm-drction/type-lst)
           ;
           ;List of pairt with the form:
           ;((comp-name-0 port-dir/only-0) (comp-name-1 port-dir/only-1) ...)
           (push  comp-name-drction/only-list vhdlp-master-comp-name-drction/only-list)
           ;---------------------------------------------------------------------
           );end of while
           ;
           (message "master:%s, cmpnt-st: %s\n" 
                    (length vhdlp-master-ent/comp-nm-drction/type-lst) 
                    (length vhdlp-ent/cmpnt-stmnt-port-nm-lst)) 
       ;
       t);end of progn associated with T
       ;
       ;F
       nil);end of if
       ;
     );end of let
  );end of defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun slurp-one-entity/component-using-locals (regex-arg)
 "Move point to 1 component statement, slurp it's lines (elements)
  Return a list --see below-- of match data if component is found, nil otherwise
  (tmp-ent/cmpnt-stmnt-port-nm-lst
  tmp-master-comp-name-drction/only-list
  tmp-master-ent/comp-nm-drction/type-lst)
  An expected regex-arg's would describe a component statement name."
   (interactive)
   (let (cur_cmpnnt_name 
         temp_element
         temp_port_name
         temp_direct/type
         temp_direct-only
         tmp-cmpnnt-stmnt-elements-list 
         tmp-ent/cmpnt-stmnt-port-nm-lst
         tmp-cmnnt-stmnt-drctn/type-list
         tmp-cmnnt-stmnt-drctn-only-list
         tmp-cmpnnt-stmnt-name-list     
         tmp-master-comp-name-drction/only-list
         tmp-master-ent/comp-nm-drction/type-lst
         ) 
   ;
     ;(match-string 0) behaves badly, when a match is not found, thus the if
     (if (re-search-forward regex-arg (point-max) t)
       (progn
         (setq cur_cmpnnt_name (match-string-no-properties 1))
         ;
         (re-search-forward "port" (point-max) t)
         ;
         (setq port-position (point))
         ;
         (setq port-statement-end (re-search-forward "end\\s-*;" (point-max) t))
         ;
         (goto-char port-position)
         ;
         (while 
           (re-search-forward 
              "\\s-+\\(\\w+\\)\\s-*:\\(\\s-*\\(\\w+\\)\\s-+\\w+\\)" port-statement-end t)
           ;
           (setq temp_element     (match-string-no-properties 0))
           (setq temp_port_name   (match-string-no-properties 1))
           (setq temp_direct/type (match-string-no-properties 2))
           (setq temp_direct-only (match-string-no-properties 3))
           ;
           ;---------------------------------------------------------------------
           ;These are locals
           (push temp_element tmp-cmpnnt-stmnt-elements-list)
           (push temp_port_name tmp-ent/cmpnt-stmnt-port-nm-lst)
           (push temp_direct/type tmp-cmnnt-stmnt-drctn/type-list)
           (push temp_direct-only tmp-cmnnt-stmnt-drctn-only-list)
           (push cur_cmpnnt_name tmp-cmpnnt-stmnt-name-list)
           ;
           ;form a list with the form (name direction/type)
           (setq comp-name-drction/type-list (list cur_cmpnnt_name temp_direct/type))
           ;form a list with the form (name direction/only)
           (setq comp-name-drction/only-list (list cur_cmpnnt_name temp_direct-only))
           ;  
           ;push onto list of lists where each sub-list with the form:
           ;((comp-name port-dir/type-1)  (comp-name port-dir/type-2) ...)
           (push  comp-name-drction/type-list tmp-master-ent/comp-nm-drction/type-lst)
           ;
           ;push onto List of lists with the form:
           ;((comp-name-0 port-dir/only-0) (comp-name-1 port-dir/only-1) ...)
           (push  comp-name-drction/only-list tmp-master-comp-name-drction/only-list)
           ;---------------------------------------------------------------------
           );end of while
           ;
           (message "master:%s, cmpnt-st: %s\n" 
                    (length tmp-master-ent/comp-nm-drction/type-lst) 
                    (length vhdlp-ent/cmpnt-stmnt-port-nm-lst)) 
       ;
       ;t)                               ;end of progn associated with T
       (setq tmp-ent/cmpnt-stmnt-port-nm-lst-inst tmp-ent/cmpnt-stmnt-port-nm-lst) 
       (list 
        tmp-master-ent/comp-nm-drction/type-lst 
        tmp-master-comp-name-drction/only-list
        tmp-ent/cmpnt-stmnt-port-nm-lst));end of progn associated with T
       ;
       ;F
       nil);end of if
       ;
     );end of let
  );end of defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-direction-of-entity-port (arg)
 "Given a top level port name tell the direction"
  (interactive)
  (let (
    element    
    direct/type
    direct-only   
    port-position
    port-statement-end
    ) 
    (save-excursion
      (goto-char 1)
      ;
      (re-search-forward "^\\s-*entity" (point-max) no-error-just-ret-nil)
      (re-search-forward "^\\s-*port" (point-max) no-error-just-ret-nil)
      ;
      (setq port-position (point))
      ;
      (setq port-statement-end (re-search-forward "end.*;" (point-max) t))
      ;
      (goto-char port-position)
      ;
      (re-search-forward 
        (format "\\s-+%s\\s-*:\\(\\s-*\\(\\w+\\)\\s-+\\w+\\)" arg) 
           port-statement-end t) ;
      ;
      (setq element     (match-string-no-properties 0))
      (setq direct/type (match-string-no-properties 1))
      (setq direct-only (match-string-no-properties 2))
      ;
    );end of save-excursion
  direct-only);end of let
 );end of defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun find-drivers-and-loads (arg)
 "Given a identifier return a list of all collapsed and trimmed matching
 lines for the current buffer"
  (interactive)
  (let (
    element-cleaned    
    drivers_and_loads_list
    ) 
    (save-excursion
      (goto-char (point-min))
      ;
      (while
        ;
        (re-search-forward 
         (format ".*\\s-*%s\\b\\s-*<=.*" arg) 
           search-is-unbounded
             no-error-just-ret-nil)
        ;-------------------------------------------------------------------
        ;
        ;----------------------------------------------------------------
        ;This could be hidiously long, think about something that would
        ;detect hidious, then do something smart with what gets collected
        ;and displayed.
        ;
        ;Consider making something that detect and removes comments
        ;at the end of line
        ;----------------------------------------------------------------
        ;Remove comment by not adding matches that start with comment
        (unless (s-matches? "^\\s-*--" (match-string-no-properties 0))        
          (setq element-cleaned 
            (s-trim (s-collapse-whitespace(match-string-no-properties 0))))
          ;
          ;Todo: as elements are pushed add text "Driver or "Load"
          (push (list "Loads" element-cleaned) drivers_and_loads_list))
        ;-------------------------------------------------------------------
        ;
      );end of while
    ;
    (goto-char (point-min))
    ;  
      (while
        ;
        (re-search-forward 
         (format ".*<=.*%s\\b.*" arg) 
           search-is-unbounded
             no-error-just-ret-nil)
        ;
        ;----------------------------------------------------------------
        ;This could be hidiously long, think about something that would
        ;detect hidious, then do something smart with what gets collected
        ;and displayed.
        ;
        ;Consider making something that detect and removes comments
        ;at the end of line
        ;----------------------------------------------------------------
        ;Remove comment by not adding matches that start with comment
        (unless (s-matches? "^\\s-*--" (match-string-no-properties 0))
          (setq element-cleaned 
            (s-trim (s-collapse-whitespace(match-string-no-properties 0))))
          ;
          ;Todo: as elements are pushed add text "Driver or "Load"
          (push (list "Driver" element-cleaned) drivers_and_loads_list))
        ;-------------------------------------------------------------------
        ;
      );end of while
      ;
    );end of save-excursion
  drivers_and_loads_list);end of let
 );end of defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun this-test ()
 (interactive)
 (print-list-to-temp-pop-up-interactive 
   (find-drivers-and-loads "arst")))
;
(defun this-test ()
 (interactive)
 (print-list-to-temp-pop-up-interactive 
   (find-drivers-and-loads "s_reset_l_q")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun test-get ()
 (interactive)
 (setq mydir (get-direction-of-entity-port "clk_det_j2"))
 (message "dir is: %s" mydir))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-formal-actual (arg-verbose arg-this-line-only &optional arg-actual)
  "Return a list (formal actual) or nil when nothing found
  When 2and arge arg-this-line-only non-nil don't move point"
  (interactive)
  (let ((start-pos (point)) (formal-actual-list) found-actual-formal-pair)
  ;
  (when arg-this-line-only (beginning-of-line) )
  ;
  (with-syntax-table search-for-vhdl-record-types-words-syntax-table
    ;
    (setq found-actual-formal-pair 
    ;search for a specific actual
    (if arg-actual
      ;T
      (progn
      (setq temp-port_map_regex_var 
      ;the \\b is important to fix the case where the user wants to search for
      ;  REG_gio_mgt1_cfg_wr 
      ;and matches 
      ;  REG_gio_mgt1_cfg_wr_drp
      ;unexpectedly
        (concat "^\\s-*\\(\\w+\\)\\s-*=>\\s-*"  (regexp-quote arg-actual) "\\b"))        
      ;
        (if arg-this-line-only  
          ;T this line only
          (re-search-forward 
            ;; "^\\s-*\\(\\w+\\)\\s-*=>\\s-*\\(\\w+\\)" (line-end-position) t)
            temp-port_map_regex_var (line-end-position) t)
          ;F forward
          (re-search-forward 
             temp-port_map_regex_var (point-max) t)))
            ;"^\\s-*\\(\\w+\\)\\s-*=>\\s-*\\(\\w+\\)" (point-max) t)))
      ;F
      (progn
        (if arg-this-line-only  
          ;T this line only
          (re-search-forward 
            "^\\s-*\\(\\w+\\)\\s-*=>\\s-*\\(\\w+\\)" (line-end-position) t)
          ;F forward
          (re-search-forward 
            "^\\s-*\\(\\w+\\)\\s-*=>\\s-*\\(\\w+\\)" (point-max) t))))))
  ;
  (when (match-string 1)
    (setq formal (substring-no-properties (match-string 1))))
  ;
  (when (match-string 2) 
    (setq actual (substring-no-properties(match-string 2))))
  ;
  (setq formal-actual-list (list formal actual))
  (when arg-verbose (message actual))
  (when arg-this-line-only (goto-char start-pos))
  ;
  ;Return value
  (if found-actual-formal-pair 
      formal-actual-list
      nil)
  ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;alist
;(port-name => port-direction-only)
;                           given be table
;                          <---------------------->
;(signal name, (port-name/instance-name port-direction ) )
;"Signal/Port connects to:" INSTANCE:INAME ":" PORT "as an :" INPUT
;use key-port-nm-val-cmpnt-stmnt-drctn-only-alist
;get the actual on the current line
;get the associated instance-name/component name
;make a list of lists with this form:
; var holds actual-name
; ( (instance-name-1 port-name-1 port-direction-1) 
;    (instance-name-2 port-name-2 port-direction-2)
;    ...
;    (instance-name-n port-name-n port-direction-n)
;  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;to do 
;- Improve the master list so that the message can be better.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun look-up-actual-fan-out ()
 "Tell the fanout of the actual on this port-map line, pop up a frame with
  the results of there are more than 2"
 (interactive)
 (let (
       (start-pos (point))
       formal-actual-list
       formal
       actual
       port-name
       initial-actual
       master_look_up_fanout_list
       current-look-up-fanout-list
       ent_port_nm_lst
       ent_name_drction/only_list
       ent_name_drction/type_lst
       temp_entity_direction
      )
 ;------------------------------------------------------------------
 ;get the formal and initial-actual this line
 ;add something to handle the case where the user is not looking
 ;at a port map element.
 (cl-multiple-value-setq (formal initial-actual) (get-formal-actual nil t nil))
 (setq formal-inst formal)
 ;------------------------------------------------------------------
 ;
 (goto-char(point-min))
 ;
 (while
   ;
   (cl-multiple-value-setq (formal actual) 
     (get-formal-actual nil nil initial-actual))
   ;
   ;get the instance-name component-name of the current instance
   (cl-multiple-value-setq 
     (current-comp-name instnc-name/port-name ) (my-find-def-inst-back '-))
   ;
   ;get the current formal direction
   (setq cur-formal-drcton 
     (look-up-ports-direction 
        ;alist                            formal  component
        key-port-nm-val-cmpnt-stmnt-drctn-only-alist  formal  current-comp-name))
   ;
   ;make a current list that gives everything the user wants
   (setq current-look-up-fanout-list
     (list 
           initial-actual 
                          instnc-name/port-name 
                                                cur-formal-drcton))
   ;
   ;push the current list onto the master list
   (push current-look-up-fanout-list    master_look_up_fanout_list)
   ;
   ;instrumentation
   (setq master-look-up-fanout-list-inst    master_look_up_fanout_list)
 ;
 );end of while
 ;
 ;-------------------------------------------------------------------------------
 ;re-search the entity when there is a match push data onto the master list 
 ;-------------------------------------------------------------------------------
 (when 
   (setq temp_entity_direction 
     (get-direction-of-entity-port initial-actual) )
       (push (list initial-actual "Top Level Entity" temp_entity_direction)
         master_look_up_fanout_list)) 
 
 ;-------------------------------------------------------------------------------
 ;Add drivers and loads
 ;-------------------------------------------------------------------------------
 (dolist (x-arg (find-drivers-and-loads initial-actual))
   (push x-arg master_look_up_fanout_list))
 ;
 ;-------------------------------------------------------------------------------
 ;think about searching again for the record type base
 ;-------------------------------------------------------------------------------
 (when (s-contains? "." initial-actual)
  (setq record-type-p t)
  (setq record-type-base-name (car (s-split "\\." initial-actual)))
  (message "Changed a compound record removing the RHS"))
 ;
 ;
 ;Print the results, to minibuffer or pop-up buffer
 (if (<= 3 (length master_look_up_fanout_list))
   (print-list-to-temp-pop-up-interactive master_look_up_fanout_list)
   (message "Lookup List %s: " master_look_up_fanout_list))
 ;
 ;
 (goto-char start-pos)
 (setq master_look_up_fanout_list_inst master_look_up_fanout_list)
 );end of let
);end of defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;in the entity want the list to look like
; (( initial-actual-1 "Top Level entity port-name-1" entity-element-dir-1))
; (( initial-actual-2 "Top Level entity port-name-2" entity-element-dir-2))
;
;in the architecture
;master list has the form  
; ((initial-actual-1 instnc-name/port-name-1 formal-drcton-1) 
;  (initial-actual-2 instnc-name/port-name-2 formal-drcton-2) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


  

;(setq aoeu '(1 2 3 4))
;; (secon d aoeu)


;(setq master-look-up-fanout-list-inst nil)

;; (setq temp1 "aoeu")
;; (setq temp2 "aoeuaoeu")
;; (equal temp1 temp2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun look-up-ports-direction (alist-arg port-arg component-arg)
 (interactive)
 (let ((port-drctn) (port-name)) ;
  (dolist (x-alist-entry alist-arg) 
  ;
  (when (equal (car x-alist-entry) port-arg) 
    (when 
      ;
      (equal (second x-alist-entry) component-arg) 
      (message "Direction of port %s is:%s"  
        ;Cnvrt all adjcnt whtspc to 1 spc, removed leading and trailing wsp.
        (setq port-name (s-trim (s-collapse-whitespace (car x-alist-entry))))
        (setq port-drctn (s-trim (s-collapse-whitespace (third x-alist-entry))))
          ;
      );end of message
     );end of when
   );end of outside when
  );end of dolist
 port-drctn))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;JUNK
; (assoc "ex0_in" key-port-nm-val-cmpnt-stmnt-drctn-only-alist)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;How do I use this;??, What is the point.
(defun slurp-actual/formal-one-instance ()
 "Move point to near beginning of an instance, slurp it's lines (elements)
  Return t if a instanec is found, nil otherwise
  Modify global vars adding to big lists as needed."
  (interactive)
  (let (my-current-instance-name 
        temp-inst-element
        temp-actual
        instance-end
        inst-begin-position
        temp-formal) 
    ;
    (if (my-find-def-inst-fwd nil)
      ;T
      (progn
        ;
        (setq inst-begin-position (point))
        ;
        (setq instance-end (re-search-forward ");" (point-max) t))
        ;
        (goto-char inst-begin-position)
        ;
        (re-search-forward "port" instance-end t)
        (while 
          ;-----------------------------------------------------------------
          ;kinda goofy but it works!
          (with-syntax-table search-for-vhdl-record-types-words-syntax-table
            (re-search-forward 
               "\\s-+\\(\\w+\\)\\s-*=>\\s-*\\(\\w+\\)" instance-end t))
          ;-----------------------------------------------------------------
          ;
          (setq temp-inst-element (match-string-no-properties 0))
          (setq temp-formal (match-string-no-properties 1))
          (setq temp-actual (match-string-no-properties 2))
          ;
          (setq vhdlp-inst-elements-list 
            (cons  temp-inst-element vhdlp-inst-elements-list ))
          ;
          (setq vhdlp-inst-formal-list 
            (cons  temp-formal vhdlp-inst-formal-list ))
          ;
          (setq vhdlp-inst-actual-list 
            (cons  temp-actual vhdlp-inst-actual-list ))
          ;
          (setq formal-actual-pair (list temp-formal temp-actual))
          ;make a list where each element is a list
          ;( (formal-1  actual-1) (formal-2  actual-2) ...)
          (setq vhdlp-master-formal-actual-pair-list 
            (cons  formal-actual-pair vhdlp-master-formal-actual-pair-list ))
          );end of while
          ;
          (message "pairs:%s, formals: %s\n" 
                   (length vhdlp-master-formal-actual-pair-list) 
                   (length vhdlp-inst-actual-list))
          t);end of progn
      ;
      ;F 
      nil);end of if
         ;   
   );end of let
   ;
 );end of defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;dev junk
;  (car vhdlp-cmpnnt-stmnt-elements-list)
;; (cons vhdlp-cmpnnt-stmnt-elements-list "aoeu")
;; (car vhdlp-cmpnnt-stmnt-elements-list)
;; (length vhdlp-cmpnnt-stmnt-elements-list)
;; (length vhdlp-cmpnnt-stmnt-name-list)
(cdr vhdlp-cmpnnt-stmnt-elements-list)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-find-def ()
 "Move point to the definition of a signal
  constant input or output based on thing at point"
   (interactive)
;
   ;;Might want to come back
   (push-mark)
   ;
   ;;This is what is being searched for
   (setq myStr (thing-at-point 'word))
   ;
   ;Build up the search string
   (setq sig_type_regex_var "\\(type[ ]*\\|subtype[ ]*\\)")
   (setq sig_con_regex_var "\\(signal[ ]*\\|constant[ ]*\\)")
   ;
   (setq verilog_int_wire_reg_define_sig_regex_var "\\(^\\s-*integer[ ]+\\|^\\s-*wire[ ]+\\|^\\s-*`define[ ]+\\|^\\s-*reg[ ]*.*\\)")
   ;
   (setq io_regex_var "\\([ ]*:[ ]*in\\|[ ]*:[ ]*out\\)")
   ;
   (setq first_part_var(concat (regexp-quote myStr) io_regex_var))
   ;
   (setq second_part_var(concat sig_con_regex_var (regexp-quote myStr)))
   ;
   (setq third_part_var(concat sig_type_regex_var (regexp-quote myStr)))
   ;
   (setq fourth_part_var(concat verilog_int_wire_reg_define_sig_regex_var (regexp-quote myStr)))
   ;
   (setq tot_var (concat second_part_var "\\|" first_part_var "\\|" third_part_var "\\|" fourth_part_var ))
   ;
   ;Start from the beginnging of the file
   (goto-char (point-min))
   ;
   (if (re-search-forward tot_var nil t)
      ;T
      (progn (message "Found it") 
         ;;Move cursor to begining of word
         (re-search-backward (regexp-quote myStr) nil t))
      ;F
      (progn
        ;
        (message "Not Found in this buffer using Re-search")
        (jump-to-mark)
        (sit-for 1)
        (message "Trying Moccur in open buffers")
        (sit-for 1)
        (unless (my-find-def-moc)
          (if (y-or-n-p "Try to search using moccur-grep-find")
            (progn
            (sit-for 1)
            ;(message "moccur-returned what I wanted"))
            (my-find-def-mgf))
            (message "Exiting my-find-def")
            (sit-for 1)
            (message ""))))))
;   
;;Interesting this does not work!
;; (global-set-key (kbd "C-c S") 'my-find-def-moc)
;(global-set-key [(control c) (S)] 'my-find-def-moc)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;does not work in an icicles enviornment
(defun findget-and-insert-signal ()
   "Show a list of stuff using IMENU then insert the thing at point"
   (interactive)
   ;;Might want to come back
   (push-mark)
   (idomenu)
   ;
   (beginning-of-line)
   (if (re-search-forward "signal" (line-end-position) t)
      ;T:skip to second word if its a signal
      (progn(re-search-forward "\\>" nil t) (re-search-forward "\\<" nil t))
      ;F:first word if its an input or output
      (re-search-forward "\\<" nil t))
   ;
   (setq myStr (thing-at-point 'word))
   (pop-to-mark-command)
(insert myStr))
;
;;C-i is same ASCII as TAB don't use it as a binding!!
;;  http://www.gnu.org/software/emacs/elisp/html_node/Function-Keys.html
;Remember 
;   C-c i is this, 
;   C-x i is idoimenu
;(global-set-key  [(control c) (i)] 'findget-and-insert-signal)
;
;Example of VHDL mode hook
;; ;
;; (add-hook 'vhdl-mode-hook
;;  (lambda ()
;;  (define-key vhdl-mode-map  [(control i)] 'findget-and-insert-signal)
;;  )
;; )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;F1 help at point
;;; describe this point lisp only
(defun describe-foo-at-point ()
  "Show the documentation of the Elisp function and variable near point.
  This checks in turn:    
  -- for a function name where point is
  -- for a variable name where point is
  -- for a surrounding function call"
  (interactive)
  (let ( (sym) (icicle-default-value t))
    ;; sigh, function-at-point is too clever.  we want only the first half.
    (cond ((setq sym (ignore-errors
                       (with-syntax-table emacs-lisp-mode-syntax-table
                         (save-excursion
                           (or (not (zerop (skip-syntax-backward "_w")))
                               (eq (char-syntax (char-after (point))) ?w)
                               (eq (char-syntax (char-after (point))) ?_)
                               (forward-sexp -1))
                           (skip-chars-forward "`'")
                           (let ((obj (read (current-buffer))))
                             (and (symbolp obj) (fboundp obj) obj))))))
           (describe-function sym))
          ((setq sym (variable-at-point)) (describe-variable sym))
          ;; now let it operate fully -- i.e. also check the
          ;; surrounding sexp for a function call.
          ((setq sym (function-at-point)) (describe-function sym)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun print-vhdl-filenames-recursive ()
 "Pop up a new frame, prompt for a starting dir, show the names of vhdl files"
 (interactive)
 (print-list-to-temp-pop-up (call-interactively 'files-in-below-directory)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ref /www.gnu.org/software/emacs/manual/html_node/eintr/Files-List.html
(defun files-in-below-directory (directory)
  "List the .vhd files in DIRECTORY and in its sub-directories."
  ;; Although the function will be used non-interactively,
  ;; it will be easier to test if we make it interactive.
  ;; The directory will have a name such as
  ;;  "/usr/local/share/emacs/22.1.1/lisp/"
  (interactive "DDirectory name to start recursive slurp: ")
  (let (local-files-list
        (current-directory-list
         (directory-files-and-attributes directory t)))
    ;; while we are in the current directory
    (while current-directory-list
      (cond
       ;; check to see whether filename ends in `.el'
       ;; and if so, append its name to a list.
       ;; ((equal ".el" (substring (car (car current-directory-list)) -3))
       ((equal ".vhd" (substring (car (car current-directory-list)) -4))
        (setq local-files-list
              (cons (car (car current-directory-list)) local-files-list)))
       ;; check whether filename is that of a directory
       ((eq t (car (cdr (car current-directory-list))))
        ;; decide whether to skip or recurse
        (if
            (equal "."
                   (substring (car (car current-directory-list)) -1))
            ;; then do nothing since filename is that of
            ;;   current directory or parent, "." or ".."
            ()
          ;; else descend into the directory and repeat the process
          (setq local-files-list
                (append
                 (files-in-below-directory
                  (car (car current-directory-list)))
                 local-files-list)))))
      ;; move to the next filename in the list; this also
      ;; shortens the list so the while loop eventually comes to an end
      (setq current-directory-list (cdr current-directory-list)))
    ;; return the filenames
    (setq myfiles local-files-list)))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;how is this different;than (slurp-actual/formal-one-instance)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun slurp-port-map-ports ()
 "Return an alist of all the formal, actual pairs"
 (interactive)
 (let 
   ((my-key-list-of-formals nil)
   (my-val-list-of-actuals nil)
   (my-alist-describe-port-map nil))
   ;------------------------------------------------------------------
   ;get the formal and initial-actual this line
   ;add something to handle the case where the user is not looking
   ;at a port map element.
   ;
   ;yes this needs both save-excursion's
   (save-excursion
   
   (my-find-def-inst-back nil)
   ;
   (save-excursion
   ;
   (setq position-of-semi (re-search-forward ";" nil t)))
   ;
   (search-forward "port map")
   ;
   ;------------------------------------------------------------------
   (while (< (point) position-of-semi)
     (forward-line 1)
     ;
     ;skip over comments
     (when (looking-at "\s*--") (forward-line 1))
     ;
     (cl-multiple-value-setq 
       (my-formal my-actual) 
       (get-formal-actual 
         vhdlp-verbose vhdlp-this-line-only vhdlp-no-actual))
   ;       
   ;don't push nils
     (when my-formal (push my-formal my-key-list-of-formals))
     (when my-actual (push  my-actual my-val-list-of-actuals)))
   ;------------------------------------------------------------------
   ;
   ;temp is the new alist created here
   (setq port-map-formals-actuals-alist 
     (pairlis  my-key-list-of-formals my-val-list-of-actuals)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-change-alist ()
 "Change alist for many components to a form usable for comparing port 
 maps to it's entity. Identify the current component and create a new alist 
 pertaining only to that component. 
 Using var key-port/name-val-cmp/name-dir-type-alist as a dir local var by
 placing it it .dir-local.el files"
 (interactive)
 (let ((component-name (get-component-name-from-port-map))
       (temp-keys-list () )
       (temp-values-list () )
       )
 (setq keys-port/names-values-mode-type-alist nil)
 ;
 (cl-multiple-value-setq 
   (my-current-comp-name my-instnc-name/port-name ) 
     (my-find-def-inst-back '- t)) 
 ;
 (dolist 
   (x-alist-entry key-port/name-val-cmp/name-dir-type-alist) 
   ;
   (message (s-join " " x-alist-entry)) 
   ;
   (message (car x-alist-entry)) 
   (message  (s-join " " (cdr x-alist-entry)))
   (setq temp-temp x-alist-entry)
   ;
   (when (equal (cadr x-alist-entry) component-name)
     (push (car x-alist-entry) temp-keys-list)
     (push (s-join " " (cddr x-alist-entry)) temp-values-list)))
 ;  
 (setq keys-port/names-values-mode-type-alist 
       (pairlis temp-keys-list temp-values-list))
 (setq component-name-instrument component-name)
 (setq tmp-keys-list temp-keys-list)
 (setq tmp-vals-list temp-values-list)

    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun diff-port-map-pov ()
  "Tell the difference between a port map and the definition in it's 
   corresponding entity. User must run slurp function first such as
   slurp-all-entities-as-components-prompt-4-start-dir"
 (interactive)
 (let
   ((entity_keys--xxx nil)
    (port_map_keys--xxx nil)
    (siglist nil)
    (complist nil))
   ; 
   (setq entity_keys nil)
   (setq port_map_keys nil)
   (setq my-vals-list nil)
   ;
   ;"Return an alist of all the formal, actual pairs"
   ;fixme this is manipulating a global, return values not used.
   (slurp-port-map-ports)
   ; 
   ;"Change alist for many components to a form usable for comparing port 
   ;maps to it's entity. Identify the current component and create a new alist 
   ;pertaining only to that component"   
   (my-change-alist)
   ;
   ;get the keys
   (dolist 
     (x-alist-entry keys-port/names-values-mode-type-alist) 
     (push (car x-alist-entry) entity_keys)) 
   ;
   (dolist 
     (x-alist-entry port-map-formals-actuals-alist) 
     (push (car x-alist-entry) port_map_keys))
   ; 
   (setq ent-minus-port-map (-difference entity_keys port_map_keys))
   (setq port-map-minus-entity (-difference  port_map_keys entity_keys))
   ;
   ;put in some logic, don't always show a pop-up
   (dolist
      (x-alist-entry ent-minus-port-map)
         (setq temp-val (assoc x-alist-entry keys-port/names-values-mode-type-alist))
         (push temp-val my-vals-list))
   ;
   ;---display---
   (with-output-to-temp-buffer "*Port-map-Entity-Diff*"
     ;---missing
     (when ent-minus-port-map
        (my-print-list-to-std-out-opl 
            ent-minus-port-map 
              "--Port map missing Formals:" 
                "   "))
     ;---extra
     (when port-map-minus-entity
       ;--extra
         (my-print-list-to-std-out-opl 
            port-map-minus-entity  
            "--Port map extra Formals:"
              "   "))
     ;
     ;component statements---
     (dolist (x-alist-entry my-vals-list)
       ;transformation & push to list
       (push (my-transform-component-statement x-alist-entry) complist))
       ;
       (when complist
           (my-print-list-to-std-out-opl 
              complist  
              "--New Component Statement Entries:"
                "  "))
     ;
     ;signals----
     (dolist (x-alist-entry my-vals-list)
       ;
       (setq one-signal-name (my-transform-list-to-signal x-alist-entry))
       ;
       (push (my-transform-list-to-signal x-alist-entry) siglist))
       ;
     (when siglist
       ;--extra
         (my-print-list-to-std-out-opl 
            siglist  
            "--Possible New Signals"
              "  "))
       ;
     ;new port map formals---
     (princ "\n--New Port Map Formals \n")
     ;
     (dolist
       (x-alist-entry my-vals-list)
       (princ (format "  %s => %s,\n" (car x-alist-entry) (car x-alist-entry) )))
     ;
     (pop-to-buffer "*Port-map-Entity-Diff*")
     (vhdl-mode))))
 ;--display--
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(defun my-transform-component-statement (arg-x-alist-entry)
  (interactive)
  ;Change one space to two
  (s-replace " " "  " 
  ;Change irregular distribution of whitespace to one
    (s-collapse-whitespace 
      (s-replace "out" "out :" 
        (s-replace "in" "in :" 
          (concat (car arg-x-alist-entry) (cdr arg-x-alist-entry) ";"))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(defun my-transform-list-to-signal (arg-x-alist-entry)
  (interactive)
  (setq blah (concat (car arg-x-alist-entry) ":" (cdr arg-x-alist-entry)))
  ;remove strings "in" and "out"
  (setq newrep 
    (s-replace "in" ""
      (s-replace "out" "" blah) ))
   ;
   ;Change one space to two
    (s-replace " " "  " 
    ;Change irregular distribution of whitespace to one
      (s-collapse-whitespace 
        ;Prepend string "signal" append string ";"
        (concat "signal  " newrep ";"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(defun my-print-list-to-std-out-opl  (arg-list &optional arg-hdr arg-lst-ele-bol)
  "opl means one per line"
  (interactive)
  (when arg-hdr
    (princ (format "%s\n" arg-hdr)))
  ;
  (if arg-lst-ele-bol
    ;T
    (progn
    (dolist (xtemp arg-list)
      (princ (format "%s%s\n" arg-lst-ele-bol xtemp))))
    ;F  
    (dolist (xtemp arg-list)
      (princ (format "%s\n"  xtemp))))
  ;
  (princ (format "\n")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun temp-test ()
 (interactive)
 (let
 (temp-entity_keys)
 (setq my-temp-list '(1 2 3))
 ; 
 (dolist 
   (x-alist-entry my-temp-list) 
   (push x-alist-entry temp-entity_keys))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;diff the 
; - keys from keys-port/names-values-mode-type-alist
; to
; - slurp-actual/formal-one-instance or slurp-port-map-ports
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;temp-temp       ;-> ("lru_state_int" "slave_top" " out    t_lru_state_bus")
;(car temp-temp) ;-> "lru_state_int"
;(cdr temp-temp) ;->                  ("slave_top" " out    t_lru_state_bus")
;(cddr temp-temp);->                              (" out    t_lru_state_bus")
;(cadr temp-temp);->                   "slave_top"
;(-difference '(1 2 3 4) '(1 2 3 5));->(4)
;(-difference  '(1 2 3 5) '(1 2 3 4));->(5)
;(pp '(1 2 3))
;(princ '(1 2 3))
;(print-elements-of-list '(1 2 3))
;(setq aoeu '(1 2))
;(setq htns '(3 4))
;(cons aoeu htns)
;(append aoeu htns)
;(nconc "aoeu" aoeu htns)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun concatString (list)
  "A non-recursive function that concatenates a list of strings."
  (if (listp list)
      (let ((result ""))
        (dolist (item list)
          (if (stringp item)
              (setq result (concatenate 'string result item))))
        result)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-component-name-from-port-map ()
 "Quietly return the component aka design unit name without a .vhd extension"
 (interactive)
 (let (current-comp-name 
       instnc-name/port-name )
 ;      
 (cl-multiple-value-setq 
   (current-comp-name instnc-name/port-name ) (my-find-def-inst-back '- t))
 current-comp-name))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;experimental junk
(setq treess '((pines . cones) (oak . acorns) (maple . seeds)))
(setq trees '((pine . cones) (oak . acorns) (maple . seeds)))
;

(-difference '(1 2 3) '(4 5 6))
;(-difference temp temp)
(-difference trees treess)
(-difference treess trees)
(-union treess trees)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;replace the 2nd word
(setq tempstr "da foo is")
(setq tempstr/w-semi "clk25mhz   :  in     std_logic")
(setq tempstr "  clk25mhz     in     std_logic")
(setq tempstr-other       "    in              std_logic")
;
;
;get rid of the semi
(replace-regexp-in-string ":" "" tempstr/w-semi)
;get rid of the middle word which should be the type
(replace-regexp-in-string  
 "\\(^\\s-*\\w+\\)\\s-+\\(\\w+\\)\\s-+\\(\\w+\\)" "\\1  \\3" tempstr)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun remove-second-word-for-vhdl (arg-string-expect-2-words)
 (interactive)
 (replace-regexp-in-string  
 ;; "\\(^\\s-*\\w+\\)\\s-+\\(\\w+\\)" "\\2" arg-string-expect-2-words))
 "\\(^\\s-*\\w+\\)\\s-+\\(\\w+\\)" "\\2" (format "%s" arg-string-expect-2-words)))
;perhaps arg-string-expect-2-words needs to be changed to a string
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;define a keyboard macro to put the direction comment at the end of port map lines
;must select them first
;note this dies when a comment line is hit.
;perhaps this could be combined with (vhdl-in-comment-p)
(fset 'put_comment_end_of_line_region
   [?\M-- C-prior ?\M-t])
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun create-then-write-dir-locals-dot-el ()
 "Form a temp buffer, put the string in, write it to file, kill the buffer
  Onverwrite file on the drive."
  (interactive)
  ;
  ;if the file exists remove it
  (when (file-exists-p ".dir-locals.el")
    (delete-file ".dir-locals.el"))
  ;
  ;form a temp buffer, put the string in, write it to file, kill the buffer
  (with-temp-file ".dir-locals.el" 
  ;extra backslashes to escape the quotes bc I want a literal quote
    (insert "((nil . ((key-port/name-val-cmp/name-dir-type-alist . nil))))")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun vlog-test (arg)
  "search for verilog module names"
  (interactive "P")
  (push-mark)
  (let (tempmatch mystr)
    ;
   ;; (setq vlogp-find-inst-fwd-str "\\(\\s-\\|\n\\)")
   ; come back (setq vlogp-find-inst-fwd-str "^\\s-*\\(\\w+\\)\s-*\n*\s-*\\w+\s-+(")
   ;; (setq vlogp-find-inst-fwd-str "^\\s-*\\(\®\w+\\)\\(\\n*\\s-+\\)\\(\\w+\\)\\s-*(")
   ;; (setq vlogp-find-inst-fwd-str "^\\s-*\\([a-z0-9_]+\\)\\(\\s-+\\|\\n+\\)\\([a-z0-9_]+\\)")
   ;; (setq vlogp-find-inst-fwd-str "^\\s-*\\([a-z0-9_]+\\)\\(\\n+\\)\\([a-z0-9_]+\\)")

   ;10-15
   ;(setq vlogp-find-inst-fwd-str "^\\s-*\\([a-z0-9_]+\\)\\(\n+\\|\\s-+\\)\\(\\s-*[a-z0-9_]+\\)")
   
   (setq vlogp-find-inst-fwd-str "^\\s-*\\([a-z0-9_]+\\)")

;; (setq vlogp-find-inst-fwd-str 
;; "^\\s-*
;; \\([a-z0-9_]+\\)\\s-*
;; \\(\n+\\|\\s-+\\)
;; \\([a-z0-9_]+\\)
;; \\(\n+\\|\\s-+\\)(")

;; (setq vlogp-find-inst-fwd-str "^\\s-*\\([a-z0-9_]+\\)\\(\\n+\\s-+\\|\\n+\\|\\s-+\\n+\\|\\s-+\\n+\\s-+\\)\\([a-z0-9_]+\\)\\s-*")
;; (setq vlogp-find-inst-fwd-str "^\\s-*\\([a-z0-9_]+\\)\\(\\s-+\\|\\n+\\s-\\\|\\n+\\|\\s-+\\n+\\|\\s-+\\n+\\s-+\\)\\([a-z0-9_]+\\)")
   (setq vlogp-find-inst-fwd-str "^\\s-*\\([a-zA-Z0-9_]\\)+\\s-+\\([a-zA-Z0-9_]+\\)")
;;   (setq vlogp-find-inst-fwd-str "^\\s-*\\([a-z0-9_]+\\)\\(\\s-+\\)\\([a-z0-9_]+\\)")


   (setq tot_var vlogp-find-inst-fwd-str)
   ;; (re-search-forward tot_var nil t 1)
   (re-search-forward vlogp-find-inst-fwd-str nil t 1)
   ;;(re-search-forward vlogp-find-inst-fwd-str nil t 1)
  
  (message "first %s second %s third %s" 
           (match-string-no-properties 1) 
           (match-string-no-properties 2) 
             (match-string-no-properties 3))

  (if (match-string 0)
    (setq tempmatch (match-string 0))
    (setq tempmatch (match-string 2)))


   ;(backward-char 2)
   ;(if (looking-at "#(") 
   ;  (message "looking at #(" )
   ;  (message "not looking at #(" )
   ;  )

    )
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;(verilog-re-search-forward REGEXP BOUND NOERROR)
(defsubst verilog-re-search-forward (REGEXP BOUND NOERROR)
  ;; checkdoc-params: (REGEXP BOUND NOERROR)
  "Like `re-search-forward', but skips over match in comments or strings."
  (let ((mdata '(nil nil)))  ; So match-end will return nil if no matches found
    (while (and
	    (re-search-forward REGEXP BOUND NOERROR)
	    (setq mdata (match-data))
	    (and (verilog-skip-forward-comment-or-string)
		 (progn
		   (setq mdata '(nil nil))
		   (if BOUND
		       (< (point) BOUND)
		     t)))))
    (store-match-data mdata)
    (match-end 0)))


(defun vlog-find-inst-fwd (arg)
  "search for verilog module names"
  (interactive "P")

  ;might want to come back
  (setq vlogp-find-inst-fwd-start (point))
  
  ;Handle repeated invocations of this defun
  ;don't want to find the same every time the key chord is pushed,
  ;rather we want the next one.
  (if (eq vlogp-find-inst-fwd-finish (point)) (forward-line 1))
  
  (push-mark)
  
  (let (
       (tempmatch nil) 
       (vlogp-find-inst-fwd-inside-comment nil) 
       (mystr nil) 
       (myplace nil) 
       (vlogp-find-inst-fwd-match-module-name nil)
       )
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
  ; Loop until a module name is matched, moving forward 1 line each time
  ; there is a match.
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
  (while (not vlogp-find-inst-fwd-match-module-name)

    ; -- search for --
    ; <module name>
    ; -- followed by --
    ; 0 or more spaces
    ; -- followed by --
    ; "("   (close paren)
    (setq vlogp-find-inst-fwd-str "\\([a-zA-Z0-9_]\\)+\\s-*(")
    (setq tot_var vlogp-find-inst-fwd-str)
    ;
    (setq vlogp-find-inst-fwd-search-return-val 
          ;verilog-re-search-forward skips matches in comments and strings
          (verilog-re-search-forward vlogp-find-inst-fwd-str nil t ))
     
    (setq vlogp-find-inst-fwd-open-paren-loc (point)) ;save for later

    ; --- move to checking defun start ---
    ;Don't want to move based on junk in comments which may not be valid verilog
    ;this does not check at the beginningt of comment line.
    (setq vlogp-find-inst-fwd-inside-comment (verilog-inside-comment-or-string-p)) ; comments
    
    ; maybe should move two words back from the open paren
    ; rather than to the beg of line.
    (beginning-of-line)

     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; check for other stuff
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (if (or
            (looking-at "\s*[a-z_]+:"); label
            (looking-at "\s*initial"); generate statement
            (looking-at "\s*generate"); generate statement
            (looking-at "\s*case")    ; case statement
            (looking-at "\s*if")      ; part of conditional statement
            (looking-at "\s*else")    ; part of conditional statement
            (looking-at "\s*for")     ; for statement
            (looking-at "\s*module")  ; the file you are in
            (looking-at "\s*//")      ; comments
            (looking-at "\s*\\."))    ; port line
       ; non module instance name     
       (progn     
         (message "Looking at . or comments or port line" )
         (setq vlogp-find-inst-fwd-match-module-name nil)
         (forward-line 1))
       ; module instance name
       (progn
         (setq vlogp-find-inst-fwd-match-module-name t)
         (message "Looking at a module name" )
         (goto-char vlogp-find-inst-fwd-open-paren-loc)));matches if
    ; --- move to checing defun end ---
         
  );matches while

   (setq vlogp-find-inst-fwd-str "^\\s-*\\([a-zA-Z0-9_]\\)+")
   (setq tot_var vlogp-find-inst-fwd-str)
   (re-search-backward vlogp-find-inst-fwd-str nil t 1)
   ;after the last function looking at space

   ; move forward to some non space, then back 1 so that point is at the begining of tha name.
   (setq vlogp-find-inst-fwd-str "\\([a-zA-Z0-9_]\\)")
   (setq tot_var vlogp-find-inst-fwd-str)
   (re-search-forward vlogp-find-inst-fwd-str nil t 1)
   (forward-char -1)

   (setq vlogp-find-inst-fwd-finish (point))
   
  (if (match-string 0)
    (setq tempmatch (match-string 0))
    (setq tempmatch (match-string 2)))

  ; fix me, this is currently meaningless
  (message "first %s second %s third %s" 
           (match-string-no-properties 1) 
           (match-string-no-properties 2) 
             (match-string-no-properties 3))

  (message "matched meaningful name is %s" vlogp-find-inst-fwd-match-module-name)

  (if (not vlogp-find-inst-fwd-search-return-val) 
      (progn
        (goto-char vlogp-find-inst-fwd-start) 
        (message "No Verilog modules instance found searching forward")))

  ) ;matches let
 ); matches defun


(defun vlog-find-inst-back (arg)
  "Search backward for verilog module names, leave point at the module name"
  (interactive "P")
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
  ; Pre command activities
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
  (setq vlogp-find-inst-back-defun-start-global (vlog-find-inst-back-pre))
  
  ;Initialize local vars
  (let ((vlogp-inst-name-start-pos t) 
        (vlogp-module-name nil)
        (vlogp-instnc-name t)) ;

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
  ; Loop until a potential name is matched
  ; Exit loop if no canditate.
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (while 
    (loop-back-p vlogp-inst-name-start-pos vlogp-instnc-name vlogp-module-name)
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
    ; INSTANCE NAME: Search backward for: 
    ; <bol>                     followed by
    ;   <zero or more space>      followed by 
    ;     <one-or-more word-chars>  followed by 
    ;       <zero-or-more space>      followed by
    ;         <(>
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
    (setq vlogp-inst-name-start-pos (vlogp-inst-search-back))
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; CHECK
    ; Check the instance name, return instance name if its good otherwise nil
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (setq vlogp-instnc-name (vlogp-get-instance-name) )
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; MODULE NAME search backward for
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; if the instance name search succeeds, then look for a module name 
    (if vlogp-instnc-name
     (setq vlogp-module-name (vlogp-get-module-name)))
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; If name bad loop again
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (unless (and vlogp-module-name  vlogp-instnc-name )
      ; dont try to move if nothing was returned nil -0 is an error
      (if vlogp-inst-name-start-pos 
          (goto-char (- vlogp-inst-name-start-pos  0))))
         
  ) ;matches while

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; Post command activities
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq vlogp-find-inst-back-finish-global 
        (vlog-find-inst-back-post vlogp-instnc-name  vlogp-module-name))

  ) ;matches let
 ); matches defun


(defun vlogp-inst-search-back ()
  "Main search backwards for the instance name.
   Return position of a character in the instance name if one is found
   or nil if not.  Leaves point at begin of instance name"
  (interactive)
  (let ((initial-search-ret-val nil))
  ;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; search
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq initial-search-ret-val 
     ;(verilog-re-search-backward vlogp-inst-rev-main-regex-global nil t))
     (verilog-re-search-backward vlogp-inst-rev-main-or-regex-global nil t))
    ;
    ; if the first search finds something, move to the symbol beginning
    (if initial-search-ret-val
      ; T, the search found a potential instance names
      (progn
      ;
      ;;;;;;;;;;;;;;;;;
      ; If the 2nd part of the search or regex matched, need to move
      ; point because we want point at text for the next function which
      ; finds the beginning of the symbol.
      ; Looking at space means the 2nd part of the or matched.
      ; Move forward to non space.
      ;
      ;;;;;;;;;;;;;;;;;
      ;; fix me
      ;;;;;;;;;;;;;;;;;
      ;; Might need to check for the open paren after the instance name
      ;; in the case of the 2and part of the search matching 
      ; From the end of the symbol +1 (skip-chars-forward "\n\s")
      ; should be looking at an open paren.
      (if (looking-at "\s*") 
          (re-search-forward "\\S-" nil t))
      ;    
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
      ; Move backward to the beginning of the instance name candidate
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
      (with-syntax-table search-for-verilog-syntax-table
        (setq vlogp-inst-name-start-pos 
              (goto-char (car (bounds-of-thing-at-point 'symbol))))))
      ;
      ; F Did not find a potential instance name
      (setq vlogp-inst-name-start-pos nil)
      ) ; matches if
      ;
   vlogp-inst-name-start-pos)) ; matches let, defun



(defun loop-back-p (vlogp-find-inst-back-rtrn-val-arg 
                       vlogp-instnc-name-arg vlogp-module-name-arg)
  "Logic to determine if the loop in to be entered"
  (interactive)
  (let (loop-again)
  (setq loop-again 
    (and 
     vlogp-find-inst-back-rtrn-val-arg
     (not 
       (and vlogp-instnc-name-arg vlogp-module-name-arg ))))))

(defun vlog-find-inst-back-pre ()
  "Initial stuff"
  (interactive)
  ;store the initial position
  (let (temp-pos)
  ;
  (setq temp-pos (point))
  ;  
  ;Handle repeated invocations of this defun
  ;Don't want to find the same every time the key chord is pushed,
  ;rather we want the next one.
  (if (eq vlogp-find-inst-back-finish-global (point)) 
      (forward-line -1))
  temp-pos))

(defun vlog-find-inst-back-post (vlogp-instnc-name vlogp-module-name )
  "Print names or no love message"
  (interactive)
  (let (temp-pos)
  (setq temp-pos (point))
  ;
  (if (not 
       ( and  vlogp-instnc-name  vlogp-module-name)) 
      ;T
      (progn
        (goto-char vlogp-find-inst-back-defun-start-global) 
        (message "No Verilog module instances found searching backward"))
      ; F  
      (progn
        (message "Module: %s  Instance: %s" 
                 vlogp-module-name vlogp-instnc-name))) 
  temp-pos))

(defun vlogp-get-instance-name ()
  "Check the instance name, return instance name if its good otherwise nil"
  (interactive)
  ;
    (with-syntax-table search-for-verilog-syntax-table
      ;
      (setq vlog-p-instance-name-candidate-back
            ;; (if (thing-at-point 'word) 
            (if (thing-at-point 'symbol) 
             (s-trim (substring-no-properties (thing-at-point 'symbol) ))))    ;
      ; Filter these: 
      ;   Some verilog system calls look like $(command)
      ;   Port map actuals look like .<\_>
      (if (or
             (or (looking-at "\s*/") (verilog-inside-comment-or-string-p))
             (not vlog-p-instance-name-candidate-back); string is empty
             (s-matches? "^if$"  vlog-p-instance-name-candidate-back )
             (s-matches? "^begin$"  vlog-p-instance-name-candidate-back )
             (s-matches? "^end$"  vlog-p-instance-name-candidate-back )
             (s-matches? "^else"  vlog-p-instance-name-candidate-back )
             (s-matches? "^for$"  vlog-p-instance-name-candidate-back )
             (s-matches? "\$.*"  vlog-p-instance-name-candidate-back )
             (s-matches? "^default$"  vlog-p-instance-name-candidate-back )
             (s-matches? "[.].*" vlog-p-instance-name-candidate-back ))
          ; t   
          (setq vlogp-instnc-nm-good-p nil)
          ; f
          (setq vlogp-instnc-nm-good-p vlog-p-instance-name-candidate-back))
      ;
      ) vlogp-instnc-nm-good-p) ;matches (with-syntax-table)

(defun vlogp-get-module-name ()
  "Return t if a module name is found, else nil"
  (interactive)
  ;
  ;Don't want to move based on junk in comments which may not be valid verilog
  ;this does not check at the beginningt of comment line.
  (setq vlogp-find-inst-back-inside-comment-p 
        (verilog-inside-comment-or-string-p)) ; comments
  ;
  (setq vlogp-find-inst-back-str "^\\s-*\\(\\_<\\)")
  (setq vlogp-module-name-candidate-start-position 
        (re-search-backward vlogp-find-inst-back-str nil t 1))
  ;move forward to the canditate start
  (re-search-forward vlogp-find-inst-back-str nil t 1)
  ;
  (setq vlog-p-module-name-candidate-back
        (if (thing-at-point 'symbol) 
         (s-trim (substring-no-properties (thing-at-point 'symbol) ))))    ;
  ;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; check for other stuff
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   (if (or
          vlogp-find-inst-back-inside-comment-p ; comments
          (looking-at "\s*[a-z_]+:"); label
          (looking-at "\s*assign") ; initial 
          (looking-at "\s*initial") ; initial 
          (looking-at "\s*generate"); generate statement
          (looking-at "\s*always")  ; always
          (looking-at "\s*case")    ; case statement
          (looking-at "\s*if")      ; part of conditional statement
          (looking-at "\s*begin")      ; part of conditional statement
          (looking-at "\s*end")      ; part of conditional statement
          (looking-at "\s*else")    ; part of conditional statement
          (looking-at "\s*for")     ; for statement
          (looking-at "\s*module")  ; the file you are in
          (looking-at "\s*default") ; used in case statement
          (looking-at "\s*//")      ; comments
          (looking-at "\s*\\."))    ; port line
     ; non module instance name     
     (progn     
       (message "Looking at NOT a module name" )
       (setq vlogp-find-inst-back-match-module-name nil)
       )
       ;; (forward-line -1))
     ; module instance name
     (progn
       (setq vlogp-find-inst-back-match-module-name vlog-p-module-name-candidate-back)
       (message "Looking at a module name" )
       ));matches if
       ;; (goto-char vlogp-find-inst-back-open-paren-loc)));matches if
  ; --- move to checing defun end ---
  ;
  vlogp-find-inst-back-match-module-name)


(defun test-back (arg)
  "Test how matchstring behaves with an or expression"
  (interactive "P")
  ;; (re-search-backward "\\(foo\\)\\|something_\\(bar\)" nil t 1)
  (re-search-backward "\\(\\w\\)+" nil t 1)
  (setq vlogp-find-inst-fwd-finish (point))
  (setq tempmatch0 (match-string 0))
  (setq tempmatch1 (match-string 1))
  (setq tempmatch2 (match-string 2)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (message "Reached the end of special-searches.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; note \n and \s not quoted (skip-chars-forward "\n\s")  aoeu


; with a newline ^\s-+*\(\w+\)\n+\(\w+\)

; basic verilog
;"\\(^\\s-+\\w+\\)\\s-+\\w+\\s-+("
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (provide 'special-searches)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
