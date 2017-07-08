;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;  FUNCTIONS HERE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Tiny setup and autoload
(add-to-list 'load-path "~/.emacs.d/tinyeat/")
(autoload 'tinyeat-forward-preserve            "tinyeat" "" t)
(autoload 'tinyeat-backward-preserve           "tinyeat" "" t)
(autoload 'tinyeat-backward                    "tinyeat" "" t)
(autoload 'tinyeat-delete-paragraph            "tinyeat" "" t)
(autoload 'tinyeat-delete-whole-word           "tinyeat" "" t)
;
;Kill does not delete the final newline,both do not save to kill ring
(autoload 'tinyeat-kill-line                   "tinyeat" "" t)
;zap does
(autoload 'tinyeat-zap-line                    "tinyeat" "" t)
;
(autoload 'tinyeat-kill-line-backward          "tinyeat" "" t)
(autoload 'tinyeat-kill-buffer-lines-point-max "tinyeat" "" t)
(autoload 'tinyeat-kill-buffer-lines-point-min "tinyeat" "" t)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'my-tinyeat-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

