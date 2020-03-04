;;; init-global-packages.el --- Emacs global packages -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; Disable menubar
(menu-bar-mode -1)

;;; undo-tree
(use-package undo-tree
  :ensure t
  :config
  ;; Global settings (defaults)
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

;;; which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;; evil mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)

  ;; Enable evil mode 
  (evil-mode 1))

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
    (projectile-global-mode))
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
  :init
  (setq ediff-dif-options "-w"
	ediff-split-window-function 'split-window-horizontally
	ediff-window-setup-function 'ediff-setup-window-plain)
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

;;; lsp-mode
(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-l")
  )

(use-package lsp-ui
  :ensure t)

(use-package company-lsp
  :ensure t)

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
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

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
