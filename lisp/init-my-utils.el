;;; init-my-utils.el --- Some util funtions -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(if (fboundp 'with-eval-after-load)
    (defalias 'after-load 'with-eval-after-load)
  (defmacro after-load (feature &rest body)
    "After FEATURE is loaded, evaluate BODY."
    (declare (indent defun))
    `(eval-after-load ,feature
       '(progn ,@body))))


;;----------------------------------------------------------------------------
;; Handier way to add modes to auto-mode-alist
;;----------------------------------------------------------------------------
(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))


;;----------------------------------------------------------------------------
;; Delete the current file
;;----------------------------------------------------------------------------
(defun delete-this-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (unless (buffer-file-name)
    (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
                             (file-name-nondirectory buffer-file-name)))
    (delete-file (buffer-file-name))
    (kill-this-buffer)))


;;----------------------------------------------------------------------------
;; Rename the current file
;;----------------------------------------------------------------------------
(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file!" name))
    (progn
      (when (file-exists-p filename)
        (rename-file filename new-name 1))
      (set-visited-file-name new-name)
      (rename-buffer new-name))))

;;----------------------------------------------------------------------------
;; Browse current HTML file
;;----------------------------------------------------------------------------
(defun browse-current-file ()
  "Open the current file as a URL using `browse-url'."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (and (fboundp 'tramp-tramp-file-p)
             (tramp-tramp-file-p file-name))
        (error "Cannot open tramp file")
      (browse-url (concat "file://" file-name)))))


(defun jiangwl/copy-matched-strings (regexp)
"Copy all matched strings.  REGEXP is a regression expression for search.
It should contains a group, and the matched group content would be returned."
  (interactive "sRegexp to match: ")
  (let ((beginning (region-beginning)) (end (region-end)) (result (list)))
    ;; (setq regexp (concat "\\(" regexp "\\)"))
    (if (use-region-p)
	(progn
	  ;; (message "In active region now! beginning: %d, end: %d" beginning end)
          (save-excursion
	    (goto-char beginning)
	    ;; (message "current position is %d, regexp: %s" (point) regexp)
	    (while (re-search-forward regexp end t 1)
	      (setq result
		    (append result (list (concat "\"" (match-string 1) "\""))))
	      (message "matched: %s" (match-string 1))))
	  )
      (message "the region is still there (from %d to %d), but it is inactive" beginning end))
    (kill-new (mapconcat 'identity result ", "))
    )
  )

(defun jiangwl/normal-font ()
  "Set the font size to 10pt."
  (interactive)
  (set-face-attribute 'default nil :height 100))

(defun jiangwl/small-font ()
  "Set the font size to 8pt."
  (interactive)
  (set-face-attribute 'default nil :height 80))

(defun jiangwl/large-font ()
  "Set the font size to 14pt."
  (interactive)
  (set-face-attribute 'default nil :height 140))

(provide 'init-my-utils)
;;; init-my-utils ends here
