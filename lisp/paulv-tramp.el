;; sometimes tramp is annoying, so whenever it gets loaded, go in to debug mode so
;; (eval-after-load "tramp" '(debug))

(require 'tramp)
(setq tramp-mode t)
(setq tramp-default-method "ssh")

(provide 'paulv-tramp)
