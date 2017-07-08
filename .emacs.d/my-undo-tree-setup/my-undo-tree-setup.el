;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Mike Fitzgerald TMRU
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;undo tree
;note that when this is re-downloaded the bindings for
  ;(define-key map (kbd "C-/") 'undo-tree-undo)
  ;(define-key map "\C-_" 'undo-tree-undo)
;must be manually removed from the source
;What a pain.
;   
;
(add-to-list 'load-path "~/.emacs.d/undotree/")
(require 'undo-tree)
(global-undo-tree-mode)
;
(setq advise-undo-tree nil)

;
;
(when (eq (and load-fit-frame advise-undo-tree) t)
   ;
   (defadvice undo-tree-visualize (around my-undo-tree-advice 0 nil activate)
     ;(message "before")
     ;(let ((fit-frame-min-width 30))
       (let (
             ;(fit-frame-inhibit-fitting-flag  t)
             ;(fit-frame-min-width 20)
             )
        (setq my-frame-rhs-pix
                        (+ (frame-parameter nil 'left) (frame-pixel-width)))
        ad-do-it
        ;(message "after %d" my-frame-rhs-pix)
        (setq my-frame-overlap-tolerance 400)
        (setq my-frame-rhs-pix-adjust
                             (- my-frame-rhs-pix my-frame-overlap-tolerance))
        (modify-frame-parameters nil `((left . ,my-frame-rhs-pix-adjust)))
        ;
        ;out of the box undo-tree data is in the 40th column
        ;This moves that position 27 col to the left
        ;If need a wider space for undo-tree data make this number go back up
        ;toward 40.
        (undo-tree-visualizer-scroll-right 27)
        ;(fit-frame)
        ;(my-shrink-frame-horizontal-test)
        ;(fix-horizontal-size 20)
        ;
        ;make the frame 25 columns wide, undo-tree and emacs were 80 columns
        ;out of the box.
        (modify-frame-parameters nil `((width . ,25)))
     ))
;
  (defadvice undo-tree-visualize (around my-undo-tree-advice 0 nil activate)
       ;(message "before")
       ;(let ((fit-frame-min-width 30))
         (let (
               ;(fit-frame-inhibit-fitting-flag  t)
               ;(fit-frame-min-width 20)
               )
          (setq my-frame-rhs-pix
                          (+ (frame-parameter nil 'left) (frame-pixel-width)))
          ad-do-it
          ;(message "after %d" my-frame-rhs-pix)
          (setq my-frame-overlap-tolerance 150)
          (setq my-frame-rhs-pix-adjust
                               (- my-frame-rhs-pix my-frame-overlap-tolerance))
          (modify-frame-parameters nil `((left . ,my-frame-rhs-pix-adjust)))
          ;
          ;out of the box undo-tree data is in the 40th column
          ;This moves that position 27 col to the left
          ;If need a wider space for undo-tree data make this number go back up
          ;toward 40.
          (undo-tree-visualizer-scroll-right 27)
          ;(fit-frame)
          ;(my-shrink-frame-horizontal-test)
          ;(fix-horizontal-size 20)
          ;
          ;make the frame 25 columns wide, undo-tree and emacs were 80 columns
          ;out of the box.
          (modify-frame-parameters nil `((width . ,25)))
          ;(sit-for 1)
          ;(move-frame-to-screen-right 0)
       ))
;
  (defadvice undo-tree-visualize-undo
                          (around my-undo-tree-undo-advice 0 nil activate)
    ;
    ;(let ((fit-frame-min-width 30))
      (let (
            (fit-frame-inhibit-fitting-flag  t)
            ;(fit-frame-min-width 20)
            )
       ad-do-it
       ;(modify-frame-parameters nil `((width . ,20)))
    ))
;
  (defadvice undo-tree-visualize-redo
                         (around my-undo-tree-undo-advice  0 nil activate)
      (let (
            (fit-frame-inhibit-fitting-flag  t)
            ;(fit-frame-min-width 20)
            )
            ad-do-it
    ;(modify-frame-parameters nil `((width . ,30)))
    ))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key undo-tree-visualizer-map "\r" 'undo-tree-visualizer-quit)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-undo-tree-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

