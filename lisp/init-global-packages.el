;;; init-global-packages.el --- Emacs global packages -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; Formatting

;; Show matching parens
(show-paren-mode 1)

;; Indentation
(setq-default tab-width 2
              tab-always-indent t
              indent-tabs-mode nil
              fill-column 80)

;; Word wrapping
(setq-default word-wrap t
              truncate-lines t
              truncate-partial-width-windows nil)


;;; Emacs Face
(jiangwl/normal-font) ;; set font size to 10pt

;;; Disable menubar
(menu-bar-mode -1)

;;; Disable cursor blink
(blink-cursor-mode 0)

;;; Disable auto backup
(setq make-backup-files nil)

;;; Enable electirc-pair-mode
(electric-pair-mode 1)

;;; undo-tree
(use-package undo-tree
  :ensure t
  :config
  ;; Global settings (defaults)
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

;;; ace-window
(use-package ace-window
  :ensure t
  :bind
  ("M-o" . ace-window)
  )

;;; ace-jump-mode
(use-package ace-jump-mode
  :ensure t)
  ;; :bind
  ;; ("C-c SPC" . ace-jump-mode))

;;; which-key
(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 0.2)
  :config
  (which-key-mode))

;;; evil mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (evil-mode 1)
  :bind (:map evil-normal-state-map
	      ("SPC" . ace-jump-mode)))

;;; ivy mode
(use-package swiper
  :ensure t
  :bind ("\C-s" . 'swiper))

(use-package counsel
  :ensure t
  :bind
  ("M-x" . 'counsel-M-x)
  ("C-x C-f" . 'counsel-find-file)
  )

(use-package ivy
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)

  ;; Enable ivy mode
  (ivy-mode 1)
  :bind
  ("C-c C-r" . 'ivy-resume)
  ("C-x b" . 'ivy-switch-buffer)
  ("C-x C-b" . 'ivy-switch-buffer)
  )

;;; projectile
(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (progn
    (setq projectile-completion-system 'ivy)
    (projectile-mode))
  )

;;; Company
(use-package company
  :ensure t
  :init
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (global-company-mode)
  )

;;; Magit
(use-package magit
  :ensure t
  :bind
  ("C-c m" . 'magit-status)
  )

;;; Yasnippet
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;;; hydra
(use-package hydra
  :ensure t
  )

;;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;;; lsp-mode
(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-l")
  (setq lsp-idle-delay 0.500)
  (add-hook 'java-mode-hook #'lsp)
  :config
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (defun my-java-mode-config ()
    (setq c-basic-offset 2
  	  tab-width 2))
  (add-hook 'java-mode-hook #'my-java-mode-config)
  )
  
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode ;; create autoload for commands and defers loading of them until they are actually used
  :bind
  (:map lsp-ui-mode-map
	([remap xref-find-definitions] . #'lsp-ui-peek-find-definitions)
	([remap xref-find-references] . #'lsp-ui-peek-find-references))
  )

(use-package lsp-java
  :ensure t
  :after lsp
  )

(use-package company-lsp
  :ensure t
;;  :commands company-lsp
  :config
  (push 'company-lsp company-backends))

(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol
  )

(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list
  )

;;; gradle mode
(use-package gradle-mode
  :ensure t
  :config
  (gradle-mode 1)
  )

;;; treemacs
(use-package treemacs
  :ensure t
  :defer t
  )

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package treemacs-persp
  :after treemacs persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(provide 'init-global-packages)
;;; init-global-packages.el ends here
