;;;;;;;;;;;;;;;;;;;
;;; Common
;;;;;;;;;;;;;;;;;;;

(defun common ()
  ;;; Paths
  (add-to-list 'load-path "~/elisp")

  ;;; color theme
  (require 'color-theme)
  (eval-after-load "color-theme"
	'(progn
	   (color-theme-initialize)
	   (color-theme-tty-dark)))

  ;; editor
  (setq line-number-mode 1)
  (setq column-number-mode 1)
  (setq-default transient-mark-mode t)  ;; enable visual feedback on selections
  (setq require-final-newline t)        ;; always end a file with a newline
  (setq next-line-add-newlines nil)     ;; stop at the end of the file

  ;;; tidbits
  (setq inhibit-startup-message   t)
  (setq frame-title-format        "%b")
  (setq explicit-shell-file-name  "/bin/bash")
  (setq grep-command              "grep -n --colour=never ")
  (setq default-major-mode        'text-mode)
  (setq default-tab-width         4)
  (global-auto-revert-mode)

  ;; matlab/octave
  (autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
  (setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
  (setq matlab-indent-function t)
  (setq matlab-verify-on-save-flag nil)
  (defun my-matlab-mode-hook () (setq fill-column 76))
  (add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
)

(defun emacs-common ()
  (common)

  ;;; Figure out how to set the default face size and frame size.
  (global-font-lock-mode t)

  ;; Auto backups
  ;; (defvar user-temporary-file-directory "~/backup/")
  ;; (make-directory user-temporary-file-directory t)
  ;; (setq backup-by-copying t)
  ;; (setq backup-directory-alist
  ;; `(("." . ,user-temporary-file-directory)
  ;; (,tramp-file-name-regexp nil)))
  ;; (setq auto-save-list-file-prefix
  ;; (concat user-temporary-file-directory ".auto-saves-"))
  ;; (setq auto-save-file-name-transforms
  ;; `((".*" ,user-temporary-file-directory t)))
  ;; (setq version-control                 t)
  ;; (setq kept-old-versions               2)
  ;; (setq kept-new-versions               8)
  ;; (setq delete-old-versions             t)

  ;; GDB
  (setq gud-gdb-command-name "debug --annotate=3")

  ;; xterm title
  ;; (load "~/elisp/xterm-title")
  ;; (load "~/elisp/xterm-frobs")
  ;; (when (and (not window-system)
  ;;   (string-match "^xterm" (getenv "TERM")))
  ;; (require 'xterm-title)
  ;; (xterm-title-mode 1))
  ;; (setq frame-title-format "%b")  ;;; TODO: Set to magit status
)

;; auto-delete trailing whitespace
(defun delete-trailing-whitespace ()
  "Get rid all whitespace at the end of lines in the current buffer."
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (replace-regexp "[\t ]+$" "")))

;;;;;;;;;;;;;;;;;;;;;
;;; Key bindings
;;;;;;;;;;;;;;;;;;;;;
(defun common-keys ()
  (global-set-key [(meta down)] 'next-error)
  (global-set-key [(meta up)] '(lambda () (interactive) (next-error -1)))
  (global-set-key (kbd "M-9") 'previous-buffer)
  (global-set-key (kbd "M-0") 'next-buffer)
  (global-set-key (kbd "M-7") 'previous-multiframe-window)
  (global-set-key (kbd "M-8") 'next-multiframe-window)
  (global-set-key (kbd "M-m") 'magit-status)
  (global-set-key [f3] 'goto-line)
  (global-set-key [f4] 'query-replace)
  (global-set-key [f12] 'compile)
)

(defun emacs-keys ()
  (common-keys)
)

(defun xemacs-keys ()
  (common-keys)
)

;;;;;;;;;;;;;;;;;;;;;
;;; XEmacs/Emacs
;;;;;;;;;;;;;;;;;;;;;

(defun xemacs-startup ()
  (xemacs-common)
  (xemacs-keys)
)

(defun emacs-startup ()
  (emacs-common)
  (emacs-keys)
)

;;;;;;;;;;;;;;;;;;;;
;;; Startup
;;;;;;;;;;;;;;;;;;;;
(defun startup ()
  (interactive)

  (if (string-match "XEmacs" emacs-version)
      (xemacs-startup) (emacs-startup)
  )
)

(startup)
