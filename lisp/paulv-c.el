;; set up stuff for C mode
;;     default tab width is 4
;;     base-offset is 2
;;     C-m is 'newline-and-indent'
;;
(require 'cc-mode)
(setq-default tab-width 4)
(setq-default c-base-offset 4)
(setq-default c-basic-offset 4)
(define-key c-mode-base-map "\C-m" 'newline-and-indent)

(provide 'paulv-c)