(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\irb_tempfile\\'" . ruby-mode))

(add-to-list 'completion-ignored-extensions ".rbc")

(add-to-list 'load-path (concat dotfiles-dir "vendor/rvm.el"))
;;(require 'rvm)
;;(rvm-use-default)

(defun paulv-ruby-mode-hook ()
  (define-key ruby-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (require 'ruby-electric)
  ;;  (ruby-electric-mode)
  (setq ruby-indent-level 2)
  ;;  (flyspell-prog-mode)
  (abbrev-mode nil)
  (require 'inf-ruby))

(defun paulv-insert-interpolation ()
  (interactive)
  (let ((start (region-beginning))
        (end (region-end)))
    (message "%s, %s" start end)
    (save-excursion
      (goto-char start)
      (insert "#{")
      (goto-char (+ 2 end))
      (insert "}"))))

(add-hook 'ruby-mode-hook  'paulv-ruby-mode-hook)

;; (require 'rhtml-mode)
;; (set-face-background 'erb-face "#383838")

(provide 'paulv-ruby)
