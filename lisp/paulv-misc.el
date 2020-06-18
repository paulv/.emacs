;(load-library "fold-dwim.el")

(global-auto-revert-mode 1)

(if (load "folding" 'nomessage 'noerror)
    (folding-mode-add-find-file-hook))

(defun paulv-mail-mode-hook () (paulv-turn-on-flyspell))

(add-hook 'HTML-mode-hook  'turn-off-auto-fill)
(add-hook 'mail-mode-hook  'paulv-mail-mode-hook)

(defun paulv-term-toggle-line-char ()
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
    (term-line-mode)))


(defun paulv-term-mode-hook ()
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
            (make-local-variable 'mouse-yank-at-point)
;;            (make-local-variable 'transient-mark-mode)
            (make-local-variable 'show-trailing-whitespace)
            (setq mouse-yank-at-point t)
;;            (setq transient-mark-mode nil)
            (setq show-trailing-whitespace nil)
            (auto-fill-mode -1)
            (setq tab-width 8)
            (local-set-key "\C-c\C-j" 'paulv-term-toggle-line-char)
            (local-set-key "\C-c\C-k" 'paulv-term-toggle-line-char))

(add-hook 'term-mode-hook 'paulv-term-mode-hook)

(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")

;; (autoload 'hideshowvis-minor-mode
;;   "hideshowvis"
;;   "Will indicate regions foldable with hideshow in the fringe."
;;   'interactive)


;; (dolist (hook (list 'emacs-lisp-mode-hook
;;                     'c++-mode-hook))
;;   (add-hook hook 'hideshowvis-enable))

;; If enabling hideshowvis-minor-mode is slow on your machine use M-x,
;; customize-option, hideshowvis-ignore-same-line and set it to nil. This will
;; then display - icons for foldable regions of one line, too but is faster
;;
;; To enable displaying a + symbol in the fringe for folded regions,
;; use:
;;

;; (hideshowvis-symbols)

(provide 'paulv-misc)
