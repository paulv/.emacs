(setq auto-mode-alist (cons '("\\.asm\\'" . asm-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.s\\'" . asm-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.S\\'" . asm-mode) auto-mode-alist))

(defun paulv-asm-mode-hook ()
  (setq asm-comment-char ?#)
  (setq comment-start "# ")
  (local-set-key ";" 'asm-comment))

(add-hook 'asm-mode-hook   'paulv-asm-mode-hook)

(provide 'paulv-asm)