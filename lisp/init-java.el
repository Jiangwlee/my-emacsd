;;; init-java.el --- Emacs java mode-*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package lsp-java
  :ensure t
  :after lsp
  :config
  (defun my-java-mode-config ()
    (setq c-basic-offset 2
	  tab-width 2
	  indent-tabs-mode nil))
  (add-hook 'java-mode-hook 'lsp)
  (add-hook 'java-mode-hook 'my-java-mode-config)
  )

(provide 'init-java)
;;; init-java.el ends here
