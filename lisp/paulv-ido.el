(require 'ido)
(ido-mode t)
(setq ido-show-confirm-message nil)
(setq ido-enable-tramp-completion t)
(setq ido-use-filename-at-point 'guess)

(provide 'paulv-ido)
