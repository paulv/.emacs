;; dired by default makes a buffer per directory. This is annoying, so
;; this fixes it. Copied from
;; http://www.emacswiki.org/emacs/DiredReuseDirectoryBuffer
(defun paulv-dired-mode-hook ()
  (defadvice dired-advertised-find-file (around dired-subst-directory activate)
    "Replace current buffer if file is a directory."
    (interactive)
    (let* ((orig (current-buffer))
           ;; (filename (dired-get-filename))
           (filename (dired-get-filename t t))
           (bye-p (file-directory-p filename)))
      ad-do-it
      (when (and bye-p (not (string-match "[/\\\\]\\.$" filename)))
        (kill-buffer orig)))))

(add-hook 'dired-mode-hook 'paulv-dired-mode-hook)

(provide 'paulv-dired)
