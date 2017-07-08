;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun create-reclock-context-sensitive ()
  "create a reclock"
 (interactive)
   ;Determine if current line is blank
   (beginning-of-line)
   (if (re-search-forward "^\\s-+$" (line-end-position) t)
      ;T
      ;(message "blank")
      (create-reclock-select-driver)
      ;F
      (create-reclock-dup-driver)))   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (global-set-key (kbd "<f9>") 'create-reclock-context-sensitive)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun findget-and-insert-signal ()
  "Show a list of stuff using IMENUm then
insert he thing at point"
 (interactive)
;
;;Might want to come back
(push-mark)
;
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
;
(pop-to-mark-command)
(insert myStr))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Begin code for add reg-driver
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun create-reclock-dup-driver ()
  "create a reclock"
 (interactive)
;;assume 1)user starts with point on line in a synchronous prosess
;;        that looks like "sig2  <= sig1"
;;       2)User wishes to re-clock sig2 so the result will look like
;;                        "sig2_q  <= sig2"
;;                   
;; create 1)New assignment  below the orginal sig1_q <= sig1
;;        2)New signal definition for sig1_q
   ;
   ;duplicate the signal assignement of the signal to be reclocked
   (duplicate-line-or-region 1)
      ;These two let the user call this command from anywhere on the line 
      (beginning-of-line)
      ;;move to the beginning of the first word of the new assignemnt
      (re-search-forward "\\<" nil t)
      ;

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   (save-excursion
      (my-find-def)
      ;duplicate, rename with _q suffix if definition is signal 
      ;stated otherwise don't duplicate if its an input ot output
      ;for tomarrow get the type of the definition jumped to
      ;will need it to create s signal
      ;might help ":\s+\\(out\\|in\\)"
      (if(re-search-forward "^\s+signal" nil t)
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;T
         (progn
            (duplicate-line-or-region 1)
            (re-search-forward "\\>" nil t)               
            ;append_q
            (insert "_q")
            (delete-char 2))
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;F
         (progn 
            (setq myTypeStr (buffer-substring (line-beginning-position) (line-end-position)))
	    ;
            ;look at the captured string to determine the type
              (if (string-match " std_logic_vector" myTypeStr )
                  (setq tempstr "std_logic_vector")
                  (if (string-match " std_logic" myTypeStr)
                      (setq tempstr "std_logic")
                      (if (string-match "unsigned" myTypeStr) 
                         (setq tempstr "unsigned") 
                         (setq tempstr "boolean")))))
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   )  )
   ;end of save excursion point is moved back to
   ;;      "sig2  <= sig2"
   ;;       ^
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;
   (thing-copy-word)
   (re-search-forward "\\>" nil t)         
   (insert "_q")
   (delete-char 2)
   (re-search-forward "\\<" nil t)         
   (del-word-mike)
   (insert (car kill-ring-yank-pointer))
   (delete-char 2)
   (smart-beginning-of-line))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun second-newline ()
  "create a reclock"
 (interactive)
   ;Determine if current line is blank
   (if (looking-at "^\n$")
      ;T
      (message "blank")
      (message "not blank")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun create-reclock-select-driver ()
  "Create a new assignment with the RHS being the users choice using IMENU"
 (interactive)
     ;
     (get-tmplt-rplce-w-imenu)
     (save-excursion
        ;
        ;move point to the signal definition that will be 
        ;the new FF output
        (my-find-def)
        ;   
        ;duplicate the signal definition
        (duplicate-line-or-region 1)
        (re-search-forward "\\>" nil t)               
        ;append_q
        (insert "_q")
        (delete-char 2))
     ;end of save excursion point is moved back to
     ;
     (re-search-forward "\\>" nil t)         
     (insert "_q")
     (delete-char 2)
     (smart-beginning-of-line))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-tmplt-rplce-w-imenu ()
  "Locate copy and insert a driver from above the current line"
 (interactive)
   ;
     (save-excursion
        (re-search-backward "\\w+\\s-+<=\\s-+\\w+" nil t)                    
        ;copy the line
        (kill-ring-save (line-beginning-position) (line-end-position)))     
        (beginning-of-line)
        (insert (car kill-ring-yank-pointer))
        ;;
        (smart-beginning-of-line)
        (del-word-mike)
        ;
        (findget-and-insert-signal)
        (backward-char 2)
        ;
        (thing-copy-word)
        (re-search-forward "\\<" nil t)
        (del-word-mike)
        (insert (car kill-ring-yank-pointer))
        (smart-beginning-of-line))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;add code for add reg-driver

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun insert-SIGNAL ()
  "Insert a SIGNAL using a copied port"
 (interactive)
      (let (p1 p2)
      
      ;locate inputs, assume cursor on input 
      ;capture two lines starting at the comment above the port
       (find-first-comment)      
      (setq p1 (point))
      ;Capture line containing port and its comment(assumed above)

      (find-end-of-line-with-in-port)
      (setq p2 (point))

      (setq myStr (buffer-substring p1 p2)))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;look at the captured string to determine the type
        (if (string-match " std_logic_vector" myStr )
            (setq tempstr "std_logic_vector")
            (if (string-match " std_logic" myStr)
                (setq tempstr "std_logic")
                (if (string-match "unsigned" myStr) 
                   (setq tempstr "unsigned") 
                   (setq tempstr "boolean")))        )
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      ;Locate the begining of the SIGNALs region and position to insert
      (re-search-forward "^[ ]*SIGNAL[ ]+.*:.*;")
      (beginning-of-line)
      (previous-line)
      (previous-line)
      (newline)
      (insert  myStr)
 
      ;Find  region that needs to be operated on
      ;beginning
      (find-first-comment)
      (setq inserted_port_begin (point))
       (re-search-forward ";")
      (setq inserted_port_end (point))  
      ;end
      
      ;remove leading whitespace
      (replace-regexp "^[ ]*" "" nil inserted_port_begin inserted_port_end)

      ;Format as a SIGNAL
      (insert  "SIGNAL " )    

      ;grab the original port name
      (setq my_port_name (thing-at-point 'symbol))
      (downcase-word 1)
      
      ;remove the direction
      (replace-regexp " in " "" nil inserted_port_begin inserted_port_end)
      (beginning-of-line)

      ;add, _d assume point is in the same line as the SIGNAL
      (let (p1 p2)
        (re-search-forward " ")
        (re-search-forward " ")
        (backward-char)
        (insert "_d")
        (setq myStr_alt (thing-at-point 'symbol))
      )


      ;Locate the correct insertion position in the sync proc
      (re-search-forward "sync_proc")
      (re-search-forward "then")
      ;(newline)
      (end-of-line)


)


;; ;Interesting
;; ;http://www.xsteve.at/prg/emacs/xsteve-functions.el
;; ((col (current-column))
;; 	 (bol (progn (beginning-of-line) (point)))
;; 	 (eol (progn (end-of-line) (point)))
;; 	 (line (buffer-substring bol eol)))


;http://xahlee.org/emacs/elisp_idioms_batch.html
; open a file, process it, save, close it
(defun my-process-file (fpath)
  "process the file at fullpath FPATH "
  (let (mybuffer)
    (setq mybuffer (find-file fpath))
    (widen) (goto-char (point-min)) ;; in case buffer already open
    ;; do something
    (save-buffer)
    (kill-buffer mybuffer)))



(defun find-first-comment () 
"start on port line" (interactive)
;(re-search-backward "\n[ ]*\n")
(re-search-backward ";\\|(")
(skip-chars-forward "\n")
(re-search-forward "[ ]*--")
(beginning-of-line)
)

(defun find-end-of-line-with-in-port () 
"start on port line" (interactive)
(re-search-forward ";")
)

;;probably don'r want these bindings, but keep them for reference
;; (global-set-key (kbd "<f12> ") 'find-first-comment)

;; (global-set-key (kbd "<f11>") 'insert-SIGNAL)
;; (global-set-key (kbd "<f10>") 'find-end-of-line-with-in-port)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(provide 'insert-signal)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
