(defun paulv-eshell-load-hook ()
  ;;  (setq eshell-prompt-function (lambda nil "JILL5 $ "))
  (setq eshell-prompt-function 
        (lambda nil
          (concat
           "(" (user-login-name) "@" paulv-current-host ")" " "
           "(" (eshell/pwd) ")"
           (if
               (=
                (user-uid)
                0)
               " # " " $ "))))

  (make-local-variable 'show-trailing-whitespace)
  (setq show-trailing-whitespace nil))

(add-hook 'eshell-mode-hook 'paulv-eshell-load-hook)

(provide 'paulv-eshell)
