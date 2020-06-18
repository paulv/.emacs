(defun scheme-return ()
  (interactive)
  (lisp-indent-line)
  (newline-and-indent))

(add-hook 'scheme-mode-hook
          (lambda ()
            (local-set-key [return] 'scheme-return)))

(setq scheme-mit-dialect nil)
(setq scheme-program-name "guile")


(provide 'paulv-scheme)