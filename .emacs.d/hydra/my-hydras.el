;http://emacs.stackexchange.com/questions/19443/make-hints-appear-immedietly-when-using-hydra

(defhydra hydra-zoom ()
   "zoom"
   ("+" text-scale-increase "in")
   ("-" text-scale-decrease "out")
   ("<right>" text-scale-increase "in")
   ("<left>" text-scale-decrease "out")
   ("0" (text-scale-adjust 0) "reset")
   ("q" nil "quit" :color blue))
   ;
   ;(global-set-key [f2] 'hydra-zoom/body)           

(defhydra hydra-window-undo (:body-pre (winner-undo))
   "Winner Window configs,left is previous"
   ("<right>" winner-redo)
   ("<left>"  winner-undo)
   ("q" nil "quit" :color blue))
   ;
   (global-set-key  [(control c) left] 'hydra-window-undo/body)

;; (defhydra hydra-block-move (global-map "C-<f12>")
;;  "zoom"
;;  ("<left>"  block-right )
;;  ("<right>" block-left ))

(defhydra hydra-navigate (:color red
                          :hint nil)
  "
_w_: forward-word       _n_: next-line
_W_: backward-word      _p_: previous-line
_r_: subword-right      _,_: beginning-of-line
_g_: subword-left       _._: end-of-line

_s_: forward sentence   _a_: forward paragraph  
_S_: backward sentence  _A_: backward paragraph 

                         _i_: window
_<left>_: previous buffer   _<right>_: next buffer
_<up>_: scroll-up           _<down>_: scroll-down

_<_ beginning of buffer _>_ end of buffer _m_: set mark
"
  ("n" forward-char)
  ("h" backward-char)
  ("w" forward-word)
  ("W" backward-word)
  ("n" next-line)
  ("p" previous-line)
  ("r" subword-right)
  ("g" subword-left)
  ("s" forward-sentence)
  ("S" backward-sentence)
  ("a" forward-paragraph)
  ("A" backward-paragraph)
  ("<right>" next-buffer)
  ("<left>" previous-buffer)
  ("h" helm-mini :color blue)
  ("i" ace-window :color blue)
  ("m" cua-set-mark)
  ("<up>" scroll-up)
  ("<down>" scroll-down)
  ("<" beginning-of-buffer)
  (">" end-of-buffer)
  ("." end-of-line)
  ("," beginning-of-line)
  ("q" nil "quit" :color blue))

(global-set-key [f6] 'hydra-navigate/body)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(provide 'my-hydras)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
