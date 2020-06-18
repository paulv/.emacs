;; no menu bars
(menu-bar-mode -1)
(blink-cursor-mode -1)
(tooltip-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

; (add-to-list 'load-path "~/local/share/emacs/site-lisp/")
; (add-to-list 'load-path "~/.elisp/")
; (add-to-list 'load-path "~/.elisp/ljupdate/")
; (add-to-list 'load-path "~/.emacs.d/")

(add-to-list 'auto-mode-alist '("\\.s?html$" . web-mode))
(add-to-list 'auto-mode-alist '("mutt-.*-[0-9]+-[0-9]+-[0-9]*$" . mail-mode))
(add-to-list 'auto-mode-alist '("paul-tol*" . text-mode))
(add-to-list 'auto-mode-alist '("\\.te?mp$"  . text-mode))
(add-to-list 'auto-mode-alist '("\\.latex\\'" . latex-mode))
(add-to-list 'auto-mode-alist '("\\.xsl\\'" . sgml-mode))
(add-to-list 'auto-mode-alist '("\\.xsl\\'" . sgml-mode))
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))

(setq inhibit-startup-message t)
(setq show-paren-mode nil)
(setq scroll-step 0)
(setq diff-switches "-u")
;; make M-x shell a login shell
(setq explicit-bash-args (quote ("-i" "-l")))
(setq folding-font-lock-begin-mark 'font-lock-comment-face)
(setq folding-font-lock-end-mark 'font-lock-comment-face)
(setq inferior-lisp-program "clisp")
(setq paulv-finished-init nil)
(setq-default show-trailing-whitespace t)
(setq-default fill-column 72)
(setq-default next-line-add-newlines nil)
(setq-default indent-tabs-mode nil)
(setq font-lock-maximum-decoration t)
(setq transient-mark-mode t)
(setq-default auto-save-interval '200)
(setq global-font-lock-mode t)
(setq frame-title-format "emacs - %b")
(setq-default add-log-mailing-address "paulv@canonical.org")
(setq-default server-temp-file-regexp "mutt-.*")
(setq mouse-yank-at-point t)
(setq tab-stop-list
      '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
(setq sentence-end-double-space nil)
;(setq ispell-program-name "ispell")

;; automatically focus emacs when emacsclient opens a file
(setq server-raise-frame t)

;; This should really be t, but if it is, opening a new frame with
;; emacsclient -c (ie emacsclient creates a new frame) causes the mouse
;; to be moved to the new frame, and that's SUPER ANNOYING.
(setq focus-follows-mouse nil)

;; umask 077
(set-default-file-modes 448)

(setq debug-on-error nil)
;; ;; tramp is annoying, so whenever it gets loaded, go in to debug mode so
;; ;; I can make whatever loaded it stop.
;; (eval-after-load "tramp" '(debug))

;; y means yes and n means no
(fset 'yes-or-no-p 'y-or-n-p)

;; so we can use narrow-to-region which prompts you with a message that
;; (parahprased) says "Are you sure you want to do this, you can get
;; confused?" I am sure, because I know what it does and I like it.
(put 'narrow-to-region 'disabled nil)

;; I want to be able to use 'downcase-region' without emacs telling me I
;; may hurt myself
(put 'downcase-region 'disabled nil)

(setq message-log-max 1000)

;; make it so things that don't have a mode are in text-mode by default.
(setq default-major-mode 'text-mode)

(setq ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-extra-args '("--sug-mode=ultra"))

(setq global-hi-lock-mode nil)
(setq hi-lock-file-patterns-policy nil)

(setq tramp-default-method "ssh")

;; emacs23 changed line movement. This changes it back.
(setq line-move-visual nil)

;; make magit use a full window instead of splitting the existing one
(setq magit-status-buffer-switch-function 'switch-to-buffer)

;; If you C-x C-f on a line that looks like it could be a hostname, ffap will try to ping it (!?)
(setq ffap-machine-p-known 'reject)
(provide 'paulv-variables)
