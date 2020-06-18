(autoload 'textile-mode "textile-mode" "Start textile-mode" t)
(autoload 'markdown-mode "markdown-mode" "Start markdown-mode" t)

(add-to-list 'auto-mode-alist '("\\.textile$" . textile-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.eyaml$" . yaml-mode))

(defun paulv-text-mode-hook ()
  (abbrev-mode t)
  (flyspell-mode -1))

(defun paulv-turn-on-flyspell ()
   "Force flyspell-mode on using a positive arg.  For use in hooks."
   (interactive)
   (flyspell-mode 1))

(add-hook 'text-mode-hook  'turn-on-auto-fill)
(add-hook 'text-mode-hook  'paulv-text-mode-hook)

(provide 'paulv-text)
