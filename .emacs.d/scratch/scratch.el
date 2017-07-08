(defgroup scratch nil
  "Scratch buffers."
  :prefix "scratch-"
  :group 'editing)

(defcustom scratch-mode-alist
  '((erc-mode . fundamental-mode)
    (sql-interactive-mode . sql-mode)
    (shell-mode . sh-mode))
  "Alist of mappings from major modes to major modes for SCRATCH.

Some interactive modes don't lend themselves well to scratch
buffers; this alist is used to change the mode used by SCRATCH
for those buffers."

  :type '(alist :key-type symbol :value-type symbol))

(defvar scratch-history nil
  "History of scratch buffers")

(defvar scratch-major-mode-list nil
  "List of major modes SCRATCH may use. See `scratch-list-modes'.")

(defvar scratch-buffer nil
  "Non-nil if the current buffer is a scratch buffer.")
(make-variable-buffer-local 'scratch-buffer)

(defun scratch-list-modes ()
  "List known major modes."
  (or scratch-major-mode-list
      (let ((modes))
        (mapatoms
         (lambda (sym)
           (let ((name (symbol-name sym)))
             (when (and (functionp sym)
                        (not (member sym minor-mode-list))
                        (string-match "-mode$" name))
               (push (substring name 0 -5) modes)))))
        modes)))

;;;###autoload
(defun scratch (&optional arg)
  "Get a scratch buffer for the current mode."
  (interactive "p")
  (let* ((tmp) (name)
         (mode (cond (current-prefix-arg
                      (intern (concat (setq name (completing-read
                                                  "Mode: " (scratch-list-modes)
                                                  nil t nil scratch-history))
                                      "-mode")))
                     ((setq tmp (assoc major-mode scratch-mode-alist))
                      (cdr tmp))
                     (t major-mode)))
         (name
          (format "*%s*"
                  (or name (replace-regexp-in-string "-mode$" ""
                                                     (symbol-name mode)))))
         (buf (get-buffer name)))
    (cond ((bufferp buf)
           (pop-to-buffer buf))
          (t
           (let ((contents (when (region-active-p)
                             (buffer-substring (region-beginning)
                                               (region-end)))))
             (setq buf (get-buffer-create name))
             (pop-to-buffer buf)
             (let ((scratch-buffer t))
               (funcall mode))
             (when contents (save-excursion (insert contents)))
             (setq scratch-buffer t))))))

(provide 'scratch)
