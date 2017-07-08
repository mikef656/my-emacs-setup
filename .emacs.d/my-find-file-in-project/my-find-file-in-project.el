;;; find-file-in-project.el --- Find files in a project quickly.

;; Copyright (C) 2006-2009, 2011-2012
;;   Phil Hagelberg, Doug Alcorn, and Will Farrington
;;   Fitzgerald, modifications significant enough that I need
;;   to keep my own flavor.  The modifications were just to
;;   make it work without Cygwin and with Win7 and Vista.

;; Author: Phil Hagelberg, Doug Alcorn, and Will Farrington
;; URL: http://www.emacswiki.org/cgi-bin/wiki/FindFileInProject
;; Git: git://github.com/technomancy/find-file-in-project.git
;; Version: 3.2
;; Created: 2008-03-18
;; Keywords: project, convenience
;; EmacsWiki: FindFileInProject

;; This file is NOT part of GNU Emacs.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This library provides a couple methods for quickly finding any file
;; in a given project.  It depends on GNU find.

;; A project is found by searching up the directory tree until a file
;; is found that matches `ffip-project-file'.  (".git" by default.)
;; You can set `ffip-project-root-function' to provide an alternate
;; function to search for the project root.  By default, it looks only
;; for files whose names match `ffip-patterns',

;; If you have so many files that it becomes unwieldy, you can set
;; `ffip-find-options' to a string which will be passed to the `find'
;; invocation in order to exclude irrelevant subdirectories.  For
;; instance, in a Ruby on Rails project, you may be interested in all
;; .rb files that don't exist in the "vendor" directory.  In that case
;; you could set `ffip-find-options' to "-not -regex \".*vendor.*\"".

;; All these variables may be overridden on a per-directory basis in
;; your .dir-locals.el.  See (info "(Emacs) Directory Variables") for
;; details.

;; Recommended binding: (global-set-key (kbd "C-x f") 'find-file-in-project)

;;; TODO:

;; Add compatibility with BSD find (PDI; I can't virtualize OS X)

;;; Code:

(require 'cl)

(defvar ffip-project-file ".prj"
  "The file that should be used to define a project root.

May be set using .dir-locals.el. Checks each entry if set to a list.")

(defvar ffip-patterns
  '( "*.org" "*.v" "*.el" "*.do" "*.py" "*.rb" "*.pl" "*.vhd"
    "*.sh" "*.twr" "*.map" "*.par")
  "List of patterns to look for with `find-file-in-project'.")

(defvar ffip-find-options ""
  "Extra options to pass to `find' when using `find-file-in-project'.

Use this to exclude portions of your project: \"-not -regex \\\".*svn.*\\\"\".")

(defvar ffip-project-root nil
  "If non-nil, overrides the project root directory location.")

(defvar ffip-project-root-function nil
  "If non-nil, this function is called to determine the project root.
This overrides variable `ffip-project-root' when set.")


;these will work, need to make a raw prefix interactive spec and set the correct
;one prior to calling ffip-project-root
;
;; (setq ffip-project-root-function 'moccur-grep-read-directory)
;; (setq ffip-project-root-function nil)


(defvar my-ffip-limit 8192
  "Limit results to this many files.")

(defvar ffip-full-paths nil
  "If non-nil, show fully project-relative paths.")


(defun ffip-grep-read-directory ()
  "From lib color-moccur.el"
  (let ((dir default-directory))
    (setq dir
          (if (and (boundp 'running-xemacs) running-xemacs)
              (read-directory-name "Directory: " dir)
            (read-file-name "Directory: " nil nil t)))
    (if (and (file-exists-p dir)
             (file-directory-p  dir))
        (setq dir (file-name-as-directory dir))
      (setq dir (file-name-as-directory (file-name-directory dir)))
      (if (and (file-exists-p dir)
               (file-directory-p  dir))
          ()
        (error (format "No such directory %s" dir))
        (sleep-for 1)
        (setq dir nil)))
    dir))


(defun ffip-project-root (arg)
  "Return the root of the project."
  (interactive)
  ;
  (if arg 
      (setq ffip-project-root-function 'ffip-grep-read-directory)
      (setq ffip-project-root-function nil))
  ;
  (let ((project-root (or ffip-project-root
                          (if (functionp ffip-project-root-function)
                              (funcall ffip-project-root-function)
                            (if (listp ffip-project-file)
                                (some (apply-partially 'locate-dominating-file
                                                       default-directory)
                                      ffip-project-file)
                              (locate-dominating-file default-directory
                                                      ffip-project-file))))))
    (or project-root
        (progn (message "No project was defined for the current file.")
               nil))))

;; (defun ffip-project-root (arg)
;;   "Return the root of the project."
;;   (interactive "P")
;;   ;
;;   (if arg 
;;       (setq ffip-project-root-function 'moccur-grep-read-directory)
;;       (setq ffip-project-root-function nil)))


;experiment
;(setq my-dir (ffip-project-root))

(defun ffip-uniqueify (file-cons)
  "Set the car of FILE-CONS to include the directory name plus the file name."
  (setcar file-cons
          (concat (cadr (reverse (split-string (cdr file-cons) "/"))) "/"
                  (car file-cons))))

(defun ffip-join-patterns ()
  "Turn `ffip-paterns' into a string that `find' can use."
  (mapconcat (lambda (pat) (format "-name \"%s\"" pat))
             ffip-patterns " -or "))

(defun ffip-project-files (&optional arg)
  "Return an alist of all filenames in the project and their path.
Files with duplicate filenames are suffixed with the name of the
directory they are found in so that they are unique."
  (interactive)
  (let ((file-alist nil)
        (root (expand-file-name (or ffip-project-root (ffip-project-root arg)
                                    (error "No project root found")))))
    (mapcar (lambda (file)
              (if ffip-full-paths
                  (cons (substring (expand-file-name file) (length root))
                        (expand-file-name file))
                (let ((file-cons (cons (file-name-nondirectory file)
                                       (expand-file-name file))))
                  (when (assoc (car file-cons) file-alist)
                    (ffip-uniqueify (assoc (car file-cons) file-alist))
                    (ffip-uniqueify file-cons))
                  (add-to-list 'file-alist file-cons)
                  file-cons)))
            (split-string 
            ;--------------------------------------------------------------------------------
            (shell-command-to-string
            ;MTF Must dbl quote first arg to find so that Win7 PC likes find\w certian paths.
            ;Removed the head command, it generally seems broke in cygwin for win7.
            ;Added a gawk command to replace head.
            (format "find \"%s\" -type f \\( %s \\) %s \|gawk \"NR < %s\"" 
            ;args    1   2                    3                 4 
                    root (ffip-join-patterns) ffip-find-options my-ffip-limit))
            ;--------------------------------------------------------------------------------
            ))))

;(setq tempval1000 (ffip-project-files 4) )

;this is junk I used to debug.
;(setq ffip-full-paths nil)
;mtf
;(setq my-temp-ff (ffip-project-files))

;; ;mtf
; (defun my-shell-command ()
;   (interactive)
;   (shell-command "find c:/Users/mfitzgerald/AppData/Roaming/.emacs.d/ -type f \\( -name \"*.org\" -or -name \"*.v\" -or -name \"*.el\" -or -name \"*.do\" -or -name \"*.py\" -or -name \"*.rb\" -or -name \"*.pl\" -or -name \"*.vhd\" -or -name \"*.sh\" -or -name \"*.twr\" -or -name \"*.map\" -or -name \"*.par\" \\) -not -regex \".*icicles.*\" -not -regex \".*svn.*\" ")
;   )

;works 13or length 160
;(length "----------------------------------------------------------------------------------------------------------------------------------------------------------------")

;;;###autoload
(defun find-file-in-project (&optional arg)
  "Prompt with a completing list of all files in the project to find one.
The project's scope is defined as the first directory containing
an `.emacs-project' file.  You can override this by locally
setting the variable `ffip-project-root'.  Any prefix arg causes
ffip to prompt user for the starting folder.

Note that the file name matched against will be relative to the starting
folder.  For example if the starting folder is .emacs.d and you are searching
for block-move.el you will not find it bc the matches are against 
./block-move/block-move.el Because of this it is almost strict that the user
needs to use a completing read and downselect rather than simply entering the
file name directly in the mini-buffer.
In a world with nothing better to do, this could be changed so the 
if first assoc was missed, then a 2nd assoc list with the names pre processed
so that they were not relative was examined for  so that 
 \(hardname.txt . path-to-hardname/hardname.txt\) would match."
  (interactive "P")
  (let* (
         (project-files (ffip-project-files arg))
         ;
         (files (mapcar 'car project-files))
         ;
         (file (if (and (boundp 'ido-mode) ido-mode)
                   ;T
                   (ido-completing-read "Find file in project: " files)
                   ;F
                   (completing-read "Find file in project: " files)))   
         )

    (find-file (cdr (assoc file project-files)))))

;;;###autoload
(defalias 'ffip 'find-file-in-project)

;; safe locals
;;;###autoload
(progn
  (put 'ffip-patterns 'safe-local-variable 'listp)
  (put 'ffip-find-options 'safe-local-variable 'stringp)
  (put 'ffip-project-file 'safe-local-variable 'stringp)
  (put 'ffip-project-root 'safe-local-variable 'stringp)
  (put 'ffip-project-root-function 'safe-local-variable 'functionp)
  (put 'my-ffip-limit 'safe-local-variable 'integerp))

(provide 'my-find-file-in-project)
;;; find-file-in-project.el ends here
