;; these hosts have desktop mode enabled
(setq paulv-load-desktop-hosts '("heisenberg" "schrodinger" "hanzo"))

;; set paulv-load-desktop to t if we're on one of the above hosts.
(cond
 ((member paulv-current-host paulv-load-desktop-hosts)
  (setq paulv-load-desktop t))
 (t
  (setq paulv-load-desktop nil)))

(if (or
     (string= (getenv "GNUS") "1")
     (string= (getenv "EMACS_NO_DESKTOP") "1"))
    (progn
      (message "not loading desktop because ENV GNUS is 1")
      (setq paulv-load-desktop nil)))

;; if we should load the desktop, then load the desktop
(cond ((eq paulv-load-desktop t)
       (cond
        ((eq emacs-major-version 21)
         (setq paulv-loading-desktop t)
         (load "desktop")
         (desktop-load-default)
         (setq history-length 250)
         (add-to-list 'desktop-globals-to-save 'file-name-history)
         (desktop-read)
         (setq paulv-loading-desktop nil))
;;        ((eq emacs-major-version 22)
;;         (desktop-save-mode 1)
;;         (setq desktop-save t))
        ((>= emacs-major-version 23)
         (desktop-save-mode 1)
         (setq desktop-save t))
        )))

(defun autosave-desktop ()
  (message "auto-saving desktop...")
  (desktop-save desktop-dirname))

(defun paulv-desktop-string-not (regexp string)
;  (message "regexp is [%s] and buffer is [%s]" regexp string)
  (not (string-match-p regexp string)))

;; if desktop mode is finished loading, and we're supposed to load the
;; desktop, save the desktop after we kill the file.
(defun paulv-kill-buffer-hook ()
  (if (and
       (eq paulv-finished-init t)
       (eq paulv-load-desktop t)
       (paulv-desktop-string-not "^\\*" (buffer-name (current-buffer)))
       (paulv-desktop-string-not "^ " (buffer-name (current-buffer)))
       (paulv-desktop-string-not "^ \\*" (buffer-name (current-buffer))))
      (progn
        (message "Saving desktop, buffername is [%s]" (buffer-name (current-buffer)))
        (desktop-save "~"))))

(cond ((eq paulv-load-desktop t)
       ;; Set paulv-finished-init to t after desktop mode is finished loading.
       (defun paulv-desktop-after-read-hook () (setq paulv-finished-init t))
       (defun paulv-before-init-hook () (setq paulv-finished-init nil))

       ;; if desktop mode is finished loading, and we're supposed to load the
       ;; desktop, save the desktop after we open the file.
       (defun paulv-find-hook ()
         (cond ((and
                 (eq paulv-finished-init t)
                 (eq paulv-load-desktop t))
                (desktop-save "~"))))

       (add-hook 'desktop-after-read-hook 'paulv-desktop-after-read-hook)
       (add-hook 'before-init-hook 'paulv-before-init-hook)
       ;; (remove-hook 'kill-buffer-hook 'paulv-kill-buffer-hook)

       (add-hook 'find-file-hook 'paulv-find-hook)
       (add-hook 'kill-buffer-hook 'paulv-kill-buffer-hook)))

(provide 'paulv-desktop)
