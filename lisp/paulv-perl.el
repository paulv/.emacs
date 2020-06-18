(cond ((eq emacs-major-version 21)
       (load-file "~/.elisp/cperl-mode.el")))

(require 'cperl-mode)

;(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(setq auto-mode-alist (cons '("\\.plx\\'" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pl\\'" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cgi\\'" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pm\\'" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.t\\'" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pod\\'" . cperl-mode) auto-mode-alist))

;; this is a hook that gets loaded every time I go into cperl-mode. It
;; loads all the colors I want for cperl-mode.
(defun paulv-cperl-mode-hook ()
  (interactive)
  (local-set-key "\C-cr" 'refontify)
  (setq cperl-hairy nil)
  (set-face-foreground cperl-pod-head-face "lightblue")
  (set-face-foreground cperl-pod-face "red")
  (defcustom cperl-invalid-face 'default
    "fuck you , cperl"
    :type 'face
    :version "21.1"
    :group 'cperl-faces)
;;  (setq cperl-invalid-face 'default)

  (set-face-attribute 'cperl-array-face nil
                      :foreground "PeachPuff"
                      :background nil)

  (set-face-attribute 'cperl-hash-face nil
                      :foreground "DarkTurquoise"
                      :background nil)
;  (cperl-array-face ((t (:foreground "PeachPuff"))))
;  (cperl-hash-face  ((t (:foreground "DarkTurquoise"))))
;  (set-face-foreground cperl-array-face "PeachPuff")
;  (set-face-foreground cperl-hash-face "DarkTurquoise")

  (setq cperl-font-lock t)
  (setq cperl-electric-lbrace-space nil)
  (setq cperl-electric-parens nil)
  (setq cperl-electric-parens-string "")
  (setq cperl-electric-keyword nil)
  (setq cperl-electric-parens-mark nil)
  (setq cperl-electric-linefeed nil)
  (setq cperl-electric-keywords nil)

  (setq cperl-scan-files-regexp "\\.\\([pP][Llm]\\|xs\\|plx\\)$")
  (setq cperl-indent-level 4)
  (setq cperl-auto-newline nil)
  (setq cperl-auto-newline-after-colon nil)
  (setq cperl-continued-brace-offset -2)
  (define-key cperl-mode-map "\C-m" 'newline-and-indent)
  (local-set-key "\C-cr" 'refontify)
  (setq compile-command (concat "perl -c " buffer-file-name))
  (setq abbrev-mode nil)
  (message "cperl hook"))

(add-hook 'cperl-mode-hook 'paulv-cperl-mode-hook)

(defalias 'perl-mode 'cperl-mode)

(provide 'paulv-perl)
