;; -*- emacs-lisp -*-

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path (concat dotfiles-dir "lisp/"))
;(add-to-list 'load-path (concat dotfiles-dir "elpa-to-submit"))
;(add-to-list 'load-path (concat dotfiles-dir "vendor/rhtml/"))
;(add-to-list 'load-path (concat dotfiles-dir "vendor/rinari/"))
;(add-to-list 'load-path (concat dotfiles-dir "vendor/scss-mode/"))
;(add-to-list 'load-path (concat dotfiles-dir "vendor/coffee-mode/"))

;; get our current hostname
(setq paulv-current-host (system-name))


(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(use-package paradox
  :ensure t
  :init
  (setq paradox-spinner-type 'progress-bar)
  (setq paradox-column-width-version 15)
  (setq paradox-column-width-package 24)
  (setq paradox-display-star-count nil)
  :config
  (paradox-enable))

(use-package exec-path-from-shell
  :if (memq window-system '(nil w32 x))

  :ensure t

  :init
  (setq exec-path-from-shell-arguments nil)
  
  :config
  (exec-path-from-shell-initialize))

;;(require 'web-mode)

(setq custom-file (concat dotfiles-dir "custom.el"))

;;(require 'paulv-gnus)
;;(require 'folding)
; (require 'paulv-lsp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lsp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package typescript-mode
  :ensure t

  :config
;;  :hook
;;  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript))
)

(use-package lsp-mode
  :ensure t
  :config

  (require 'lsp-ui-imenu)
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)

  (use-package lsp-ui
    :ensure t
    :config
    (setq lsp-ui-sideline-ignore-duplicate t)
    (add-hook 'lsp-mode-hook 'lsp-ui-mode))

  (use-package company-lsp
    :config
    (push 'company-lsp company-backends))


  :hook
  ((typescript-mode . lsp-deferred)
   (lsp-mode . lsp-enable-which-key-integration))

  :commands lsp lsp-deferred)

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; javascript
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))



(require 'flyspell)
(require 'ffap) ; find-file-at-point
(require 'ansi-color) ; translate ansi escape sequences into colors
(require 'tooltip)

(require 'paulv-appearance)
(require 'paulv-defuns)
(require 'paulv-variables)

;(require 'paulv-which-func)
(require 'paulv-uniquify)
(require 'paulv-key-bindings)
(require 'paulv-ido)
; (require 'paulv-abbrevs)
(require 'paulv-server)
(require 'paulv-dired)
(require 'paulv-smex)
(require 'paulv-ruby)
(require 'paulv-perl)
(require 'paulv-c)
(require 'paulv-java)
(require 'paulv-asm)
(require 'paulv-scheme)
(require 'paulv-php)
;(require 'paulv-javascript)
(require 'paulv-misc)
(require 'paulv-text)
(require 'paulv-eshell)
;(require 'paulv-scss)
(require 'paulv-yas)
(require 'paulv-tramp)
;;(require 'paulv-epa)
;;(require 'paulv-bbdb)
;;(require 'paulv-realgud)
(require 'paulv-desktop)

(load custom-file 'noerror)

;; (require 'saveplace) ; save's your place in a file
;; (require 'uniquify)
;; (require 'recentf)
