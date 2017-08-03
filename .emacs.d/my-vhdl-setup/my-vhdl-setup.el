;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;  FUNCTIONS HERE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;A new syntax table, that adds _ as as symbol which removes it as a word
(defvar underscore-is-symbol-not-word-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?_ "_" table)
    table))
;
(defun my-hdl-right-syntax-or-subword ()
  (interactive)
  (with-syntax-table underscore-is-symbol-not-word-syntax-table 
    (syntax-subword-right 1)))
;
(defun my-hdl-left-syntax-or-subword ()
  (interactive)
    (with-syntax-table underscore-is-symbol-not-word-syntax-table 
      (syntax-subword-left 1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VHDL MODE
;Want VHDL to behave like text, copied using C-h-v from text mode file
(add-hook 'vhdl-mode-hook
   (lambda ()
   (scroll-bar-mode -1)
   (define-key vhdl-mode-map [(control meta r)] 'my-hdl-right-syntax-or-subword) 
   (define-key vhdl-mode-map [(control meta r)] 'my-hdl-right-syntax-or-subword) 
   (define-key vhdl-mode-map [(control meta g)] 'my-hdl-left-syntax-or-subword) 
   (company-mode 1)
   (global-set-key [(control meta r)] 'nil)
   (setq paragraph-separate "[   \f]*$")
   (setq paragraph-start  "\f\\|[   ]*$")
   (global-unset-key (kbd "<M-backspace>"))
   (global-set-key (kbd "<M-backspace>") 'tinyeat-forward-preserve)
   (local-set-key (kbd "<M-delete>") 'tinyeat-forward-preserve) 
   ;does not "Stick" as a global set key when initiated in the .emacs
   ;prehaps because of the autoload?
   ;
   ;This did not work when called as part if the .emacs.
   ;seems like vhdl-mode-map did not exist at that time
   (local-unset-key (kbd "<C-M-f>") ) 
   (define-key vhdl-mode-map [(control meta f)] 'nil) 
   ;(define-key vhdl-mode-map [(control meta f)] 'icicle-occur) 
   (define-key vhdl-mode-map [(control meta \\)] 'nil) 
   (define-key vhdl-mode-map [(control meta prior)] 'look-up-actual-fan-out) 
   (define-key vhdl-mode-map [(control meta next)] 'look-up-actual-fan-out) 
   (define-key vhdl-mode-map "\t" 'nil) 
   (define-key vhdl-mode-map "\t" 'my-vhdl-electric-tab) 
   ;(local-set-key  (kbd "<C-M-f>") 'icicle-occur) 
   (local-set-key (kbd "<M-delete>") 'tinyeat-forward-preserve) 
   (define-key vhdl-mode-map "\M-e" 'whole-line-with-end)
   (define-key vhdl-mode-map (kbd "<C-prior>") 'look-up-actual-info)
   (define-key vhdl-mode-map (kbd "<C-next>") 'put_comment_end_of_line_region)
      ;
      ;note this does not work as a hook, it still needs to be vhdl-mode.el;don't know why
      ;; (setq vhdl-imenu-generic-expression
      ;; '(
      ;; ("Subprogram" "^\\s-*\\(\\(\\(impure\\|pure\\)\\s-+\\|\\)function\\|procedure\\)\\s-+\\(\"?\\(\\w\\|\\s_\\)+\"?\\)" 4)
      ;; ("Instance" "^\\s-*\\(\\(\\w\\|\\s_\\)+\\s-*:\\(\\s-\\|\n\\)*\\(\\w\\|\\s_\\)+\\)\\(\\s-\\|\n\\)+\\(generic\\|port\\)\\s-+map\\>" 1)
      ;; ("Component" "^\\s-*\\(component\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\)" 2)
      ;; ("Procedural" "^\\s-*\\(\\(\\w\\|\\s_\\)+\\)\\s-*:\\(\\s-\\|\n\\)*\\(procedural\\)" 1)
      ;; ("Process" "^\\s-*\\(\\(\\w\\|\\s_\\)+\\)\\s-*:\\(\\s-\\|\n\\)*\\(\\(postponed\\s-+\\|\\)process\\)" 1)
      ;; ("Block" "^\\s-*\\(\\(\\w\\|\\s_\\)+\\)\\s-*:\\(\\s-\\|\n\\)*\\(block\\)" 1)
      ;; ("Package" "^\\s-*\\(package\\( body\\|\\)\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\)" 3)
      ;; ("Configuration" "^\\s-*\\(configuration\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\s-+of\\s-+\\(\\w\\|\\s_\\)+\\)" 2)
      ;; ("Architecture" "^\\s-*\\(architecture\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\s-+of\\s-+\\(\\w\\|\\s_\\)+\\)" 2)
      ;; ("Entity" "^\\s-*\\(entity\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\)"2)
      ;; ("Port Map Drivers" "=>\\s-\\(\\<[^g].*\\>\\)"1)
      ;; ("All Drivers" "\\(=>\\s-\\(\\<[^g].*\\>\\)\\)\\|\\(.*<=\\)"1)
      ;; ("Local Assignments" "\\(\\<.*\\>\\)\\s-<="1)
      ;; ("Input Clk Drivers" "\\(\\<clk.+\\>\\).*in"1)
      ;; ;("Direct Insance"  "entity[ ]+work.\\(\\<.*\\>\\)"1)
      ;; ;("Direct Instance" "entity+.\\(\\<.*\\>\\.\\<.*\\>\\)"1)
      ;; ("Direct Instance" "\\(\\(\\<.*\\>\\) *: *\n*entity* *\\(\w. *\\)*\\<.*\\>\\.\\<.*\\>\\)"1)
      ;; ("Outputs " "\\(\\<.*\\>\\)+[ ]+:[ ]+out"1)
      ;; ("Inputs " "\\(\\<.*\\>\\)+[ ]+:[ ]+in"1)
      ;; ("Signals" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\)"2)
      ;; ("Constants" "^\\s-*\\(constant\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\)"2)
      ;; ("Signals-INT" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*integer\\>"2)
      ;; ("Signals-NAT" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*natural\\>"2)
      ;; ("Signals-BOL" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*boolean\\>"2)
      ;; ("Signals-UnSigned" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*unsigned"2)
      ;; ("Signals-SLV" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*vector"2)
      ;; ("Signals-SL" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*logic\\>"2)
      ;; ;
      ;; ))
      ;
   ) )    

;
;; add .do files to VHDL mode
(setq auto-mode-alist
  (append
    '(
        ("\\.do$" . tcl-mode)
        ("\\.vho$" . vhdl-mode)
        ("\\.svp$" . verilog-mode)
        ("\\.f$" . verilog-mode)
        ("\\.log$" . verilog-mode)
     ) auto-mode-alist))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;(insert (car myset))


(defun print-elements-of-list (list)
       "Print each element of LIST on a line of its own."
       (while list
         (insert (car list))
         (setq list (cdr list))))


(defun list-instances ()
 "take a list of VHDL instances, make it into somithing useable"
 (interactive)
   ;
  (push-mark)
  (print-elements-of-list myset) 
  (setq my-limit (point))
  (jump-to-mark)
  ;
  ;remove the "generic map" and "port map" stuff
  (while (re-search-forward "\\s-+generic map\\s-*" my-limit t)
    (replace-match " "))
    (jump-to-mark)
  (while (re-search-forward "\\s-+port map\\s-*" my-limit  t)
    (replace-match " "))
    (jump-to-mark)
  ;
  ;put everything on one line
  (while (re-search-forward "\n"my-limit  t)
    (replace-match ""))
    (jump-to-mark)
  ;now the candidates are all on one line,point is before the first
  ;candidate
  ;the line is formated like
  ;  bol"i1: candidate1  i2: candidate2 i3: candidate3"
  ;
  (while  (re-search-forward "\\:"my-limit  t);move to just after the :
    (re-search-forward "\\S-"my-limit  t);move to the name of the candidate
    (re-search-forward "\\s-"my-limit  t);move to whitespace after the candidate
    (insert "\n"))
  (jump-to-mark)
  ;
  (while  (re-search-forward "\\:\\s-*" my-limit  t);move to just after the :
    (replace-match ": ")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VERILOG
;

; trying to set this any way I can, Verilog mode does not what me to, why?
;(setq verilog-tool 'verilog-compiler)

;
(add-hook 'verilog-mode-hook 'my-verilog-hook)
;
(defun my-verilog-hook ()
  (define-key verilog-mode-map [(control meta r)] 'my-hdl-right-syntax-or-subword) 
  (define-key verilog-mode-map [(control meta g)] 'my-hdl-left-syntax-or-subword) 
  (define-key verilog-mode-map [(meta next)]      'vlog-find-inst-fwd) 
  (define-key verilog-mode-map [(meta prior)]  'vlog-find-inst-back) 
  (if  (>= emacs-major-version 24 )
    (company-mode 1))
  ;
  ; realted to compile
  (setq verilog-tool 'verilog-compiler)
  (verilog-set-compile-command)
  ;
  ; Change syntax table so that name matches in both 'define name  matches 'name for 
  ; 1) highlight-symbol 
  ; 2) iedit
  ; Don't know if this will cause problems with any fancy functions in verilog mode which
  ; I don't use today 6-25-2015
  (modify-syntax-entry ?\` "." verilog-mode-syntax-table)
  ;
  ;(modify-syntax-entry ?. "`")
  (setq indent-tabs-mode nil)
  ; 
  ;this was very irritating!
  ; was (define-key map ";"        'electric-verilog-semi)
  (define-key verilog-mode-map (kbd ";") 'nil)
  ;
  ;this was very irritating (bc of tinyeat)!
  ; was  (define-key map [(meta delete)] 'kill-word))
  (define-key verilog-mode-map [(meta delete)] 'nil)
  ;
  ;(define-key verilog-mode-map [(M-\r)] 'nil)
  (define-key verilog-mode-map (kbd "<M-RET>") 'nil)
  (define-key verilog-mode-map (kbd "<RET>") 'nil)
  ;
  ;verilog-mode has return and indent by default
  (define-key verilog-mode-map (kbd "<RET>") 'newline)
  ;
  (define-key verilog-mode-map (kbd "M-*") 'nil);I have a global
  (define-key verilog-mode-map (kbd "C-M-f") '(lambda nil (interactive) (copy-from-above-command 1)));I have a global
  (setq tab-width 2))         
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; compile buffer, don't pop up  a new frame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (defun mike-compile-vlog ()
    "Don't want the a pop-up frams, want a vertical window split"
      (interactive)
      (let (
            (special-display-regexps nil)
            (pop-up-frames nil)
            (split-height-threshold nil) 
            (split-width-threshold 1)
            ) 
        (compile compile-command)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; compile using irun
; does irun accept command line args?
; if so figure out how to start wo runnintg the sim, or opening the GUI.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (defun mike-compile/w-irun ()
    "Don't want the a pop-up frams, want a vertical window split"
      (interactive)
      (let (
            (special-display-regexps nil)
            (pop-up-frames nil)
            (split-height-threshold nil) 
            (split-width-threshold 1)
            ) 
        (compile "./irun.csh")))

(defun my-vhdl-electric-tab (&optional prefix-arg)
;(defun -vhdl-electric-tab (&optional prefix-arg)
  "If preceding character is part of a word or a paren then hippie-expand,
else if right of non whitespace on line then insert tab,
else if last command was a tab or return then dedent one step or if a comment
toggle between normal indent and inline comment indent,
else indent `correctly'."
  (interactive "*P")
  (message "mike")
  ;(vhdl-prepare-search-2
   (cond
    ;; indent region if region is active
    ((and (not (featurep 'xemacs)) (use-region-p))
     (vhdl-indent-region (region-beginning) (region-end) nil))
    ;; expand word
    ((= (char-syntax (preceding-char)) ?w)
     (let ((case-fold-search (not vhdl-word-completion-case-sensitive))
       (case-replace nil)
       (hippie-expand-only-buffers
        (or (and (boundp 'hippie-expand-only-buffers)
             hippie-expand-only-buffers)
        '(vhdl-mode))))
       (vhdl-expand-abbrev prefix-arg)))
    ;; expand parenthesis
    ((or (= (preceding-char) ?\() (= (preceding-char) ?\)))
     (let ((case-fold-search (not vhdl-word-completion-case-sensitive))
       (case-replace nil))
       (vhdl-expand-paren prefix-arg)))
    ;; insert tab
    ;((> (current-column) (current-indentation))
    ; (insert-tab))
    ;; toggle comment indent
    ((and (looking-at "--")
      (or (eq last-command 'vhdl-electric-tab)
          (eq last-command 'vhdl-electric-return)))
     (cond ((= (current-indentation) 0) ; no indent
        (indent-to 1)
        (indent-according-to-mode))
       ((< (current-indentation) comment-column) ; normal indent
        (indent-to comment-column)
        (indent-according-to-mode))
       (t                ; inline comment indent
        (delete-region (line-beginning-position) (point)))))
    ;; dedent
    (
       ;Only get here if looking at whitespace
       ;Use this is to "tab" (indent) forward with point looking at
       ;the beginning of a word, then use the arrow key to move just
       ;to the left and tab again (now you are looking at whitespace
       ;so you will indent backwards.
       ;Point in the whitespace, indent backwards
       ;at the beginning of a line delete whitespace being looked at   
       (looking-at "\\s-+") 
         ;
         (progn
           (if (eq (current-column)  0)
             (progn (tinyeat-forward-preserve));T
	          			;
             (my-backwards-indent)
           )
         )
       ;F
    )
    ;; indent line
    ;; (t (indent-according-to-mode)))
    (t (indent-relative)))
   ;; (setq this-command 'vhdl-electric-tab))
   (setq this-command 'my-vhdl-electric-tab))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Index menu (using `imenu.el'), also used for speedbar (using `speedbar.el')
;
(defconst vhdl-imenu-generic-expression
   '(
   ("Subprogram" "^\\s-*\\(\\(\\(impure\\|pure\\)\\s-+\\|\\)function\\|procedure\\)\\s-+\\(\"?\\(\\w\\|\\s_\\)+\"?\\)" 4)
   ("Instance" "^\\s-*\\(\\(\\w\\|\\s_\\)+\\s-*:\\(\\s-\\|\n\\)*\\(\\w\\|\\s_\\)+\\)\\(\\s-\\|\n\\)+\\(generic\\|port\\)\\s-+map\\>" 1)
   ("Component" "^\\s-*\\(component\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\)" 2)
   ("Procedural" "^\\s-*\\(\\(\\w\\|\\s_\\)+\\)\\s-*:\\(\\s-\\|\n\\)*\\(procedural\\)" 1)
   ("Process" "^\\s-*\\(\\(\\w\\|\\s_\\)+\\)\\s-*:\\(\\s-\\|\n\\)*\\(\\(postponed\\s-+\\|\\)process\\)" 1)
   ("Block" "^\\s-*\\(\\(\\w\\|\\s_\\)+\\)\\s-*:\\(\\s-\\|\n\\)*\\(block\\)" 1)
   ("Package" "^\\s-*\\(package\\( body\\|\\)\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\)" 3)
   ("Configuration" "^\\s-*\\(configuration\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\s-+of\\s-+\\(\\w\\|\\s_\\)+\\)" 2)
   ("Architecture" "^\\s-*\\(architecture\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\s-+of\\s-+\\(\\w\\|\\s_\\)+\\)" 2)
   ("Entity" "^\\s-*\\(entity\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\)"2)
   ("Port Map Drivers" "=>\\s-\\(\\<[^g].*\\>\\)"1)
   ("Local Assignments" "\\(\\<.*\\>\\)\\s-<="1)
   ("Input Clk Drivers" "\\(\\<clk.+\\>\\).*in"1)
   ;("Direct Insance"  "entity[ ]+work.\\(\\<.*\\>\\)"1)
   ;("Direct Instance" "entity+.\\(\\<.*\\>\\.\\<.*\\>\\)"1)
   ("Direct Instance" "\\(\\(\\<.*\\>\\) *: *\n*entity* *\\(\w. *\\)*\\<.*\\>\\.\\<.*\\>\\)"1)
   ("Outputs " "\\(\\<.*\\>\\)+[ ]+:[ ]+out"1)
   ("Inputs " "\\(\\<.*\\>\\)+[ ]+:[ ]+in"1)
   ("Signals" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\)"2)
   ("Constants" "^\\s-*\\(constant\\)\\s-+\\(\\(\\w\\|\\s_\\)+\\)"2)
   ("Signals-INT" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*integer\\>"2)
   ("Signals-NAT" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*natural\\>"2)
   ("Signals-BOL" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*boolean\\>"2)
   ("Signals-UnSigned" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*unsigned"2)
   ("Signals-SLV" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*vector"2)
   ("Signals-SL" "^\\s-*\\(signal\\)\\s-+\\(\\(\\w\\)+\\)\\s-+:\\s-+.*logic\\>"2)
   ;
   ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-flush-modelsim-transcript ()
  "Clean up the mess so user can see the real messages"
  (interactive)
  (flush-lines "note" (point-min) (point-max) nil)
  (flush-lines "time" (point-min) (point-max) nil)
  (flush-lines "Time" (point-min) (point-max) nil)
  (flush-lines "loading" (point-min) (point-max) nil)
  (flush-lines "dpram_bram" (point-min) (point-max) nil)
  (flush-lines "dpram_ram" (point-min) (point-max) nil)
  (flush-lines "dpram_clb" (point-min) (point-max) nil)
  (flush-lines "spram_clb" (point-min) (point-max) nil)
  (flush-lines "sync_fifo" (point-min) (point-max) nil)
  ;(flush-lines "^run" (point-min) (point-max) nil)
  (flush-lines "^rtb" (point-min) (point-max) nil)
  (flush-lines "warning" (point-min) (point-max) nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-ports-to-list ()
  (interactive)
  (while (not (re-search-forward ";" (line-end-position) t))
     ;
     ;FALSE 
     ;need a better regex to get the list one
     (re-search-forward "\\(\\w+\\)\\(,\\)" (line-end-position) t)  
       (setq mytempvar
         (buffer-substring-no-properties 
             (car (match-data)) (car (cdr (cdr (cdr (match-data)))))))
     (forward-line 1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;  use this
;; (nth N LIST)
;; Return the Nth element of LIST.
;; N counts from zero.  If LIST is not that long, nil is returned.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-ports-to-list-get-word-before-comma ()
  (interactive)
     (re-search-forward "\\(\\w+\\)\\(,\\)" (line-end-position) t)
       (setq mytempvar
         (buffer-substring-no-properties 
             (car (match-data)) (car (cdr (cdr (cdr (match-data))))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun my-keep-lines ()
  (interactive)
  (keep-lines "clk_gbus\\|arst\\|REG_en_ex_insert\\|d1_scan_active_gbus\\|
  d1_vt_pulse_gbus\\|inj_err_156\\|REG_in_qwords_per_segment_minus_1\\|
  REG_insert_tube_position\\|REG_insert_e_pattern\\|das_test_gen_active_gbus\\|
  das_test_chk_active_gbus\\|console_test_gen_active_gbus\\|
  console_test_chk_active_gbus\\|new1_ex0_tube_position\\|d1_ex0\\|
  d1_ex1\\|d1_ex2\\|d1_ex3\\|d1_ex5\\|d1_ex6\\|d1_ex7\\|d1_ex8\\|d1_ex9\\|
  d1_ex10\\|d1_ex11\\|d1_ex12\\|d1_ex13\\|d1_ex14\\|d1_ex15\\|d1_ex16\\|
  d1_ex17\\|d1_ex20\\|top_in_seg_fifo_empty_mux\\|top_in_seg_fifo_rd_mux\\|
  top_in_seg_fifo_rdata_mux\\|top_ex_fifo_empty\\|top_ex_fifo_rd\\|
  top_ex_fifo_rdata")
 )  




(defun my-increment-number-hexadecimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer hex-format)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789abcdefABCDEF")
        (when (re-search-forward "[0-9a-fA-F]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 16) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 16 field-width) answer)))
          (if (equal (match-string 0) (upcase (match-string 0)))
              (setq hex-format "X")
            (setq hex-format "x"))
          (replace-match (format (concat "%0" (int-to-string field-width)
                                         hex-format)
                                 answer)))))))


(defun my-inc ()
  "Call to my-increment-number-hexadecimal."
  (interactive)
  (my-increment-number-hexadecimal 4))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(eval-after-load "vhdl-mode" '
(defun vhdl-electric-return ()
  "newline-and-indent or indent-new-comment-line if in comment and preceding
character is a space."
  (interactive)
  (if (and (= (preceding-char) ? ) (vhdl-in-comment-p))
      (indent-new-comment-line)
    (when (and (>= (preceding-char) ?a) (<= (preceding-char) ?z)
	       (not (vhdl-in-comment-p)))
      (vhdl-fix-case-word -1))
    (newline)))) ;MTF the change from newline-and-indent to newline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Add verilog mode to the speedbar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'speedbar)
(speedbar-add-supported-extension '(".v" ".sv" ".svh" ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Reached the end of my-vhdl-setup.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-vhdl-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

