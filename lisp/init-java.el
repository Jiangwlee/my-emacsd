;;; init-java.el --- Emacs java mode-*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package lsp-java
  :ensure t
  :after lsp
  :config
  (add-hook 'java-mode-hook 'lsp)
  )

(provide 'init-java)
;;; init-java.el ends here
