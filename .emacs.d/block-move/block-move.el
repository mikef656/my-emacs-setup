;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;      FUNCTIONS HERE
;;     block-left 
;;     block-right 
;;     count-this-position-not-blank-p 
;;     count-this-position-p 
;;     line-is-not-blank-p 
;;     line-is-not-blank-se-p 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun count-this-position-p () 
  "determine if current position needs to be counted as part of the block" 
   (interactive)
   ;init
   (setq prev-char-a-space nil)
   (setq cur-char-not-a-space nil) 
   (setq col0-and-space nil)
   (setq col0-and-not-space nil)
   ;
   (if (eq (current-column) 0) 
      ;T:This progn means current-column = 0
      (progn 
         ;interesting that \\s- by itself is not recognized as space!
         (if  ( or (looking-at "\\s-") (looking-at "\n"))
           (setq col0-and-space t)
           (setq col0-and-not-space t)))
      ;
      ;F;This progn means current-column /= 0
      (progn
         ;
         (if (not ( or (looking-at "\\s-") (looking-at "\n") ))
            (setq cur-char-not-a-space t)
            (setq cur-char-not-a-space nil))
         ;
         (backward-char 1)
         ;
         (if ( or (looking-at "\\s-") (looking-at "\n") )
            (setq prev-char-a-space t)
            (setq prev-char-a-space nil))
         ;
         (forward-char 1)))
   ;
   (if  (and prev-char-a-space cur-char-not-a-space) 
      ;T
      (setq count-this-positon-ret-val t)
      ;F, condider column 0
      (progn
         (if col0-and-space
            ;space terminates
            (setq count-this-positon-ret-val nil))
         ;
         (if col0-and-not-space
            ;non-space continues the count
            (setq count-this-positon-ret-val t)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun count-this-position-not-blank-p ()
  "determine if current position needs to be counted as part of the block
  using the criteria of a non-blank line is counted and a blank line terminated
  the count"
   (interactive)
   ;init
   (setq prev-char-a-space nil)
   (setq  cur-char-not-a-space nil) 
   (setq col0-and-space nil)
   (setq col0-and-not-space nil)
   ;
   (if (line-is-blank-p) 
      (setq count-this-positon-ret-val nil)
      (setq count-this-positon-ret-val t)))
;
;(global-set-key [(meta f12)] 'count-this-position-not-blank-p);test binding only
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun block-left (arg) 
   "Move a block to the left.
   First identify the number of rows in the block,
   then delete a character just to the left of each:
   examples:
      aaa
      bbb
      ccc
   becomes:
     aaa
     bbb
     ccc
   If point starts out on the leftmost a.
   --
   With a negative arg allow raggad contigious (no blank lines)
   aaa
     bbb
     ccc
   ddd
   becomes:
  aaa
    bbb
    ccc
  ddd"
   (interactive "p")
   ;
   ;Init
   ;(setq line-move-visual nil) Note:this is probably not needed not that I am
   ;moving to the column number in the destination line
   (setq prev-char-a-space t)
   (setq cur-char-not-a-space t)
   (setq num_lines_moved 0)
   (setq last-line-of-file nil)   
   ;  
   ;with a negative arg allow raggad shaped blocks
   (if (> 0 arg)
      (setq raggad-move-p t)
      (setq raggad-move-p nil))
   ; 
   ;DISCOVERY
   ;Don't re-discover each time so that the moving block
   ;can "walk past" text directory below and not move it.
   ;
   (if (not (or (eq last-command this-command) (eq last-command 'block-right)))
      (save-excursion
      (setq num_lines_moving 0)
      (while (and 
	        (if raggad-move-p 
                    ;t
                    (line-is-not-blank-p) 
                    ;f
                    (count-this-position-p)) 
                    ;
                (not last-line-of-file))
                ;
         (progn
            (if (last-line-of-buffer-p)
                (progn
                  (setq num_lines_moving (+ 1 num_lines_moving))
                  (setq last-line-of-file t))
                ;
                (progn 
                  (next-line)
                  (setq num_lines_moving (+ 1 num_lines_moving)))))))) 
   ;
   ;MOVEMENT
   (save-excursion
   (backward-char 1)
   (while (< num_lines_moved num_lines_moving )
      (progn
      (message "moving a block left")
      (delete-char 1)
      ;
      (setq my-cur-col (current-column))
      ;
      ;need to check if point is in the last line
      ;Why: because if you are on the last line and do a (next-line)
      ;then point jumps to a strange place and the running outer progrm
      ;exits abnormally
      (if (last-line-of-buffer-p)
          ;T is the last line
          (progn (setq last-line-of-file t))
          ;
          ;F is not the last line
          (progn (next-line)  (setq last-line-of-file nil))) 
          ;
      (move-to-column my-cur-col t)
      ;
      (setq num_lines_moved  (+ 1 num_lines_moved)))))) 
;
;
;(global-set-key [(shift f12)] 'block-left)
;(global-set-key (kbd "<M-left> ") 'block-left)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun block-right (arg) 
   "Move a block to the right.
   First identify the number of rows in the block,
   then delete a character just to the left of each:
   examples:
      aaa
      bbb
      ccc
   becomes:
       aaa
       bbb
       ccc
   If point starts out on the leftmost a.
   --
   With a negative arg allow raggad contigious (no blank lines)
   aaa
     bbb
     ccc
   ddd
   becomes:
    aaa
      bbb
      ccc
    ddd"
   (interactive "p")
   (setq prev-char-a-space t)
   (setq cur-char-not-a-space t)
   (setq num_lines_moved 0)
   (setq last-line-of-file nil)
   ;  
   ;with a negative arg allow raggad shaped blocks
   (if (> 0 arg)
      (setq raggad-move-p t)
      (setq raggad-move-p nil))
   ;     
   ;DISCOVERY
   ;Don't re-discover each time so that the moving block
   ;can "walk past" text directory below and not move it.
   (if (not (or (eq last-command this-command) (eq last-command 'block-left)))
      (save-excursion
      (setq num_lines_moving 0)
      (while (and 
	        (if raggad-move-p (line-is-not-blank-p) (count-this-position-p )) 
                (not last-line-of-file))
         (progn
            (if (last-line-of-buffer-p)
                (progn
                  (setq num_lines_moving (+ 1 num_lines_moving))
                  (setq last-line-of-file t))
                ;
                (progn 
                  (next-line)
                  (setq num_lines_moving (+ 1 num_lines_moving))))))))
   ;
   ;   
   ;MOVEMENT
   (save-excursion
   (while (< num_lines_moved num_lines_moving )
      (progn
      (message "moving a block right")
      (setq col-prior-to-insert (current-column));11-25
      (insert " ")
      ;
      ;this business about moving to a column should not be necessary
      ;but (next-line) sometimes moves to a different col in the next line
      (setq my-other-cur-col (current-column))
      ;
      ;      
      ;need to check if point is in the last line
      ;Why: because if you are on the last line and do a (next-line)
      ;then point jumps to a strange place and the running outer progrm
      ;exits abnormally
      ;; (if ( equal (line-number-at-pos) (count-lines (point-min) (point-max)))
      (if (last-line-of-buffer-p)
          ;T is the last line
          (progn (setq last-line-of-file t))
          ;
          ;F is not the last line
          (progn (next-line)  (setq last-line-of-file nil)))      
      ;          
      ;
      (move-to-column my-other-cur-col t)
      ;      
      ;backward char causes point to jump to the previous line if on col 0
      (if (not (eq (current-column) 0))
      ;
      ;; (backward-char 1))
      (move-to-column col-prior-to-insert t))
      (setq num_lines_moved  (+ 1 num_lines_moved)))))
   (forward-char 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(defun insert-text-move-block-right (arg) 
   "Insert text before a block then move it to the right.
   finish edit by repeating same command. The experience is alot like rectangle
   editing, but you can paste into this"
   (interactive "p")
   ;   
   ;Init
   ;(setq line-move-visual nil) Note:this is probably not needed not that I am
   ;moving to the column number in the destination line
   (if iedit-mode    
      (iedit-mode 1)
      (progn
      (setq prev-char-a-space t)
      (setq cur-char-not-a-space t)
      (setq num_lines_moved 0)
      (setq last-line-of-file nil)
      ;
      ;For some reason this defun works better if it has point
      ;at the beginnig of a word.
      (if (looking-at "\\s-")
	  (skip-chars-forward "\s-"))
      ;  
      ;with a negative arg allow raggad shaped blocks
      (if (> 0 arg)
         (setq raggad-move-p t)
         (setq raggad-move-p nil))
      ;     
      ;DISCOVERY
      ;Don't re-discover each time so that the moving block
      ;can "walk past" text directory below and not move it.
      ;(if (not (or (eq last-command this-command) (eq last-command 'insert-text-move-block-right)))
         (save-excursion
         (setq num_lines_moving 0)
         (while (and 
       	        (if raggad-move-p (line-is-not-blank-p) (count-this-position-p )) 
                   (not last-line-of-file))
            (progn
               (if ;last line
		   (last-line-of-buffer-p)
                   (progn
                   (setq num_lines_moving (+ 1 num_lines_moving))
                   (setq last-line-of-file t)
                    )
                   ;
		   ;not last line
                   (progn 
                   (next-line)
                   (setq num_lines_moving (+ 1 num_lines_moving))
                   )
               )
            )
         ))
      ;) 
      ;
      ;   
      ;MOVEMENT
      (save-excursion
      (while (< num_lines_moved num_lines_moving )
         (progn
         (message "moving a block right")
         (setq col-prior-to-insert (current-column));11-25
         (insert "*tmp* ")
         ;
         ;this business about moving to a column should not be necessary
         ;but (next-line) sometimes moves to a different col in the next line
         (setq my-other-cur-col (current-column))
         ;
         ;      
         ;need to check if point is in the last line
         ;Why: because if you are on the last line and do a (next-line)
         ;then point jumps to a strange place and the running outer progrm
         ;exits abnormally
         (if (last-line-of-buffer-p)
             ;T is the last line
             (progn (setq last-line-of-file t))
             ;
             ;F is not the last line
             (progn (next-line)  (setq last-line-of-file nil)))      
         ;          
         ;
         (move-to-column my-other-cur-col)
         ;      
         ;backward char causes point to jump to the previous line if on col 0
         (if (not (eq (current-column) 0))
         ;
         (move-to-column col-prior-to-insert))
         (setq num_lines_moved  (+ 1 num_lines_moved)))))
      ;(forward-char 1)
      ;(iedit-mode 1)
      (iedit-dwim nil))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(provide 'block-move)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
