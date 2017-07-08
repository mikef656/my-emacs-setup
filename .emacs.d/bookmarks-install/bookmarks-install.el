;;; bookmarks-install.el -- Download and optionally byte-compile Icicles 
;;
;; Filename: bookmarks-install.el
;; Description: Download and optionally byte-compile the Icicles package
;; Author: Anupam Sengupta
;; Maintainer: Anupam Sengupta
;; Copyright (C) 2007-2008 Anupam Sengupta, all rights reserved.
;; Created: Wed May 24 14:05:13 2007
;; Version: 1.0
;; Last-Updated: Fri May 22 12:57:40 2009 (-0700)
;;           By: dradams
;; URL: http://www.emacswiki.org/cgi-bin/wiki/icicles-install.el
;; Keywords: package, download
;; Compatibility: GNU Emacs 20.x, GNU Emacs 21.x, GNU Emacs 22.x
;;
;; Features that might be required by this library:
;;
;;   `url'.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;  Download the Icicles package (libraries) from
;;  http://www.emacswiki.org and optionally byte-compile any files in
;;  the target directory that were previously byte-compiled.
;;
;;  Usage:
;;
;;  1. Download this file to a convenient directory (e.g. ~/elisp)
;;  2. Add the following line in your .emacs file:
;;
;;      (load "~/<dirname>/icicles-install")
;;
;;     Adjust the directory name for your local download directory.
;;
;;  3. You need not restart Emacs. At end of the sexp, enter C-x C-e
;;     to load the file
;;
;;  4. Optional Step: You may want to customize the download directory
;;     (it defaults to "~/icicles") by running `customize-variable' on
;;     the `bookmark-download-dir' variable. If you do this, be sure to
;;     also add the value of `bookmark-download-dir' to variable
;;     `load-path'.
;;
;;  5. Run the command `bookmarks-download-wizard' from the mini-buffer:
;;
;;      M-x bookmarks-download-wizard
;;
;;  Acknowledgements:
;;
;;  Code based largely on `package.el' by Tom Tromey.
;;  See: http://tromey.com/elpa/package-install.el
;;  See: http://www.emacswiki.org/cgi-bin/wiki/TomTromey
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change log:
;;
;; 2012/01/14 dadams
;;     bookmarks-files-to-download-list: Added ring+.el (needed by doremi.el).
;; 2009/05/22 dadams
;;     Split icicles-cmd.el into icicles-cmd1.el and icicles-cmd2.el.
;; 2008/08/16 dadams
;;       Thx to Kevin Rodgers.
;; 2008/03/06 dap (Damon Permezel)
;;     Mention setting url-http-version for ^M work around.
;; 2007/08/16 dadams
;;     Mention updating load-path in step 4. Thx to Lars Bjornfot.
;; 2007/06/09 dadams
;;     Corrected Tom Tromey's name and URL.
;; 2007/06/07 dadams (Drew Adams)
;;     Added icicles-doc1.el and icicles-doc2.el.
;;     Clarified that only files that have been byte-compiled are byte-compiled.
;; 2007/06/02 AnupamSengupta
;;     Created.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software software; you can redistribute it
;; and/or modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; GNU Emacs is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(eval-when-compile (require 'cl)) ;; dolist

(require 'url nil t) ;; (no error if not found): If not present, uses `wget' instead

;; Override HTTP version to avoid url bug handling Transfer-Encoding: chunked
;; which results in a spurious ^M at the end of each file.
;; Leave this commented out for now, mainly for documentation of this problem
;; while some more investigation is performed ... by someone as yet unknown.
;; - Damon Permezel
;;
;; (if (fboundp 'url-retrieve-synchronously) (set-variable 'url-http-version "1.0"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;###autoload
(defcustom icicle-archive-base "http://www.emacswiki.org/cgi-bin/wiki/download/"
  "*Base URL from which the Icicles files should be downloaded.
Default value is the Emacs Wiki site."
  :type 'string :group 'Icicles-Miscellaneous)

;;;###autoload
(defcustom bookmark-download-dir "~/.emacs.d/bookmarks_plus"
  "*Directory to which the Icicles files should be downloaded."
  :type 'directory :group 'bookmark-plus)

;;;###autoload
(defcustom bookmarks-files-to-download-list
  (list
   "bookmark+-1.el"             ; Column highlighting
   "bookmark+-bmu.el"           ; Crosshairs highlighting
   "bookmark+-chg.el"           ; Change incrementally (requires ring+.el)
   "bookmark+-doc.el"           ; Color manipulation
   "bookmark+-key.el"           ; Line highlighting
   "bookmark+-lit.el"           ; Main library - just loads the others
   "bookmark+-mac.el"           ; Change logs
   "bookmark+.el"               ; Doc, part 1
  )
  "*Icicles files to download.
Icicles is made to take advantage of some libraries that are not
strictly required.  All of these are recommended, but only some are
included in the default value of `bookmarks-files-to-download-list'.

The following files are included in the download list by default.  If
you like, you can remove any of them without impacting core Icicles
functionality:

  `col-highlight.el' - Column highlighting
  `crosshairs.el' - Crosshairs highlighting
  `doremi.el' - Change *Completions* display incrementally
  `hexrgb.el' - Lets you use and manipulate colors with Icicles
  `hl-line+.el' - Line highlighting
  `icicles-chg.el' - Change logs for all Icicles libraries
  `icicles-doc1.el' and `icicles-doc2.el' - Icicles documentation
  `icomplete+.el' - Enhancements to `icomplete.el'
  `lacarte.el' - Menu-bar access from keyboard
  `synonyms.el' - Look up synonyms in a thesaurus using Icicles

The following files are also recommended but not strictly required.
You might want to add them to `bookmarks-files-to-download-list'.

  `apropos-fn+var.el' - Enhanced apropos commands
  `bookmark+.el' - Bookmark enhancements
  `dired+.el' - Use file on current line as default in Dired
  `doremi-frm.el' - Zoom *Completions*
  `ffap-.el' - Extensions to `ffap.el'
  `fit-frame.el' - Fit frames to their (sole) buffers
  `fuzzy-match.el' - Provides Icicles with fuzzy matching
  `info+.el' - Info enhancements
  `linkd' - Provides hypertext links for Icicles doc
  `menu-bar+.el' - Menu-bar menus (Apropos, Describe, Frames, Tags)
  `misc-cmds.el' - Clear search history.  Kill buffer deletes window.
  `palette.el' - Pick up foreground/background color
  `pp+.el' - Enhanced version of `pp-eval-expression', for `M-:'
  `thingatpt+.el' - Use names near, not just at, point as defaults
  `wid-edit+.el' - Color widget for Customize"
  :type '(repeat file) :group 'bookmark-plus)

;;;###autoload
(defun bookmarks-download-file (url)
  "Download a file from the specified URL and return the download buffer.
This uses package `url' if available or `wget' otherwise."
  (if (fboundp 'url-retrieve-synchronously)
      (let ((buffer (url-retrieve-synchronously url))) ; Use URL to download
        (save-excursion
          (set-buffer buffer)
          (goto-char (point-min))
          (re-search-forward "^$" nil 'move)
          (forward-char)
          (delete-region (point-min) (point))
          buffer))
    (with-current-buffer                ; Else use `wget' to download
        (get-buffer-create (generate-new-buffer-name " *Download*"))
      (shell-command (concat "wget -q -O- " url) (current-buffer))
      (goto-char (point-min))
      (current-buffer))))

;;;###autoload
(defun bookmarks-install-download-and-save-file (file-to-download)
  "Download and save FILE-TO-DOWNLOAD."
  (let ((pkg-buffer (bookmarks-download-file (concat icicle-archive-base
                                                  file-to-download))))
    ;; Save the downloaded buffer contents in the file
    (save-excursion
      (set-buffer pkg-buffer)
      (setq buffer-file-name (concat (file-name-as-directory bookmark-download-dir)
                                     file-to-download))
      (save-buffer)
      (kill-buffer pkg-buffer)
      (message "Downloaded `%s'" file-to-download))))

;;;###autoload
(defun bookmark-download-all-files ()
  "Download and save all Icicles files.
Create the download directory if it does not exist."
  (dolist (file-to-download bookmarks-files-to-download-list t)
    (bookmarks-install-download-and-save-file file-to-download)
    (sleep-for 2)))            ; Sleep to prevent overloading the site

;;;###autoload
(defun bookmarks-byte-compile-downloaded-files ()
  "Byte-compile all previously compiled files in `bookmark-download-dir'."
  (byte-recompile-directory bookmark-download-dir 0))

;;;###autoload
(defun bookmarks-download-wizard ()
  "Run the interactive wizard for downloading Icicles libraries."
  (interactive)
  (if (not (y-or-n-p "Download the Bookmarks files? "))
      (message "Bookmarks download cancelled")
    (make-directory bookmark-download-dir t) ; Create directory if not present.
    (bookmark-download-all-files)
    (message "Bookmarks download completed")
    (if (y-or-n-p "Byte-compile files in download directory now? ")
        (let ((load-path (cons bookmark-download-dir load-path)))
          (bookmarks-byte-compile-downloaded-files))
      (message "Byte-compiled the Bookmarks files"))
    (when (y-or-n-p "Show the Bookmarks files in Dired? ")
      (dired-other-frame bookmark-download-dir))
    (message "Bookmarks download complete")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'bookmarks-install)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; bookmarks-install ends here.
